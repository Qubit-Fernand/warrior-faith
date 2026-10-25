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
      
      public function ClassLoader(param1:Object = null, param2:LoaderContext = null)
      {
         super();
         if(param1 != null)
         {
            if(param1 is ByteArray)
            {
               loadBytes(param1 as ByteArray,param2);
            }
            else
            {
               if(!(param1 is String))
               {
                  throw new Error("参数错误，构造函数第一参数只接受ByteArray或String");
               }
               load(param1 as String,param2);
            }
         }
      }
      
      public function getClass(param1:String) : Object
      {
         return loader.contentLoaderInfo.applicationDomain.getDefinition(param1);
      }
      
      private function delEvent() : void
      {
         loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,progressFun);
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeFun);
      }
      
      private function progressFun(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         dispatchEvent(param1);
         _loc2_ = param1.bytesLoaded / param1.bytesTotal;
         Load.percentLoaded = Math.round(_loc2_ * 100);
      }
      
      public function clear() : void
      {
         loader.unload();
         loader = null;
      }
      
      public function loadBytes(param1:ByteArray, param2:LoaderContext = null) : void
      {
         loader = new Loader();
         loader.loadBytes(param1,param2);
         addEvent();
      }
      
      public function load(param1:String, param2:LoaderContext = null) : void
      {
         url = param1;
         loader = new Loader();
         loader.load(new URLRequest(url),param2);
         addEvent();
      }
      
      private function completeFun(param1:Event) : void
      {
         delEvent();
         dispatchEvent(param1);
      }
      
      private function addEvent() : void
      {
         loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressFun);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeFun);
      }
      
      public function hasClass(param1:String) : Boolean
      {
         return loader.contentLoaderInfo.applicationDomain.hasDefinition(param1);
      }
   }
}

