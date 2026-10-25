package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class NewMC extends MovieClip
   {
      
      public static var F_J3_fanfYu:Number = 1;
      
      public var other:int;
      
      private var upMove:Boolean;
      
      private var upX:int;
      
      public var who:*;
      
      public var time:int = 0;
      
      public var nameXX:String;
      
      public function NewMC()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
      }
      
      public static function Open(param1:String, param2:MovieClip, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:Boolean = false, param8:int = 2) : *
      {
         var _loc9_:Class = null;
         var _loc10_:NewMC = null;
         if(!param2)
         {
            return;
         }
         _loc9_ = getDefinitionByName(param1) as Class;
         _loc10_ = new _loc9_();
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
            this.removeEventListener(Event.ENTER_FRAME,Over);
         }
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         if(nameXX == "_攻击数字" || nameXX == "_被打数字" || nameXX == "_暴击数字")
         {
            _1_mc.visible = _2_mc.visible = _3_mc.visible = _4_mc.visible = _5_mc.visible = false;
            _loc2_ = String(other);
            _loc3_ = _loc2_.length;
            if(_loc3_ > 5)
            {
               _loc3_ = 5;
               _loc2_ = 99999;
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
            addEventListener(Event.ENTER_FRAME,TimeOver);
         }
         else if(nameXX == "回血效果" || nameXX == "回蓝效果")
         {
            this["_txt"].text = "+" + other;
            addEventListener(Event.ENTER_FRAME,Over);
         }
         else if(nameXX == "法师技能3")
         {
            trace("时间" + time);
            获取法师技能3防御附加();
            addEventListener(Event.ENTER_FRAME,TimeOver2);
         }
         else if(nameXX == "掉钱")
         {
            this["_txt"].text = "$" + other;
            addEventListener(Event.ENTER_FRAME,TimeOver);
         }
         else if(nameXX == "闪避2")
         {
            addEventListener(Event.ENTER_FRAME,TimeOver);
         }
         else
         {
            addEventListener(Event.ENTER_FRAME,Over);
         }
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
      }
      
      public function TimeOver(param1:*) : *
      {
         --time;
         if(upMove)
         {
            this.y -= this.upX;
         }
         if(time < 0)
         {
            stop();
            if(parent)
            {
               parent.removeChild(this);
            }
            removeEventListener(Event.ENTER_FRAME,TimeOver);
         }
      }
      
      public function 获取法师技能3防御附加() : *
      {
         var _loc1_:PlayerData = null;
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         _loc1_ = (who as Player).data;
         _loc2_ = SkillFactory.getSkillByTypeIAndLevel("b10",_loc1_.getSkillLevel("b10")).getSkillValueArray();
         _loc3_ = Number((_loc2_[0] as VT).getValue());
         F_J3_fanfYu = 1 + _loc3_;
      }
      
      public function TimeOver2(param1:*) : *
      {
         --time;
         if(upMove)
         {
            this.y -= this.upX;
         }
         if(time < 0)
         {
            stop();
            if(parent)
            {
               parent.removeChild(this);
               F_J3_fanfYu = 1;
            }
            removeEventListener(Event.ENTER_FRAME,TimeOver);
         }
      }
   }
}

