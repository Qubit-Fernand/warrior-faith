package com.hotpoint.braveManIII.events
{
   import flash.events.Event;
   
   public class DaoJuEvent extends Event
   {
      
      public static const DAOJU_OVER_MESSAGE:String = "ID_NAME_OVER";
      
      public static const DAOJU_DOWN_MESSAGE:String = "ID_NAME_DOWN";
      
      public static const DAOJU_UP_MESSAGE:String = "ID_NAME_UP";
      
      public static const DAOJU_OUT_MESSAGE:String = "ID_NAME_OUT";
      
      public function DaoJuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("DaoJuEvent","type","bubbles","cancelable","eventPhase");
      }
      
      override public function clone() : Event
      {
         return new DaoJuEvent(type,bubbles,cancelable);
      }
   }
}

