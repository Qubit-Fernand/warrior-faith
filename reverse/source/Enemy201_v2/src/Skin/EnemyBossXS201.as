package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBossXS201 extends EnemySkin
   {
      
      internal var rushNum2:int = 0;
      
      internal var rushNum:int = 0;
      
      public function EnemyBossXS201()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击2")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move);
         }
         if(param1 == "攻击3")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move2);
         }
         if(Boolean(param1 == "死亡") && Boolean(this.parent) && (this.parent as Enemy).id == 201)
         {
            Main.wts.wantedTaskComplete();
         }
      }
      
      internal function move(param1:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 10 && this.rushNum < 50)
         {
            if(this.parent.RL == true)
            {
               if(this.parent.x < 1580)
               {
                  this.parent.x += 7;
               }
            }
            else if(this.parent.x > 20)
            {
               this.parent.x -= 7;
            }
         }
         if(this.rushNum > 50)
         {
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move);
         }
      }
      
      internal function move2(param1:Event) : *
      {
         this.rushNum2 += 1;
         if(this.rushNum2 > 18 && this.rushNum2 < 46)
         {
            if(this.parent.RL == true)
            {
               if(this.parent.x < 1580)
               {
                  this.parent.x += 20;
               }
            }
            else if(this.parent.x > 20)
            {
               this.parent.x -= 20;
            }
         }
         if(this.rushNum2 > 46)
         {
            this.rushNum2 = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move2);
         }
      }
   }
}

