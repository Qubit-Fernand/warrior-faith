package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class Fire extends Fly
   {
      
      public function Fire()
      {
         super();
      }
      
      override public function onADDED_TO_STAGE(e:* = null) : *
      {
         var parentMC:MovieClip = null;
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         parentMC = this;
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
            if(parentMC is Fly && parentMC.parent is Fly)
            {
               who = (parentMC.parent as Fly).who;
               this.RL = (who as Enemy).RL;
               硬直 = who.skin.硬直;
               attTimes = who.skin.attTimes;
               gongJi_hp = (who.skin as EnemySkin).hpX;
               runX = (who.skin as EnemySkin).runX;
               runY = (who.skin as EnemySkin).runY;
               runTime = (who.skin as EnemySkin).runTime;
               type = (who.skin as EnemySkin).type;
               space = (who.skin as EnemySkin).space;
               totalTime = (who.skin as EnemySkin).totalTime;
               numValue = (who.skin as EnemySkin).numValue;
               break;
            }
            parentMC = parentMC.parent as MovieClip;
         }
         this.y = 485;
         this.x = this.parent.x;
         Main.world.moveChild_Other.addChild(this);
      }
   }
}

