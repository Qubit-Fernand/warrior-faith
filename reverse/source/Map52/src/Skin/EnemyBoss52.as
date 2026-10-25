package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss52 extends EnemySkin
   {
      
      public static var kaiguan:MovieClip = new KaiGuan();
      
      internal var rushNum:int = 0;
      
      public function EnemyBoss52()
      {
         super();
         Main.world.moveChild_Other.addChild(kaiguan);
         kaiguan.gotoAndStop(1);
         kaiguan.x = 5400;
         kaiguan.y = 500;
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,yincang);
         }
         if(str == "攻击3")
         {
            this.addEventListener(Event.ENTER_FRAME,move3);
         }
      }
      
      internal function move3(e:Event) : *
      {
         rushNum += 1;
         if(rushNum > 22 && rushNum < 90)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 16;
            }
            else
            {
               this.parent.x -= 16;
            }
         }
         if(rushNum > 90)
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move3);
         }
      }
      
      internal function yincang(e:Event) : *
      {
         rushNum += 1;
         if(rushNum > 28)
         {
            (this.parent as Enemy).lifeMC.visible = false;
            this.alpha = 0.1;
            this.hit.y = this.y + 200;
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,yincang);
         }
      }
   }
}

