package {
  import flash.display.*;
  import flash.events.*;
  import flash.net.URLRequest;
  import flash.system.*;
  import flash.text.*;
  import flash.geom.*;
  import flash.utils.*;
  [SWF(width="940", height="580", frameRate="24", backgroundColor="#101820")]
  public class ModuleProbe extends Sprite {
    private var output:TextField=new TextField();
    private var queue:Array=["../../../equip_1_18.swf", "equip_1_18/equip_1_18-rebuilt.swf", "../../../Music_v3.swf", "Music_v3/Music_v3-rebuilt.swf"];
    private var loaded:Array=[];
    public function ModuleProbe() {
      output.defaultTextFormat=new TextFormat("_sans",16,0xffffff);
      output.width=920;output.height=560;output.x=10;output.y=10;output.multiline=true;output.wordWrap=true;addChild(output);
      output.text="Standalone module reconstruction probe — no game / save access\n"; next();
    }
    private function line(s:String):void {output.appendText(s+"\n");trace(s);}
    private function next():void {
      if(queue.length==0){verify();return;}
      var path:String=queue.shift(),loader:Loader=new Loader();
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e:Event):void{loaded.push(loader);line("Loaded: "+path);next();});
      loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(e:IOErrorEvent):void{line("FAIL loading: "+e.text);});
      loader.load(new URLRequest(path),new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain)));
    }
    private function verify():void {
      try {
        var originalClass:Class=loaded[0].contentLoaderInfo.applicationDomain.getDefinition("S2") as Class;
        var rebuiltClass:Class=loaded[1].contentLoaderInfo.applicationDomain.getDefinition("S2") as Class;
        var a:MovieClip=new originalClass(),b:MovieClip=new rebuiltClass();
        if(a.totalFrames!=340 || b.totalFrames!=a.totalFrames)throw new Error("frame count mismatch");
        if(a.mouseEnabled || a.mouseChildren || b.mouseEnabled || b.mouseChildren)throw new Error("constructor mouse flags mismatch");
        var compared:int=0;
        for(var i:int=1;i<=a.totalFrames;i++) {
          a.gotoAndStop(i);b.gotoAndStop(i);
          var ba:Rectangle=a.getBounds(a),bb:Rectangle=b.getBounds(b);
          if(!ba.equals(bb))throw new Error("bounds frame "+i+": "+ba+" vs "+bb);
          var ma:BitmapData=new BitmapData(256,256,true,0),mb:BitmapData=new BitmapData(256,256,true,0);
          var t:Matrix=new Matrix(1,0,0,1,128,128);ma.draw(a,t);mb.draw(b,t);
          var diff:Object=ma.compare(mb);ma.dispose();mb.dispose();
          if(diff is BitmapData){BitmapData(diff).dispose();throw new Error("pixels differ frame "+i);}
          if(diff!==0)throw new Error("bitmap comparison error "+diff);
          compared++;
        }
        line("PASS equipment: "+compared+" runtime frames identical; constructor mouse flags identical.");
        var names:Array=["女神音乐","战士击中声音","战士挥刀声音","战士转职技能4声音","战斗音乐","拳手技能2声音","拳手普通攻击123声音","拳手普通攻击4声音","村庄音乐","村庄音乐2","法师击中声音","法师技能3声音","法师挥杖声音","海皇城","艾尔之海"];
        for each(var name:String in names){
          var ac:Class=loaded[2].contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
          var bc:Class=loaded[3].contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
          var sa:Object=new ac(),sb:Object=new bc();
          if(sa.length!=sb.length || sa.bytesTotal!=sb.bytesTotal)throw new Error("sound length/bytes mismatch "+name);
        }
        line("PASS sounds: 15 linked classes instantiate; duration and bytes match original.");
        line("ALL MODULE CHECKS PASSED. This does not verify game integration or listening quality.");
      } catch(e:Error){line("FAIL: "+e.toString()+"\n"+e.getStackTrace());}
    }
  }
}
