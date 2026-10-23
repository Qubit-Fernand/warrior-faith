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
      
      public static function creatSkill(id:Number, typeId:String, frame:Number, skillName:String, introduction:String, touchOff:String, weapon:String, professional:String, skillLevel:Number, skillLevelUp:Number, mp:Number, ep:Number, skillCd:Number, duration:Number, actOn:Number, arrValue:Array) : Skill
      {
         var sk:Skill = null;
         sk = new Skill();
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

