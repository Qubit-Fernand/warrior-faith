package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss1206 extends EnemySkin
   {
      
      public static var redbool:Boolean = false;
      
      public static var bluebool:Boolean = false;
      
      internal var rushNum:int = 0;
      
      public var red:MovieClip = new Red();
      
      public var blue:MovieClip = new Blue();
      
      private var redxg:MovieClip = new Redxg();
      
      private var bluexg:MovieClip = new Bluexg();
      
      internal var temptime:int = 0;
      
      public function EnemyBoss1206()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,init);
      }
      
      public function init(e:*) : *
      {
         red.name = "红";
         blue.name = "蓝";
         redbool = false;
         bluebool = false;
         Enemy.bool_5 = true;
         Enemy.bool_6 = true;
      }
      
      internal function move1(e:Event) : *
      {
         rushNum += 1;
         if(rushNum > 10 && rushNum < 80)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 15;
            }
            else
            {
               this.parent.x -= 15;
            }
         }
         if(rushNum > 80)
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move1);
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击1")
         {
            this.addEventListener(Event.ENTER_FRAME,move1);
         }
         if(str == "攻击5")
         {
            this.parent.addChild(red);
            this.parent.防御力.setValue(9989999);
            Main.world.moveChild_Enemy.addChild(redxg);
            redxg.gotoAndPlay(0);
            redxg.x = 100;
            redxg.y = 500;
            Main.world.moveChild_Enemy.addChild(bluexg);
            bluexg.gotoAndPlay(0);
            bluexg.x = 1100;
            bluexg.y = 500;
            this.addEventListener(Event.ENTER_FRAME,xiaoshi);
            redbool = true;
         }
         if(str == "攻击6")
         {
            this.parent.addChild(blue);
            this.parent.防御力.setValue(9989999);
            Main.world.moveChild_Enemy.addChild(redxg);
            redxg.gotoAndPlay(0);
            redxg.x = 100;
            redxg.y = 500;
            Main.world.moveChild_Enemy.addChild(bluexg);
            bluexg.gotoAndPlay(0);
            bluexg.x = 1100;
            bluexg.y = 500;
            this.addEventListener(Event.ENTER_FRAME,xiaoshi);
            bluebool = true;
         }
      }
      
      private function xiaoshi(event:*) : *
      {
         var e1:Enemy = null;
         var e2:Enemy = null;
         ++temptime;
         if(temptime > 29)
         {
            e1 = new Enemy(2008);
            Main.world.moveChild_Enemy.addChild(e1);
            e1.x = 1100;
            e1.y = 500;
            e2 = new Enemy(2007);
            Main.world.moveChild_Enemy.addChild(e2);
            e2.x = 100;
            e2.y = 500;
            temptime = 0;
            if(redxg.parent)
            {
               redxg.parent.removeChild(redxg);
            }
            if(bluexg.parent)
            {
               bluexg.parent.removeChild(bluexg);
            }
            this.removeEventListener(Event.ENTER_FRAME,xiaoshi);
         }
      }
   }
}

