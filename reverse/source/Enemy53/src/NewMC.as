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
      
      public static function Open(nameX:String, where:MovieClip, xx:int = 0, yy:int = 0, timeX:int = 0, otherX:int = 0, upMoveX:Boolean = false, upXX:int = 2, newOther:String = "") : *
      {
         if(!where)
         {
            return;
         }
         var classRef:Class = getDefinitionByName(nameX) as Class;
         var newMC:NewMC = new classRef();
         newMC.nameXX = nameX;
         newMC.who = where;
         newMC.x = xx;
         newMC.y = yy;
         newMC.time = timeX;
         newMC.other = otherX;
         newMC.upMove = upMoveX;
         newMC.upX = upXX;
         newMC.newOther = newOther;
         where.addChild(newMC);
      }
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         var str:String = null;
         var i:* = 0;
         var ii:int = 0;
         var xx:uint = 0;
         if(this.nameXX == "_攻击数字" || this.nameXX == "_被打数字" || this.nameXX == "_暴击数字" || this.nameXX == "_特殊数字")
         {
            _1_mc.visible = _2_mc.visible = _3_mc.visible = _4_mc.visible = _5_mc.visible = _6_mc.visible = false;
            str = String(this.other);
            i = str.length;
            if(i > 6)
            {
               i = 6;
               str = 999999;
            }
            while(i)
            {
               ii = int(str.substr(i - 1,1));
               this["_" + i + "_mc"].visible = true;
               if(ii == 0)
               {
                  this["_" + i + "_mc"].gotoAndStop(10);
               }
               else
               {
                  this["_" + i + "_mc"].gotoAndStop(ii);
               }
               if(i == 1 && ii == 0)
               {
                  this["_" + i + "_mc"].visible = false;
               }
               i--;
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
         else if(this.nameXX == "雪")
         {
            xx = Math.random() * 6 + 1;
            this.gotoAndStop(xx);
            if(xx > 5)
            {
               this.downSpeed = 5;
            }
            else if(xx > 4)
            {
               this.downSpeed = 4;
            }
            else if(xx > 1)
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
      
      public function Over(e:*) : *
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
      
      public function TimeOver(e:*) : *
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
      
      public function TimeOver2(e:*) : *
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

