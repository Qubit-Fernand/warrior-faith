package chaptertest
{
    import flash.events.EventDispatcher;
    import flash.events.NetStatusEvent;
    import flash.utils.ByteArray;

    /** In-memory storage double. This class never imports or opens SharedObject. */
    public class FakeSharedObject extends EventDispatcher
    {
        public static var instance:FakeSharedObject = new FakeSharedObject();
        public static var throwOnOpen:Boolean = false;
        public var data:Object = {};
        public var persisted:Object = {};
        public var pendingSnapshot:Object;
        public var nextResult:String = "flushed";
        public var flushCalls:int = 0;
        public var requestedName:String = "";

        public function FakeSharedObject() {super();}

        public static function getLocal(name:String):FakeSharedObject
        {
            if(throwOnOpen)throw new Error("injected open failure");
            instance.requestedName=name;
            return instance;
        }
        public function flush():String
        {
            flushCalls++;
            if(nextResult=="throw")throw new Error("injected flush exception");
            if(nextResult=="flushed")persisted=copy(data);
            else if(nextResult=="pending")pendingSnapshot=copy(data);
            return nextResult;
        }
        public function resolve(success:Boolean):void
        {
            if(success && pendingSnapshot!=null)persisted=copy(pendingSnapshot);
            pendingSnapshot=null;
            signal(success?"SharedObject.Flush.Success":"SharedObject.Flush.Failed");
        }
        public function signal(code:String):void
        {
            dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS,false,false,{code:code}));
        }
        private function copy(value:Object):Object
        {
            var bytes:ByteArray=new ByteArray();bytes.writeObject(value);bytes.position=0;
            return bytes.readObject();
        }
    }
}
