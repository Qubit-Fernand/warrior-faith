package {
 import flash.display.Sprite;
 import flash.net.SharedObject;
 import flash.text.TextField;
 import src.epilogue.ChapterState;
 import src.epilogue.scene.ChapterScenery;
 public class HomecomingHarness extends Sprite {
  private var checks:Array=[];
  private function check(name:String,ok:Boolean):void {checks.push({name:name,pass:ok});}
  private function points(s:ChapterScenery):String {var a:Array=[];for each(var p:Object in s.interactionPoints())a.push(p.id);return a.join(",");}
  public function HomecomingHarness() {
   var legacy:Object={version:1,ending:"release",stage:6,rewardClaims:{returnLight:{gold:50000,pending:0}},seenDialogues:{post_release:true}};
   ChapterState.restore(legacy);
   check("legacy ending and paid reward preserved",ChapterState.value.ending=="release" && ChapterState.value.stage==6 && ChapterState.value.rewardClaims.returnLight.gold==50000);
   check("old completed save can play new coda",ChapterState.value.homecomingSteps==0);
   var scene:ChapterScenery=new ChapterScenery("village_release");scene.setProgress(ChapterState.value);
   check("only wick initially actionable",points(scene)=="post,home_wick");
   check("out-of-order handover rejected",!ChapterState.advanceHomecoming("home_lantern"));
   check("out-of-order course rejected",!ChapterState.advanceHomecoming("home_course"));
   check("wick accepted",ChapterState.advanceHomecoming("home_wick") && ChapterState.value.homecomingSteps==1);
   check("repeated wick rejected",!ChapterState.advanceHomecoming("home_wick"));
   scene.setProgress(ChapterState.value);check("only course now actionable",points(scene)=="post,home_course");
   ChapterState.advanceHomecoming("home_course");
   check("wrong direction not completed",ChapterState.value.homecomingSteps==1 && ChapterState.value.homecomingHeading==1);
   var saved:Object=ChapterState.exported();ChapterState.reset();ChapterState.restore(saved);
   check("partial heading survives serialization",ChapterState.value.homecomingSteps==1 && ChapterState.value.homecomingHeading==1);
   check("restored object is isolated",saved!==ChapterState.value);
   ChapterState.advanceHomecoming("home_course");check("second wrong direction remains incomplete",ChapterState.value.homecomingSteps==1);
   ChapterState.advanceHomecoming("home_course");check("upstream direction completes course",ChapterState.value.homecomingSteps==2 && ChapterState.value.homecomingHeading==3);
   check("solved course cannot change",!ChapterState.advanceHomecoming("home_course"));
   scene.setProgress(ChapterState.value);check("only handover now actionable",points(scene)=="post,home_lantern");
   check("handover completes coda",ChapterState.advanceHomecoming("home_lantern") && ChapterState.value.homecomingSteps==3);
   check("handover is idempotent",!ChapterState.advanceHomecoming("home_lantern"));
   scene.setProgress(ChapterState.value);scene.update(.05);check("completion leaves conversation",points(scene)=="post");
   check("no extra reward claim",ChapterState.value.rewardClaims.returnLight.gold==50000 && ChapterState.value.rewardClaims.returnLight.pending==0);
   ChapterState.restore(ChapterState.exported());check("completed coda restores",ChapterState.value.homecomingSteps==3);
   ChapterState.restore({version:1,ending:"beacon"});check("beacon route refuses coda",!ChapterState.advanceHomecoming("home_wick"));
   var beacon:ChapterScenery=new ChapterScenery("village_beacon");beacon.setProgress(ChapterState.value);check("beacon interactions unchanged",points(beacon)=="post");
   ChapterState.restore({version:99,ending:"release",opaque:{future:true}});
   check("future schema refuses actions",ChapterState.unsupported && !ChapterState.advanceHomecoming("home_wick"));
   check("future payload preserved",ChapterState.value.opaque.future && !ChapterState.value.hasOwnProperty("homecomingSteps"));
   ChapterState.restore({version:1,ending:"release",homecomingSteps:99,homecomingHeading:-1});
   check("progress normalized",ChapterState.value.homecomingSteps==3 && ChapterState.value.homecomingHeading==3);
   ChapterState.restore(legacy);check("input save not mutated",!legacy.hasOwnProperty("homecomingSteps") && legacy.rewardClaims.returnLight.gold==50000);
   var failed:int=0;for each(var c:Object in checks)if(!c.pass)failed++;
   var result:SharedObject=SharedObject.getLocal("returnlight_homecoming_contract_v1","/");
   result.data.report={checks:checks,failed:failed,total:checks.length,gameSaveOpened:false};result.flush();
   var label:TextField=new TextField();label.width=800;label.height=600;label.text=(failed==0?"PASS":"FAIL")+" "+checks.length+" checks\n";
   for each(c in checks)label.appendText((c.pass?"OK ":"FAIL ")+c.name+"\n");addChild(label);
  }
 }
}
