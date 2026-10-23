package com.hotpoint.braveManIII.repository.monsterCard
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.monsterCard.MonsterCard;
   import src.*;
   
   public class MonsterFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function MonsterFactory()
      {
         super();
      }
      
      public static function creatMonsterFactory() : *
      {
         var _loc1_:MonsterFactory = new MonsterFactory();
         myXml = XMLAsset.createXML(Data2.monster);
         _loc1_.creatMonsterFactory();
      }
      
      public static function getMonsterById(param1:Number) : MonsterBasicData
      {
         var _loc2_:MonsterBasicData = null;
         var _loc3_:MonsterBasicData = null;
         for each(_loc3_ in allData)
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
      
      public static function getMonsterByType(param1:Number) : MonsterBasicData
      {
         var _loc2_:MonsterBasicData = null;
         var _loc3_:MonsterBasicData = null;
         for each(_loc3_ in allData)
         {
            if(_loc3_.getType() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_;
      }
      
      public static function getId(param1:Number) : Number
      {
         return getMonsterById(param1).getId();
      }
      
      public static function getName(param1:Number) : String
      {
         return getMonsterById(param1).getName();
      }
      
      public static function getType(param1:Number) : Number
      {
         return getMonsterById(param1).getType();
      }
      
      public static function getFrame(param1:Number) : Number
      {
         return getMonsterById(param1).getFrame();
      }
      
      public static function getFrame2(param1:Number) : Number
      {
         return getMonsterById(param1).getFrame2();
      }
      
      public static function getIntroduction(param1:Number) : String
      {
         return getMonsterById(param1).getIntroduction();
      }
      
      public static function getAttup(param1:Number) : Number
      {
         return getMonsterById(param1).getAttup();
      }
      
      public static function getDefup(param1:Number) : Number
      {
         return getMonsterById(param1).getDefup();
      }
      
      public static function getCritup(param1:Number) : Number
      {
         return getMonsterById(param1).getCritup();
      }
      
      public static function getHpup(param1:Number) : Number
      {
         return getMonsterById(param1).getHpup();
      }
      
      public static function getMpup(param1:Number) : Number
      {
         return getMonsterById(param1).getMpup();
      }
      
      public static function creatMonster(param1:Number) : MonsterCard
      {
         return getMonsterById(param1).creatMonsterCard();
      }
      
      public static function creatMonsterType(param1:Number) : MonsterCard
      {
         if(getMonsterByType(param1))
         {
            return getMonsterByType(param1).creatMonsterCard();
         }
         return null;
      }
      
      private function creatMonsterFactory() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:MonsterBasicData = null;
         for each(_loc1_ in myXml.怪物图鉴)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = String(_loc1_.名字);
            _loc4_ = Number(_loc1_.类型);
            _loc5_ = Number(_loc1_.帧数);
            _loc6_ = Number(_loc1_.帧数二);
            _loc7_ = String(_loc1_.描述);
            _loc8_ = Number(_loc1_.攻击成长);
            _loc9_ = Number(_loc1_.防御成长);
            _loc10_ = Number(_loc1_.暴击成长);
            _loc11_ = Number(_loc1_.生命成长);
            _loc12_ = Number(_loc1_.魔法成长);
            _loc13_ = MonsterBasicData.creatMonsterBasicData(_loc2_,_loc4_,_loc3_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_);
            allData.push(_loc13_);
         }
      }
   }
}

