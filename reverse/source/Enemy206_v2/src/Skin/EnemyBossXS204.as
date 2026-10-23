package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class EnemyBossXS204 extends EnemySkin
   {
      
      internal var xxxx:int = 0;
      
      internal var rushNum:int = 0;
      
      internal var rushNum2:int = 0;
      
      public function EnemyBossXS204()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         var xx:int = 0;
         if(str == "攻击5")
         {
            timeOut = setTimeout(daoDan,600);
            timeOut = setTimeout(daoDan,1000);
            timeOut = setTimeout(daoDan,1500);
            timeOut = setTimeout(daoDan,1900);
            timeOut = setTimeout(daoDan,2400);
            timeOut = setTimeout(daoDan,2800);
         }
         if(str == "攻击3")
         {
            this.addEventListener(Event.ENTER_FRAME,move3);
         }
         if(str == "攻击4")
         {
            if(Player.All.length > 0)
            {
               xx = Math.random() * Player.All.length;
               xxxx = (Player.All[xx] as Player).x;
            }
            this.addEventListener(Event.ENTER_FRAME,move4);
         }
         if(str == "死亡")
         {
            Main.wts.wantedTaskComplete();
         }
      }
      
      internal function move3(e:Event) : *
      {
         rushNum += 1;
         if(rushNum > 13 && rushNum < 85)
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
         if(rushNum >= 85)
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move3);
         }
      }
      
      internal function move4(e:Event) : *
      {
         rushNum2 += 1;
         if(rushNum2 >= 1 && rushNum2 < 17)
         {
            if(this.parent.RL == true)
            {
               if(this.parent.x < xxxx)
               {
                  this.parent.x += int((xxxx - this.parent.x) / 17);
               }
            }
            else if(this.parent.x > xxxx)
            {
               this.parent.x -= int((this.parent.x - xxxx) / 17);
            }
         }
         if(rushNum2 >= 17)
         {
            rushNum2 = 0;
            this.removeEventListener(Event.ENTER_FRAME,move4);
         }
      }
      
      internal function daoDan() : *
      {
         if(this.parent)
         {
            this.addChild(new 冰锥());
         }
      }
   }
}

