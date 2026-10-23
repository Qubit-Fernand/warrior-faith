package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.EnemySkin;
   
   public class EnemyBossSLKM extends EnemySkin
   {
      
      public function EnemyBossSLKM()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击4")
         {
            this.parent.攻击力.setValue(int(this.parent.攻击力.getValue() * 1.3));
         }
      }
   }
}

