package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class TieQiuXiYin extends Fly
   {
      
      public function TieQiuXiYin()
      {
         super();
      }
      
      override public function Move() : *
      {
         var _loc3_:Point = null;
         var _loc1_:Point = this.parent.localToGlobal(new Point(this.x,this.y));
         var _loc2_:int = 0;
         while(_loc2_ < Player.All.length)
         {
            _loc3_ = Player.All[_loc2_].parent.localToGlobal(new Point(Player.All[_loc2_].x,Player.All[_loc2_].y));
            if(_loc3_.x > _loc1_.x)
            {
               (Player.All[_loc2_] as Player).runPower(-10,0,1);
            }
            else
            {
               (Player.All[_loc2_] as Player).runPower(10,0,1);
            }
            _loc2_++;
         }
      }
   }
}

