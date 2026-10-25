package src.epilogue.ui
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Stage;

    /**
     * Pauses only timelines whose playing state is explicitly readable and true.
     * SWF9 may not expose isPlaying: unknown clips are never stopped or restarted.
     * ENTER_FRAME handlers, timers, sounds and UI are owned by the controller.
     * Use one instance per world; call clear(), never resume(), during disposal.
     */
    public class WorldTimelinePause
    {
        private var world:DisplayObjectContainer;
        private var worldStage:Stage;
        private var playing:Array = [];
        private var frozen:Boolean = false;
        private var knownStates:int = 0;
        private var unknownStates:int = 0;

        public function WorldTimelinePause() {}

        public function get isFrozen():Boolean {return frozen;}
        public function get frozenCount():int {return playing.length;}
        public function get playbackMode():String
        {
            if(!frozen)return "idle";
            if(unknownStates==0)return "timelines";
            return knownStates==0?"logic-only":"partial";
        }
        public function get playbackDiagnostics():Object
        {return {mode:playbackMode,known:knownStates,unknown:unknownStates,stopped:playing.length};}

        /** Nested/repeated calls do not replace the original playback snapshot. */
        public function freeze(root:DisplayObjectContainer):void
        {
            if(frozen || root==null)return;
            frozen=true;world=root;worldStage=root.stage;playing=[];
            knownStates=0;unknownStates=0;
            freezeTree(root);
        }

        private function freezeTree(node:DisplayObject):void
        {
            var clip:MovieClip=node as MovieClip;
            if(clip)
            {
                var state:* = null;
                // A newer observer SWF can expose APIs unavailable to the direct SWF9
                // entry. Dynamic lookup alone is not enough: sealed clips throw 1069.
                try {state=Object(clip)["isPlaying"];}
                catch(unavailable:Error) {state=null;}
                if(state is Boolean)
                {
                    knownStates++;
                    if(state===true)
                    {
                        clip.stop();
                        playing.push(clip);
                    }
                }
                else unknownStates++;
            }
            var container:DisplayObjectContainer=node as DisplayObjectContainer;
            if(container==null)return;
            for(var i:int=0;i<container.numChildren;i++)freezeTree(container.getChildAt(i));
        }

        /**
         * Restores the saved playing set, excluding clips removed/reparented out
         * of this world. A detached/replaced world is never restarted.
         */
        public function resume():void
        {
            if(!frozen)return;
            var root:DisplayObjectContainer=world;
            var originalStage:Stage=worldStage;
            var snapshot:Array=playing;
            clear();
            // Clear first: callbacks and repeated resume cannot replay this set.
            if(root==null || originalStage==null || root.stage!=originalStage)return;
            for each(var clip:MovieClip in snapshot)
            {
                if(belongsTo(clip,root))clip.play();
            }
        }

        private function belongsTo(node:DisplayObject,root:DisplayObjectContainer):Boolean
        {
            while(node!=null)
            {
                if(node==root)return true;
                node=node.parent;
            }
            return false;
        }

        /** Discards a snapshot without playing any old world object. */
        public function clear():void
        {
            frozen=false;playing=[];world=null;worldStage=null;
            knownStates=0;unknownStates=0;
        }
    }
}
