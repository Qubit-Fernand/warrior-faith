package com.hotpoint.braveManIII.repository.skill
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.skill.*;
   
   public class SkillFactory
   {
      
      public static var isSkillDataOk:Boolean;
      
      public static var skillAllDataArr:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function SkillFactory()
      {
         super();
      }
      
      public static function creatSkillData() : void
      {
         var sk:SkillFactory = new SkillFactory();
         sk.creatLoard();
      }
      
      public static function getSkillById(id:Number) : Skill
      {
         var data:Skill = null;
         var skData:Skill = null;
         for each(data in skillAllDataArr)
         {
            if(data.getId() == id)
            {
               skData = data;
            }
         }
         if(skData == null)
         {
         }
         return skData;
      }
      
      public static function getSkillByTypeIAndLevel(typeId:String, level:Number = 1) : Skill
      {
         var data:Skill = null;
         var data2:Skill = null;
         var skArr:Array = [];
         var skData:Skill = null;
         for each(data in skillAllDataArr)
         {
            if(data.getTypeId() == typeId)
            {
               skArr.push(data);
            }
         }
         for each(data2 in skArr)
         {
            if(data2.getSkillLevel() == level)
            {
               skData = data2;
            }
         }
         if(skData == null)
         {
         }
         return skData;
      }
      
      public static function getSkillByPet(petId:String) : Number
      {
         var data:Skill = null;
         var skArr:Array = [];
         var skData:Skill = null;
         for each(data in skillAllDataArr)
         {
            if(data.getProfessional() == petId)
            {
               skArr.push(data.getId());
            }
         }
         return skArr[Math.round(Math.random() * (skArr.length - 1))];
      }
      
      private function creatLoard() : *
      {
         xmlLoaded();
      }
      
      internal function xmlLoaded() : *
      {
         var property:XML = null;
         var id:Number = NaN;
         var typeId:String = null;
         var frame:Number = NaN;
         var skillName:String = null;
         var introduction:String = null;
         var touchOff:String = null;
         var professional:String = null;
         var weapon:String = null;
         var skillLevel:Number = NaN;
         var skillLevelUp:Number = NaN;
         var mp:Number = NaN;
         var ep:Number = NaN;
         var skillCd:Number = NaN;
         var duration:Number = NaN;
         var actOn:Number = NaN;
         var valueLise:XMLList = null;
         var arrValue:Array = null;
         var va:XML = null;
         var skillData:Skill = null;
         for each(property in myXml.数据)
         {
            id = Number(property.编号);
            typeId = String(property.技能类型);
            frame = Number(property.帧数);
            skillName = String(property.技能名称);
            introduction = String(property.技能描述);
            touchOff = String(property.触发类型);
            professional = String(property.职业要求);
            weapon = String(property.武器要求);
            skillLevel = Number(property.技能等级);
            skillLevelUp = Number(property.技能等级上限);
            mp = Number(property.魔法消耗);
            ep = Number(property.能量消耗);
            skillCd = Number(property.技能冷却);
            duration = Number(property.持续时间);
            actOn = Number(property.作用类型);
            valueLise = property.具体数值;
            arrValue = [];
            for each(va in valueLise)
            {
               if(va.数值1 != "null")
               {
                  arrValue.push(VT.createVT(Number(va.数值1)));
               }
               if(va.数值2 != "null")
               {
                  arrValue.push(VT.createVT(Number(va.数值2)));
               }
               if(va.数值3 != "null")
               {
                  arrValue.push(VT.createVT(Number(va.数值3)));
               }
               if(va.数值4 != "null")
               {
                  arrValue.push(VT.createVT(Number(va.数值4)));
               }
               if(va.次数 != "null")
               {
                  arrValue.push(VT.createVT(Number(va.次数)));
               }
               if(va.硬直 != "null")
               {
                  arrValue.push(VT.createVT(Number(va.硬直)));
               }
               if(va.挑高 != "null")
               {
                  arrValue.push(VT.createVT(Number(va.挑高)));
               }
               if(va.震退 != "null")
               {
                  arrValue.push(VT.createVT(Number(va.震退)));
               }
               if(va.持续 != "null")
               {
                  arrValue.push(VT.createVT(Number(va.持续)));
               }
            }
            skillData = Skill.creatSkill(id,typeId,frame,skillName,introduction,touchOff,weapon,professional,skillLevel,skillLevelUp,mp,ep,skillCd,duration,actOn,arrValue);
            skillAllDataArr.push(skillData);
         }
         isSkillDataOk = true;
      }
   }
}

