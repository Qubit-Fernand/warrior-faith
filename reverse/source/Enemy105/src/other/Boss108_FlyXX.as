package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   import src.tool.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol506")]
   public class Boss108_FlyXX extends Fly
   {
      
      public function Boss108_FlyXX()
      {
         super();
         TiaoShi.txtShow("Boss108_FlyXX -------- 初始化!");
      }
      
      override public function otherXX() : *
      {
         if(Main.gameNum.getValue() == 0 || this.who is Enemy && (this.who as Enemy).life.getValue() <= 0)
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

