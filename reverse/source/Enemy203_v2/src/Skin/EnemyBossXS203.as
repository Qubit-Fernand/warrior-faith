package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBossXS203 extends EnemySkin
   {
      
      internal var rushNum2:int = 0;
      
      internal var rushNum:int = 0;
      
      internal var tempNum:int = 0;
      
      public function EnemyBossXS203()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move);
         }
         if(param1 == "攻击5")
         {
            this.addEventListener(Event.ENTER_FRAME,this.changeX);
         }
         if(Boolean(param1 == "死亡") && Boolean(this.parent) && (this.parent as Enemy).id == 203)
         {
            Main.wts.wantedTaskComplete();
         }
      }
      
      internal function changeX(param1:Event) : *
      {
         var _loc2_:int = 0;
         ++this.tempNum;
         if(this.tempNum > 45)
         {
            if(Player.All.length > 0)
            {
               _loc2_ = Math.random() * Player.All.length;
               this.parent.x = (Player.All[_loc2_] as Player).x;
            }
            this.tempNum = 0;
            this.addEventListener(Event.ENTER_FRAME,this.move2);
            this.removeEventListener(Event.ENTER_FRAME,this.changeX);
         }
      }
      
      internal function move(param1:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 17 && this.rushNum < 60)
         {
            if(this.parent.RL == true)
            {
               if(this.parent.x < 1580)
               {
                  this.parent.x += 15;
               }
            }
            else if(this.parent.x > 20)
            {
               this.parent.x -= 15;
            }
         }
         if(this.rushNum > 60)
         {
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move);
         }
      }
      
      internal function move2(param1:Event) : *
      {
         this.rushNum2 += 1;
         if(this.rushNum2 > 19 && this.rushNum2 < 103)
         {
            if(this.parent.RL == true)
            {
               if(this.parent.x < 1580)
               {
                  this.parent.x += 15;
               }
            }
            else if(this.parent.x > 20)
            {
               this.parent.x -= 15;
            }
         }
         if(this.rushNum2 > 103)
         {
            this.rushNum2 = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move2);
         }
      }
   }
}

