package src._data
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.common.*;
   import src.*;
   import src.tool.*;
   
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
         for each(_loc1_ in myXml.点券商城)
         {
            _loc2_ = uint(_loc1_.ID);
            Shop4399.ShopArr[_loc2_] = new Array();
            Shop4399.ShopArr[_loc2_][0] = VT.createVT(Number(_loc1_.点券));
            Shop4399.ShopArr[_loc2_][1] = String(_loc1_.类型);
            Shop4399.ShopArr[_loc2_][2] = VT.createVT(Number(_loc1_.物品ID));
            Shop4399.ShopArr[_loc2_][3] = int(_loc1_.图标);
            Shop4399.ShopArr[_loc2_][4] = String(_loc1_.说明);
            Shop4399.ShopArr[_loc2_][5] = String(_loc1_.名称);
            Shop4399.ShopArr[_loc2_][6] = VT.createVT(_loc1_.商城ID);
            Shop4399.ShopArr[_loc2_][7] = VT.createVT(_loc2_);
         }
      }
      
      public static function GetObjData(param1:uint, param2:uint = 1) : Object
      {
         var _loc3_:Object = new Object();
         _loc3_.propId = "" + (Shop4399.ShopArr[param1][6] as VT).getValue();
         _loc3_.count = param2;
         _loc3_.price = (Shop4399.ShopArr[param1][0] as VT).getValue();
         _loc3_.idx = Main.saveNum;
         _loc3_.tag = "BuyObj_" + _loc3_.propId;
         TiaoShi.txtShow(">>>>>>>>>>>>>>>> GetObjData id = " + _loc3_.propId + ", dataObj.price = " + _loc3_.price);
         return _loc3_;
      }
   }
}

