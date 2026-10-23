package com.hotpoint.braveManIII.repository.skillCondition
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class SkillConditionBaseData
   {
      
      private var _typeId:String;
      
      private var _skillLevel:VT;
      
      private var _playerLevel:VT;
      
      private var _rebirth:Boolean;
      
      private var _transfer:Boolean;
      
      private var _beforeLevelId:String;
      
      private var _beforeLevel:VT;
      
      private var _points:VT;
      
      private var _gold:VT;
      
      public function SkillConditionBaseData()
      {
         super();
      }
      
      public static function creatConditionBaseData(param1:String, param2:Number, param3:Number, param4:Boolean, param5:Boolean, param6:String, param7:Number, param8:Number, param9:Number) : SkillConditionBaseData
      {
         var _loc10_:SkillConditionBaseData = new SkillConditionBaseData();
         _loc10_._typeId = param1;
         _loc10_._skillLevel = VT.createVT(param2);
         _loc10_._playerLevel = VT.createVT(param3);
         _loc10_._rebirth = param4;
         _loc10_._transfer = param5;
         _loc10_._beforeLevelId = param6;
         _loc10_._beforeLevel = VT.createVT(param7);
         _loc10_._points = VT.createVT(param8);
         _loc10_._gold = VT.createVT(param9);
         return _loc10_;
      }
      
      public function getTypeId() : String
      {
         return this._typeId;
      }
      
      public function getSkillLevel() : Number
      {
         return this._skillLevel.getValue();
      }
      
      public function getPlayerDataLevel() : Number
      {
         return this._playerLevel.getValue();
      }
      
      public function getRebirth() : Boolean
      {
         return this._rebirth;
      }
      
      public function getTransfer() : Boolean
      {
         return this._transfer;
      }
      
      public function getBeforeLevelId() : String
      {
         return this._beforeLevelId;
      }
      
      public function getBeforeLevel() : Number
      {
         return this._beforeLevel.getValue();
      }
      
      public function getPoints() : Number
      {
         return this._points.getValue();
      }
      
      public function getGold() : Number
      {
         return this._gold.getValue();
      }
   }
}

