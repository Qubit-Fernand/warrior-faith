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
         var _loc1_:SkillFactory = new SkillFactory();
         _loc1_.creatLoard();
      }
      
      public static function getSkillById(param1:Number) : Skill
      {
         var _loc3_:Skill = null;
         var _loc2_:Skill = null;
         for each(_loc3_ in skillAllDataArr)
         {
            if(_loc3_.getId() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
         }
         return _loc2_;
      }
      
      public static function getSkillByTypeIAndLevel(param1:String, param2:Number = 1) : Skill
      {
         var _loc5_:Skill = null;
         var _loc6_:Skill = null;
         var _loc3_:Array = [];
         var _loc4_:Skill = null;
         for each(_loc5_ in skillAllDataArr)
         {
            if(_loc5_.getTypeId() == param1)
            {
               _loc3_.push(_loc5_);
            }
         }
         for each(_loc6_ in _loc3_)
         {
            if(_loc6_.getSkillLevel() == param2)
            {
               _loc4_ = _loc6_;
            }
         }
         if(_loc4_ == null)
         {
         }
         return _loc4_;
      }
      
      public static function getSkillByPet(param1:String) : Number
      {
         var _loc4_:Skill = null;
         var _loc2_:Array = [];
         var _loc3_:Skill = null;
         for each(_loc4_ in skillAllDataArr)
         {
            if(_loc4_.getProfessional() == param1)
            {
               _loc2_.push(_loc4_.getId());
            }
         }
         return _loc2_[Math.round(Math.random() * (_loc2_.length - 1))];
      }
      
      private function creatLoard() : *
      {
         this.xmlLoaded();
      }
      
      internal function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:XMLList = null;
         var _loc18_:Array = null;
         var _loc19_:XML = null;
         var _loc20_:Skill = null;
         for each(_loc1_ in myXml.数据)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = String(_loc1_.技能类型);
            _loc4_ = Number(_loc1_.帧数);
            _loc5_ = String(_loc1_.技能名称);
            _loc6_ = String(_loc1_.技能描述);
            _loc7_ = String(_loc1_.触发类型);
            _loc8_ = String(_loc1_.职业要求);
            _loc9_ = String(_loc1_.武器要求);
            _loc10_ = Number(_loc1_.技能等级);
            _loc11_ = Number(_loc1_.技能等级上限);
            _loc12_ = Number(_loc1_.魔法消耗);
            _loc13_ = Number(_loc1_.能量消耗);
            _loc14_ = Number(_loc1_.技能冷却);
            _loc15_ = Number(_loc1_.持续时间);
            _loc16_ = Number(_loc1_.作用类型);
            _loc17_ = _loc1_.具体数值;
            _loc18_ = [];
            for each(_loc19_ in _loc17_)
            {
               if(_loc19_.数值1 != "null")
               {
                  _loc18_.push(VT.createVT(Number(_loc19_.数值1)));
               }
               if(_loc19_.数值2 != "null")
               {
                  _loc18_.push(VT.createVT(Number(_loc19_.数值2)));
               }
               if(_loc19_.数值3 != "null")
               {
                  _loc18_.push(VT.createVT(Number(_loc19_.数值3)));
               }
               if(_loc19_.数值4 != "null")
               {
                  _loc18_.push(VT.createVT(Number(_loc19_.数值4)));
               }
               if(_loc19_.次数 != "null")
               {
                  _loc18_.push(VT.createVT(Number(_loc19_.次数)));
               }
               if(_loc19_.硬直 != "null")
               {
                  _loc18_.push(VT.createVT(Number(_loc19_.硬直)));
               }
               if(_loc19_.挑高 != "null")
               {
                  _loc18_.push(VT.createVT(Number(_loc19_.挑高)));
               }
               if(_loc19_.震退 != "null")
               {
                  _loc18_.push(VT.createVT(Number(_loc19_.震退)));
               }
               if(_loc19_.持续 != "null")
               {
                  _loc18_.push(VT.createVT(Number(_loc19_.持续)));
               }
            }
            _loc20_ = Skill.creatSkill(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc9_,_loc8_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc18_);
            skillAllDataArr.push(_loc20_);
         }
         isSkillDataOk = true;
      }
   }
}

