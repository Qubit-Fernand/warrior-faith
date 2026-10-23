package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class Guangzhu extends Fly
   {
      
      public var gongji:Number = 0;
      
      public var tiaogao:int = 120;
      
      public function Guangzhu()
      {
         super();
      }
      
      override public function onADDED_TO_STAGE(e:* = null) : *
      {
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
               runY = this.tiaogao;
               runTime = who.skin.runTime;
               break;
            }
            if(parentMC is EnemySkin && parentMC.parent is Enemy)
            {
               who = parentMC.parent;
               this.RL = (who as Enemy).RL;
               硬直 = who.skin.硬直;
               attTimes = who.skin.attTimes;
               gongJi_hp = this.gongji;
               runX = (parentMC as EnemySkin).runX;
               runY = this.tiaogao;
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
         this.y = 0;
         this.x = Math.random() * 1400 + 100;
      }
   }
}

