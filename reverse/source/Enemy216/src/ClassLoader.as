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
      
      public var url:String;
      
      public var loader:Loader;
      
      private var noCookieArr:Array = ["TempData.swf"];
      
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
      
      public function load(param1:String, param2:LoaderContext = null) : void
      {
         url = param1;
         loader = new Loader();
         loader.load(new URLRequest(url),param2);
         addEvent();
      }
      
      private function NoCookie(param1:String) : String
      {
         var _loc2_:* = undefined;
         for(_loc2_ in noCookieArr)
         {
            if(noCookieArr[_loc2_] == param1)
            {
               return param1 + "?" + int(Math.random() * 1000);
            }
         }
         return param1;
      }
      
      public function loadBytes(param1:ByteArray, param2:LoaderContext = null) : void
      {
         loader = new Loader();
         loader.loadBytes(param1,param2);
         addEvent();
      }
      
      private function addEvent() : void
      {
         loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressFun);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeFun);
      }
      
      private function delEvent() : void
      {
         loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,progressFun);
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeFun);
      }
      
      private function completeFun(param1:Event) : void
      {
         delEvent();
         dispatchEvent(param1);
      }
      
      private function progressFun(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         Load.percentLoaded = Math.round(_loc2_ * 100);
      }
      
      public function getClass(param1:String) : Object
      {
         return loader.contentLoaderInfo.applicationDomain.getDefinition(param1);
      }
      
      public function hasClass(param1:String) : Boolean
      {
         return loader.contentLoaderInfo.applicationDomain.hasDefinition(param1);
      }
      
      public function clear() : void
      {
         loader.unload();
         loader = null;
      }
   }
}

