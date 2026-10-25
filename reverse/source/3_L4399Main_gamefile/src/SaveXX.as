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
         if(param1 == 2 || param1 == 7 || param1 == 8 || param1 == 11 || param1 == 12 || param1 == 13)
         {
            Main.NoGame("复制物品");
            return;
         }
         if(Main.NoLogInfo[param1])
         {
            return;
         }
         if(Main.NoLog < SaveXX.varX)
         {
            Main.NoLog = SaveXX.varX;
            Main.NoLogInfo[param1] = param2;
         }
         if(Main.noSave <= 0)
         {
            if(param5)
            {
               _loc6_ = Math.random() * 43994385 + 1;
            }
            else
            {
               _loc6_ = -(Math.random() * 43594384 + 1);
            }
            Main.noSave = _loc6_;
         }
         if(param3 == true)
         {
            Main.Save(param4);
         }
      }
      
      public static function TestGoldMax() : *
      {
         if(Boolean(Main.player1) && Main.player1.getGold() > InitData.Money_max.getValue())
         {
            Save(3,Main.player1.getGold(),true,false,false);
         }
         else if(Boolean(Main.P1P2) && Boolean(Main.player2) && Main.player2.getGold() > InitData.Money_max.getValue())
         {
            Save(3,Main.player2.getGold(),true,false,false);
         }
      }
   }
}

