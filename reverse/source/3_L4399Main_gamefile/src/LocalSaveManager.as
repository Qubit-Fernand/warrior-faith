package src
{
   import flash.net.SharedObject;
   
   public class LocalSaveManager
   {
      
      private static var _so:SharedObject;
      
      private static const SO_NAME:String = "yzlr2_saves";
      
      private static const MAX_SLOT:int = 8;
      
      public function LocalSaveManager()
      {
         super();
      }
      
      public static function init() : void
      {
         if(_so)
         {
            return;
         }
         _so = SharedObject.getLocal(SO_NAME);
         if(!_so.data.slots)
         {
            _so.data.slots = [];
            var i:int = 0;
            while(i < MAX_SLOT)
            {
               _so.data.slots[i] = null;
               i++;
            }
            _so.flush();
         }
      }
      
      public static function saveSlot(slot:int, title:String, data:Object) : void
      {
         init();
         if(slot < 0 || slot >= MAX_SLOT)
         {
            slot = 0;
         }
         var now:Date = new Date();
         var meta:Object = {
            "index":slot,
            "title":title,
            "datetime":now.fullYear + "-" + pad2(now.month + 1) + "-" + pad2(now.date) + " " + pad2(now.hours) + ":" + pad2(now.minutes) + ":" + pad2(now.seconds),
            "data":data
         };
         _so.data.slots[slot] = meta;
         _so.flush();
      }
      
      public static function loadSlot(slot:int) : Object
      {
         init();
         if(slot < 0 || slot >= MAX_SLOT)
         {
            return null;
         }
         return _so.data.slots[slot];
      }
      
      public static function getSlotTitles() : Array
      {
         init();
         var arr:Array = [];
         var i:int = 0;
         while(i < MAX_SLOT)
         {
            var meta:Object = _so.data.slots[i];
            if(meta == null)
            {
               arr[i] = "空存档";
            }
            else
            {
               arr[i] = meta.title + "\n" + meta.datetime;
            }
            i++;
         }
         return arr;
      }
      
      private static function pad2(n:int) : String
      {
         return (n < 10 ? "0" : "") + n;
      }
   }
}

