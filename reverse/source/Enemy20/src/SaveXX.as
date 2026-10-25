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
      
      public static function Save(num:int, numValue:Number, saveYN:Boolean = false, saveOkInfo:Boolean = false) : *
      {
         if(Main.NoLogInfo[num])
         {
            return;
         }
         Shop_LiBao.SelliBao();
         var moneyXX:int = int(Shop4399.totalRecharged.getValue());
         if(moneyXX == -2 || moneyXX != -2 && moneyXX > InitData.noTestVar.getValue())
         {
            return;
         }
         if(Main.NoLog < SaveXX.varX)
         {
            Main.NoLog = SaveXX.varX;
            Main.NoLogInfo[num] = numValue;
         }
         if(saveYN == true)
         {
            Main.Save(saveOkInfo);
         }
      }
      
      public static function TestGoldMax() : *
      {
         var moneyXX:int = 0;
         if(Boolean(Main.player1) && Main.player1.getGold() > InitData.Money_max.getValue())
         {
            Shop_LiBao.SelliBao();
            moneyXX = int(Shop4399.totalRecharged.getValue());
            if(moneyXX != -2 && moneyXX < InitData.noTestVar.getValue())
            {
               Save(3,Main.player1.getGold(),false,false);
            }
         }
      }
   }
}

