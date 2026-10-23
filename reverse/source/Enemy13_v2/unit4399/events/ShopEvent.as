package unit4399.events
{
   import flash.events.Event;
   
   public class ShopEvent extends Event
   {
      
      public static const SHOP_GET_PACKAGEINFO:String = "getPacakgeInfo";
      
      public static const SHOP_DEL_SUCC:String = "delItemSuc";
      
      public static const SHOP_ERROR:String = "shopError";
      
      public static const SHOP_ADD_SUCC:String = "addItemSuc";
      
      public static const SHOP_ADDFREE_SUCC:String = "addFreeItemSuc";
      
      public static const SHOP_UPDATEPRO_SUCC:String = "updateProSuc";
      
      public static const SHOP_UPDATE_EXTEND:String = "updateExtend";
      
      public static const SHOP_GET_FREEPACKAGEINFO:String = "getFreePacakgeInfo";
      
      public static const SHOP_GET_PAYPACKAGEINFO:String = "getPayPacakgeInfo";
      
      public static const SHOP_GET_TYPENOTICE:String = "getTypeNotice";
      
      public static const SHOP_MODIFY_EX:String = "modifyEx";
      
      public static const SHOP_CLEARITEMS_EXTYPE:String = "clearItemsByExType";
      
      protected var _data:Object;
      
      public function ShopEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new ShopEvent(type,data,bubbles,cancelable);
      }
   }
}

