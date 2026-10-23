package src
{
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class NewMC extends MovieClip
   {
      
      public var nameXX:String;
      
      public var newOther:String;
      
      public var other:int;
      
      public var time:int = 0;
      
      private var upMove:Boolean;
      
      private var upX:int;
      
      public var who:*;
      
      internal var downSpeed:uint = 2;
      
      public function NewMC()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
      }
      
      public static function Open(param1:String, param2:MovieClip, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:Boolean = false, param8:int = 2, param9:String = "") : *
      {
         if(!param2)
         {
            return;
         }
         var _loc10_:Class = getDefinitionByName(param1) as Class;
         var _loc11_:NewMC = new _loc10_();
         _loc11_.nameXX = param1;
         _loc11_.who = param2;
         _loc11_.x = param3;
         _loc11_.y = param4;
         _loc11_.time = param5;
         _loc11_.other = param6;
         _loc11_.upMove = param7;
         _loc11_.upX = param8;
         _loc11_.newOther = param9;
         param2.addChild(_loc11_);
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         if(this.nameXX == "_攻击数字" || this.nameXX == "_被打数字" || this.nameXX == "_暴击数字" || this.nameXX == "_特殊数字")
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
         else if(this.nameXX == "无入场券" || this.nameXX == "保存失败")
         {
            addEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
         else if(this.nameXX == "获得卡片")
         {
            this["_txt"].text = "获得卡牌:" + this.newOther;
            addEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
         else if(this.nameXX == "圣诞挂件")
         {
            this["_txt"].text = "获得圣诞装饰:" + this.newOther;
            addEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
         else if(this.nameXX == "文字提示")
         {
            this["_txt"].text = this.newOther;
            addEventListener(Event.ENTER_FRAME,this.TimeOver);
         }
         else if(this.nameXX == "文字提示1")
         {
            addEventListener(Event.ENTER_FRAME,this.Over);
         }
         else if(this.nameXX == "文字提示2")
         {
            addEventListener(Event.ENTER_FRAME,this.Over);
         }
         else if(this.nameXX == "文字提示3")
         {
            addEventListener(Event.ENTER_FRAME,this.Over);
         }
         else if(this.nameXX == "文字提示4")
         {
            addEventListener(Event.ENTER_FRAME,this.Over);
         }
         else if(this.nameXX == "文字提示5")
         {
            addEventListener(Event.ENTER_FRAME,this.Over);
         }
         else if(this.nameXX == "雪")
         {
            _loc5_ = Math.random() * 6 + 1;
            this.gotoAndStop(_loc5_);
            if(_loc5_ > 5)
            {
               this.downSpeed = 5;
            }
            else if(_loc5_ > 4)
            {
               this.downSpeed = 4;
            }
            else if(_loc5_ > 1)
            {
               this.downSpeed = 3;
            }
            addEventListener(Event.ENTER_FRAME,this.TimeOver2);
         }
         else
         {
            addEventListener(Event.ENTER_FRAME,this.Over);
         }
         removeEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
      }
      
      public function Over(param1:*) : *
      {
         if(this.currentFrame == this.totalFrames || this is 死亡倒计时 && this.parent is Player && (this.parent as Player).hp.getValue() > 0)
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
      
      public function TimeOver2(param1:*) : *
      {
         this.y += this.downSpeed;
         this.x -= 0;
         if(this.y > 600)
         {
            this.y = -10;
         }
         if(this.x < 0 && this.parent.parent is Map)
         {
            this.x += (this.parent.parent as Map)._width;
         }
         if(Boolean(this.parent) && this.parent.parent != Main.world)
         {
            removeEventListener(Event.ENTER_FRAME,this.TimeOver2);
         }
      }
   }
}

