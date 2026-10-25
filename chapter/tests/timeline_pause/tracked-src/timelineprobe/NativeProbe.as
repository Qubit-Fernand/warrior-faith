package timelineprobe {import flash.display.MovieClip;
 public class NativeProbe extends MovieClip {
  public var enteredFrames:int=0;
  public function NativeProbe(){super();addFrameScript(0,entered,1,entered,2,entered,3,entered);}
  private function entered():void{enteredFrames++;}
 }
}
