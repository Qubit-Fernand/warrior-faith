package com.hotpoint.braveManIII.Tool
{
   import mx.core.*;
   
   public class XMLAsset
   {
      
      protected var _xml:XML;
      
      public function XMLAsset(param1:Class)
      {
         super();
         if(param1 != null)
         {
            this._xml = createXML(param1);
         }
      }
      
      public static function createXML(param1:Class) : XML
      {
         var xml:XML = null;
         var asset:Class = param1;
         var ba:ByteArrayAsset = ByteArrayAsset(new asset());
         var source:String = ba.readUTFBytes(ba.length);
         try
         {
            xml = new XML(source);
         }
         catch(error:Error)
         {
            throw new Error("Class must embed an XML document containing valid mark-up. " + error.message);
         }
         return xml;
      }
      
      public function get xml() : XML
      {
         return this._xml;
      }
   }
}

