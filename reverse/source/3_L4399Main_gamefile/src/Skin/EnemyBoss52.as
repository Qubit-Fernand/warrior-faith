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
         Main.world.moveChild_ChongWu.addChild(kaiguan);
         kaiguan.gotoAndStop(1);
         kaiguan.x = 5400;
         kaiguan.y = 500;
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击4")
         {
            this.hit.y = this.y + 200;
            this.addEventListener(Event.ENTER_FRAME,yincang);
         }
         if(param1 == "攻击3")
         {
            this.addEventListener(Event.ENTER_FRAME,move3);
         }
      }
      
      override public function onENTER_FRAME(param1:*) : *
      {
         HitKG.HitFly();
         if(this.currentFrame == this.totalFrames)
         {
            stop();
            (this.parent as Enemy).Dead();
            return;
         }
         if(continuousTime > 0)
         {
            --continuousTime;
         }
         else if(runType == "被打")
         {
            GoTo("站立");
         }
         GoToPlay();
      }
      
      internal function move3(param1:Event) : *
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
      
      internal function yincang(param1:Event) : *
      {
         rushNum += 1;
         if(rushNum > 28)
         {
            (this.parent as Enemy).lifeMC.visible = false;
            this.alpha = 0;
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,yincang);
         }
      }
   }
}

