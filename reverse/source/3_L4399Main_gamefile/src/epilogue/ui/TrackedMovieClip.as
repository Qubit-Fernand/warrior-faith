package src.epilogue.ui
{
    import flash.display.MovieClip;
    /** Exact native commands, independent of the unavailable SWF9 isPlaying API. */
    public class TrackedMovieClip extends MovieClip
    {
        private var intended:Boolean=true;
        private var held:Boolean=false;
        public function TrackedMovieClip(){super();}
        public function get trackedPlaying():Boolean{return intended;}
        public function get pauseHeld():Boolean{return held;}
        public function holdTimeline():void {if(held)return;held=true;super.stop();}
        public function releaseTimeline():void {if(!held)return;held=false;if(intended)super.play();}
        public function abandonTimelineHold():void {if(!held)return;held=false;intended=false;super.stop();}
        override public function play():void {intended=true;if(!held)super.play();}
        override public function stop():void {intended=false;super.stop();}
        override public function gotoAndPlay(frame:Object,scene:String=null):void
        {
            var previous:Boolean=intended;
            intended=true;
            try {if(held)super.gotoAndStop(frame,scene);else super.gotoAndPlay(frame,scene);}
            catch(error:Error){intended=previous;throw error;}
        }
        override public function gotoAndStop(frame:Object,scene:String=null):void
        {
            var previous:Boolean=intended;
            intended=false;
            try {super.gotoAndStop(frame,scene);}
            catch(error:Error){intended=previous;throw error;}
        }
        override public function nextFrame():void {var previous:Boolean=intended;intended=false;try{super.nextFrame();}catch(error:Error){intended=previous;throw error;}}
        override public function prevFrame():void {var previous:Boolean=intended;intended=false;try{super.prevFrame();}catch(error:Error){intended=previous;throw error;}}
        override public function nextScene():void {var previous:Boolean=intended;intended=false;try{super.nextScene();}catch(error:Error){intended=previous;throw error;}}
        override public function prevScene():void {var previous:Boolean=intended;intended=false;try{super.prevScene();}catch(error:Error){intended=previous;throw error;}}
    }
}
