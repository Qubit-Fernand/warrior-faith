package src.tool
{
   import com.hotpoint.braveManIII.views.shortTip.*;
   import src.*;
   
   public class CheckTest
   {
      
      public static var testStr:String = "no";
      
      public static var tempStr:String = "no";
      
      public static var testStr2:String = "no";
      
      public static var tempStr2:String = "no";
      
      public static var p2testStr:String = "no";
      
      public static var p2tempStr:String = "no";
      
      public static var p2testStr2:String = "no";
      
      public static var p2tempStr2:String = "no";
      
      public function CheckTest()
      {
         super();
      }
      
      public static function startTest() : *
      {
         if(testStr == "no")
         {
            testStr = MD5contrast.getObj_MD5String(Main.player1.getBag().getGemBag());
            testStr2 = MD5contrast.getObj_MD5String(Main.player1.getBag().getOtherobjBag());
            if(Main.P1P2)
            {
               p2testStr = MD5contrast.getObj_MD5String(Main.player2.getBag().getGemBag());
               p2testStr2 = MD5contrast.getObj_MD5String(Main.player2.getBag().getOtherobjBag());
            }
            return;
         }
      }
      
      public static function Testing() : *
      {
         tempStr = MD5contrast.getObj_MD5String(Main.player1.getBag().getGemBag());
         if(testStr != tempStr)
         {
            SaveXX.Save(5,999);
         }
         if(Main.P1P2)
         {
            p2tempStr = MD5contrast.getObj_MD5String(Main.player2.getBag().getGemBag());
            if(p2testStr != p2tempStr)
            {
               SaveXX.Save(5,999);
            }
         }
      }
      
      public static function setMD5() : *
      {
         testStr = MD5contrast.getObj_MD5String(Main.player1.getBag().getGemBag());
         if(Main.P1P2)
         {
            p2testStr = MD5contrast.getObj_MD5String(Main.player2.getBag().getGemBag());
         }
      }
      
      public static function TestingOther() : *
      {
         tempStr2 = MD5contrast.getObj_MD5String(Main.player1.getBag().getOtherobjBag());
         if(testStr2 != tempStr2)
         {
            SaveXX.Save(5,888);
         }
         if(Main.P1P2)
         {
            p2tempStr2 = MD5contrast.getObj_MD5String(Main.player2.getBag().getOtherobjBag());
            if(p2testStr2 != p2tempStr2)
            {
               SaveXX.Save(5,888);
            }
         }
      }
      
      public static function setMD5Other() : *
      {
         testStr2 = MD5contrast.getObj_MD5String(Main.player1.getBag().getOtherobjBag());
         if(Main.P1P2)
         {
            p2testStr2 = MD5contrast.getObj_MD5String(Main.player2.getBag().getOtherobjBag());
         }
      }
   }
}

