package timelineprobe
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.utils.Dictionary;

    /** Holds exact tracked native command state; unknown decorative clips are untouched. */
    public class WorldTimelinePause
    {
        private var world:DisplayObjectContainer;
        private var worldStage:Stage;
        private var held:Array=[];
        private var visited:Dictionary=new Dictionary(true);
        private var frozen:Boolean=false;
        private var unknownStates:int=0;
        private var originallyPlaying:int=0;
        public function WorldTimelinePause(){}
        public function get isFrozen():Boolean{return frozen;}
        public function get frozenCount():int{return originallyPlaying;}
        public function get playbackMode():String{return !frozen?"idle":(unknownStates==0?"tracked":"tracked-partial");}
        public function get playbackDiagnostics():Object{return {mode:playbackMode,known:held.length,unknown:unknownStates,stopped:originallyPlaying,held:held.length};}
        public function freeze(root:DisplayObjectContainer):void
        {
            if(frozen || root==null)return;
            frozen=true;world=root;worldStage=root.stage;held=[];visited=new Dictionary(true);
            unknownStates=0;originallyPlaying=0;
            // Capture runs before newly added Fly's target listener can reparent it.
            world.addEventListener(Event.ADDED,added,true,10000,true);
            freezeTree(root);
        }
        private function added(event:Event):void
        {
            var node:DisplayObject=event.target as DisplayObject;
            if(frozen && node!=null && belongsTo(node,world))freezeTree(node);
        }
        private function freezeTree(node:DisplayObject):void
        {
            if(visited[node]!==true)
            {
                visited[node]=true;
                var clip:TrackedClip=node as TrackedClip;
                if(clip!=null)
                {
                    if(clip.trackedPlaying)originallyPlaying++;
                    clip.holdTimeline();held.push(clip);
                }
                else if(node is MovieClip)unknownStates++;
            }
            var container:DisplayObjectContainer=node as DisplayObjectContainer;
            if(container==null)return;
            for(var i:int=0;i<container.numChildren;i++)freezeTree(container.getChildAt(i));
        }
        public function resume():void
        {
            if(!frozen)return;
            var root:DisplayObjectContainer=world;var originalStage:Stage=worldStage;var snapshot:Array=held;
            reset();
            for each(var clip:TrackedClip in snapshot)
            {
                if(root!=null && originalStage!=null && root.stage==originalStage && belongsTo(clip,root))clip.releaseTimeline();
                else clip.abandonTimelineHold();
            }
        }
        private function belongsTo(node:DisplayObject,root:DisplayObjectContainer):Boolean
        {
            if(root==null)return false;
            while(node!=null){if(node==root)return true;node=node.parent;}
            return false;
        }
        private function reset():void
        {
            if(world!=null)world.removeEventListener(Event.ADDED,added,true);
            frozen=false;held=[];visited=new Dictionary(true);world=null;worldStage=null;unknownStates=0;originallyPlaying=0;
        }
        /** Disposed/detached world objects are never played by cleanup. */
        public function clear():void
        {
            var snapshot:Array=held;reset();
            for each(var clip:TrackedClip in snapshot)clip.abandonTimelineHold();
        }
    }
}
