package src
{
   import flash.display.*;
   import flash.events.*;
   
   public class SaveXX
   {
      
      public static var varX:int = 3;
      
      public function SaveXX()
      {
         super();
      }
      
      public static function Save(param1:int, param2:Number, param3:Boolean = false, param4:Boolean = false, param5:Boolean = true) : *
      {
         var _loc6_:int = 0;
         if(Main.NoLogInfo[param1])
         {
            return;
         }
         if(Main.NoLog < SaveXX.varX)
         {
            Main.NoLog = SaveXX.varX;
            Main.NoLogInfo[param1] = param2;
         }
         if(param3 == true)
         {
            Main.Save(param4);
         }
         if(Main.noSave <= 0)
         {
            if(param5)
            {
               _loc6_ = Math.random() * 43994385;
            }
            else
            {
               _loc6_ = -(Math.random() * 43594384 + 999);
            }
            Main.noSave = _loc6_;
         }
      }
      
      public static function TestGoldMax() : *
      {
         if(Boolean(Main.player1) && Main.player1.getGold() > InitData.Money_max.getValue())
         {
            Save(3,Main.player1.getGold(),false,false);
         }
         else if(Boolean(Main.P1P2) && Boolean(Main.player2) && Main.player2.getGold() > InitData.Money_max.getValue())
         {
            Save(3,Main.player2.getGold(),false,false);
         }
      }
   }
}

