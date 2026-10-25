package com.hotpoint.braveManIII.repository.gem
{
   import com.hotpoint.braveManIII.models.gem.*;
   import flash.events.*;
   
   public class GemFactory
   {
      
      public static var isGemOK:Boolean = false;
      
      public static var _GemDataList:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function GemFactory()
      {
         super();
      }
      
      public static function findStrengthenLevel(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getStrengthenLevel();
      }
      
      private static function getGemBaseDataById(param1:Number) : GemBaseData
      {
         var _loc2_:GemBaseData = null;
         var _loc3_:GemBaseData = null;
         for each(_loc3_ in _GemDataList)
         {
            if(_loc3_.getId() == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         if(_loc2_ == null)
         {
            throw new Error("找不到基础数据!id:" + param1);
         }
         return _loc2_;
      }
      
      public static function createGemByCompose(param1:Number, param2:Number, param3:Array) : Gem
      {
         var _loc4_:GemBaseData = null;
         var _loc5_:Array = null;
         var _loc6_:GemBaseData = null;
         _loc5_ = getGemBaseDataByColor(param1);
         for each(_loc6_ in _loc5_)
         {
            if(_loc6_.getStrengthenLevel() == param2)
            {
               _loc4_ = _loc6_;
            }
         }
         if(_loc4_ == null)
         {
            throw new Error("找不到基础数据!");
         }
         return _loc4_.composeGem(param3);
      }
      
      public static function findIsStrengthen(param1:Number) : Boolean
      {
         return getGemBaseDataById(param1).getIsStrengthen();
      }
      
      public static function findIsCompound(param1:Number) : Boolean
      {
         return getGemBaseDataById(param1).getIsCompound();
      }
      
      public static function findPrice(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getPrice();
      }
      
      public static function findType(param1:Number) : int
      {
         return getGemBaseDataById(param1).getType();
      }
      
      public static function findTimes(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getTimes();
      }
      
      public static function findIsPile(param1:Number) : Boolean
      {
         return getGemBaseDataById(param1).getIsPile();
      }
      
      public static function findUseLevel(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getUseLevel();
      }
      
      private static function getGemBaseDataByColor(param1:Number) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:GemBaseData = null;
         _loc2_ = [];
         for each(_loc3_ in _GemDataList)
         {
            if(_loc3_.getColor() == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         if(_loc2_.length < 1)
         {
            throw new Error("没有这个颜色的宝石:color:" + param1);
         }
         return _loc2_;
      }
      
      public static function findDropLevel(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getDropLevel();
      }
      
      public static function findSkill(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getAddSkill();
      }
      
      public static function creatGemFactory() : *
      {
         var _loc1_:GemFactory = null;
         _loc1_ = new GemFactory();
         _loc1_.creatGemData();
      }
      
      public static function findDescript(param1:Number) : String
      {
         return getGemBaseDataById(param1).getDescript();
      }
      
      public static function createGemByColorAndLevel(param1:Array) : Gem
      {
         var _loc2_:Array = null;
         var _loc3_:GemBaseData = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         _loc2_ = [];
         for each(_loc3_ in _GemDataList)
         {
            for each(_loc5_ in param1)
            {
               if(_loc3_.getDropLevel() == _loc5_)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         if(_loc2_.length < 1)
         {
            throw new Error("没有这个的等级物品:" + param1);
         }
         _loc4_ = Math.floor(Math.random() * _loc2_.length);
         _loc3_ = _loc2_[_loc4_] as GemBaseData;
         return _loc3_.createGem();
      }
      
      public static function findColor(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getColor();
      }
      
      public static function findName(param1:Number) : String
      {
         return getGemBaseDataById(param1).getName();
      }
      
      public static function createGemByStrengthen(param1:String, param2:Number) : Gem
      {
         var _loc3_:GemBaseData = null;
         var _loc4_:Array = null;
         var _loc5_:GemBaseData = null;
         _loc4_ = getGemBaseDataByName(param1);
         for each(_loc5_ in _loc4_)
         {
            trace(_loc5_.getStrengthenLevel());
            if(_loc5_.getStrengthenLevel() == param2 + 1)
            {
               _loc3_ = _loc5_;
            }
         }
         if(_loc3_ == null)
         {
            throw new Error("找不到基础数据!");
         }
         return _loc3_.upLevelGem();
      }
      
      private static function getGemBaseDataByName(param1:String) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:GemBaseData = null;
         _loc2_ = [];
         for each(_loc3_ in _GemDataList)
         {
            if(_loc3_.getName() == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         if(_loc2_.length < 1)
         {
            throw new Error("没有这个名称的宝石:color:" + param1);
         }
         return _loc2_;
      }
      
      public static function findPileLimit(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getPileLimit();
      }
      
      public static function findFrame(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getFrame();
      }
      
      public static function findProbability(param1:Number) : Number
      {
         return getGemBaseDataById(param1).getProbability();
      }
      
      public static function creatGemById(param1:Number) : Gem
      {
         var _loc2_:GemBaseData = null;
         _loc2_ = getGemBaseDataById(param1);
         return _loc2_.createGem();
      }
      
      private function creatGemData() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:XMLList = null;
         var _loc20_:Array = null;
         var _loc21_:XML = null;
         var _loc22_:GemBaseData = null;
         for each(_loc1_ in myXml.宝石)
         {
            _loc2_ = String(_loc1_.名称);
            _loc3_ = Number(_loc1_.帧数);
            _loc4_ = Number(_loc1_.编号);
            _loc5_ = String(_loc1_.描述);
            _loc6_ = Number(_loc1_.使用等级);
            _loc7_ = Number(_loc1_.掉落等级);
            _loc8_ = Number(_loc1_.强化等级);
            _loc9_ = Number(_loc1_.价钱);
            _loc10_ = int(_loc1_.类型);
            _loc11_ = Number(_loc1_.堆叠次数);
            _loc12_ = Number(_loc1_.颜色);
            _loc13_ = (_loc1_.是否堆叠.toString() == "true") as Boolean;
            _loc14_ = (_loc1_.是否强化.toString() == "true") as Boolean;
            _loc15_ = (_loc1_.是否合成.toString() == "true") as Boolean;
            _loc16_ = Number(_loc1_.堆叠上限);
            _loc17_ = Number(_loc1_.概率);
            _loc18_ = Number(_loc1_.宝石技能);
            _loc19_ = _loc1_.宝石属性;
            _loc20_ = [];
            for each(_loc21_ in _loc19_)
            {
               if(_loc21_.生命 == "null")
               {
                  break;
               }
               _loc20_.push(Attribute.creatAttribute(1,Number(_loc21_.生命)));
               _loc20_.push(Attribute.creatAttribute(2,Number(_loc21_.魔法)));
               _loc20_.push(Attribute.creatAttribute(3,Number(_loc21_.攻击)));
               _loc20_.push(Attribute.creatAttribute(4,Number(_loc21_.防御)));
               _loc20_.push(Attribute.creatAttribute(5,Number(_loc21_.暴击)));
               _loc20_.push(Attribute.creatAttribute(6,Number(_loc21_.闪避)));
               _loc20_.push(Attribute.creatAttribute(7,Number(_loc21_.移动速度)));
               _loc20_.push(Attribute.creatAttribute(8,Number(_loc21_.硬直)));
            }
            _loc22_ = GemBaseData.cteateGemBaseData(_loc4_,_loc3_,_loc2_,_loc5_,_loc11_,_loc10_,_loc13_,_loc14_,_loc15_,_loc7_,_loc6_,_loc8_,_loc16_,_loc9_,_loc12_,_loc17_,_loc20_,_loc18_);
            _GemDataList.push(_loc22_);
         }
         GemFactory.isGemOK = true;
      }
   }
}

