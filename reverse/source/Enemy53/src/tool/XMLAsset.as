package src.tool
{
   import mx.core.*;
   
   public class XMLAsset
   {
      
      protected var _xml:XML;
      
      public function XMLAsset(asset:Class)
      {
         super();
         if(asset != null)
         {
            this._xml = createXML(asset);
         }
      }
      
      public static function createXML(asset:Class) : XML
      {
         var xml:XML = null;
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

