package com.hotpoint.braveManIII.views.strPanel
{
   public class StrBag
   {
      
      private var _bagArr:Array = [];
      
      private var _pointArr:Array = [];
      
      public function StrBag()
      {
         super();
      }
      
      public static function creatBag() : StrBag
      {
         var data:StrBag = new StrBag();
         data.initBag();
         return data;
      }
      
      private function initBag() : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            this._bagArr[i] = -1;
            this._pointArr[i] = -1;
         }
      }
      
      public function addBag(ob:Object, num:Number = -1) : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._bagArr[i] == -1)
            {
               this._bagArr[i] = ob;
               this._pointArr[i] = num;
               break;
            }
         }
      }
      
      public function getObj(num:Number) : Array
      {
         var arr:Array = [];
         if(this._bagArr[num] != -1)
         {
            arr = [this._bagArr[num],this._pointArr[num]];
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function clearBag() : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            this._bagArr[i] = -1;
            this._pointArr[i] = -1;
         }
      }
   }
}

