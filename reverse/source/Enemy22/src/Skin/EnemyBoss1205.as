package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.EnemySkin;
   
   public class EnemyBoss1205 extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function EnemyBoss1205()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击5")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move5);
         }
      }
      
      internal function move5(e:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 18)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 520;
            }
            else
            {
               this.parent.x -= 520;
            }
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move5);
         }
      }
   }
}

