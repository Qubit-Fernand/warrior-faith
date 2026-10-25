package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBossT3 extends EnemySkin
   {
      
      public static var per:Number = 0.1;
      
      public var temp:int = 0;
      
      private var bool:Boolean = true;
      
      public function EnemyBossT3()
      {
         super();
      }
      
      override public function boss14() : *
      {
         if(Boolean(this.parent as Enemy) && Boolean((this.parent as Enemy).life.getValue() < (this.parent as Enemy).lifeMAX.getValue() * EnemyBossT3.per) && this.bool == true)
         {
            runOver = true;
            this.bool = false;
            runType = "攻击5";
            continuousTime = 170;
            addEventListener(Event.ENTER_FRAME,this.zhaohuan);
         }
         else if(Boolean(this.parent as Enemy) && Boolean((this.parent as Enemy).life.getValue() >= (this.parent as Enemy).lifeMAX.getValue() * EnemyBossT3.per) && runType == "攻击5")
         {
            runType = "站立";
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击2")
         {
            setTimeout(this.maotouying,300);
            setTimeout(this.maotouying,600);
            setTimeout(this.maotouying,900);
            setTimeout(this.maotouying,1200);
            setTimeout(this.maotouying,1500);
            setTimeout(this.maotouying,1800);
            setTimeout(this.maotouying,2100);
            setTimeout(this.maotouying,2400);
         }
         if(str == "攻击4")
         {
            setTimeout(this.fangguang,1500);
            setTimeout(this.fangdu,5000);
         }
         if(str == "死亡")
         {
            EnemyBossT3.per = 0.1;
            if(Main.world["回村"])
            {
               Main.world["回村"].x = 1380;
               Main.world["回村"].y = 460;
            }
         }
      }
      
      public function fangguang() : *
      {
         if(this.parent)
         {
            this.addChild(new 上升光柱());
         }
      }
      
      public function fangdu() : *
      {
         if(this.parent)
         {
            this.addChild(new 毒雾());
         }
      }
      
      public function maotouying() : *
      {
         if(this.parent)
         {
            this.addChild(new 猫头鹰());
         }
      }
      
      public function zhaohuan(e:*) : *
      {
         ++this.temp;
         if((this.parent as Enemy).life.getValue() > 0)
         {
            if(this.temp > 168)
            {
               EnemyBossT3.per = 0.058;
               this.temp = 0;
               this.tuihua();
               (this.parent as Enemy).life.setValue(0);
               this.parent.parent.removeChild(this.parent);
               removeEventListener(Event.ENTER_FRAME,this.zhaohuan);
            }
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.zhaohuan);
         }
      }
      
      public function tuihua() : *
      {
         var e:Enemy = new Enemy(45);
         Main.world.moveChild_Enemy.addChild(e);
         Play_Interface.WhoIsBoss(e);
         if(this.parent.RL == true)
         {
            e.x = this.parent.x - 60;
            e.y = this.parent.y;
         }
         else
         {
            e.x = this.parent.x + 60;
            e.y = this.parent.y;
         }
      }
   }
}

