package com.hotpoint.braveManIII.repository.equip
{
   import com.hotpoint.braveManIII.models.equip.*;
   import flash.events.*;
   
   public class EquipFactory
   {
      
      public static var _equipDataList:Array = [];
      
      public static var isEquipOK:Boolean = false;
      
      public static var isSuitOK:Boolean = false;
      
      public static var _suitEquipList:Array = [];
      
      public static var myXml:XML = new XML();
      
      public static var suitXml:XML = new XML();
      
      public function EquipFactory()
      {
         super();
      }
      
      public static function findPosition(param1:Number) : Number
      {
         return getEquipBaseDataById(param1).getPosition();
      }
      
      public static function findIsStrengthen(param1:Number) : Boolean
      {
         return getEquipBaseDataById(param1).getIsStrengthen();
      }
      
      public static function getSuitEquipSkillAttrib(param1:Number) : String
      {
         var _loc2_:Array = null;
         var _loc3_:SuitEquipAttrib = null;
         var _loc4_:String = null;
         var _loc5_:SuitEquipAttrib = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc4_ = "";
         for each(_loc5_ in _suitEquipList)
         {
            if(_loc5_.getSuitId() == param1)
            {
               _loc3_ = _loc5_;
               break;
            }
         }
         if(_loc3_ == null)
         {
            throw new Error("不存在的套装:suitId:" + param1);
         }
         _loc2_ = _loc3_.getSuitBaseAttrib();
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc4_ += _loc2_[_loc6_] + "\n";
            _loc6_++;
         }
         _loc2_ = _loc3_.getSuitSkillAttrib();
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc4_ += _loc2_[_loc7_] + "\n";
            _loc7_++;
         }
         return _loc4_;
      }
      
      public static function findPrice(param1:Number) : Number
      {
         return getEquipBaseDataById(param1).getPrice();
      }
      
      public static function findReincarnationLimit(param1:Number) : Number
      {
         return getEquipBaseDataById(param1).getReincarnationLimit();
      }
      
      private static function getEquipBaseDatasByColor(param1:Number) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:EquipBaseData = null;
         _loc2_ = [];
         for each(_loc3_ in _equipDataList)
         {
            if(_loc3_.getColor() == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         if(_loc2_.length < 1)
         {
            throw new Error("没有这个颜色的物品:color:" + param1);
         }
         return _loc2_;
      }
      
      public static function getAllSuitEquipPostionAddName(param1:Number) : Array
      {
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         var _loc4_:EquipBaseData = null;
         var _loc5_:Array = null;
         _loc2_ = true;
         _loc3_ = [];
         for each(_loc4_ in _equipDataList)
         {
            if(!(_loc2_ == false && _loc4_.getPosition() == 1))
            {
               if(_loc4_.getSuitId() == param1)
               {
                  _loc5_ = [];
                  if(_loc4_.getPosition() == 1)
                  {
                     _loc3_[0] = _loc5_;
                     _loc5_[0] = _loc4_.getPosition();
                     _loc5_[1] = _loc4_.getName();
                  }
                  else if(_loc4_.getPosition() == 2)
                  {
                     _loc3_[1] = _loc5_;
                     _loc5_[0] = _loc4_.getPosition();
                     _loc5_[1] = _loc4_.getName();
                  }
                  else if(_loc4_.getPosition() == 3)
                  {
                     _loc3_[2] = _loc5_;
                     _loc5_[0] = _loc4_.getPosition();
                     _loc5_[1] = _loc4_.getName();
                  }
                  else if(_loc4_.getPosition() == 4)
                  {
                     _loc3_[3] = _loc5_;
                     _loc5_[0] = _loc4_.getPosition();
                     _loc5_[1] = _loc4_.getName();
                  }
               }
               if(_loc4_.getPosition() == 1 && _loc4_.getSuitId() == param1)
               {
                  _loc2_ = false;
               }
            }
         }
         return _loc3_;
      }
      
      public static function createEquipByShop() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:EquipBaseData = null;
         _loc1_ = [];
         _loc2_ = getEquipBaseDatasByColor(1);
         for each(_loc3_ in _loc2_)
         {
            _loc1_.push(_loc3_.createShopEquip());
         }
         return _loc1_;
      }
      
      public static function creatEquipFactory() : *
      {
         var _loc1_:EquipFactory = null;
         _loc1_ = new EquipFactory();
         _loc1_.creatEquipData();
      }
      
      public static function findName(param1:Number) : String
      {
         return getEquipBaseDataById(param1).getName();
      }
      
      public static function createEquipByColorAndLevel(param1:Array) : Equip
      {
         var _loc2_:Array = null;
         var _loc3_:EquipBaseData = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         _loc2_ = [];
         for each(_loc3_ in _equipDataList)
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
         _loc3_ = _loc2_[_loc4_] as EquipBaseData;
         return _loc3_.createEquip();
      }
      
      private static function getEquipBaseDataById(param1:Number) : EquipBaseData
      {
         var _loc2_:EquipBaseData = null;
         var _loc3_:EquipBaseData = null;
         for each(_loc3_ in _equipDataList)
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
      
      public static function findSuitId(param1:Number) : Number
      {
         return getEquipBaseDataById(param1).getSuitId();
      }
      
      public static function findClassName(param1:Number) : String
      {
         return getEquipBaseDataById(param1).getClassName();
      }
      
      public static function findDropLevel(param1:Number) : Number
      {
         return getEquipBaseDataById(param1).getDropLevel();
      }
      
      public static function findDescript(param1:Number) : String
      {
         return getEquipBaseDataById(param1).getDescript();
      }
      
      public static function createEquipByID(param1:Number) : Equip
      {
         var _loc2_:EquipBaseData = null;
         _loc2_ = getEquipBaseDataById(param1);
         return _loc2_.createEquip();
      }
      
      public static function findColor(param1:Number) : Number
      {
         return getEquipBaseDataById(param1).getColor();
      }
      
      public static function findFrame(param1:Number) : Number
      {
         return getEquipBaseDataById(param1).getFrame();
      }
      
      public static function findDressLevel(param1:Number) : Number
      {
         return getEquipBaseDataById(param1).getDressLevel();
      }
      
      public static function getSuitEquip(param1:Number) : SuitEquipAttrib
      {
         var _loc2_:SuitEquipAttrib = null;
         var _loc3_:SuitEquipAttrib = null;
         for each(_loc3_ in _suitEquipList)
         {
            if(_loc3_.getSuitId() == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      private function creatEquipData() : *
      {
         xmlLoaded();
         suitxmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Boolean = false;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:XMLList = null;
         var _loc17_:XMLList = null;
         var _loc18_:Number = NaN;
         var _loc19_:Array = null;
         var _loc20_:XML = null;
         var _loc21_:XML = null;
         var _loc22_:EquipBaseData = null;
         for each(_loc1_ in myXml.装备)
         {
            _loc2_ = String(_loc1_.名称);
            _loc3_ = String(_loc1_.类名);
            _loc4_ = Number(_loc1_.帧数);
            _loc5_ = Number(_loc1_.编号);
            _loc6_ = Number(_loc1_.部位);
            _loc7_ = Number(_loc1_.穿戴等级);
            _loc8_ = Number(_loc1_.掉落等级);
            _loc9_ = String(_loc1_.描述).replace(/\\n/g,"\n");
            _loc10_ = Number(_loc1_.价钱);
            _loc11_ = Number(_loc1_.重生要求);
            _loc12_ = Number(_loc1_.品质);
            _loc13_ = (_loc1_.是否强化.toString() == "true") as Boolean;
            _loc14_ = Number(_loc1_.格子数);
            _loc15_ = Number(_loc1_.套装编号);
            _loc16_ = _loc1_.固定属性;
            _loc17_ = _loc1_.随机属性;
            _loc18_ = Number(_loc1_.装备特性);
            _loc19_ = [];
            for each(_loc20_ in _loc16_)
            {
               if(_loc20_.生命 != "null")
               {
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,1,Number(_loc20_.生命)));
               }
               if(_loc20_.魔法 != "null")
               {
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,2,Number(_loc20_.魔法)));
               }
               if(_loc20_.攻击 != "null")
               {
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,3,Number(_loc20_.攻击)));
               }
               if(_loc20_.防御 != "null")
               {
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,4,Number(_loc20_.防御)));
               }
            }
            for each(_loc21_ in _loc17_)
            {
               if(_loc12_ == 2)
               {
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(2,1,Number(_loc21_.附加生命)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(2,2,Number(_loc21_.附加魔法)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(2,3,Number(_loc21_.附加攻击)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(2,5,Number(_loc21_.附加暴击)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(2,6,Number(_loc21_.附加闪避)));
               }
               if(_loc12_ == 3)
               {
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,1,Number(_loc21_.附加生命)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,2,Number(_loc21_.附加魔法)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,3,Number(_loc21_.附加攻击)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,5,Number(_loc21_.附加暴击)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,6,Number(_loc21_.附加闪避)));
               }
               if(_loc12_ == 4)
               {
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,1,Number(_loc21_.附加生命)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,2,Number(_loc21_.附加魔法)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,3,Number(_loc21_.附加攻击)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,5,Number(_loc21_.附加暴击)));
                  _loc19_.push(EquipBaseAttrib.creatEquipBaseAttrib(3,6,Number(_loc21_.附加闪避)));
               }
            }
            _loc22_ = EquipBaseData.createEquipBaseData(_loc5_,_loc4_,_loc2_,_loc3_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc19_,_loc18_);
            _equipDataList.push(_loc22_);
         }
         isEquipOK = true;
      }
      
      private function suitxmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:XMLList = null;
         var _loc4_:XMLList = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:XML = null;
         var _loc8_:XML = null;
         for each(_loc1_ in suitXml.套装)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = _loc1_.套装技能;
            _loc4_ = _loc1_.套装属性;
            _loc5_ = [];
            _loc6_ = [];
            for each(_loc7_ in _loc3_)
            {
               if(_loc7_.技能1 != "null")
               {
                  _loc5_.push(Number(_loc7_.技能1));
               }
               if(_loc7_.技能2 != "null")
               {
                  _loc5_.push(Number(_loc7_.技能2));
               }
            }
            for each(_loc8_ in _loc4_)
            {
               if(_loc8_.生命 != "null")
               {
                  _loc6_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,1,Number(_loc8_.生命)));
               }
               if(_loc8_.魔法 != "null")
               {
                  _loc6_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,2,Number(_loc8_.魔法)));
               }
               if(_loc8_.攻击 != "null")
               {
                  _loc6_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,3,Number(_loc8_.攻击)));
               }
               if(_loc8_.防御 != "null")
               {
                  _loc6_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,4,Number(_loc8_.防御)));
               }
               if(_loc8_.暴击 != "null")
               {
                  _loc6_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,5,Number(_loc8_.暴击)));
               }
               if(_loc8_.闪避 != "null")
               {
                  _loc6_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,6,Number(_loc8_.闪避)));
               }
               if(_loc8_.移动 != "null")
               {
                  _loc6_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,7,Number(_loc8_.移动)));
               }
               if(_loc8_.硬直 != "null")
               {
                  _loc6_.push(EquipBaseAttrib.creatEquipBaseAttrib(1,8,Number(_loc8_.硬直)));
               }
            }
            _suitEquipList.push(SuitEquipAttrib.creatSuitEquipAttrib(_loc2_,_loc5_,_loc6_));
         }
         isSuitOK = true;
      }
   }
}

