package unit4399.events
{
   import flash.events.Event;
   
   public class RankListEvent extends Event
   {
      
      public static const RANKLIST_ERROR:String = "rankListError";
      
      public static const RANKLIST_SUCCESS:String = "rankListSuccess";
      
      protected var _data:Object;
      
      public function RankListEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._data = param2;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      override public function clone() : Event
      {
         return new RankListEvent(type,this.data,bubbles,cancelable);
      }
   }
}

