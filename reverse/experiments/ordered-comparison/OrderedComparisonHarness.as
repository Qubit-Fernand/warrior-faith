package {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    [SWF(width="1000",height="700",frameRate="1",backgroundColor="#171a20")]
    public class OrderedComparisonHarness extends Sprite {
        private function originalGold(old:Number,delta:Number,cap:Number):Number {
            var sum:Number=old+delta;
            if(!(sum>cap)) return sum;
            return old;
        }
        private function recoveredGold(old:Number,delta:Number,cap:Number):Number {
            var sum:Number=old+delta;
            if(sum<=cap) return sum;
            return old;
        }
        private function originalActive(time:Number):Boolean { return !(time<=0); }
        private function recoveredActive(time:Number):Boolean { return time>0; }
        private function originalStop(count:Number):Boolean { return !(count>0); }
        private function recoveredStop(count:Number):Boolean { return count<=0; }
        private function same(a:Number,b:Number):Boolean { return isNaN(a)&&isNaN(b) || a==b; }
        public function OrderedComparisonHarness() {
            var out:Array=["Ordered comparison recovery probe — no game/save/network APIs", ""];
            var failed:int=0; var checked:int=0;
            var samples:Array=[-Infinity,-1,-0.0,0,1,500000000,500000001,Infinity,NaN];
            for each(var n:Number in samples) {
                var unordered:Boolean=isNaN(n);
                var a:Boolean=originalActive(n),b:Boolean=recoveredActive(n);
                var c:Boolean=originalStop(n),d:Boolean=recoveredStop(n);
                var ok:Boolean=(a!=b)==unordered && (c!=d)==unordered;
                checked++;if(!ok)failed++;
                out.push("value="+n+" active old/new="+a+"/"+b+" stop old/new="+c+"/"+d+" "+(ok?"PASS":"FAIL"));
            }
            var gold:Array=[[100,4,500000000],[500000000,1,500000000],[100,NaN,500000000],[100,4,NaN],[100,Infinity,500000000],[100,-Infinity,500000000]];
            for each(var v:Array in gold) {
                var old:Number=originalGold(v[0],v[1],v[2]);var recovered:Number=recoveredGold(v[0],v[1],v[2]);
                var expectedDifferent:Boolean=isNaN(v[0]+v[1])||isNaN(v[2]);
                ok=(!same(old,recovered))==expectedDifferent;
                checked++;if(!ok)failed++;
                out.push("gold="+v+" => old="+old+" recovered="+recovered+" "+(ok?"PASS":"FAIL"));
            }
            out.push("", "Checked: "+checked+" / Failures: "+failed, "PASS validates the specified counterexamples, not the whole game.");
            var field:TextField=new TextField();field.defaultTextFormat=new TextFormat("_typewriter",15,0xddeeff);
            field.width=980;field.height=680;field.x=10;field.y=10;field.multiline=true;field.selectable=true;
            field.text=out.join("\n");addChild(field);trace(field.text);
        }
    }
}
