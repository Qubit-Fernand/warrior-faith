package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.SharedObject;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.setTimeout;
    import chaptertest.FakeSharedObject;
    import chaptertest.BuildInfo;
    import src.LocalSaveManager;

    [SWF(width="940",height="580",frameRate="27",backgroundColor="#15282B")]
    public class SaveContractHarness extends Sprite
    {
        private static const REPORT_NAME:String="yzlr2_rebuild_save_contract_diag_v1";
        private var screen:TextField=new TextField();
        private var heading:TextField=new TextField();
        private var fake:FakeSharedObject=FakeSharedObject.instance;
        private var checks:Array=[];
        private var report:Object={schema:1,mode:"real-manager-with-in-memory-storage-adapter",checks:checks,
            nativeSharedObjectPendingTested:false,gameSaveStoreOpened:false};
        private var synchronousCallbacks:int=0;
        private var pendingCallbacks:int=0;
        private var failedCallbacks:int=0;
        private var retryCallbacks:int=0;
        private var incoming:Object;
        private var previousFlushCalls:int=0;
        private var complete:Boolean=false;

        public function SaveContractHarness()
        {
            screen.defaultTextFormat=new TextFormat("_typewriter",13,0xE3F1D5);
            heading.defaultTextFormat=new TextFormat("_typewriter",17,0xE3F1D5,true);
            heading.x=16;heading.y=10;heading.width=908;heading.height=45;heading.multiline=true;addChild(heading);
            screen.x=16;screen.y=60;screen.width=908;screen.height=508;
            screen.multiline=true;screen.wordWrap=true;screen.selectable=true;addChild(screen);
            if(stage)start();else addEventListener(Event.ADDED_TO_STAGE,start);
        }
        private function start(event:Event=null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE,start);
            report.startedUTC=new Date().toUTCString();
            report.canonicalManagerSHA256=BuildInfo.CANONICAL_SHA;report.buildGeneration=BuildInfo.GENERATION;
            guard(runInitial);
        }
        private function check(label:String,passed:Boolean,actual:Object=null):void
        {
            checks.push({label:label,passed:passed,actual:actual});render();
        }
        private function guard(action:Function):void
        {
            try{action();}catch(error:Error){report.error={text:error.message,stack:error.getStackTrace()};finish();}
        }
        private function slotGold(slot:int):Number
        {
            var meta:Object=LocalSaveManager.loadSlot(slot);return meta?Number(meta.data.gold):NaN;
        }
        private function runInitial():void
        {
            check("initial status is idle",LocalSaveManager.lastStatus=="idle");
            FakeSharedObject.throwOnOpen=true;
            check("getLocal exception returns failed",LocalSaveManager.saveSlot(0,"not-written",{gold:1})=="failed");
            check("open failure sets error",LocalSaveManager.lastError.indexOf("injected open failure")>=0);
            FakeSharedObject.throwOnOpen=false;
            fake.data.slots=[null,null,{index:2,title:"6.0·毕业起点 Lv85",displayName:"6.0·毕业起点",datetime:"test",data:{logNameSave:"role-a",gold:77}},null,null,null,null,null];
            LocalSaveManager.init();
            check("initialization performs no implicit flush",fake.flushCalls==0);
            check("empty slots remain empty",LocalSaveManager.loadSlot(0)==null);
            fake.nextResult="flushed";
            LocalSaveManager.saveSlot(2,"P1:Lv86",{logNameSave:"role-a",gold:78});
            check("user label survives same-role save with updated level",LocalSaveManager.loadSlot(2).title=="6.0·毕业起点 Lv86");
            check("user label does not alter game data",slotGold(2)==78);
            fake.nextResult="failed";
            LocalSaveManager.saveSlot(2,"P1:Lv87",{logNameSave:"role-a",gold:79});
            check("failed save preserves prior label and data",LocalSaveManager.loadSlot(2).title=="6.0·毕业起点 Lv86"&&slotGold(2)==78);
            fake.nextResult="flushed";
            LocalSaveManager.saveSlot(2,"P1:Lv1",{logNameSave:"role-b",gold:0});
            check("new role does not inherit another role label",LocalSaveManager.loadSlot(2).title=="P1:Lv1"&&!LocalSaveManager.loadSlot(2).hasOwnProperty("displayName"));
            incoming={gold:10,chapter:{stage:1},bag:[{id:7,count:2}]};
            fake.nextResult="flushed";
            var result:String=LocalSaveManager.saveSlot(0,"base",incoming,function(status:String,error:String):void{synchronousCallbacks++;});
            check("synchronous flushed status",result=="flushed"&&LocalSaveManager.lastStatus=="flushed"&&!LocalSaveManager.isPending);
            check("no callback for synchronous result",synchronousCallbacks==0);
            incoming.gold=999;incoming.chapter.stage=99;incoming.bag[0].count=99;
            var loaded:Object=LocalSaveManager.loadSlot(0);
            check("save snapshots nested live data",loaded.data.gold==10&&loaded.data.chapter.stage==1&&loaded.data.bag[0].count==2);
            loaded.data.gold=888;loaded.data.chapter.stage=88;
            check("load result cannot mutate confirmed data",slotGold(0)==10&&LocalSaveManager.loadSlot(0).data.chapter.stage==1);
            check("synchronous fake disk readback",fake.persisted.slots[0].data.gold==10&&fake.persisted.slots[0].data.chapter.stage==1);
            LocalSaveManager.saveSlot(1,"other-slot",{gold:200,chapter:{stage:2}});
            check("two slots stay separate",slotGold(0)==10&&slotGold(1)==200);
            fake.nextResult="failed";
            check("unknown flush result fails",LocalSaveManager.saveSlot(0,"bad-result",{gold:500})=="failed");
            check("failed result rolls back memory",slotGold(0)==10&&fake.data.slots[0].data.gold==10);
            check("failed result preserves other slot",slotGold(1)==200);
            fake.nextResult="throw";
            check("flush exception returns failed",LocalSaveManager.saveSlot(0,"throw",{gold:600})=="failed");
            check("exception error and rollback",LocalSaveManager.lastError.indexOf("injected flush exception")>=0&&slotGold(0)==10&&fake.data.slots[0].data.gold==10);
            incoming={gold:30,chapter:{stage:3},bag:[{id:7,count:4}]};
            fake.nextResult="pending";
            result=LocalSaveManager.saveSlot(0,"pending-success",incoming,function(status:String,error:String):void{
                pendingCallbacks++;check("pending callback status and unlocked state",status=="flushed"&&error==""&&!LocalSaveManager.isPending);
            });
            check("pending is not a success",result=="pending"&&LocalSaveManager.lastStatus=="pending"&&LocalSaveManager.isPending&&pendingCallbacks==0);
            check("pending reads expose old confirmed slot",slotGold(0)==10&&String(LocalSaveManager.getSlotTitles()[0]).indexOf("base")==0);
            incoming.gold=3000;incoming.chapter.stage=300;incoming.bag[0].count=300;
            previousFlushCalls=fake.flushCalls;
            check("pending rejects another slot write",LocalSaveManager.saveSlot(1,"blocked",{gold:9999})=="blocked");
            check("blocked request never invokes flush",fake.flushCalls==previousFlushCalls&&LocalSaveManager.lastStatus=="pending");
            check("pending snapshot is not overwritten",fake.pendingSnapshot.slots[0].data.gold==30&&fake.pendingSnapshot.slots[1].data.gold==200);
            fake.signal("SharedObject.Unrelated.Status");
            check("unrelated status cannot resolve pending",LocalSaveManager.isPending&&pendingCallbacks==0);
            setTimeout(function():void{guard(resolveSuccess);},25);
        }
        private function resolveSuccess():void
        {
            fake.resolve(true);
            check("async success callback exactly once",pendingCallbacks==1);
            check("async success confirms full original snapshot",slotGold(0)==30&&LocalSaveManager.loadSlot(0).data.chapter.stage==3&&LocalSaveManager.loadSlot(0).data.bag[0].count==4);
            check("async success preserves unrelated slot",slotGold(1)==200&&fake.persisted.slots[1].data.gold==200);
            check("pending disk readback equals submitted data",fake.persisted.slots[0].data.gold==30&&fake.persisted.slots[0].data.chapter.stage==3);
            fake.signal("SharedObject.Flush.Success");fake.signal("SharedObject.Flush.Failed");
            check("duplicate completion ignored",pendingCallbacks==1&&LocalSaveManager.lastStatus=="flushed"&&slotGold(0)==30);
            fake.nextResult="pending";
            LocalSaveManager.saveSlot(0,"pending-failure",{gold:44,chapter:{stage:4}},function(status:String,error:String):void{
                failedCallbacks++;check("failed callback reports failure once",status=="failed"&&error.length>0&&!LocalSaveManager.isPending);
            });
            setTimeout(function():void{guard(resolveFailure);},25);
        }
        private function resolveFailure():void
        {
            fake.resolve(false);
            check("async denial rolls back confirmed and store memory",slotGold(0)==30&&fake.data.slots[0].data.gold==30&&fake.persisted.slots[0].data.gold==30);
            fake.signal("SharedObject.Flush.Failed");fake.signal("SharedObject.Flush.Success");
            check("duplicate failure callback ignored",failedCallbacks==1&&LocalSaveManager.lastStatus=="failed");
            fake.nextResult="pending";
            LocalSaveManager.saveSlot(0,"then-retry",{gold:55,chapter:{stage:5}},function(status:String,error:String):void{
                retryCallbacks++;
                check("callback entered after lock released",!LocalSaveManager.isPending&&status=="flushed");
                fake.nextResult="flushed";
                check("callback may save another full slot",LocalSaveManager.saveSlot(1,"callback-next",{gold:222,chapter:{stage:22}})=="flushed");
            });
            setTimeout(function():void{guard(finishRetry);},25);
        }
        private function finishRetry():void
        {
            fake.resolve(true);
            check("callback retry does not corrupt first transaction",retryCallbacks==1&&slotGold(0)==55&&slotGold(1)==222);
            check("final fake disk holds both full slots",fake.persisted.slots[0].data.chapter.stage==5&&fake.persisted.slots[1].data.chapter.stage==22);
            check("no unresolved transaction remains",!LocalSaveManager.isPending&&LocalSaveManager.lastStatus=="flushed");
            finish();
        }
        private function finish():void
        {
            if(complete)return;complete=true;
            var failures:int=0;for each(var row:Object in checks)if(!row.passed)failures++;
            report.completed=true;report.pass=failures==0&&!report.error;report.failures=failures;
            report.fakeFlushCalls=fake.flushCalls;report.finalStatus=LocalSaveManager.lastStatus;
            report.finalConfirmed=[LocalSaveManager.loadSlot(0),LocalSaveManager.loadSlot(1)];
            report.fakePersisted=fake.persisted;
            report.outputStore=REPORT_NAME;
            // The ONLY real SharedObject opened by this harness is this diagnostic report.
            try{
                var diagnostic:SharedObject=SharedObject.getLocal(REPORT_NAME,"/");
                diagnostic.data.payload=JSON.stringify(report);
                report.reportFlush=diagnostic.flush();
                report.reportMemoryReadback=JSON.parse(String(diagnostic.data.payload)).completed===true;
                diagnostic.data.payload=JSON.stringify(report);diagnostic.flush();
            }catch(error:Error){report.reportWriteError=error.message;}
            render();
        }
        private function render():void
        {
            heading.text="LocalSaveManager contract: "+(complete?(report.pass?"PASS":"FAIL"):"RUNNING")+"  ("+checks.length+" checks)";
            var lines:Array=["Real manager control flow; fake storage only. Native permission UI NOT tested."];
            for each(var row:Object in checks)lines.push((row.passed?"PASS ":"FAIL ")+row.label);
            if(report.error)lines.push("ERROR "+report.error.text);
            if(report.reportWriteError)lines.push("REPORT WRITE ERROR "+report.reportWriteError);
            if(complete)lines.push("Report: "+REPORT_NAME+" | checks="+checks.length+" | failed="+report.failures);
            screen.text=lines.join("\n");screen.scrollV=Math.max(1,screen.maxScrollV);
        }
    }
}
