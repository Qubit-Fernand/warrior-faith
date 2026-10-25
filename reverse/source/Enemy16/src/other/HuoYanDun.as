package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class HuoYanDun extends Fly
   {
      
      public function HuoYanDun()
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
            if(_loc2_ is Fly && _loc2_.parent is Fly)
            {
               who = (_loc2_.parent as Fly).who;
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
            _loc2_ = _loc2_.parent as MovieClip;
         }
         Main.world.moveChild_Other.addChild(this);
      }
      
      override public function Move() : *
      {
         this.y = this.who.y;
         this.x = this.who.x;
         if(this.x > 2000 || this.x < -400)
         {
            life = 0;
         }
      }
   }
}

