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
      
      public static function duMake(param1:Array) : void
      {
         makeArr = param1;
      }
      
      public static function initAllMake() : void
      {
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(!makeArr)
         {
            makeArr = new Array();
            makeArr = MakeFactory.makeData;
         }
         if(makeArr.length != MakeFactory.makeData.length)
         {
            _loc1_ = DeepCopyUtil.clone(MakeFactory.makeData);
            _loc2_ = 0;
            while(_loc2_ < MakeFactory.makeData.length)
            {
               _loc3_ = 0;
               while(_loc3_ < makeArr.length)
               {
                  if((MakeFactory.makeData[_loc2_] as Make).getId() == (makeArr[_loc3_] as Make).getId())
                  {
                     _loc1_[_loc2_] = makeArr[_loc3_];
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
            makeArr = _loc1_;
         }
      }
      
      public static function clearXXX() : void
      {
         makeArr = null;
      }
      
      public static function open(param1:Number) : void
      {
         var _loc2_:Make = null;
         for each(_loc2_ in makeArr)
         {
            if(_loc2_.getId() == param1)
            {
               _loc2_.setState();
            }
         }
      }
      
      public static function isOpen(param1:Number) : Boolean
      {
         var _loc2_:Make = null;
         for each(_loc2_ in makeArr)
         {
            if(_loc2_.getId() == param1)
            {
               return _loc2_.isState();
            }
         }
         return false;
      }
      
      public static function getAllByType(param1:Number) : Array
      {
         var _loc3_:Make = null;
         var _loc2_:Array = [];
         for each(_loc3_ in makeArr)
         {
            if(_loc3_.getType() == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function getArr4(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         _loc2_ = getAllByType(param1);
         var _loc5_:uint = 0;
         while(_loc5_ < 100)
         {
            if(_loc2_.length < 4)
            {
               _loc3_ = _loc2_.splice(0);
               if(_loc3_.length > 0)
               {
                  _loc4_.push(_loc3_);
               }
               break;
            }
            _loc3_ = _loc2_.splice(0,4);
            _loc4_.push(_loc3_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function getEquip(param1:Number, param2:Number) : Array
      {
         var _loc3_:Array = [];
         if(param2 == 1)
         {
            _loc3_ = Main.player1.getBag().getEquipById(param1);
         }
         else if(param2 == 2)
         {
            _loc3_ = Main.player2.getBag().getEquipById(param1);
         }
         return _loc3_;
      }
      
      public static function getSup(param1:Number, param2:Number) : Array
      {
         var _loc3_:Array = [];
         if(param2 == 1)
         {
            _loc3_ = Main.player1.getBag().getSupById(param1);
         }
         else if(param2 == 2)
         {
            _loc3_ = Main.player2.getBag().getSupById(param1);
         }
         return _loc3_;
      }
      
      public static function getGem(param1:Number, param2:Number) : Array
      {
         var _loc3_:Array = [];
         if(param2 == 1)
         {
            _loc3_ = Main.player1.getBag().getGemById(param1);
         }
         else if(param2 == 2)
         {
            _loc3_ = Main.player2.getBag().getGemById(param1);
         }
         return _loc3_;
      }
      
      public static function getOther(param1:Number, param2:Number) : Array
      {
         var _loc3_:Array = [];
         if(param2 == 1)
         {
            _loc3_ = Main.player1.getBag().getOtherobjById(param1);
         }
         else if(param2 == 2)
         {
            _loc3_ = Main.player2.getBag().getOtherobjById(param1);
         }
         return _loc3_;
      }
      
      public static function getGemType(param1:Number, param2:Number) : Array
      {
         var _loc3_:Array = [];
         if(param2 == 1)
         {
            _loc3_ = Main.player1.getBag().getGemByType(param1);
         }
         else if(param2 == 2)
         {
            _loc3_ = Main.player2.getBag().getGemByType(param1);
         }
         return _loc3_;
      }
      
      public static function getOtherType(param1:Number, param2:Number) : Array
      {
         var _loc3_:Array = [];
         if(param2 == 1)
         {
            _loc3_ = Main.player1.getBag().getOtherByType(param1);
         }
         else if(param2 == 2)
         {
            _loc3_ = Main.player2.getBag().getOtherByType(param1);
         }
         return _loc3_;
      }
   }
}

