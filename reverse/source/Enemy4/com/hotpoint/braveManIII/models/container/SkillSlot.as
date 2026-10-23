package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import flash.utils.*;
   
   public class SkillSlot
   {
      
      private static var _slotNum:VT;
      
      private static var _slotArr:Array = [];
      
      public function SkillSlot()
      {
         super();
      }
      
      public static function creatStriengSkill() : SkillSlot
      {
         var _loc1_:SkillSlot = null;
         _loc1_ = new SkillSlot();
         _slotNum = VT.createVT(3);
         creatSlotArr();
         return _loc1_;
      }
      
      private static function creatSlotArr() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         _loc1_ = Number(_slotNum.getValue());
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _slotArr[_loc2_] = -1;
            _loc2_++;
         }
      }
      
      public function slotArr() : Array
      {
         return _slotArr;
      }
      
      public function get slotNum() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _slotNum;
      }
      
      public function delSlot(param1:Number) : void
      {
         if(_slotArr[param1] != 1)
         {
            _slotArr[param1] = -1;
         }
      }
      
      public function clearSlot() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            if(_slotArr[_loc1_] != -1)
            {
               _slotArr[_loc1_] = -1;
            }
            _loc1_++;
         }
      }
      
      public function getType(param1:uint) : Number
      {
         if(_slotArr[param1] != -1)
         {
            if(_slotArr[param1] as Gem)
            {
               return _slotArr[param1].getType();
            }
         }
         return -1;
      }
      
      public function getPropGem(param1:uint) : Boolean
      {
         if(_slotArr[param1] is Gem)
         {
            return true;
         }
         return false;
      }
      
      public function getPropEquip(param1:uint) : Boolean
      {
         if(_slotArr[param1] is Equip)
         {
            return true;
         }
         return false;
      }
      
      public function getProp(param1:uint) : *
      {
         return _slotArr[param1];
      }
      
      public function addToSlot(param1:*, param2:*) : void
      {
         _slotArr[param2] = param1;
      }
   }
}

