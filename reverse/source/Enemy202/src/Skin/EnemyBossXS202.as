package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBossXS202 extends EnemySkin
   {
      
      internal var temp:int = 1;
      
      internal var left:Fly;
      
      internal var right:Fly;
      
      internal var rushNum:int = 0;
      
      public function EnemyBossXS202()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(this.temp == 1)
         {
            if(this.parent)
            {
               this.left = new 能量墙();
               this.right = new 能量墙();
               this.addChild(this.left);
               this.addChild(this.right);
               this.right.x = this.left.x + 1900;
               this.temp = 0;
            }
         }
         if(param1 == "攻击3")
         {
            addEventListener(Event.ENTER_FRAME,this.move);
         }
         if(param1 == "死亡")
         {
            if(this.left)
            {
               this.left.time = 1;
               this.right.time = 1;
            }
            Main.wts.wantedTaskComplete();
         }
      }
      
      internal function move(param1:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 12 && this.rushNum < 82)
         {
            this.left.x += 0.5;
            this.right.x -= 0.5;
         }
         if(this.rushNum > 82)
         {
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move);
         }
      }
   }
}

