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
      
      public static function creatSkill(id:Number, typeId:String, frame:Number, skillName:String, introduction:String, touchOff:String, weapon:String, professional:String, skillLevel:Number, skillLevelUp:Number, mp:Number, ep:Number, skillCd:Number, duration:Number, actOn:Number, arrValue:Array) : Skill
      {
         var sk:Skill = new Skill();
         sk._id = VT.createVT(id);
         sk._typeId = typeId;
         sk._frame = VT.createVT(frame);
         sk._skillName = skillName;
         sk._introduction = introduction;
         sk._touchOff = touchOff;
         sk._professional = professional;
         sk._weapon = weapon;
         sk._skillLevel = VT.createVT(skillLevel);
         sk._skillLevelUp = VT.createVT(skillLevelUp);
         sk._mp = VT.createVT(mp);
         sk._ep = VT.createVT(ep);
         sk._skillCd = VT.createVT(skillCd);
         sk._duration = VT.createVT(duration);
         sk._actOn = VT.createVT(actOn);
         sk._arrValue = arrValue;
         return sk;
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

