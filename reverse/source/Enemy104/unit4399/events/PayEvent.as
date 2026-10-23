package unit4399.events
{
   import flash.events.Event;
   
   public class PayEvent extends Event
   {
      
      public static const LOG:String = "logsuccess";
      
      public static const INC_MONEY:String = "incMoney";
      
      public static const DEC_MONEY:String = "decMoney";
      
      public static const GET_MONEY:String = "getMoney";
      
      public static const PAY_MONEY:String = "payMoney";
      
      public static const PAY_ERROR:String = "payError";
      
      protected var _data:Object;
      
      public function PayEvent(type:String, dataOb:Object, bubbles:Boolean = false, cancelable:Boolean = false)
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

