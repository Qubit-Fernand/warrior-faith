package com.hotpoint.braveManIII.models.skill
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class Skill
   {
      
      private var _introduction:String;
      
      private var _professional:String;
      
      private var _skillLevelUp:VT;
      
      private var _actOn:VT;
      
      private var _typeId:String;
      
      private var _touchOff:String;
      
      private var _id:VT;
      
      private var _weapon:String;
      
      private var _mp:VT;
      
      private var _ep:VT;
      
      private var _skillLevel:VT;
      
      private var _skillCd:VT;
      
      private var _frame:VT;
      
      private var _arrValue:Array;
      
      private var _duration:VT;
      
      private var _skillName:String;
      
      public function Skill()
      {
         super();
      }
      
      public static function creatSkill(param1:Number, param2:String, param3:Number, param4:String, param5:String, param6:String, param7:String, param8:String, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number, param15:Number, param16:Array) : Skill
      {
         var _loc17_:Skill = null;
         _loc17_ = new Skill();
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
      
      public function getskillLevelUp() : Number
      {
         return _skillLevelUp.getValue();
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getMp() : Number
      {
         return _mp.getValue();
      }
      
      public function getProfessional() : String
      {
         return _professional;
      }
      
      public function getWeapon() : String
      {
         return _weapon;
      }
      
      public function getSkillLevel() : Number
      {
         return _skillLevel.getValue();
      }
      
      public function getEp() : Number
      {
         return _ep.getValue();
      }
      
      public function getSkillActOn() : Number
      {
         return _actOn.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getSkillName() : String
      {
         return _skillName;
      }
      
      public function getSkillDuration() : Number
      {
         return _duration.getValue();
      }
      
      public function getSkillCd() : Number
      {
         return _skillCd.getValue();
      }
      
      public function getSkillValueArray() : Array
      {
         return _arrValue;
      }
      
      public function getTypeId() : String
      {
         return _typeId;
      }
      
      public function getSkillTouchOff() : String
      {
         return _touchOff;
      }
   }
}

