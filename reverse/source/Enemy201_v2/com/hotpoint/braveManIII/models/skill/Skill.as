package com.hotpoint.braveManIII.models.skill
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class Skill
   {
      
      private var _id:VT;
      
      private var _typeId:String;
      
      private var _frame:VT;
      
      private var _skillName:String;
      
      private var _introduction:String;
      
      private var _touchOff:String;
      
      private var _weapon:String;
      
      private var _professional:String;
      
      private var _skillLevel:VT;
      
      private var _skillLevelUp:VT;
      
      private var _mp:VT;
      
      private var _ep:VT;
      
      private var _skillCd:VT;
      
      private var _duration:VT;
      
      private var _actOn:VT;
      
      private var _arrValue:Array;
      
      public function Skill()
      {
         super();
      }
      
      public static function creatSkill(param1:Number, param2:String, param3:Number, param4:String, param5:String, param6:String, param7:String, param8:String, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number, param15:Number, param16:Array) : Skill
      {
         var _loc17_:Skill = new Skill();
         _loc17_._id = VT.createVT(param1);
         _loc17_._typeId = param2;
         _loc17_._frame = VT.createVT(param3);
         _loc17_._skillName = param4;
         _loc17_._introduction = param5;
         _loc17_._touchOff = param6;
         _loc17_._professional = param8;
         _loc17_._weapon = param7;
         _loc17_._skillLevel = VT.createVT(param9);
         _loc17_._skillLevelUp = VT.createVT(param10);
         _loc17_._mp = VT.createVT(param11);
         _loc17_._ep = VT.createVT(param12);
         _loc17_._skillCd = VT.createVT(param13);
         _loc17_._duration = VT.createVT(param14);
         _loc17_._actOn = VT.createVT(param15);
         _loc17_._arrValue = param16;
         return _loc17_;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getTypeId() : String
      {
         return this._typeId;
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getSkillName() : String
      {
         return this._skillName;
      }
      
      public function getSkillTouchOff() : String
      {
         return this._touchOff;
      }
      
      public function getIntroduction() : String
      {
         return this._introduction;
      }
      
      public function getWeapon() : String
      {
         return this._weapon;
      }
      
      public function getProfessional() : String
      {
         return this._professional;
      }
      
      public function getSkillLevel() : Number
      {
         return this._skillLevel.getValue();
      }
      
      public function getskillLevelUp() : Number
      {
         return this._skillLevelUp.getValue();
      }
      
      public function getMp() : Number
      {
         return this._mp.getValue();
      }
      
      public function getEp() : Number
      {
         return this._ep.getValue();
      }
      
      public function getSkillCd() : Number
      {
         return this._skillCd.getValue();
      }
      
      public function getSkillDuration() : Number
      {
         return this._duration.getValue();
      }
      
      public function getSkillActOn() : Number
      {
         return this._actOn.getValue();
      }
      
      public function getSkillValueArray() : Array
      {
         return this._arrValue;
      }
   }
}

