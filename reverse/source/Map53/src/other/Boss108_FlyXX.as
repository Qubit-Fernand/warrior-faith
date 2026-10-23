package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   import src.tool.*;
   
   public class Boss108_FlyXX extends Fly
   {
      
      public function Boss108_FlyXX()
      {
         super();
         TiaoShi.txtShow("Boss108_FlyXX -------- 初始化!");
      }
      
      override public function otherXX() : *
      {
         var bool:Boolean = false;
         if(Boolean(!Main.P1P2) && Boolean(Main.player_1) && Main.player_1.hp.getValue() <= 0)
         {
            bool = true;
         }
         else if(Boolean(Main.P1P2 && Main.player_1 && Main.player_1.hp.getValue() <= 0) && Boolean(Main.player_2) && Main.player_2.hp.getValue() <= 0)
         {
            bool = true;
         }
         if(Main.gameNum.getValue() == 0 || this.who is Enemy && (this.who as Enemy).life.getValue() <= 0 || bool)
         {
            TiaoShi.txtShow("Boss108_FlyXX -------- 清除!");
            this.life = 0;
            this.Dead();
            return;
         }
         if(this.who)
         {
            this.x = this.who.x;
         }
         if(Boolean(Main.gameNum.getValue() != 0) && Boolean(this.parent) && this.parent != Main.world.moveChild_Back)
         {
            Main.world.moveChild_Back.addChild(this);
         }
      }
   }
}

