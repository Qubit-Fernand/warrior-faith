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
               this.loadBytes(param1 as ByteArray,param2);
            }
            else
            {
               if(!(param1 is String))
               {
                  throw new Error("参数错误，构造函数第一参数只接受ByteArray或String");
               }
               this.load(param1 as String,param2);
            }
         }
      }
      
      public function load(param1:String, param2:LoaderContext = null) : void
      {
         this.url = param1;
         this.loader = new Loader();
         this.loader.load(new URLRequest(this.url),param2);
         this.addEvent();
      }
      
      private function NoCookie(param1:String) : String
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.noCookieArr)
         {
            if(this.noCookieArr[_loc2_] == param1)
            {
               return param1 + "?" + int(Math.random() * 1000);
            }
         }
         return param1;
      }
      
      public function loadBytes(param1:ByteArray, param2:LoaderContext = null) : void
      {
         this.loader = new Loader();
         this.loader.loadBytes(param1,param2);
         this.addEvent();
      }
      
      private function addEvent() : void
      {
         this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressFun);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeFun);
      }
      
      private function delEvent() : void
      {
         this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progressFun);
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeFun);
      }
      
      private function completeFun(param1:Event) : void
      {
         this.delEvent();
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
         return this.loader.contentLoaderInfo.applicationDomain.getDefinition(param1);
      }
      
      public function hasClass(param1:String) : Boolean
      {
         return this.loader.contentLoaderInfo.applicationDomain.hasDefinition(param1);
      }
      
      public function clear() : void
      {
         this.loader.unload();
         this.loader = null;
      }
   }
}

