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
      
      public function ClassLoader(obj:Object = null, lc:LoaderContext = null)
      {
         super();
         if(obj != null)
         {
            if(obj is ByteArray)
            {
               this.loadBytes(obj as ByteArray,lc);
            }
            else
            {
               if(!(obj is String))
               {
                  throw new Error("参数错误，构造函数第一参数只接受ByteArray或String");
               }
               this.load(obj as String,lc);
            }
         }
      }
      
      public function load(_url:String, lc:LoaderContext = null) : void
      {
         this.url = _url;
         this.loader = new Loader();
         this.loader.load(new URLRequest(this.url),lc);
         this.addEvent();
      }
      
      private function NoCookie(str:String) : String
      {
         var s:* = undefined;
         for(s in this.noCookieArr)
         {
            if(this.noCookieArr[s] == str)
            {
               return str + "?" + int(Math.random() * 1000);
            }
         }
         return str;
      }
      
      public function loadBytes(bytes:ByteArray, lc:LoaderContext = null) : void
      {
         this.loader = new Loader();
         this.loader.loadBytes(bytes,lc);
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
      
      private function completeFun(e:Event) : void
      {
         this.delEvent();
         dispatchEvent(e);
      }
      
      private function progressFun(e:ProgressEvent) : void
      {
         dispatchEvent(e);
         var percentLoadedXX:Number = e.bytesLoaded / e.bytesTotal;
         Load.percentLoaded = Math.round(percentLoadedXX * 100);
      }
      
      public function getClass(className:String) : Object
      {
         return this.loader.contentLoaderInfo.applicationDomain.getDefinition(className);
      }
      
      public function hasClass(className:String) : Boolean
      {
         return this.loader.contentLoaderInfo.applicationDomain.hasDefinition(className);
      }
      
      public function clear() : void
      {
         this.loader.unload();
         this.loader = null;
      }
   }
}

