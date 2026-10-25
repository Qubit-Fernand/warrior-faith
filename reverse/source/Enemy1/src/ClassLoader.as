package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.LoaderContext;
   import flash.text.*;
   import flash.utils.*;
   
   public class ClassLoader extends EventDispatcher
   {
      
      public var loader:Loader;
      
      public var url:String;
      
      public function ClassLoader(obj:Object = null, lc:LoaderContext = null)
      {
         super();
         if(obj != null)
         {
            if(obj is ByteArray)
            {
               loadBytes(obj as ByteArray,lc);
            }
            else
            {
               if(!(obj is String))
               {
                  throw new Error("参数错误，构造函数第一参数只接受ByteArray或String");
               }
               load(obj as String,lc);
            }
         }
      }
      
      public function getClass(className:String) : Object
      {
         return loader.contentLoaderInfo.applicationDomain.getDefinition(className);
      }
      
      private function delEvent() : void
      {
         loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,progressFun);
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeFun);
      }
      
      private function progressFun(e:ProgressEvent) : void
      {
         var percentLoadedXX:Number = NaN;
         dispatchEvent(e);
         percentLoadedXX = e.bytesLoaded / e.bytesTotal;
         Load.percentLoaded = Math.round(percentLoadedXX * 100);
      }
      
      public function clear() : void
      {
         loader.unload();
         loader = null;
      }
      
      public function loadBytes(bytes:ByteArray, lc:LoaderContext = null) : void
      {
         loader = new Loader();
         loader.loadBytes(bytes,lc);
         addEvent();
      }
      
      public function load(_url:String, lc:LoaderContext = null) : void
      {
         url = _url;
         loader = new Loader();
         loader.load(new URLRequest(url),lc);
         addEvent();
      }
      
      private function completeFun(e:Event) : void
      {
         delEvent();
         dispatchEvent(e);
      }
      
      private function addEvent() : void
      {
         loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressFun);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeFun);
      }
      
      public function hasClass(className:String) : Boolean
      {
         return loader.contentLoaderInfo.applicationDomain.hasDefinition(className);
      }
   }
}

