package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class ShuiBao extends Fly
   {
      
      public static var nowX:Number;
      
      public static var nowY:Number;
      
      public function ShuiBao()
      {
         super();
      }
      
      override public function onADDED_TO_STAGE(e:* = null) : *
      {
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
         speedY = Math.random() * 30 - 15;
      }
   }
}

