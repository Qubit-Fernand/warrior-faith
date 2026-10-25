package src._data
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class GaneObjFactory
   {
      
      public static var dataArr:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function GaneObjFactory()
      {
         super();
      }
      
      public static function creatFactory() : *
      {
         myXml = XMLAsset.createXML(Data2.gameObjData);
         InitDataX();
      }
      
      private static function InitDataX() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:XML = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Object = null;
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            dataArr[_loc1_] = new Array();
            _loc1_++;
         }
         for each(_loc2_ in myXml.关卡掉落)
         {
            _loc3_ = Number(_loc2_.关卡);
            _loc4_ = Number(_loc2_.星级);
            _loc5_ = new Object();
            _loc1_ = 1;
            while(_loc1_ <= 12)
            {
               _loc5_["tb" + _loc1_] = uint(_loc2_["物品图标" + _loc1_]);
               _loc5_["mc" + _loc1_] = String(_loc2_["物品名称" + _loc1_]);
               _loc5_["sm" + _loc1_] = String(_loc2_["物品说明" + _loc1_]);
               _loc5_["pz" + _loc1_] = String(_loc2_["物品品质" + _loc1_]);
               _loc1_++;
            }
            dataArr[_loc4_][_loc3_] = _loc5_;
         }
      }
      
      public static function GetNumArr(param1:uint, param2:uint) : Array
      {
         var _loc3_:Array = new Array();
         var _loc4_:uint = 1;
         while(_loc4_ <= 12)
         {
            if(Boolean(dataArr[param2]) && Boolean(dataArr[param2][param1]))
            {
               _loc3_[_loc4_] = dataArr[param2][param1]["tb" + _loc4_];
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function GetInfo(param1:uint, param2:uint, param3:uint) : Array
      {
         var _loc4_:Array = new Array();
         if(Boolean(dataArr[param2]) && Boolean(dataArr[param2][param1]))
         {
            _loc4_[0] = dataArr[param2][param1]["mc" + param3];
            _loc4_[1] = dataArr[param2][param1]["sm" + param3];
            _loc4_[2] = dataArr[param2][param1]["pz" + param3];
         }
         return _loc4_;
      }
   }
}

