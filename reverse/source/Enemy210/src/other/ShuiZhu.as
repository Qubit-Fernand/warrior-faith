package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class ShuiZhu extends Fly
   {
      
      public static var nowX:Number;
      
      public static var nowY:Number;
      
      public function ShuiZhu()
      {
         super();
      }
      
      override public function onADDED_TO_STAGE(e:* = null) : *
      {
         var xx:int = 0;
         var tan:Number = NaN;
         var jiaodu:Number = NaN;
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
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
         Main.world.moveChild_Other.addChild(this);
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
         if(Player.All.length > 0)
         {
            xx = Math.random() * Player.All.length;
            tan = Math.abs((Player.All[xx] as Player).x - this.x) / Math.abs((Player.All[xx] as Player).y - this.y - 300);
            jiaodu = Math.round(Math.atan(tan) * 180 / Math.PI);
            speedX = 15 * Math.sin(jiaodu * Math.PI / 180);
            speedY = 15 * Math.cos(jiaodu * Math.PI / 180);
            nowX = (Player.All[xx] as Player).x - who.x;
            nowY = (Player.All[xx] as Player).y - this.y;
            if(nowX < 0)
            {
               speedX = -Math.abs(speedX);
            }
            else
            {
               speedX = Math.abs(speedX);
            }
            if(nowY < 0)
            {
               speedY = -Math.abs(speedY);
            }
            else
            {
               speedY = Math.abs(speedY);
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
   }
}

