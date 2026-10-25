package com.hotpoint.braveManIII.events
{
   import flash.events.Event;
   
   public class BtnEvent extends Event
   {
      
      public static const OPEN_INIT:String = "openInit";
      
      public static const OPEN_COMPLETE:String = "openComplete";
      
      public static const DO_CHANGE:String = "doChange";
      
      public static const DO_CLICK:String = "doClick";
      
      public static const DO_CLOSE:String = "doClose";
      
      public static const DO_OUT:String = "doOut";
      
      public static const DO_OVER:String = "doOver";
      
      public static const DO_ONECLICK:* = "doOneClick";
      
      private var _id:Number;
      
      public function BtnEvent(type:String, id:Number = 0)
      {
         super(type,true,false);
         this._id = id;
      }
      
      public function get id() : Number
      {
         return this._id;
      }
   }
}

