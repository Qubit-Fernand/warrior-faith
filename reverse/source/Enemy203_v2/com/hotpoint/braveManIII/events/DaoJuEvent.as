package com.hotpoint.braveManIII.events
{
   import flash.events.Event;
   
   public class DaoJuEvent extends Event
   {
      
      public static const DAOJU_OVER_MESSAGE:String = "ID_NAME_OVER";
      
      public static const DAOJU_DOWN_MESSAGE:String = "ID_NAME_DOWN";
      
      public static const DAOJU_UP_MESSAGE:String = "ID_NAME_UP";
      
      public static const DAOJU_OUT_MESSAGE:String = "ID_NAME_OUT";
      
      public static const DAOJU_CLICK_MESSAGE:String = "ID_NAME_CLICK";
      
      public function DaoJuEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new DaoJuEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("DaoJuEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}

