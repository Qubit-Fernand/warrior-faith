package {
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import flash.text.TextField;
    [SWF(width="940",height="580",frameRate="27",backgroundColor="#333333")]
    public class Source extends Sprite {
        private var game:Loader=new Loader();
        private var clock:Timer=new Timer(1000);
        private var domain:ApplicationDomain;
        private var main:Object;
        private var store:SharedObject;
        private var report:Object={schema:1,mode:"observer-wrapper-not-direct",samples:[],errors:[]};
        private var sequence:int=0;
        public function Source(){if(stage)start();else addEventListener(Event.ADDED_TO_STAGE,start);}
        private function start(event:Event=null):void{
            removeEventListener(Event.ADDED_TO_STAGE,start);
            store=SharedObject.getLocal("yzlr2_rebuild_epilogue_diag_v2","/");
            report.startedUTC=new Date().toUTCString();report.wrapper=loaderInfo.url;
            game.contentLoaderInfo.addEventListener(Event.COMPLETE,loaded);
            game.contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,uncaught);
            game.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioError);
            addChild(game);game.load(new URLRequest("3_L4399Main_gamefile.swf"),new LoaderContext(false,new ApplicationDomain(null)));
        }
        private function loaded(event:Event):void{
            domain=game.contentLoaderInfo.applicationDomain;
            main=domain.getDefinition("src.Main");report.gameURL=game.contentLoaderInfo.url;
            clock.addEventListener(TimerEvent.TIMER,capture);clock.start();capture();
        }
        private function read(object:Object,key:String):*{
            try{return object==null?null:object[key];}catch(error:Error){return null;}
        }
        private function number(value:Object):Number{
            if(value==null)return NaN;
            return value.hasOwnProperty("getValue") || value is Object && read(value,"getValue") is Function?value.getValue():Number(value);
        }
        private function rect(object:DisplayObject):Object{
            if(!object || !object.stage)return null;
            var b:Object=object.getBounds(stage);return {x:b.x,y:b.y,w:b.width,h:b.height};
        }
        private function capture(event:Event=null):void{
            var sample:Object={sequence:sequence++,ms:getTimer()};
            try{
                sample.map=number(read(main,"gameNum"));sample.room=number(read(main,"gameNum2"));
                var world:Object=read(main,"world");var player:Object=read(main,"player_1");
                sample.player=player?{x:player.x,y:player.y,hp:number(player.hp),maxHp:number(player.use_hp_Max),
                    attack:number(player.use_gongji),defense:number(player.use_fangyu),hit:rect(player.hit),skin:rect(player.skin)}:null;
                sample.world=world?{x:world.x,y:world.y,width:world._width,playerLayer:rect(world.moveChild_Player),
                    mapData:rect(world.MapData),stopX1:world.stopX_1,stopX2:world.stopX_2}:null;
                if(world && domain.hasDefinition("src.epilogue.ChapterController")){
                    var controller:Object=domain.getDefinition("src.epilogue.ChapterController");
                    sample.chapter=controller.snapshot();
                }
                sample.gold=read(main,"player1")?number(read(read(main,"player1"),"gold")):null;
                sample.slot=read(main,"saveNum");
                // Read-only focus evidence: never assign focus or synthesize input.
                var focused:InteractiveObject=stage.focus;
                sample.focus=focused?{type:getQualifiedClassName(focused),name:focused.name,
                    onStage:focused.stage!=null,sameStage:focused.stage===stage,
                    parentType:focused.parent?getQualifiedClassName(focused.parent):null}:null;
                sample.keys=read(main,"player1")?read(read(main,"player1"),"_keyArr"):null;
                sample.npcs=[];if(world)collectNPCs(world as DisplayObject,sample.npcs,0);
                sample.ui=[];
                collectText(stage,sample.ui,0);
                sample.nativeRoots={stage:rootChildren(stage),main:rootChildren(read(main,"_this") as DisplayObjectContainer)};
            }catch(error:Error){sample.observerError={id:error.errorID,text:error.message};}
            report.samples.push(sample);while(report.samples.length>20)report.samples.shift();persist();
        }
        private function rootChildren(parent:DisplayObjectContainer):Array{
            var result:Array=[];if(!parent)return result;
            for(var i:int=0;i<parent.numChildren;i++){
                var child:DisplayObject=parent.getChildAt(i);
                result.push({type:getQualifiedClassName(child),name:child.name,visible:child.visible,
                    bounds:rect(child),children:child is DisplayObjectContainer?DisplayObjectContainer(child).numChildren:null});
            }
            return result;
        }
        private function collectNPCs(node:DisplayObject,output:Array,depth:int):void{
            if(depth>12 || output.length>=40)return;
            var type:String=getQualifiedClassName(node);
            if(node is SimpleButton || type.indexOf("npc")>=0)output.push({type:type,name:node.name,bounds:rect(node)});
            if(node is DisplayObjectContainer){var c:DisplayObjectContainer=node as DisplayObjectContainer;for(var i:int=0;i<c.numChildren;i++)collectNPCs(c.getChildAt(i),output,depth+1);}
        }
        private function collectText(node:DisplayObject,output:Array,depth:int):void{
            if(depth>12 || !node.visible || output.length>=45)return;
            if(node is TextField){var text:String=TextField(node).text;if(text.length>0)output.push(text.substr(0,140));return;}
            if(node is DisplayObjectContainer){var c:DisplayObjectContainer=node as DisplayObjectContainer;for(var i:int=0;i<c.numChildren;i++)collectText(c.getChildAt(i),output,depth+1);}
        }
        private function uncaught(event:UncaughtErrorEvent):void{
            var error:Object=event.error;report.errors.push({ms:getTimer(),id:read(error,"errorID"),text:String(error),stack:error is Error?Error(error).getStackTrace():null});
            while(report.errors.length>10)report.errors.shift();persist();
            // Do not preventDefault: the official debugger must still show failures.
        }
        private function ioError(event:IOErrorEvent):void{report.errors.push({ms:getTimer(),text:event.text});persist();}
        private function persist():void{
            var encoded:String=JSON.stringify(report);
            while(encoded.length>90000 && report.samples.length>1){report.samples.shift();encoded=JSON.stringify(report);}
            store.data.payload=encoded;store.flush();
        }
    }
}
