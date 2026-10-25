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
      
      public static function Open(nameX:String, where:MovieClip, xx:int = 0, yy:int = 0, timeX:int = 0, otherX:int = 0, upMoveX:Boolean = false, upXX:int = 2) : *
      {
         var classRef:Class = null;
         var newMC:NewMC = null;
         if(!where)
         {
            return;
         }
         classRef = getDefinitionByName(nameX) as Class;
         newMC = new classRef();
         newMC.nameXX = nameX;
         newMC.who = where;
         newMC.x = xx;
         newMC.y = yy;
         newMC.time = timeX;
         newMC.other = otherX;
         newMC.upMove = upMoveX;
         newMC.upX = upXX;
         where.addChild(newMC);
      }
      
      public function Over(e:*) : *
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
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         var str:String = null;
         var i:* = 0;
         var ii:int = 0;
         if(nameXX == "_攻击数字" || nameXX == "_被打数字" || nameXX == "_暴击数字")
         {
            _1_mc.visible = _2_mc.visible = _3_mc.visible = _4_mc.visible = _5_mc.visible = false;
            str = String(other);
            i = str.length;
            if(i > 5)
            {
               i = 5;
               str = 99999;
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
      
      public function TimeOver(e:*) : *
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
         var pd:PlayerData = null;
         var arr:Array = null;
         var num:Number = NaN;
         pd = (who as Player).data;
         arr = SkillFactory.getSkillByTypeIAndLevel("b10",pd.getSkillLevel("b10")).getSkillValueArray();
         num = Number((arr[0] as VT).getValue());
         F_J3_fanfYu = 1 + num;
      }
      
      public function TimeOver2(e:*) : *
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

