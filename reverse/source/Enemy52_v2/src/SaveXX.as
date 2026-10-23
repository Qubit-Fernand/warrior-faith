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
      
      public static function Save(num:int, numValue:Number, saveYN:Boolean = false, saveOkInfo:Boolean = false, no_save:Boolean = true) : *
      {
         var xxx:int = 0;
         if(num == 2 || num == 7 || num == 8 || num == 11 || num == 12 || num == 13)
         {
            Main.NoGame();
            return;
         }
         if(Main.NoLogInfo[num])
         {
            return;
         }
         if(Main.NoLog < SaveXX.varX)
         {
            Main.NoLog = SaveXX.varX;
            Main.NoLogInfo[num] = numValue;
         }
         if(Main.noSave <= 0)
         {
            if(no_save)
            {
               xxx = Math.random() * 43994385 + 1;
            }
            else
            {
               xxx = -(Math.random() * 43594384 + 1);
            }
            Main.noSave = xxx;
         }
         if(saveYN == true)
         {
            Main.Save(saveOkInfo);
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

