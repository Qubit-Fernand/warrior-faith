package com.hotpoint.braveManIII.repository.supplies
{
   import com.hotpoint.braveManIII.models.supplies.*;
   import flash.events.*;
   
   public class SuppliesFactory
   {
      
      public static var _suppliesDataList:Array = [];
      
      public static var isSuppiesOK:Boolean = false;
      
      public static var myXml:XML = new XML();
      
      public function SuppliesFactory()
      {
         super();
      }
      
      public static function findTimes(param1:Number) : Number
      {
         return getSuppliesBaseDataById(param1).getTimes();
      }
      
      public static function findCoolDowns(param1:Number) : Number
      {
         return getSuppliesBaseDataById(param1).getCoolDowns();
      }
      
      public static function findPrice(param1:Number) : Number
      {
         return getSuppliesBaseDataById(param1).getPrice();
      }
      
      public static function findIsPile(param1:Number) : Boolean
      {
         return getSuppliesBaseDataById(param1).getIsPile();
      }
      
      public static function findUseLevel(param1:Number) : Number
      {
         return getSuppliesBaseDataById(param1).getUseLevel();
      }
      
      public static function findDropLevel(param1:Number) : Number
      {
         return getSuppliesBaseDataById(param1).getDropLevel();
      }
      
      public static function findName(param1:Number) : String
      {
         return getSuppliesBaseDataById(param1).getName();
      }
      
      public static function findDescript(param1:Number) : String
      {
         return getSuppliesBaseDataById(param1).getDescript();
      }
      
      public static function getSuppliesNameAndCD() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:SuppliesBaseData = null;
         var _loc3_:Array = null;
         _loc1_ = [];
         for each(_loc2_ in _suppliesDataList)
         {
            _loc3_ = [];
            _loc3_.push(_loc2_.getName());
            _loc3_.push(_loc2_.getCoolDowns());
            _loc1_.push(_loc3_);
         }
         if(_loc1_.length < 1)
         {
            throw new Error("找不到基础数据!");
         }
         return _loc1_;
      }
      
      public static function findDuration(param1:Number) : Number
      {
         return getSuppliesBaseDataById(param1).getDuration();
      }
      
      public static function findAffect(param1:Number) : Array
      {
         return getSuppliesBaseDataById(param1).getAffect();
      }
      
      private static function getSuppliesBaseDataById(param1:Number) : SuppliesBaseData
      {
         var _loc2_:SuppliesBaseData = null;
         var _loc3_:SuppliesBaseData = null;
         for each(_loc3_ in _suppliesDataList)
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
      
      public static function findAffectMode(param1:Number) : Number
      {
         return getSuppliesBaseDataById(param1).getAffectMode();
      }
      
      public static function findFrame(param1:Number) : Number
      {
         return getSuppliesBaseDataById(param1).getFrame();
      }
      
      public static function getSuppliesBaseDataByColor(param1:Number) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:SuppliesBaseData = null;
         _loc2_ = [];
         for each(_loc3_ in _suppliesDataList)
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
      
      public static function createSuppliesByShop() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:SuppliesBaseData = null;
         _loc1_ = [];
         _loc2_ = getSuppliesBaseDataByColor(1);
         for each(_loc3_ in _loc2_)
         {
            _loc1_.push(_loc3_.createSupplies());
         }
         return _loc1_;
      }
      
      public static function createSuppliesByColorAndLevel(param1:Array) : Supplies
      {
         var _loc2_:Array = null;
         var _loc3_:SuppliesBaseData = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         _loc2_ = [];
         for each(_loc3_ in _suppliesDataList)
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
         _loc3_ = _loc2_[_loc4_] as SuppliesBaseData;
         return _loc3_.createSupplies();
      }
      
      public static function findColor(param1:Number) : Number
      {
         return getSuppliesBaseDataById(param1).getColor();
      }
      
      public static function creatSuppliesFactory() : *
      {
         var _loc1_:SuppliesFactory = null;
         _loc1_ = new SuppliesFactory();
         _loc1_.creatSuppliesData();
      }
      
      private static function getSuppliesById(param1:Number) : Supplies
      {
         var _loc2_:SuppliesBaseData = null;
         _loc2_ = getSuppliesBaseDataById(param1);
         return _loc2_.createSupplies();
      }
      
      private function creatSuppliesData() : *
      {
         xmlLoaded();
      }
      
      internal function xmlLoaded() : *
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
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:XMLList = null;
         var _loc16_:Array = null;
         var _loc17_:XML = null;
         var _loc18_:SuppliesBaseData = null;
         for each(_loc1_ in myXml.消耗品)
         {
            _loc2_ = String(_loc1_.名称);
            _loc3_ = Number(_loc1_.帧数);
            _loc4_ = Number(_loc1_.编号);
            _loc5_ = String(_loc1_.描述);
            _loc6_ = Number(_loc1_.使用等级);
            _loc7_ = Number(_loc1_.掉落等级);
            _loc8_ = Number(_loc1_.价钱);
            _loc9_ = Number(_loc1_.冷却时间);
            _loc10_ = Number(_loc1_.堆叠次数);
            _loc11_ = Number(_loc1_.品质);
            _loc12_ = (_loc1_.是否堆叠.toString() == "true") as Boolean;
            _loc13_ = Number(_loc1_.作用模式);
            _loc14_ = Number(_loc1_.持续时间);
            _loc15_ = _loc1_.具体作用;
            _loc16_ = [];
            for each(_loc17_ in _loc15_)
            {
               if(_loc17_.生命 != "null")
               {
                  _loc16_.push(SuppliesAffect.creatSuppliesAffect(1,Number(_loc17_.生命)));
               }
               if(_loc17_.魔法 != "null")
               {
                  _loc16_.push(SuppliesAffect.creatSuppliesAffect(2,Number(_loc17_.魔法)));
               }
               if(_loc17_.攻击 != "null")
               {
                  _loc16_.push(SuppliesAffect.creatSuppliesAffect(3,Number(_loc17_.攻击)));
               }
               if(_loc17_.防御 != "null")
               {
                  _loc16_.push(SuppliesAffect.creatSuppliesAffect(4,Number(_loc17_.防御)));
               }
               if(_loc17_.暴击 != "null")
               {
                  _loc16_.push(SuppliesAffect.creatSuppliesAffect(5,Number(_loc17_.暴击)));
               }
               if(_loc17_.闪避 != "null")
               {
                  _loc16_.push(SuppliesAffect.creatSuppliesAffect(6,Number(_loc17_.闪避)));
               }
               if(_loc17_.移动速度 != "null")
               {
                  _loc16_.push(SuppliesAffect.creatSuppliesAffect(7,Number(_loc17_.移动速度)));
               }
               if(_loc17_.硬直 != "null")
               {
                  _loc16_.push(SuppliesAffect.creatSuppliesAffect(8,Number(_loc17_.硬直)));
               }
               if(_loc17_.经验 != "null")
               {
                  _loc16_.push(SuppliesAffect.creatSuppliesAffect(9,Number(_loc17_.经验)));
               }
            }
            _loc18_ = SuppliesBaseData.createSuppliesBaseData(_loc4_,_loc3_,_loc2_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc16_);
            _suppliesDataList.push(_loc18_);
         }
         isSuppiesOK = true;
      }
   }
}

