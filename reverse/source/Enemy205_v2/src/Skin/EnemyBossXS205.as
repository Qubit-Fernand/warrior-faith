package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class EnemyBossXS205 extends EnemySkin
   {
      
      public function EnemyBossXS205()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击3")
         {
            timeOut = setTimeout(daoDan,1900);
         }
         if(str == "死亡")
         {
            Main.wts.wantedTaskComplete();
         }
      }
      
      internal function daoDan() : *
      {
         if(this.parent)
         {
            this.addChild(new 冰块爆炸());
         }
      }
   }
}

