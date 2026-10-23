package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   import src.tool.*;
   
   public class XSpao extends Fly
   {
      
      public function XSpao()
      {
         super();
      }
      
      override public function onADDED_TO_STAGE(param1:* = null) : *
      {
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         var _loc2_:MovieClip = this;
         while(_loc2_ != _stage)
         {
            if(_loc2_ is Skin_WuQi && _loc2_.parent is Player)
            {
               who = _loc2_.parent;
               this.RL = (who as Player).RL;
               硬直 = who.skin.硬直;
               gongJi_hp = who.skin.hpX;
               attTimes = who.skin.attTimes;
               runX = who.skin.runX;
               runY = who.skin.runY;
               runTime = who.skin.runTime;
               break;
            }
            if(_loc2_ is EnemySkin && _loc2_.parent is Enemy)
            {
               who = _loc2_.parent;
               this.RL = (who as Enemy).RL;
               硬直 = who.skin.硬直;
               attTimes = who.skin.attTimes;
               gongJi_hp = (_loc2_ as EnemySkin).hpX;
               runX = (_loc2_ as EnemySkin).runX;
               runY = (_loc2_ as EnemySkin).runY;
               runTime = (_loc2_ as EnemySkin).runTime;
               type = (_loc2_ as EnemySkin).type;
               space = (_loc2_ as EnemySkin).space;
               totalTime = (_loc2_ as EnemySkin).totalTime;
               numValue = (_loc2_ as EnemySkin).numValue;
               break;
            }
            _loc2_ = _loc2_.parent as MovieClip;
         }
         Main.world.moveChild_Other.addChild(this);
         this.y += who.y - 290;
         if(this.RL)
         {
            scaleX *= -1;
            this.x = who.x - this.x + 168;
         }
         else
         {
            scaleX *= 1;
            this.x = who.x + this.x - 168;
         }
         if(!this.RL)
         {
            if(this.name == "p1")
            {
               speedX = 32 * Math.sin(80 * Math.PI / 180);
               speedY = 32 * Math.cos(80 * Math.PI / 180);
            }
            else if(this.name == "p2")
            {
               speedX = 32 * Math.sin(70 * Math.PI / 180);
               speedY = 32 * Math.cos(70 * Math.PI / 180);
            }
            else if(this.name == "p3")
            {
               speedX = 32 * Math.sin(50 * Math.PI / 180);
               speedY = 32 * Math.cos(50 * Math.PI / 180);
            }
            else if(this.name == "p4")
            {
               speedX = 32 * Math.sin(30 * Math.PI / 180);
               speedY = 32 * Math.cos(30 * Math.PI / 180);
            }
            else if(this.name == "p5")
            {
               speedX = 32 * Math.sin(10 * Math.PI / 180);
               speedY = 32 * Math.cos(10 * Math.PI / 180);
            }
            else if(this.name == "p6")
            {
               speedX = 32 * Math.sin(0 * Math.PI / 180);
               speedY = 32 * Math.cos(0 * Math.PI / 180);
            }
            else if(this.name == "p7")
            {
               speedX = 32 * Math.sin(-10 * Math.PI / 180);
               speedY = 32 * Math.cos(-10 * Math.PI / 180);
            }
            else if(this.name == "p8")
            {
               speedX = 32 * Math.sin(-30 * Math.PI / 180);
               speedY = 32 * Math.cos(-30 * Math.PI / 180);
            }
            else if(this.name == "p9")
            {
               speedX = 32 * Math.sin(-50 * Math.PI / 180);
               speedY = 32 * Math.cos(-50 * Math.PI / 180);
            }
            else if(this.name == "p10")
            {
               speedX = 32 * Math.sin(-70 * Math.PI / 180);
               speedY = 32 * Math.cos(-70 * Math.PI / 180);
            }
            else if(this.name == "p11")
            {
               speedX = 32 * Math.sin(-80 * Math.PI / 180);
               speedY = 32 * Math.cos(-80 * Math.PI / 180);
            }
            else if(this.name == "p12")
            {
               speedX = 32 * Math.sin(-90 * Math.PI / 180);
               speedY = 32 * Math.cos(-90 * Math.PI / 180);
            }
            else if(this.name == "p13")
            {
               speedX = 32 * Math.sin(-100 * Math.PI / 180);
               speedY = 32 * Math.cos(-100 * Math.PI / 180);
            }
            else if(this.name == "p14")
            {
               speedX = 32 * Math.sin(-110 * Math.PI / 180);
               speedY = 32 * Math.cos(-110 * Math.PI / 180);
            }
            else if(this.name == "p15")
            {
               speedX = 32 * Math.sin(-120 * Math.PI / 180);
               speedY = 32 * Math.cos(-120 * Math.PI / 180);
            }
            else if(this.name == "p16")
            {
               speedX = 32 * Math.sin(-125 * Math.PI / 180);
               speedY = 32 * Math.cos(-125 * Math.PI / 180);
            }
         }
         else if(this.name == "p1")
         {
            speedX = 32 * Math.sin(-80 * Math.PI / 180);
            speedY = 32 * Math.cos(-80 * Math.PI / 180);
         }
         else if(this.name == "p2")
         {
            speedX = 32 * Math.sin(-70 * Math.PI / 180);
            speedY = 32 * Math.cos(-70 * Math.PI / 180);
         }
         else if(this.name == "p3")
         {
            speedX = 32 * Math.sin(-50 * Math.PI / 180);
            speedY = 32 * Math.cos(-50 * Math.PI / 180);
         }
         else if(this.name == "p4")
         {
            speedX = 32 * Math.sin(-30 * Math.PI / 180);
            speedY = 32 * Math.cos(-30 * Math.PI / 180);
         }
         else if(this.name == "p5")
         {
            speedX = 32 * Math.sin(-10 * Math.PI / 180);
            speedY = 32 * Math.cos(-10 * Math.PI / 180);
         }
         else if(this.name == "p6")
         {
            speedX = 32 * Math.sin(0 * Math.PI / 180);
            speedY = 32 * Math.cos(0 * Math.PI / 180);
         }
         else if(this.name == "p7")
         {
            speedX = 32 * Math.sin(10 * Math.PI / 180);
            speedY = 32 * Math.cos(10 * Math.PI / 180);
         }
         else if(this.name == "p8")
         {
            speedX = 32 * Math.sin(30 * Math.PI / 180);
            speedY = 32 * Math.cos(30 * Math.PI / 180);
         }
         else if(this.name == "p9")
         {
            speedX = 32 * Math.sin(50 * Math.PI / 180);
            speedY = 32 * Math.cos(50 * Math.PI / 180);
         }
         else if(this.name == "p10")
         {
            speedX = 32 * Math.sin(70 * Math.PI / 180);
            speedY = 32 * Math.cos(70 * Math.PI / 180);
         }
         else if(this.name == "p11")
         {
            speedX = 32 * Math.sin(80 * Math.PI / 180);
            speedY = 32 * Math.cos(80 * Math.PI / 180);
         }
         else if(this.name == "p12")
         {
            speedX = 32 * Math.sin(90 * Math.PI / 180);
            speedY = 32 * Math.cos(90 * Math.PI / 180);
         }
         else if(this.name == "p13")
         {
            speedX = 32 * Math.sin(100 * Math.PI / 180);
            speedY = 32 * Math.cos(100 * Math.PI / 180);
         }
         else if(this.name == "p14")
         {
            speedX = 32 * Math.sin(110 * Math.PI / 180);
            speedY = 32 * Math.cos(110 * Math.PI / 180);
         }
         else if(this.name == "p15")
         {
            speedX = 32 * Math.sin(120 * Math.PI / 180);
            speedY = 32 * Math.cos(120 * Math.PI / 180);
         }
         else if(this.name == "p16")
         {
            speedX = 32 * Math.sin(125 * Math.PI / 180);
            speedY = 32 * Math.cos(125 * Math.PI / 180);
         }
      }
      
      override public function Move() : *
      {
         this.y += speedY;
         this.x += speedX;
         if(this.x > Main.world._width + 400 || this.x < -400)
         {
            life = 0;
         }
      }
      
      override public function onENTER_FRAME(param1:*) : *
      {
         if(over && this.currentLabel != "结束")
         {
            Dead();
            return;
         }
         if(!over && life == 0)
         {
            life = -1;
            this.rotation = 0;
            gotoAndPlay("结束");
            continuous = false;
            over = true;
         }
         if(!over && time != -1)
         {
            --time;
            if(time == -1)
            {
               time = -1;
               this.rotation = 0;
               gotoAndPlay("结束");
               continuous = false;
               over = true;
            }
         }
         if(continuous && this.currentLabel != "运行")
         {
            gotoAndPlay("运行");
         }
         else if(!continuous && this.currentLabel != "运行")
         {
            over = true;
         }
         if(!over)
         {
            Move();
         }
      }
      
      override public function getData() : *
      {
         life = 1;
         continuous = true;
         cross = false;
         time = 540;
         speedX = 0;
         speedY = 0;
      }
   }
}

