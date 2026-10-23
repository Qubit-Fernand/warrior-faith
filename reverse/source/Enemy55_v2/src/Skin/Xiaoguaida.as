package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.tool.*;
   
   public class Xiaoguaida extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function Xiaoguaida()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击1")
         {
            this.addEventListener(Event.ENTER_FRAME,move1);
         }
      }
      
      internal function move1(param1:Event) : *
      {
         rushNum += 1;
         if((this.parent as Enemy).life.getValue() > 0)
         {
            if(rushNum > 5 && rushNum < 51)
            {
               if(this.parent.RL == true)
               {
                  this.parent.x += 12;
               }
               else
               {
                  this.parent.x -= 12;
               }
               (this.parent as Enemy).防御力.setValue(9999999);
            }
            if(rushNum > 51)
            {
               (this.parent as Enemy).防御力.setValue(1);
               rushNum = 0;
               this.removeEventListener(Event.ENTER_FRAME,move1);
            }
         }
         else
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move1);
         }
      }
   }
}

