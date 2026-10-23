package com.hotpoint.braveManIII.views.makePanel
{
   import com.hotpoint.braveManIII.models.make.*;
   import com.hotpoint.braveManIII.repository.make.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import src.*;
   
   public class MakeData
   {
      
      public static var makeArr:Array;
      
      public function MakeData()
      {
         super();
      }
      
      public static function saveMake() : Array
      {
         return makeArr;
      }
      
      public static function duMake(arr:Array) : void
      {
         makeArr = arr;
      }
      
      public static function initAllMake() : void
      {
         var arr:Array = null;
         var i:uint = 0;
         var j:uint = 0;
         if(!makeArr)
         {
            makeArr = new Array();
            makeArr = MakeFactory.makeData;
         }
         if(makeArr.length != MakeFactory.makeData.length)
         {
            arr = DeepCopyUtil.clone(MakeFactory.makeData);
            for(i = 0; i < MakeFactory.makeData.length; i++)
            {
               for(j = 0; j < makeArr.length; j++)
               {
                  if((MakeFactory.makeData[i] as Make).getId() == (makeArr[j] as Make).getId())
                  {
                     arr[i] = makeArr[j];
                  }
               }
            }
            makeArr = arr;
         }
      }
      
      public static function clearXXX() : void
      {
         makeArr = null;
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
      
      public static function isOpen(id:Number) : Boolean
      {
         var data:Make = null;
         for each(data in makeArr)
         {
            if(data.getId() == id)
            {
               return data.isState();
            }
         }
         return false;
      }
      
      public static function getAllByType(type:Number) : Array
      {
         var data:Make = null;
         var arr:Array = [];
         for each(data in makeArr)
         {
            if(data.getType() == type)
            {
               arr.push(data);
            }
         }
         return arr;
      }
      
      public static function getArr4(type:Number) : Array
      {
         var arr:Array = [];
         var arr2:Array = [];
         var allArr:Array = [];
         arr = getAllByType(type);
         for(var i:uint = 0; i < 100; i++)
         {
            if(arr.length < 4)
            {
               arr2 = arr.splice(0);
               if(arr2.length > 0)
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
      
      public static function getEquip(id:Number, num:Number) : Array
      {
         var arr:Array = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getEquipById(id);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getEquipById(id);
         }
         return arr;
      }
      
      public static function getSup(id:Number, num:Number) : Array
      {
         var arr:Array = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getSupById(id);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getSupById(id);
         }
         return arr;
      }
      
      public static function getGem(id:Number, num:Number) : Array
      {
         var arr:Array = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getGemById(id);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getGemById(id);
         }
         return arr;
      }
      
      public static function getOther(id:Number, num:Number) : Array
      {
         var arr:Array = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getOtherobjById(id);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getOtherobjById(id);
         }
         return arr;
      }
      
      public static function getGemType(type:Number, num:Number) : Array
      {
         var arr:Array = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getGemByType(type);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getGemByType(type);
         }
         return arr;
      }
      
      public static function getOtherType(type:Number, num:Number) : Array
      {
         var arr:Array = [];
         if(num == 1)
         {
            arr = Main.player1.getBag().getOtherByType(type);
         }
         else if(num == 2)
         {
            arr = Main.player2.getBag().getOtherByType(type);
         }
         return arr;
      }
   }
}

