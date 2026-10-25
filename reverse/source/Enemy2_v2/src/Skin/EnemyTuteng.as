package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyTuteng extends EnemySkin
   {
      
      public function EnemyTuteng()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "死亡")
         {
            DefenseDOWN();
         }
      }
      
      public function DefenseDOWN() : *
      {
         var i:* = undefined;
         for(i = 0; i < Enemy.All.length; i++)
         {
            Enemy.All[i].防御力.setValue(Enemy.All[i].防御力.getValue() - 20);
         }
      }
   }
}

