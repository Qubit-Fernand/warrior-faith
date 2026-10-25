package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.tool.*;
   
   public class EnemyBoss55 extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      internal var bool:Boolean = false;
      
      internal var rushNum2:int = 0;
      
      internal var xxxx:int;
      
      internal var rushNum4:int = 0;
      
      internal var fx:Boolean = true;
      
      public function EnemyBoss55()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击1")
         {
            this.addEventListener(Event.ENTER_FRAME,move1);
         }
         if(param1 == "攻击5")
         {
            this.addEventListener(Event.ENTER_FRAME,move5);
         }
         if(param1 == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,move4);
         }
      }
      
      internal function move1(param1:Event) : *
      {
         var _loc2_:* = undefined;
         ++rushNum;
         for(_loc2_ in HitXX.AllHitXX)
         {
            if(Main.player_1.hitXX == HitXX.AllHitXX[_loc2_])
            {
               bool = true;
               TiaoShi.txtShow("bool = " + bool);
            }
         }
         if(rushNum >= 13)
         {
            if(!bool)
            {
               runOver = true;
               GoTo("站立");
               TiaoShi.txtShow("runOver = " + runOver);
            }
            else
            {
               bool = false;
            }
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move1);
         }
      }
      
      internal function move5(param1:Event) : *
      {
         var _loc2_:int = 0;
         rushNum2 += 1;
         if(rushNum2 == 11)
         {
            if(Player.All.length > 0)
            {
               _loc2_ = Math.random() * Player.All.length;
               temp = Math.abs((Player.All[_loc2_] as Player).x - this.parent.x);
               xxxx = int(temp / 15);
            }
         }
         if(rushNum2 > 11 && rushNum2 < 26)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += xxxx;
            }
            else
            {
               this.parent.x -= xxxx;
            }
         }
         if(rushNum2 >= 26)
         {
            rushNum2 = 0;
            this.removeEventListener(Event.ENTER_FRAME,move5);
         }
      }
      
      internal function move4(param1:Event) : *
      {
         rushNum4 += 1;
         if(rushNum4 == 15)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 230;
               fx = true;
            }
            else
            {
               this.parent.x -= 230;
               fx = false;
            }
         }
         if(rushNum4 == 16)
         {
            if(fx)
            {
               this.parent.x += 40;
            }
            else
            {
               this.parent.x -= 40;
            }
         }
         if(rushNum4 > 16)
         {
            rushNum4 = 0;
            this.removeEventListener(Event.ENTER_FRAME,move4);
         }
      }
   }
}

