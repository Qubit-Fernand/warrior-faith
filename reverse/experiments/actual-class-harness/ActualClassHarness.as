package {
 import flash.display.Sprite;
 import flash.display.Loader;
 import flash.events.Event;
 import flash.events.IOErrorEvent;
 import flash.events.UncaughtErrorEvent;
 import flash.events.NetStatusEvent;
 import flash.net.URLLoader;
 import flash.net.URLRequest;
 import flash.net.SharedObject;
 import flash.system.ApplicationDomain;
 import flash.system.LoaderContext;
 import flash.text.TextField;
 import flash.text.TextFormat;
 import flash.utils.setTimeout;
 import flash.utils.getTimer;
 [SWF(width="940",height="580",frameRate="27",backgroundColor="#15202b")]
 public class ActualClassHarness extends Sprite {
  private var log:TextField=new TextField();
  private var loader:Loader=new Loader();
  private var domain:ApplicationDomain;
  private var config:Object;
  private var queue:Array=[];
  private var rows:Array=[];
  private var fatal:Array=[];
  private var current:String="initializing";
  private var passed:int=0;
  private var base:String="com.hotpoint.braveManIII.";
  private var gem:Object,other:Object,quest:Object;
  private var complete:Boolean=false;
  private var store:SharedObject;
  private var persistence:String="not attempted";
  private var soName:String="not assigned";
  public function ActualClassHarness() {
   log.defaultTextFormat=new TextFormat("_sans",15,0xe4eef5);log.width=920;log.height=560;log.x=10;log.y=10;log.multiline=true;log.wordWrap=true;log.selectable=true;addChild(log);
   var input:URLLoader=new URLLoader();
   input.addEventListener(Event.COMPLETE,function(e:Event):void {
    try {
     config=JSON.parse(String(input.data));
     if(config.schema!="yzlr2-actual-class-v1" || (config.mode!="original" && config.mode!="rebuilt") || !/^[a-f0-9]{64}$/.test(config.subjectSHA256)) throw new Error("Invalid fixture manifest");
     domain=new ApplicationDomain(ApplicationDomain.currentDomain);
     loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaded);
     loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,failed);
     loader.contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,function(u:UncaughtErrorEvent):void {fatal.push(String(u.error));show();});
     current="loading ABC-identical library (no document class)";show();
     loader.load(new URLRequest("subject-library.swf"),new LoaderContext(false,domain));
    } catch(err:Error){fatal.push(err.toString());finish();}
   });
   input.addEventListener(IOErrorEvent.IO_ERROR,failed);input.load(new URLRequest("fixture.json"));show();
  }
  private function failed(e:IOErrorEvent):void {fatal.push(e.text);finish();}
  private function cls(n:String):Object {return domain.getDefinition(base+n);}
  private function loaded(e:Event):void {
   try {
    // All fixture objects are ordinary instances of the loaded game's real classes.
    // Public repositories are populated only in this fresh, isolated child domain.
    cls("repository.gem.GemFactory")._GemDataList=[cls("repository.gem.GemBaseData").cteateGemBaseData(991001,1,"probe","",1,1,false,false,false,1,1,0,1,1,1,1,[],0)];
    cls("repository.other.OtherFactory").allData=[cls("repository.other.OtherBasicData").creatOtherBasicData(991002,1,1,"probe",1,1,"",false,1,1,1,0,0,0,0)];
    cls("repository.quest.QuestFactory").allData=[cls("repository.quest.QuestBasicData").creatQuest(991003,991003,1,"probe",1,"",false,1,1,1,1)];
    gem=cls("models.gem.Gem").creatGem(991001,1,[]);other=cls("models.other.Otherobj").creatOther(991002,1);quest=cls("models.quest.Quest").creatQuest(991003,1);
    if(gem.getIsPile() || other.isMany() || quest.isMany()) throw new Error("Nonstack fixture setup failed");
    var specs:Array=[
     ["Bag","isGemBagEmpty","gemBag",24,"gem",false],
     ["Bag","addGemBag","gemBag",24,"gem",true],
     ["Bag","addOtherobjBag","otherobjBag",24,"other",true],
     ["Bag","addQuestBag","questBag",24,"quest",true],
     ["Storage","addGemStorage","gemStorage",35,"gem",true],
     ["Storage","addOtherobjStorage","otherobjStorage",35,"other",true]];
    for each(var spec:Array in specs) for(var hole:int=-1;hole<int(spec[3]);hole++) queue.push({kind:"container",spec:spec,hole:hole});
    for(var map:int=1;map<=3;map++) {
     queue.push({kind:"achievement",map:map,ry:true,tg:false,star:1,limit:0,expected:map<=2});
     queue.push({kind:"achievement",map:map,ry:false,tg:true,star:1,limit:0,expected:map<=2});
     queue.push({kind:"achievement",map:map,ry:false,tg:false,star:1,limit:0,expected:false});
    }
    queue.push({kind:"achievement",map:2,ry:true,tg:false,star:2,limit:0,expected:false});
    queue.push({kind:"achievement",map:2,ry:true,tg:false,star:1,limit:-1,expected:false});
    setTimeout(next,50);
   }catch(err:Error){fatal.push(err.toString()+"\n"+err.getStackTrace());finish();}
  }
  private function next():void {
   if(queue.length==0){finish();return;}
   var f:Object=queue.shift();current=f.kind=="container"?f.spec[0]+"."+f.spec[1]+" hole="+f.hole:"Achievement map="+f.map+" ry="+f.ry+" tg="+f.tg+" star="+f.star+" limit="+f.limit;show();
   // Yield before the actual call so an unexpected VM timeout leaves the exact case visible.
   setTimeout(function():void {
    var start:int=getTimer();var r:Object={name:current,input:f,passed:false};
    try {r.details=f.kind=="container"?container(f):achievement(f);r.passed=true;passed++;}
    catch(err:Error){r.error=err.toString();r.stack=err.getStackTrace();fatal.push(current+": "+err.toString());}
    r.elapsedMs=getTimer()-start;rows.push(r);
    if(fatal.length){finish();return;}setTimeout(next,1);
   },1);
  }
  private function container(f:Object):Object {
   var s:Array=f.spec;var C:Class=cls("models.container."+s[0]) as Class;var object:Object=new C();
   var candidate:Object=s[4]=="gem"?gem:s[4]=="other"?other:quest;
   // Same real item may occupy multiple slots for this structural, nonstack test.
   // The candidate is a distinct actual game instance from the occupied sentinel.
   var sentinel:Object=s[4]=="gem"?cls("models.gem.Gem").creatGem(991001,1,[]):s[4]=="other"?cls("models.other.Otherobj").creatOther(991002,1):cls("models.quest.Quest").creatQuest(991003,1);
   var a:Array=[];var i:int;for(i=0;i<int(s[3]);i++)a[i]=(i==f.hole?null:sentinel);object[s[2]]=a;
   var result:Boolean=object[s[1]](candidate);var expected:Boolean=f.hole>=0;
   if(result!==expected)throw new Error("Return mismatch "+result+" expected "+expected);
   var after:Array=object[s[2]];if(after.length!==int(s[3]))throw new Error("Length changed");
   for(i=0;i<after.length;i++)if(after[i] !== (i==f.hole?(s[5]?candidate:null):sentinel))throw new Error("Unexpected mutation at "+i);
   return {returned:result,expected:expected,writtenIndex:expected&&s[5]?f.hole:-1,allOtherSlotsUnchanged:true};
  }
  private function achievement(f:Object):Object {
   cls("repository.achievement.AchNumFactory").allData=[cls("repository.achievement.AchNumBasicData").ceartAchNum(991004,"probe",1,"",false,1,0,"1*2","1",35,f.limit,1,f.ry,0)];
   var a:Object=cls("models.achievement.Achievement").creatAchForNum(991004);
   a.setMapId(f.map);a.setStarId(f.star);if(f.tg)a.setTg();
   // Real isOk selects smallType35 -> tgByIdAndTimeOk -> private getIddo -> real dbNum.
   var got:Boolean=a.isOk();if(got!==f.expected)throw new Error("Return mismatch "+got+" expected "+f.expected);
   return {returned:got,expected:f.expected,path:"isOk/type35 -> tgByIdAndTimeOk -> getIddo -> dbNum when eligible"};
  }
  private function finish():void {
   complete=true;current="DONE";
   if(config) {
    try {
     soName="yzlr2_actual_class_"+config.mode+"_"+String(config.subjectSHA256).substr(0,12)+"_"+String(config.wrapperSHA256).substr(0,8);
     store=SharedObject.getLocal(soName,"/");
     store.addEventListener(NetStatusEvent.NET_STATUS,function(e:NetStatusEvent):void {persistence=String(e.info.code);show();});
     var report:Object={schema:"yzlr2-actual-class-result-v1",config:config,complete:true,passed:passed,total:183,rows:rows,fatal:fatal,finishedUTC:new Date().toUTCString(),gameSavesAccessed:false,documentClassInstantiated:false};
     store.data.json=JSON.stringify(report);persistence=String(store.flush());
    }
    catch(err:Error){persistence=err.toString();fatal.push("Probe result persistence: "+err.toString());}
   }show();
  }
  private function show():void {log.text="REAL GAME CLASS REGRESSION\n"+(config?config.mode+" "+String(config.subjectSHA256).substr(0,12):"Reading local manifest")+"\nPassed "+passed+" / 183 | Failures "+fatal.length+"\n"+current+"\n\n"+rows.slice(-12).map(function(r:Object,...rest):String{return (r.passed?"PASS ":"FAIL ")+r.name;}).join("\n")+"\n\n"+fatal.join("\n")+"\n\nPersistence: "+persistence+"\nSO: "+soName+"\nOnly local fixture memory; no game save/online API.\nSetKeyPanel private closeOk is outside this probe.";}
 }
}
