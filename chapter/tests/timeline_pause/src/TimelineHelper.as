package
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.system.ApplicationDomain;

    /** SWF14 probe only: no game classes, timers, global settings or external I/O. */
    public class TimelineHelper extends Sprite
    {
        private var frozen:Boolean=false;
        private var saved:Array=[];
        private var owner:DisplayObjectContainer;
        private var ownerStage:Stage;
        public function TimelineHelper() {super();mouseEnabled=false;mouseChildren=false;}
        public function info():Object {return {version:loaderInfo.swfVersion,parentDomain:ApplicationDomain.currentDomain.parentDomain!=null};}
        public function inspect(clip:MovieClip):Object
        {
            try {return {supported:true,playing:clip.isPlaying,frame:clip.currentFrame,frames:clip.totalFrames};}
            catch(e:Error) {return {supported:false,errorID:e.errorID,error:e.toString()};}
            return {supported:false,error:"unreachable fallthrough"};
        }
        public function missingLabel(clip:MovieClip):Object
        {
            try {clip.gotoAndStop("__missing_probe_label__");return {threw:false,frame:clip.currentFrame};}
            catch(e:Error) {return {threw:true,errorID:e.errorID};}
            return {threw:true,errorID:-1};
        }
        public function freeze(root:DisplayObjectContainer,clips:Array):Object
        {
            if(frozen)return {stopped:saved.length,repeated:true};
            frozen=true;owner=root;ownerStage=root.stage;saved=[];
            var errors:Array=[];
            for each(var clip:MovieClip in clips)
            {
                try {if(clip.isPlaying){clip.stop();saved.push(clip);}}
                catch(e:Error) {errors.push({errorID:e.errorID,error:e.toString()});}
            }
            return {stopped:saved.length,repeated:false,errors:errors};
        }
        public function resume():int
        {
            if(!frozen)return 0;
            var old:Array=saved;var root:DisplayObjectContainer=owner;var originalStage:Stage=ownerStage;
            frozen=false;saved=[];owner=null;ownerStage=null;
            var count:int=0;
            if(!root || !originalStage || root.stage!==originalStage)return 0;
            for each(var clip:MovieClip in old)if(root.contains(clip)){clip.play();count++;}
            return count;
        }
    }
}
