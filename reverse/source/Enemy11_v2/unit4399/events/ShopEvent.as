package unit4399.events
{
   import flash.events.Event;
   
   public class ShopEvent extends Event
   {
      
      public static const SHOP_GET_PACKAGEINFO:String = "getPacakgeInfo";
      
      public static const SHOP_DEL_SUCC:String = "delItemSuc";
      
      public static const SHOP_ERROR:String = "shopError";
      
      protected var _data:Object;
      
      public function ShopEvent(type:String, dataOb:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         _data = dataOb;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new PayEvent(type,data,bubbles,cancelable);
      }
   }
}

