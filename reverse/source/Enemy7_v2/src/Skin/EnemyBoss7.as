package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.EnemySkin;
   import src.other.*;
   
   public class EnemyBoss7 extends EnemySkin
   {
      
      public function EnemyBoss7()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         var i:int = 0;
         if(str == "攻击3")
         {
            for(i = 0; i < 10; i++)
            {
               this.addChild(new 火图腾());
            }
         }
      }
   }
}

