package unit4399.events
{
   import flash.events.Event;
   
   public class SaveEvent extends Event
   {
      
      public static const LOG:String = "logreturn";
      
      public static const SAVE_SET:String = "saveuserdata";
      
      public static const SAVE_GET:String = "getuserdata";
      
      public static const SAVE_LIST:String = "getuserdatalist";
      
      protected var _data:Object;
      
      public function SaveEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      override public function toString() : String
      {
         return formatToString("DataEvent:","type","bubbles","cancelable","data");
      }
      
      public function get ret() : Object
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new SaveEvent(type,data,bubbles,cancelable);
      }
   }
}

