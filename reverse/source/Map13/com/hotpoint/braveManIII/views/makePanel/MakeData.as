package com.hotpoint.braveManIII.views.makePanel
{
   import com.hotpoint.braveManIII.models.make.Make;
   import com.hotpoint.braveManIII.repository.make.*;
   import src.*;
   
   public class MakeData
   {
      
      public static var makeArr:Array;
      
      public function MakeData()
      {
         super();
      }
      
      public static function getOther(id:Number, num:Number) : Array
      {
         var arr:Array = null;
         arr = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getOtherobjById(id);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getOtherobjById(id);
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public static function getArr4(type:Number) : Array
      {
         var arr:Array = null;
         var arr2:Array = null;
         var allArr:Array = null;
         var i:uint = 0;
         arr = [];
         arr2 = [];
         allArr = [];
         arr = getAllByType(type);
         for(i = 0; i < 100; i++)
         {
            if(arr.length < 4)
            {
               arr2 = arr.splice(0);
               if(arr2 != "")
               {
                  allArr.push(arr2);
               }
               break;
            }
            arr2 = arr.splice(0,4);
            allArr.push(arr2);
         }
         trace(allArr);
         trace(allArr.length,"allArr.length");
         return allArr;
      }
      
      public static function open(id:Number) : void
      {
         var data:Make = null;
         for each(data in makeArr)
         {
            if(data.getId() == id)
            {
               data.setState();
            }
         }
      }
      
      public static function saveMake() : Array
      {
         return makeArr;
      }
      
      public static function initAllMake() : void
      {
         if(!makeArr)
         {
            makeArr = new Array();
            makeArr = MakeFactory.makeData;
         }
      }
      
      public static function getOtherType(type:Number, num:Number) : Array
      {
         var arr:Array = null;
         arr = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getOtherByType(type);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getOtherByType(type);
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public static function getGemType(type:Number, num:Number) : Array
      {
         var arr:Array = null;
         arr = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getGemByType(type);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getGemByType(type);
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public static function getSup(id:Number, num:Number) : Array
      {
         var arr:Array = null;
         arr = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getSupById(id);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getSupById(id);
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public static function getGem(id:Number, num:Number) : Array
      {
         var arr:Array = null;
         arr = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getGemById(id);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getGemById(id);
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public static function getEquip(id:Number, num:Number) : Array
      {
         var arr:Array = null;
         arr = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getEquipById(id);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getEquipById(id);
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public static function getAllByType(type:Number) : Array
      {
         var arr:Array = null;
         var data:Make = null;
         arr = [];
         for each(data in makeArr)
         {
            if(data.getType() == type)
            {
               arr.push(data);
            }
         }
         return arr;
      }
      
      public static function duMake(arr:Array) : void
      {
         makeArr = arr;
      }
   }
}

