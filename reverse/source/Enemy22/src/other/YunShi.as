package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class YunShi extends Fly
   {
      
      public function YunShi()
      {
         super();
      }
      
      override public function onADDED_TO_STAGE(e:* = null) : *
      {
         var xx:int = 0;
         var tan:Number = NaN;
         var jiaodu:Number = NaN;
         var nowX:Number = NaN;
         removeEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
         var parentMC:MovieClip = this;
         while(parentMC != _stage)
         {
            if(parentMC is Skin_WuQi && parentMC.parent is Player)
            {
               who = parentMC.parent;
               this.RL = (who as Player).RL;
               硬直 = who.skin.硬直;
               gongJi_hp = who.skin.hpX;
               attTimes = who.skin.attTimes;
               runX = who.skin.runX;
               runY = who.skin.runY;
               runTime = who.skin.runTime;
               break;
            }
            if(parentMC is EnemySkin && parentMC.parent is Enemy)
            {
               who = parentMC.parent;
               this.RL = (who as Enemy).RL;
               硬直 = who.skin.硬直;
               attTimes = who.skin.attTimes;
               gongJi_hp = (parentMC as EnemySkin).hpX;
               runX = (parentMC as EnemySkin).runX;
               runY = (parentMC as EnemySkin).runY;
               runTime = (parentMC as EnemySkin).runTime;
               type = (parentMC as EnemySkin).type;
               space = (parentMC as EnemySkin).space;
               totalTime = (parentMC as EnemySkin).totalTime;
               numValue = (parentMC as EnemySkin).numValue;
               break;
            }
            parentMC = parentMC.parent as MovieClip;
         }
         this.y += who.y;
         if(this.RL)
         {
            scaleX *= -1;
            this.x = who.x - this.x;
         }
         else
         {
            scaleX *= 1;
            this.x = who.x + this.x;
         }
         Main.world.moveChild_Other.addChild(this);
         if(Player.All.length > 0)
         {
            xx = Math.random() * Player.All.length;
            tan = Math.abs((Player.All[xx] as Player).x - this.x) / Math.abs(480 - this.y);
            jiaodu = Math.round(Math.atan(tan) * 180 / Math.PI);
            speedX = 32 * Math.sin(jiaodu * Math.PI / 180);
            speedY = 32 * Math.cos(jiaodu * Math.PI / 180);
            nowX = (Player.All[xx] as Player).x - who.x;
            if(nowX < 0)
            {
               this.rotation += jiaodu;
               speedX = -Math.abs(speedX);
            }
            else
            {
               this.rotation -= jiaodu;
               speedX = Math.abs(speedX);
            }
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
      
      override public function onENTER_FRAME(e:*) : *
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
            this.Move();
         }
      }
   }
}

