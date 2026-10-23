package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class 鬼闪雷击 extends Fly
   {
      
      public function 鬼闪雷击()
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
         this.y = 520;
         if(this.RL)
         {
            scaleX *= -1;
            this.x = who.x - this.x - 130;
         }
         else
         {
            scaleX *= 1;
            this.x = who.x + this.x + 130;
         }
      }
   }
}

