package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.EnemySkin;
   
   public class EnemyBoss53 extends EnemySkin
   {
      
      internal var rdm:int = 0;
      
      internal var rushNum:int = 0;
      
      public function EnemyBoss53()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击5")
         {
            this.rdm = Math.random() * 10;
            this.addEventListener(Event.ENTER_FRAME,this.move5);
         }
         if(str == "攻击2")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move2);
         }
         if(str == "攻击3")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move3);
         }
         if(str == "攻击6")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move6);
         }
      }
      
      internal function move6(e:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 12 && this.rushNum < 47)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 11;
            }
            else
            {
               this.parent.x -= 11;
            }
         }
         if(this.rushNum >= 47)
         {
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move6);
         }
      }
      
      internal function move2(e:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 8 && this.rushNum < 57)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 10;
            }
            else
            {
               this.parent.x -= 10;
            }
         }
         if(this.rushNum >= 57)
         {
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move2);
         }
      }
      
      internal function move3(e:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 0 && this.rushNum < 13)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 30;
            }
            else
            {
               this.parent.x -= 30;
            }
         }
         if(this.rushNum >= 13)
         {
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move3);
         }
      }
      
      internal function move5(e:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 1 && this.rushNum < 17)
         {
            if(this.rdm > 5)
            {
               this.parent.x += 25;
            }
            else
            {
               this.parent.x -= 25;
            }
         }
         if(this.rushNum >= 17)
         {
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move5);
         }
      }
   }
}

