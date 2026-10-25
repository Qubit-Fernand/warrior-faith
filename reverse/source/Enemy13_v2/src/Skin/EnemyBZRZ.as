package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBZRZ extends EnemySkin
   {
      
      public function EnemyBZRZ()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "移动")
         {
            if(this.parent)
            {
               (this.parent as Enemy).lifeMC.visible = false;
            }
         }
         if(param1 == "站立")
         {
            if(this.parent)
            {
               (this.parent as Enemy).lifeMC.visible = false;
            }
         }
         if(param1 == "攻击1")
         {
            if(this.parent)
            {
               (this.parent as Enemy).lifeMC.visible = true;
            }
         }
      }
   }
}

