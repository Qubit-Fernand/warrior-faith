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
      
      public static function creatConditionBaseData(typeId:String, skillLevel:Number, playerLevel:Number, rebirth:Boolean, transfer:Boolean, beforeLevelId:String, beforeLevel:Number, points:Number, gold:Number) : SkillConditionBaseData
      {
         var cond:SkillConditionBaseData = new SkillConditionBaseData();
         cond._typeId = typeId;
         cond._skillLevel = VT.createVT(skillLevel);
         cond._playerLevel = VT.createVT(playerLevel);
         cond._rebirth = rebirth;
         cond._transfer = transfer;
         cond._beforeLevelId = beforeLevelId;
         cond._beforeLevel = VT.createVT(beforeLevel);
         cond._points = VT.createVT(points);
         cond._gold = VT.createVT(gold);
         return cond;
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

