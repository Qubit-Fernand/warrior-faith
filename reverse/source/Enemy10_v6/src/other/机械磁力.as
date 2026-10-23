package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class 机械磁力 extends Fly
   {
      
      public function 机械磁力()
      {
         super();
      }
      
      override public function Move() : *
      {
         var pPoint:Point = null;
         var xPoint:Point = this.parent.localToGlobal(new Point(this.x,this.y));
         for(var i:int = 0; i < Player.All.length; i++)
         {
            pPoint = Player.All[i].parent.localToGlobal(new Point(Player.All[i].x,Player.All[i].y));
            if(pPoint.x > xPoint.x)
            {
               (Player.All[i] as Player).runPower(-15,0,1);
            }
            else
            {
               (Player.All[i] as Player).runPower(15,0,1);
            }
         }
      }
   }
}

