package src
{
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class NewMC extends MovieClip
   {
      
      public var nameXX:String;
      
      public var other:int;
      
      public var time:int = 0;
      
      private var upMove:Boolean;
      
      private var upX:int;
      
      public var who:*;
      
      public function NewMC()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
      }
      
      public static function Open(param1:String, param2:MovieClip, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:Boolean = false, param8:int = 2) : *
      {
         if(!param2)
         {
            return;
         }
         var _loc9_:Class = getDefinitionByName(param1) as Class;
         var _loc10_:NewMC = new _loc9_();
         _loc10_.nameXX = param1;
         _loc10_.who = param2;
         _loc10_.x = param3;
         _loc10_.y = param4;
         _loc10_.time = param5;
         _loc10_.other = param6;
         _loc10_.upMove = param7;
         _loc10_.upX = param8;
         param2.addChild(_loc10_);
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         if(this.nameXX == "_攻击数字" || this.nameXX == "_被打数字" || this.nameXX == "_暴击数字")
         {
            _1_mc.visible = _2_mc.visible = _3_mc.visible = _4_mc.visible = _5_mc.visible = _6_mc.visible = false;
            _loc2_ = String(this.other);
            _loc3_ = _loc2_.length;
            if(_loc3_ > 6)
            {
               _loc3_ = 6;
               _loc2_ = 999999;
            }
            while(_loc3_)
            {
               _loc4_ = int(_loc2_.substr(_loc3_ - 1,1));
               this["_" + _loc3_ + "_mc"].visible = true;
               if(_loc4_ == 0)
               {
                  this["_" + _loc3_ + "_mc"].gotoAndStop(10);
               }
               else
               {
                  this["_" + _loc3_ + "_mc"].gotoAndStop(_loc4_);
               }
               if(_loc3_ == 1 && _loc4_ == 0)
               {
                  this["_" + _loc3_ + "_mc"].visible = false;
               }
               _loc3_--;
            }
            addEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
         else if(this.nameXX == "回血效果" || this.nameXX == "回蓝效果")
         {
            this["_txt"].text = "+" + this.other;
            addEventListener(Event.ENTER_FRAME,this.Over);
         }
         else if(this.nameXX == "掉钱")
         {
            this["_txt"].text = "$" + this.other;
            addEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
         else if(this.nameXX == "闪避" || this.nameXX == "闪避2")
         {
            addEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
         else if(this.nameXX == "挑战关波数")
         {
            this["_txt"].text = "第" + this.other + "波";
            addEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
         else if(this.nameXX == "无入场券")
         {
            addEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
         else
         {
            addEventListener(Event.ENTER_FRAME,this.Over);
         }
         removeEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
      }
      
      public function Over(param1:*) : *
      {
         if(this.currentFrame == this.totalFrames)
         {
            this.stop();
            this.visible = false;
            if(parent)
            {
               this.parent.removeChild(this);
            }
            this.removeEventListener(Event.ENTER_FRAME,this.Over);
         }
      }
      
      public function TimeOver(param1:*) : *
      {
         --this.time;
         if(this.upMove)
         {
            this.y -= this.upX;
         }
         if(this.time < 0)
         {
            stop();
            if(parent)
            {
               parent.removeChild(this);
            }
            removeEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
      }
   }
}

