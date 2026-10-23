package src._data
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.common.*;
   import src.*;
   
   public class ShopFactory
   {
      
      public static var myXml:XML = new XML();
      
      public static var AllData:Array = new Array();
      
      public function ShopFactory()
      {
         super();
      }
      
      public static function creatFactory() : *
      {
         myXml = XMLAsset.createXML(Data2.shopData);
         InitDataX();
      }
      
      private static function InitDataX() : *
      {
         var _loc1_:XML = null;
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         for each(_loc1_ in myXml.点券商城)
         {
            _loc2_ = uint(_loc1_.ID);
            _loc3_ = new Object();
            _loc3_.x1 = String(_loc1_.类型);
            _loc3_.x2 = VT.createVT(Number(_loc1_.物品ID));
            _loc3_.x3 = String(_loc1_.名称);
            _loc3_.x4 = VT.createVT(Number(_loc1_.图标));
            _loc3_.x5 = String(_loc1_.说明);
            _loc3_.x6 = VT.createVT(Number(_loc1_.点券));
            AllData[_loc2_] = _loc3_;
         }
      }
   }
}

