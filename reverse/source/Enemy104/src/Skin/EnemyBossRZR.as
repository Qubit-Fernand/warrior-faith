package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class EnemyBossRZR extends EnemySkin
   {
      
      internal var tempX:int = 0;
      
      internal var timeOut:uint;
      
      internal var tempFY:int = 0;
      
      public function EnemyBossRZR()
      {
         super();
      }
      
      internal function daoTui() : *
      {
         if(this.parent)
         {
            tempX = 60;
            this.addEventListener(Event.ENTER_FRAME,moveX);
         }
      }
      
      public function clearTimeout() : void
      {
         if(timeOut > 0)
         {
            clearTimeout(timeOut);
         }
      }
      
      internal function upFangYu(e:*) : *
      {
         if(tempFY <= 0)
         {
            (this.parent as Enemy).防御力.setValue(486);
            trace("aaaaa = " + (this.parent as Enemy).防御力.getValue());
            this.removeEventListener(Event.ENTER_FRAME,upFangYu);
         }
         else
         {
            (this.parent as Enemy).防御力.setValue(10000);
         }
         tempFY = tempFY - 1;
      }
      
      internal function daoDan() : *
      {
         if(this.parent)
         {
            this.addChild(new 导弹());
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击4")
         {
            timeOut = setTimeout(daoDan,2000);
            timeOut = setTimeout(daoDan,2500);
            timeOut = setTimeout(daoDan,3000);
         }
         if(str == "攻击2")
         {
            timeOut = setTimeout(daoTui,800);
         }
         if(str == "攻击6")
         {
            tempFY = 200;
            this.addEventListener(Event.ENTER_FRAME,upFangYu);
         }
      }
      
      internal function moveX(e:*) : *
      {
         if(tempX <= 0)
         {
            this.removeEventListener(Event.ENTER_FRAME,moveX);
         }
         else if((this.parent as Enemy).RL)
         {
            (this.parent as Enemy).x -= tempX;
         }
         else
         {
            (this.parent as Enemy).x += tempX;
         }
         tempX -= 4;
      }
   }
}

