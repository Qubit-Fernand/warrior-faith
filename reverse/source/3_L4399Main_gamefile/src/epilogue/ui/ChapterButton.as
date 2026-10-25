package src.epilogue.ui
{
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class ChapterButton extends Sprite
    {
        private var w:Number;
        private var h:Number;
        private var highlighted:Boolean = false;
        private var hovering:Boolean = false;
        private var callback:Function;
        private var labelField:TextField;
        private var descriptionField:TextField;
        private var enabledValue:Boolean = true;

        public function ChapterButton(label:String, width:Number, height:Number, action:Function, description:String = "")
        {
            super();
            w=width;h=height;callback=action;
            buttonMode=true;mouseChildren=false;tabEnabled=false;tabChildren=false;
            labelField=field(label,16,0xF5E5BE,w-24,26);
            labelField.x=12;labelField.y=description ? 6 : (h-26)/2;
            addChild(labelField);
            if(description) {
                descriptionField=field(description,12,0xD9C8A9,w-24,h-31);
                descriptionField.x=12;descriptionField.y=29;addChild(descriptionField);
            }
            addEventListener(MouseEvent.ROLL_OVER,over);
            addEventListener(MouseEvent.ROLL_OUT,out);
            addEventListener(MouseEvent.CLICK,click);
            paint();
        }

        private function field(value:String,size:int,color:uint,width:Number,height:Number):TextField
        {
            var t:TextField=new TextField();
            t.defaultTextFormat=new TextFormat("PingFang SC",size,color);
            t.text=value;t.width=width;t.height=height;t.selectable=false;
            t.multiline=true;t.wordWrap=true;t.mouseEnabled=false;
            return t;
        }
        public function setSelected(value:Boolean):void {highlighted=value;paint();}
        public function setEnabled(value:Boolean):void {enabledValue=value;mouseEnabled=value;buttonMode=value;alpha=value?1:.42;paint();}
        public function activate():void {if(enabledValue && callback!=null)callback();}
        private function over(e:MouseEvent):void {hovering=true;paint();}
        private function out(e:MouseEvent):void {hovering=false;paint();}
        private function click(e:MouseEvent):void
        {
            e.stopImmediatePropagation();
            var focusStage:Stage=stage;
            try {activate();}
            finally {
                // The callback can remove this button, open another modal, or
                // start a scene transition. Never leave focus on the old sprite.
                if(focusStage)focusStage.focus=focusStage;
            }
        }
        private function paint():void
        {
            graphics.clear();
            graphics.lineStyle(highlighted||hovering?2:1,highlighted||hovering?0xE7C984:0x967647);
            graphics.beginFill(highlighted||hovering?0x4E594E:0x2E4247);
            graphics.drawRoundRect(0,0,w,h,9,9);graphics.endFill();
            graphics.lineStyle(1,0xF0D59C,.14);graphics.moveTo(10,3);graphics.lineTo(w-10,3);
            if(highlighted){graphics.beginFill(0xE9C778);graphics.moveTo(w-18,h/2-4);graphics.lineTo(w-12,h/2);graphics.lineTo(w-18,h/2+4);graphics.endFill();}
        }
        public function dispose():void
        {
            removeEventListener(MouseEvent.ROLL_OVER,over);removeEventListener(MouseEvent.ROLL_OUT,out);removeEventListener(MouseEvent.CLICK,click);callback=null;
        }
    }
}
