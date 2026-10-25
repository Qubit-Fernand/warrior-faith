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
         if(Main.NoLogInfo[num])
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
         if(Main.noSave <= 0)
         {
            if(no_save)
            {
               xxx = Math.random() * 43994385;
            }
            else
            {
               xxx = -(Math.random() * 43594384 + 999);
            }
            Main.noSave = xxx;
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

