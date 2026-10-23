package {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;

    // Standalone arithmetic conformance probe: no Loader, network, or save API.
    [SWF(width="940", height="680", frameRate="1", backgroundColor="#171a20")]
    public class DecrementHarness extends Sprite {
        private function one():Number { return 1; }
        private function subtractOne(value:Number):Number { return value - one(); }
        private function decrementOne(value:Number):Number { --value; return value; }
        private function same(a:Number,b:Number):Boolean {
            if(isNaN(a) && isNaN(b)) return true;
            return a == b && (a != 0 || 1/a == 1/b);
        }
        public function DecrementHarness() {
            var samples:Array = [-Infinity,-9007199254740992,-2147483648,-1.5,-1,-0.0,0.0,0.5,1,2,3,4,12,2147483647,2147483648,4294967295,9007199254740992,Infinity,NaN];
            var lines:Array = ["AVM2 subtraction/decrement probe", "No game modules or SharedObject", ""];
            var failures:int = 0;
            for each(var input:Number in samples) {
                var a:Number = subtractOne(input);
                var b:Number = decrementOne(input);
                var ok:Boolean = same(a,b);
                if(!ok) failures++;
                lines.push(String(input)+" => subtract="+a+", decrement="+b+" "+(ok ? "PASS" : "FAIL"));
            }
            // Reject an accidental signed-int32 lowering at the critical boundary.
            var boundary:Number = decrementOne(-2147483648);
            if(boundary != -2147483649) failures++;
            lines.push("", "int32 boundary: "+boundary+" (expected -2147483649)", "Failures: "+failures);
            var text:TextField = new TextField();
            text.defaultTextFormat = new TextFormat("_typewriter",14,0xddeeff);
            text.multiline=true; text.width=920; text.height=660; text.x=10; text.y=10;
            text.selectable=true; text.text=lines.join("\n"); addChild(text); trace(text.text);
        }
    }
}
