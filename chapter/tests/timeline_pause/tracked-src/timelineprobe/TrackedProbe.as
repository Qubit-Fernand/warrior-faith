package timelineprobe {
 public class TrackedProbe extends TrackedClip {
  public var enteredFrames:int=0;
  public var stopOnThree:Boolean=false;
  public var stopCalls:int=0;
  public function TrackedProbe(){super();addFrameScript(0,entered,1,entered,2,entered,3,entered);}
  private function entered():void {enteredFrames++;if(stopOnThree && currentFrame==3){stopCalls++;stop();}}
 }
}
