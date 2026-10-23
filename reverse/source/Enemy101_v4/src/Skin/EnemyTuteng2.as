package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyTuteng2 extends EnemySkin
   {
      
      public function EnemyTuteng2()
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
         for(var i:* = 0; i < Enemy.All.length; i++)
         {
            Enemy.All[i].防御力.setValue(Enemy.All[i].防御力.getValue() - 20);
         }
      }
   }
}

