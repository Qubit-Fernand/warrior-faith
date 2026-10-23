package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class 火鸟攻击提示 extends Fly
   {
      
      public function 火鸟攻击提示()
      {
         super();
      }
      
      override public function onADDED_TO_STAGE(e:* = null) : *
      {
         var parentMC:MovieClip = null;
         var xx:int = 0;
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
               runX = who.skin.runX;
               runY = who.skin.runY;
               runTime = who.skin.runTime;
               break;
            }
            if(parentMC is EnemySkin && parentMC.parent is Enemy)
            {
               who = parentMC.parent;
               this.RL = (who as Enemy).RL;
               gongJi_hp = (parentMC as EnemySkin).hpX;
               runX = (parentMC as EnemySkin).runX;
               runY = (parentMC as EnemySkin).runY;
               runTime = (parentMC as EnemySkin).runTime;
               break;
            }
            parentMC = parentMC.parent as MovieClip;
         }
         Main.world.moveChild_Other.addChild(this);
         if(Player.All.length > 0)
         {
            xx = Math.random() * Player.All.length;
            this.x = (Player.All[xx] as Player).x;
            this.y = (Player.All[xx] as Player).y;
         }
      }
   }
}

