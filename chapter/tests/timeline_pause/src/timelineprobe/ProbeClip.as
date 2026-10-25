package timelineprobe
{
    import flash.display.MovieClip;
    /** Linked by build.py to a newly authored four-frame DefineSprite. */
    public class ProbeClip extends MovieClip
    {
        public var enteredFrames:int=0;
        public function ProbeClip()
        {
            super();
            addFrameScript(0,entered,1,entered,2,entered,3,entered);
        }
        private function entered():void {enteredFrames++;}
    }
}
