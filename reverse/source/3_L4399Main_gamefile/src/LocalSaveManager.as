package src
{
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   import flash.utils.ByteArray;

   public class LocalSaveManager
   {
      private static var _so:SharedObject;
      private static const SO_NAME:String = "yzlr2_saves";
      private static const MAX_SLOT:int = 8;
      private static var _lastStatus:String = "idle";
      private static var _lastError:String = "";
      private static var _confirmedSlots:Array = [];
      private static var _pendingSlots:Array;
      private static var _pendingCallback:Function;
      private static var _pending:Boolean = false;

      public function LocalSaveManager() { super(); }
      public static function get lastStatus():String { return _lastStatus; }
      public static function get lastError():String { return _lastError; }
      public static function get isPending():Boolean { return _pending; }

      public static function init() : void
      {
         if(_so) return;
         try
         {
            var opened:SharedObject = SharedObject.getLocal(SO_NAME);
            var slots:Array = opened.data.slots as Array;
            if(!slots)
            {
               slots = [];
               for(var i:int=0;i<MAX_SLOT;i++) slots[i]=null;
            }
            _confirmedSlots = snapshot(slots) as Array;
            opened.data.slots = snapshot(_confirmedSlots);
            opened.addEventListener(NetStatusEvent.NET_STATUS,onFlushStatus);
            _so = opened;
            // Do not flush empty initialization: every write has an explicit result.
         }
         catch(error:Error)
         {
            _so=null;
            reportFailed("无法打开本地存档："+error.message);
         }
      }

      /** One whole-role snapshot. Callback runs once only for pending resolution. */
      public static function saveSlot(slot:int, title:String, data:Object, onResolved:Function=null) : String
      {
         if(_pending) return reportBlocked("上一次保存仍在等待 Flash 存储许可，本次保存未提交。");
         init();
         if(!_so) return "failed";
         if(slot<0 || slot>=MAX_SLOT) slot=0;
         try
         {
            var now:Date = new Date();
            var meta:Object = {"index":slot,"title":title,
               "datetime":now.fullYear+"-"+pad2(now.month+1)+"-"+pad2(now.date)+" "+pad2(now.hours)+":"+pad2(now.minutes)+":"+pad2(now.seconds),
               "data":data};
            // Keep the user-facing label when saving the same role, not a new
            // character that happens to occupy the same slot.
            var previous:Object = _confirmedSlots[slot];
            if(previous && previous.hasOwnProperty("displayName") &&
               previous.data && data && previous.data.hasOwnProperty("logNameSave") &&
               data.hasOwnProperty("logNameSave") &&
               previous.data.logNameSave == data.logNameSave)
            {
               meta.displayName = previous.displayName;
               meta.title = String(meta.displayName) + " " + title.replace("P1:", "");
            }
            // AMF snapshot detaches live inventory/chapter mutations while permission is pending.
            var next:Array = snapshot(_confirmedSlots) as Array;
            next[slot] = snapshot(meta);
            _pendingSlots=next;
            _so.data.slots=next;
            var result:String = _so.flush();
            if(result==SharedObjectFlushStatus.FLUSHED)
            {
               _confirmedSlots=next;
               _pendingSlots=null;
               _lastStatus="flushed";_lastError="";
               return "flushed";
            }
            if(result==SharedObjectFlushStatus.PENDING)
            {
               _pending=true;_pendingCallback=onResolved;
               _lastStatus="pending";_lastError="";
               return "pending";
            }
            rollback();
            return reportFailed("本地存储返回未识别状态："+result);
         }
         catch(error:Error)
         {
            rollback();
            return reportFailed("写入本地存档失败："+error.message);
         }
      }

      /** Preserve the status of an older in-flight save when rejecting a new request. */
      public static function reportBlocked(reason:String) : String
      {
         if(!_pending) _lastStatus="blocked";
         _lastError=reason;
         return "blocked";
      }
      public static function reportFailed(reason:String) : String
      {
         if(!_pending) _lastStatus="failed";
         _lastError=reason;
         return "failed";
      }
      private static function onFlushStatus(event:NetStatusEvent) : void
      {
         if(!_pending) return;
         var code:String = String(event.info.code);
         if(code!="SharedObject.Flush.Success" && code!="SharedObject.Flush.Failed") return;
         var callback:Function=_pendingCallback;
         _pendingCallback=null;_pending=false;
         if(code=="SharedObject.Flush.Success")
         {
            _confirmedSlots=_pendingSlots;_pendingSlots=null;
            _lastStatus="flushed";_lastError="";
         }
         else
         {
            rollback();
            _lastStatus="failed";_lastError="Flash 未允许写入本地存储，存档尚未保存。";
         }
         // Clear the pending transaction before invoking code that may retry.
         if(callback!=null) callback(_lastStatus,_lastError);
      }
      private static function rollback() : void
      {
         _pendingSlots=null;_pendingCallback=null;_pending=false;
         if(_so) _so.data.slots=_confirmedSlots;
      }
      private static function snapshot(value:Object) : Object
      {
         var bytes:ByteArray=new ByteArray();
         bytes.writeObject(value);bytes.position=0;
         return bytes.readObject();
      }
      public static function loadSlot(slot:int) : Object
      {
         init();
         if(!_so || slot<0 || slot>=MAX_SLOT) return null;
         // Loading must not mutate the confirmed snapshot through shared references.
         return _confirmedSlots[slot]==null ? null : snapshot(_confirmedSlots[slot]);
      }
      public static function getSlotTitles() : Array
      {
         init();
         var arr:Array=[];
         for(var i:int=0;i<MAX_SLOT;i++)
         {
            var meta:Object=_confirmedSlots[i];
            if(meta==null) arr[i]="空存档";
            else
            {
               var stamp:String=String(meta.datetime);
               if(stamp.indexOf("explicit")>=0) stamp=stamp.substr(0,10)+" · 体验起点";
               arr[i]=meta.title+"\n"+stamp;
            }
         }
         return arr;
      }
      private static function pad2(n:int) : String { return (n<10?"0":"")+n; }
   }
}
