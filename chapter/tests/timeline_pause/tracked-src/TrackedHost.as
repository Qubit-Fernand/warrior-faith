package {
 import flash.display.Sprite;import flash.display.MovieClip;import flash.events.Event;
 import flash.text.TextField;import flash.text.TextFormat;import flash.net.SharedObject;import flash.utils.setTimeout;
 import timelineprobe.WorldTimelinePause;import timelineprobe.TrackedProbe;import timelineprobe.NativeProbe;import timelineprobe.BuildInfo;
 public class TrackedHost extends Sprite {
  private var label:TextField=new TextField();
  private var report:Object={generation:BuildInfo.GENERATION,phase:"starting",runtimeExecuted:true,checks:[],samples:{}};
  private var failures:int=0;private var running:TrackedProbe;private var stopped:TrackedProbe;private var scripted:TrackedProbe;
  private var numeric:TrackedProbe;private var nativeNumeric:NativeProbe;private var missing:TrackedProbe;private var nativeMissing:NativeProbe;
  private var before:Array;private var newcomer:TrackedProbe;private var pause:WorldTimelinePause=new WorldTimelinePause();private var removed:TrackedProbe;private var unknownBefore:int;
  public function TrackedHost(){loaderInfo.addEventListener(Event.COMPLETE,ready);addEventListener(Event.ENTER_FRAME,ready);}
  private function ready(e:Event):void {
   if(!stage)return;try{var v:uint=loaderInfo.swfVersion;}catch(error:Error){if(error.errorID==2099)return;throw error;}
   loaderInfo.removeEventListener(Event.COMPLETE,ready);removeEventListener(Event.ENTER_FRAME,ready);start();
  }
  private function start():void {
   graphics.beginFill(0x14232E);graphics.drawRect(0,0,940,580);graphics.endFill();
   label.defaultTextFormat=new TextFormat("_sans",13,0xE9F1EF);label.width=920;label.height=565;label.x=10;label.y=5;label.multiline=true;label.wordWrap=true;addChild(label);
   report.hostVersion=loaderInfo.swfVersion;check("Direct host remains SWF9",loaderInfo.swfVersion==9);
   running=make();stopped=make();scripted=make();scripted.stopOnThree=true;
   check("Default command state starts playing",running.trackedPlaying);
   stopped.gotoAndStop(2);check("gotoAndStop tracks false",!stopped.trackedPlaying);
   running.gotoAndStop("known");check("Known label gotoAndStop tracks false",!running.trackedPlaying);
   running.gotoAndPlay("known");check("Known label gotoAndPlay tracks true",running.trackedPlaying);
   missing=make();nativeMissing=new NativeProbe();addChild(nativeMissing);missing.stop();nativeMissing.stop();
   missing.gotoAndPlay("__missing__");nativeMissing.gotoAndPlay("__missing__");check("Missing label gotoAndPlay tracks the native play command",missing.trackedPlaying);
   numeric=make();nativeNumeric=new NativeProbe();addChild(nativeNumeric);numeric.stop();nativeNumeric.stop();report.samples.missingStoppedAt=missing.enteredFrames;
   numeric.gotoAndPlay("2");nativeNumeric.gotoAndPlay("2");
   report.phase="native playback and frame-script stop baseline";paint();setTimeout(baseline,450);
  }
  private function make():TrackedProbe{var c:TrackedProbe=new TrackedProbe();addChild(c);return c;}
  private function baseline():void {
   check("Default native timeline advances",running.enteredFrames>3);
   check("Explicitly stopped native timeline stays frame 2",stopped.currentFrame==2);
   check("Authored frame-script stop dispatches override",scripted.stopCalls==1 && !scripted.trackedPlaying && scripted.currentFrame==3);
   report.samples.missingLabel={tracked:missing.trackedPlaying,trackedFrames:missing.enteredFrames,nativeFrames:nativeMissing.enteredFrames};
   check("Missing label native baseline really plays",missing.currentFrame==nativeMissing.currentFrame && missing.enteredFrames==nativeMissing.enteredFrames && missing.enteredFrames>2);
   missing.gotoAndStop("__missing__");nativeMissing.gotoAndStop("__missing__");check("Missing label gotoAndStop tracks native stop command",!missing.trackedPlaying);
   report.samples.numericString={tracked:numeric.trackedPlaying,trackedFrames:numeric.enteredFrames,nativeFrames:nativeNumeric.enteredFrames,trackedFrame:numeric.currentFrame,nativeFrame:nativeNumeric.currentFrame};
   check("Numeric string playback matches tracked intent",numeric.trackedPlaying==Boolean(nativeNumeric.enteredFrames>2));
   numeric.stop();nativeNumeric.stop();report.samples.missingStoppedAt=missing.enteredFrames;
   pause.freeze(this);pause.freeze(this);
   check("Holding preserves previous true and false intent",running.trackedPlaying && !stopped.trackedPlaying && !scripted.trackedPlaying);
   newcomer=make();check("World ADDED capture holds new native timeline immediately",newcomer.pauseHeld);
   removed=make();removeChild(removed);nativeNumeric.play();unknownBefore=nativeNumeric.enteredFrames;
   running.play();check("play while held preserves held state",running.pauseHeld && running.trackedPlaying);
   setTimeout(beginFrozen,100);
  }
  private function beginFrozen():void {report.samples.missingStoppedSettled={tracked:missing.enteredFrames,native:nativeMissing.enteredFrames};before=[running.enteredFrames,stopped.enteredFrames,scripted.enteredFrames,newcomer.enteredFrames];report.phase="held for 450ms";paint();setTimeout(frozen,450);}
  private function frozen():void {
   report.samples.missingStoppedAfter={tracked:missing.enteredFrames,native:nativeMissing.enteredFrames};
   check("Missing-label gotoAndStop really stops native frames",missing.enteredFrames==int(report.samples.missingStoppedSettled.tracked) && nativeMissing.enteredFrames==int(report.samples.missingStoppedSettled.native));
   check("Held running native timeline executes no further frame scripts",running.enteredFrames==before[0]);
   check("Held stopped native timeline stays stopped",stopped.enteredFrames==before[1]);
   check("Held script-stopped native timeline stays stopped",scripted.enteredFrames==before[2]);
   check("Newly attached held native timeline does not run",newcomer.enteredFrames==before[3]);
   check("Unknown native timeline is deliberately untouched",nativeNumeric.enteredFrames>unknownBefore);nativeNumeric.stop();
   pause.resume();pause.resume();check("Removed timeline is cleared without restart",!removed.pauseHeld && !removed.trackedPlaying);
   report.phase="resume 450ms";paint();setTimeout(resumed,450);
  }
  private function resumed():void {
   check("Previously running timeline resumes",running.enteredFrames>before[0]);
   check("Previously stopped timeline never restarts",stopped.enteredFrames==before[1] && stopped.currentFrame==2);
   check("Frame-script-stopped timeline never restarts",scripted.enteredFrames==before[2] && scripted.currentFrame==3);
   check("New timeline resumes from remembered intent",newcomer.enteredFrames>before[3]);
   running.nextFrame();check("nextFrame tracks stopped",!running.trackedPlaying);running.play();running.prevFrame();check("prevFrame tracks stopped",!running.trackedPlaying);
   running.play();var prior:Boolean=running.trackedPlaying;var threw:Boolean=false;try{running.gotoAndStop(1,"nonexistent scene");}catch(error:Error){threw=true;}
   report.samples.invalidScene={threw:threw,tracked:running.trackedPlaying};check("Invalid scene preserves prior playing state",running.trackedPlaying==prior);
   running.stop();var errorFromStopped:Boolean=false;try{running.gotoAndPlay(1,"nonexistent scene");}catch(invalid:Error){errorFromStopped=true;}check("Invalid scene from stopped preserves false state",errorFromStopped && !running.trackedPlaying);
   running.play();pause.freeze(this);pause.clear();check("Clear does not restart detached/disposed world timelines",!running.pauseHeld && !running.trackedPlaying && !pause.isFrozen);
   running.stop();stopped.stop();scripted.stop();newcomer.stop();report.phase="complete";report.failures=failures;report.pass=failures==0;paint();
   var so:SharedObject=SharedObject.getLocal("yzlr2_timeline_tracked_probe_v1","/");so.data.report=report;try{report.flushStatus=so.flush();}catch(e:Error){report.flushError=e.toString();}paint();
  }
  private function check(name:String,pass:Boolean):void {report.checks.push({name:name,pass:pass});if(!pass)failures++;}
  private function paint():void {var t:String="Tracked native timeline SWF9 — "+BuildInfo.GENERATION+"\n"+report.phase+" | failures="+failures+"\n";for each(var c:Object in report.checks)t+=(c.pass?"PASS ":"FAIL ")+c.name+"\n";label.text=t;}
 }
}
