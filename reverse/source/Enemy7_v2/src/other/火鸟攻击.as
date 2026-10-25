package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class 火鸟攻击 extends Fly
   {
      
      public function 火鸟攻击()
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
            speedX = Math.abs((Player.All[xx] as Player).x - this.x) / 18;
            speedY = Math.abs((Player.All[xx] as Player).y - this.y) / 18;
         }
      }
      
      override public function Dead() : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         if(this.who is Player || this.who is Enemy)
         {
            this.who.x = this.x;
            this.who.y = this.y;
            this.who.visible = true;
            this.parent.removeChild(this);
         }
      }
   }
}

