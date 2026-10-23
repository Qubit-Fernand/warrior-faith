package src.Skin
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss54 extends EnemySkin
   {
      
      private var star:MovieClip = new 星星();
      
      internal var rdm:int = 0;
      
      internal var rushNum6:int = 0;
      
      internal var rushNum:int = 0;
      
      internal var rushNum4:int = 0;
      
      internal var rushNum3:int = 0;
      
      internal var rushNum2:int = 0;
      
      internal var speedY:int = 0;
      
      internal var speedX:int = 0;
      
      internal var baoqi:int = 0;
      
      internal var xxxx:int;
      
      internal var temp:int;
      
      internal var xxx:int;
      
      internal var part:int = 0;
      
      public function EnemyBoss54()
      {
         super();
         addEventListener(Event.ENTER_FRAME,jiqi);
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(this.parent)
         {
            Main.world.moveChild_Back.addChild(star);
            star.x = 5514.35;
            star.y = -3;
         }
         if(param1 == "攻击5")
         {
            this.addEventListener(Event.ENTER_FRAME,move5);
         }
         if(param1 == "攻击3")
         {
            if(this.parent)
            {
               (this.parent as Enemy).lifeMC.visible = false;
            }
            this.addEventListener(Event.ENTER_FRAME,move3);
         }
         if(param1 == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,move4);
         }
         if(param1 == "攻击2")
         {
            this.addEventListener(Event.ENTER_FRAME,move2);
         }
         if(param1 == "攻击6")
         {
            this.addEventListener(Event.ENTER_FRAME,move6);
         }
      }
      
      internal function jiqi(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         ++baoqi;
         if(baoqi > 0)
         {
            for(_loc2_ in HitXX.AllHitXX)
            {
               if(Player.All.length > 0)
               {
                  _loc3_ = Math.random() * Player.All.length;
                  if((Player.All[_loc3_] as Player).hitXX == HitXX.AllHitXX[_loc2_])
                  {
                     if(Enemy.boss54 == 0)
                     {
                        star.gotoAndPlay(2);
                        Enemy.boss54 = 1;
                     }
                     else if(Enemy.boss54 == 1)
                     {
                        star.gotoAndPlay(17);
                        Enemy.boss54 = 2;
                     }
                     else if(Enemy.boss54 == 2)
                     {
                        star.gotoAndPlay(32);
                        Enemy.boss54 = 3;
                     }
                     else if(Enemy.boss54 == 3)
                     {
                        star.gotoAndPlay(47);
                        Enemy.boss54 = 4;
                     }
                     else if(Enemy.boss54 == 4)
                     {
                        star.gotoAndPlay(62);
                        Enemy.boss54 = 5;
                     }
                     baoqi = -50;
                  }
               }
            }
         }
      }
      
      internal function move6(param1:Event) : *
      {
         baoqi = -100;
         ++rushNum6;
         if(Enemy.boss54 == 5)
         {
            ++Enemy.boss54;
         }
         if(rushNum6 == 1)
         {
            star.gotoAndPlay(77);
         }
         if(rushNum6 >= 500)
         {
            baoqi = -50;
            Enemy.boss54 = 0;
            rushNum6 = 0;
            this.removeEventListener(Event.ENTER_FRAME,move6);
         }
      }
      
      internal function move2(param1:Event) : *
      {
         var _loc2_:int = 0;
         rushNum2 += 1;
         if(rushNum2 == 8)
         {
            if(Player.All.length > 0)
            {
               _loc2_ = Math.random() * Player.All.length;
               temp = Math.abs((Player.All[_loc2_] as Player).x - this.parent.x);
               xxxx = int(temp / 15);
            }
         }
         if(rushNum2 > 8 && rushNum2 < 24)
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
         if(rushNum2 >= 24)
         {
            rushNum2 = 0;
            this.removeEventListener(Event.ENTER_FRAME,move2);
         }
      }
      
      internal function move4(param1:Event) : *
      {
         var _loc2_:int = 0;
         rushNum4 += 1;
         if(rushNum4 == 64)
         {
            if(Player.All.length > 0)
            {
               _loc2_ = Math.random() * Player.All.length;
               this.parent.x = (Player.All[_loc2_] as Player).x;
            }
         }
         if(rushNum4 >= 102)
         {
            if(this.parent)
            {
               this.parent.y = 150;
            }
            rushNum4 = 0;
            this.removeEventListener(Event.ENTER_FRAME,move4);
            if(Math.random() * 10 > 5)
            {
               if((this.parent as Enemy).life.getValue() > 0)
               {
                  this.runOver = true;
                  this.GoTo("攻击5");
               }
            }
         }
      }
      
      internal function move3(param1:Event) : *
      {
         var _loc2_:int = 0;
         ++rushNum3;
         if(rushNum3 == 13)
         {
            if(Player.All.length > 0)
            {
               _loc2_ = Math.random() * Player.All.length;
               temp = Math.abs((Player.All[_loc2_] as Player).x - this.parent.x);
               xxx = int(temp / 23);
            }
         }
         if(rushNum3 > 14 && rushNum3 < 39)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += xxx;
            }
            else
            {
               this.parent.x -= xxx;
            }
         }
         if(rushNum3 >= 59)
         {
            rushNum3 = 0;
            this.removeEventListener(Event.ENTER_FRAME,move3);
            if((this.parent as Enemy).life.getValue() > 0)
            {
               this.runOver = true;
               this.GoTo("攻击4");
            }
         }
      }
      
      internal function move5(param1:Event) : *
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         rushNum += 1;
         if(rushNum == 12)
         {
            if(Player.All.length > 0)
            {
               _loc2_ = Math.random() * Player.All.length;
               _loc3_ = Math.abs((Player.All[_loc2_] as Player).x - this.parent.x) / Math.abs((Player.All[_loc2_] as Player).y - this.parent.y);
               _loc4_ = Math.round(Math.atan(_loc3_) * 180 / Math.PI);
               speedX = int(30 * Math.sin(_loc4_ * Math.PI / 180));
               speedY = int(30 * Math.cos(_loc4_ * Math.PI / 180));
               (this.parent as Enemy).gravity = 0;
               if(Boolean(this.parent.RL) && (Player.All[_loc2_] as Player).y <= this.parent.y)
               {
                  this.parent.rotation += _loc4_;
                  part = 1;
               }
               else if(Boolean(this.parent.RL) && (Player.All[_loc2_] as Player).y > this.parent.y)
               {
                  this.parent.rotation = 180 - _loc4_;
                  part = 2;
               }
               else if(!this.parent.RL && (Player.All[_loc2_] as Player).y <= this.parent.y)
               {
                  this.parent.rotation -= _loc4_;
                  part = 3;
               }
               else if(!this.parent.RL && (Player.All[_loc2_] as Player).y > this.parent.y)
               {
                  this.parent.rotation = -180 + _loc4_;
                  part = 4;
               }
            }
         }
         if(rushNum > 11 && rushNum < 49)
         {
            if(part == 1 && this.parent.y > 100)
            {
               this.parent.x += speedX;
               this.parent.y -= speedY;
            }
            if(part == 2 && this.parent.y < 420)
            {
               this.parent.x += speedX;
               this.parent.y += speedY - 2;
            }
            if(part == 3 && this.parent.y > 100)
            {
               this.parent.x -= speedX;
               this.parent.y -= speedY;
            }
            if(part == 4 && this.parent.y < 420)
            {
               this.parent.x -= speedX;
               this.parent.y += speedY - 2;
            }
         }
         if(rushNum >= 49)
         {
            rushNum = 0;
            (this.parent as Enemy).gravity = 2;
            this.parent.rotation = 0;
            this.removeEventListener(Event.ENTER_FRAME,move5);
         }
      }
   }
}

