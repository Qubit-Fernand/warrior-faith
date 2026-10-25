package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.EnemySkin;
   
   public class EnemyBoss1203 extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function EnemyBoss1203()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击3")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move3);
         }
         if(str == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move4);
         }
         if(str == "攻击5")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move5);
         }
      }
      
      internal function move3(e:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 124)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 180;
            }
            else
            {
               this.parent.x -= 180;
            }
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move3);
         }
      }
      
      internal function move4(e:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 124)
         {
            if(this.parent.RL == true)
            {
               this.parent.x -= 180;
            }
            else
            {
               this.parent.x += 180;
            }
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move4);
         }
      }
      
      internal function move5(e:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 124)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 355;
            }
            else
            {
               this.parent.x -= 355;
            }
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move5);
         }
      }
   }
}

