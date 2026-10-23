package com.hotpoint.braveManIII.models.player
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.elves.Elves;
   import com.hotpoint.braveManIII.models.pet.Pet;
   import com.hotpoint.braveManIII.models.skill.Skill;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.setProfession.*;
   import flash.utils.*;
   import src.*;
   
   public class PlayerData
   {
      
      public var playerJL_Data:Elves;
      
      public var playerCW_Data:Pet;
      
      private var _stampSlot:StampSlot;
      
      private var _titleSlot:TitleSlot;
      
      private var _badgeSlot:BadgeSlot;
      
      private var _elvesSlot:ElvesSlot;
      
      private var _petSlot:PetSlot;
      
      private var _skillArr:Array = [];
      
      private var _Exp:VT = VT.createVT();
      
      private var _level:VT = VT.createVT();
      
      private var _bag:Bag = new Bag();
      
      private var _equipSlot:EquipSlot;
      
      private var _equipSkillSlot:EquipSkillSlot;
      
      private var _suppliesSlot:SuppliesSlot;
      
      private var _gold:VT;
      
      private var _points:VT;
      
      public var _rebirth:Boolean;
      
      public var _keyArr:Array = [];
      
      public var _transferArr:Array = [];
      
      public var _pickSkillArr:Array = [];
      
      public var skinArr:Array = [0,1];
      
      public var skinNum:int = 0;
      
      private var _killPoint:VT = VT.createVT();
      
      public function PlayerData()
      {
         super();
      }
      
      public static function creatPlayerData(param1:int = 1) : PlayerData
      {
         var _loc3_:int = 0;
         var _loc2_:PlayerData = new PlayerData();
         _loc2_._stampSlot = StampSlot.createStampSlot();
         _loc2_._titleSlot = TitleSlot.createTitleSlot();
         _loc2_._petSlot = PetSlot.createPetSlot();
         _loc2_._elvesSlot = ElvesSlot.createElvesSlot();
         _loc2_._badgeSlot = BadgeSlot.createBadgeSlot();
         _loc2_._equipSlot = EquipSlot.createEquipSlot();
         _loc2_._equipSlot.who = _loc2_;
         _loc2_._equipSkillSlot = EquipSkillSlot.createEquipSkillSlot();
         _loc2_._suppliesSlot = SuppliesSlot.createSuppliesSlot();
         _loc2_._level = VT.createVT(VT.GetTempVT("8/8"));
         _loc2_._gold = VT.createVT(InitData.Money_init.getValue());
         _loc2_._points = VT.createVT(VT.GetTempVT("8/2"));
         _loc2_._rebirth = false;
         _loc2_._transferArr = [false,false,false];
         _loc2_._pickSkillArr = [false,false,false];
         _loc2_.skinArr = SetProfession["skinArr" + param1];
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            if(_loc2_.skinArr[_loc3_] == 0)
            {
               _loc2_._pickSkillArr[0] = true;
               选武器(_loc2_,11110,_loc3_);
            }
            else if(_loc2_.skinArr[_loc3_] == 1)
            {
               _loc2_._pickSkillArr[1] = true;
               选武器(_loc2_,11210,_loc3_);
            }
            else if(_loc2_.skinArr[_loc3_] == 2)
            {
               _loc2_._pickSkillArr[2] = true;
               选武器(_loc2_,11310,_loc3_);
            }
            _loc3_++;
         }
         if(param1 == 1)
         {
            _loc2_._keyArr = DeepCopyUtil.clone(SetKeyPanel.ysArr);
         }
         else if(param1 == 2)
         {
            _loc2_._keyArr = DeepCopyUtil.clone(SetKeyPanel.ysArr2);
         }
         _loc2_.initSkillLevel();
         _loc2_.getEquipSlot().addToSlot(EquipFactory.createEquipByID(11510),0);
         _loc2_.getEquipSlot().addToSlot(EquipFactory.createEquipByID(11410),1);
         _loc2_.getEquipSlot().addToSlot(EquipFactory.createEquipByID(11710),3);
         _loc2_.getEquipSlot().addToSlot(EquipFactory.createEquipByID(11610),4);
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc2_.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(21110));
            _loc2_.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(21210));
            _loc3_++;
         }
         _loc2_.getSuppliesSlot().setToSuppliesSlot(SuppliesFactory.getSuppliesById(21110),0);
         _loc2_.getSuppliesSlot().setToSuppliesSlot(SuppliesFactory.getSuppliesById(21210),1);
         return _loc2_;
      }
      
      private static function 选武器(param1:PlayerData, param2:int, param3:int) : *
      {
         if(param3 == 0)
         {
            param1.getEquipSlot().addToSlot(EquipFactory.createEquipByID(param2),2);
         }
         else
         {
            param1.getEquipSlot().addToSlot(EquipFactory.createEquipByID(param2),5);
         }
      }
      
      public function get killPoint() : VT
      {
         trace("禁止killPoint_get1:",getQualifiedClassName(this));
         return _killPoint;
      }
      
      public function set killPoint(param1:VT) : void
      {
         trace("禁止killPoint_get2:",getQualifiedClassName(this));
         _killPoint = param1;
      }
      
      public function get Exp() : VT
      {
         trace("禁止get1:",getQualifiedClassName(this));
         return _Exp;
      }
      
      public function set Exp(param1:VT) : void
      {
         trace("禁止get2:",getQualifiedClassName(this));
         _Exp = param1;
      }
      
      public function get level() : VT
      {
         trace("禁止get3:",getQualifiedClassName(this));
         return _level;
      }
      
      public function set level(param1:VT) : void
      {
         trace("禁止get4:",getQualifiedClassName(this));
         _level = param1;
      }
      
      public function get skillArr() : Array
      {
         return _skillArr;
      }
      
      public function set skillArr(param1:Array) : void
      {
         trace("禁止get6:",getQualifiedClassName(this));
         _skillArr = param1;
      }
      
      public function get gold() : VT
      {
         trace("禁止get7:",getQualifiedClassName(this));
         return _gold;
      }
      
      public function set gold(param1:VT) : void
      {
         trace("禁止get8:",getQualifiedClassName(this));
         _gold = param1;
      }
      
      public function get points() : VT
      {
         trace("禁止get9:",getQualifiedClassName(this));
         return _points;
      }
      
      public function set points(param1:VT) : void
      {
         trace("禁止get10:",getQualifiedClassName(this));
         _points = param1;
      }
      
      public function get rebirth() : Boolean
      {
         trace("禁止get11:",getQualifiedClassName(this));
         return _rebirth;
      }
      
      public function set rebirth(param1:Boolean) : void
      {
         trace("禁止get12:",getQualifiedClassName(this));
         _rebirth = param1;
      }
      
      public function get transferArr() : Array
      {
         trace("禁止get13:",getQualifiedClassName(this));
         return _transferArr;
      }
      
      public function set transferArr(param1:Array) : void
      {
         trace("禁止get14:",getQualifiedClassName(this));
         _transferArr = param1;
      }
      
      public function get pickSkillArr() : Array
      {
         trace("禁止get15:",getQualifiedClassName(this));
         return _pickSkillArr;
      }
      
      public function set pickSkillArr(param1:Array) : void
      {
         trace("禁止get16:",getQualifiedClassName(this));
         _pickSkillArr = param1;
      }
      
      public function get bag() : Bag
      {
         trace("禁止get17:",getQualifiedClassName(this));
         return _bag;
      }
      
      public function set bag(param1:Bag) : void
      {
         trace("禁止get18:",getQualifiedClassName(this));
         _bag = param1;
      }
      
      public function get equipSkillSlot() : EquipSkillSlot
      {
         trace("禁止get21:",getQualifiedClassName(this));
         return _equipSkillSlot;
      }
      
      public function set equipSkillSlot(param1:EquipSkillSlot) : void
      {
         trace("禁止get22:",getQualifiedClassName(this));
         _equipSkillSlot = param1;
      }
      
      public function get equipSlot() : EquipSlot
      {
         return _equipSlot;
      }
      
      public function set equipSlot(param1:EquipSlot) : void
      {
         trace("禁止get24:",getQualifiedClassName(this));
         _equipSlot = param1;
      }
      
      public function get keyArr() : Array
      {
         trace("禁止get25:",getQualifiedClassName(this));
         return _keyArr;
      }
      
      public function set keyArr(param1:Array) : void
      {
         trace("禁止get26:",getQualifiedClassName(this));
         _keyArr = param1;
      }
      
      public function get suppliesSlot() : SuppliesSlot
      {
         trace("禁止get27:",getQualifiedClassName(this));
         return _suppliesSlot;
      }
      
      public function set suppliesSlot(param1:SuppliesSlot) : void
      {
         trace("禁止get28:",getQualifiedClassName(this));
         _suppliesSlot = param1;
      }
      
      public function get petSlot() : PetSlot
      {
         trace("禁止get29:",getQualifiedClassName(this));
         return _petSlot;
      }
      
      public function set petSlot(param1:PetSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         _petSlot = param1;
      }
      
      public function get badgeSlot() : BadgeSlot
      {
         trace("禁止get30:",getQualifiedClassName(this));
         return _badgeSlot;
      }
      
      public function set badgeSlot(param1:BadgeSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         _badgeSlot = param1;
      }
      
      public function get titleSlot() : TitleSlot
      {
         trace("禁止get30:",getQualifiedClassName(this));
         return _titleSlot;
      }
      
      public function set titleSlot(param1:TitleSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         _titleSlot = param1;
      }
      
      public function get stampSlot() : StampSlot
      {
         trace("禁止get30:",getQualifiedClassName(this));
         return _stampSlot;
      }
      
      public function set stampSlot(param1:StampSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         _stampSlot = param1;
      }
      
      public function get elvesSlot() : ElvesSlot
      {
         trace("禁止get30:",getQualifiedClassName(this));
         return _elvesSlot;
      }
      
      public function set elvesSlot(param1:ElvesSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         _elvesSlot = param1;
      }
      
      private function initSkillLevel() : void
      {
         _skillArr[0] = ["a1",1];
         _skillArr[1] = ["a2",1];
         _skillArr[2] = ["a3",1];
         _skillArr[3] = ["a4",1];
         _skillArr[4] = ["a5",1];
         _skillArr[5] = ["a6",1];
         _skillArr[6] = ["a7",1];
         _skillArr[7] = ["a8",0];
         _skillArr[8] = ["a9",0];
         _skillArr[9] = ["a10",0];
         _skillArr[10] = ["a11",0];
         _skillArr[11] = ["a12",0];
         _skillArr[12] = ["a13",0];
         _skillArr[13] = ["a14",0];
         _skillArr[14] = ["a15",0];
         _skillArr[15] = ["b1",1];
         _skillArr[16] = ["b2",1];
         _skillArr[17] = ["b3",1];
         _skillArr[18] = ["b4",1];
         _skillArr[19] = ["b5",1];
         _skillArr[20] = ["b6",1];
         _skillArr[21] = ["b7",1];
         _skillArr[22] = ["b8",0];
         _skillArr[23] = ["b9",0];
         _skillArr[24] = ["b10",0];
         _skillArr[25] = ["b11",0];
         _skillArr[26] = ["b12",0];
         _skillArr[27] = ["b13",0];
         _skillArr[28] = ["b14",0];
         _skillArr[29] = ["b15",0];
         _skillArr[30] = ["c1",1];
         _skillArr[31] = ["c2",1];
         _skillArr[32] = ["c3",1];
         _skillArr[33] = ["c4",1];
         _skillArr[34] = ["c5",1];
         _skillArr[35] = ["c6",1];
         _skillArr[36] = ["c7",1];
         _skillArr[37] = ["c8",0];
         _skillArr[38] = ["c9",0];
         _skillArr[39] = ["c10",0];
         _skillArr[40] = ["c11",0];
         _skillArr[41] = ["c12",0];
         _skillArr[42] = ["c13",0];
         _skillArr[43] = ["c14",0];
         _skillArr[44] = ["c15",0];
         _skillArr[45] = ["d1",0];
         _skillArr[46] = ["d2",0];
         _skillArr[47] = ["d3",0];
         _skillArr[48] = ["d4",0];
         _skillArr[49] = ["d5",0];
         _skillArr[50] = ["d6",0];
         _skillArr[51] = ["d7",0];
         _skillArr[52] = ["d8",0];
         _skillArr[53] = ["d9",0];
         _skillArr[54] = ["d10",0];
         _skillArr[55] = ["d11",0];
         _skillArr[56] = ["d12",0];
         _skillArr[57] = ["d13",0];
         _skillArr[58] = ["d14",0];
         _skillArr[59] = ["d15",0];
         _skillArr[60] = ["d16",0];
      }
      
      public function getKeyArr() : Array
      {
         return DeepCopyUtil.clone(_keyArr);
      }
      
      public function setKeyArr(param1:Array) : void
      {
         _keyArr = DeepCopyUtil.clone(param1);
      }
      
      public function getBag() : Bag
      {
         return _bag;
      }
      
      public function getPetSlot() : PetSlot
      {
         if(!_petSlot)
         {
            _petSlot = PetSlot.createPetSlot();
         }
         return _petSlot;
      }
      
      public function getElvesSlot() : ElvesSlot
      {
         if(!_elvesSlot)
         {
            _elvesSlot = ElvesSlot.createElvesSlot();
         }
         return _elvesSlot;
      }
      
      public function getBadgeSlot() : BadgeSlot
      {
         if(!_badgeSlot)
         {
            _badgeSlot = BadgeSlot.createBadgeSlot();
         }
         return _badgeSlot;
      }
      
      public function getStampSlot() : StampSlot
      {
         if(!_stampSlot)
         {
            _stampSlot = StampSlot.createStampSlot();
         }
         return _stampSlot;
      }
      
      public function getTitleSlot() : TitleSlot
      {
         if(!_titleSlot)
         {
            _titleSlot = TitleSlot.createTitleSlot();
         }
         return _titleSlot;
      }
      
      public function getSuppliesSlot() : SuppliesSlot
      {
         return _suppliesSlot;
      }
      
      public function getEquipSlot() : EquipSlot
      {
         return _equipSlot;
      }
      
      public function getEquipSkillSlot() : EquipSkillSlot
      {
         return _equipSkillSlot;
      }
      
      public function getPickSkill() : Array
      {
         return _pickSkillArr;
      }
      
      public function getSkillLevel(param1:String) : Number
      {
         var _loc2_:uint = 0;
         while(_loc2_ < _skillArr.length)
         {
            if(_skillArr[_loc2_][0] == param1)
            {
               return _skillArr[_loc2_][1];
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function aginSkillLevel(param1:String) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < _skillArr.length)
         {
            if(_skillArr[_loc2_][0] == param1)
            {
               _skillArr[_loc2_][1] = 0;
            }
            _loc2_++;
         }
      }
      
      public function getGold() : Number
      {
         return _gold.getValue();
      }
      
      public function getPoints() : Number
      {
         return _points.getValue();
      }
      
      public function addSkillLevel(param1:String) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < _skillArr.length)
         {
            if(_skillArr[_loc2_][0] == param1)
            {
               ++_skillArr[_loc2_][1];
            }
            _loc2_++;
         }
      }
      
      public function payGold(param1:Number) : Boolean
      {
         if(_gold.getValue() - param1 >= 0)
         {
            _gold.setValue(_gold.getValue() - param1);
            return true;
         }
         return false;
      }
      
      public function addGold(param1:Number) : void
      {
         var _loc2_:Number = _gold.getValue() + param1;
         if(_loc2_ <= InitData.Money_max.getValue())
         {
            _gold.setValue(_loc2_);
         }
      }
      
      public function SetGold(param1:Number) : void
      {
         _gold.setValue(param1);
      }
      
      public function delPoints(param1:Number) : void
      {
         if(_points.getValue() - param1 >= 0)
         {
            _points.setValue(_points.getValue() - param1);
         }
      }
      
      public function addPoint(param1:Number) : void
      {
         _points.setValue(_points.getValue() + param1);
      }
      
      public function getLevel() : Number
      {
         return _level.getValue();
      }
      
      public function setLevel(param1:int) : void
      {
         _level.setValue(param1);
      }
      
      public function isRebirth() : Boolean
      {
         return _rebirth;
      }
      
      public function isTransfer(param1:Number) : Boolean
      {
         return _transferArr[param1];
      }
      
      public function isTransferOk() : Boolean
      {
         var _loc1_:uint = 0;
         while(_loc1_ < _transferArr.length)
         {
            if(_transferArr[_loc1_])
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function getTransferOk() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:uint = 0;
         while(_loc2_ < _transferArr.length)
         {
            if(_transferArr[_loc2_])
            {
               _loc1_.push(_loc2_);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getEXP() : Number
      {
         return _Exp.getValue();
      }
      
      public function setEXP(param1:int) : *
      {
         _Exp.setValue(param1);
      }
      
      public function skillCdArr() : Array
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Skill = null;
         var _loc7_:Array = null;
         var _loc1_:Array = [];
         var _loc2_:uint = 0;
         while(_loc2_ < _skillArr.length)
         {
            _loc3_ = _skillArr[_loc2_][0];
            _loc4_ = Number(_skillArr[_loc2_][1]);
            if(_loc4_ != 0)
            {
               _loc6_ = SkillFactory.getSkillByTypeIAndLevel(_loc3_,_loc4_);
            }
            else
            {
               _loc6_ = SkillFactory.getSkillByTypeIAndLevel(_loc3_,1);
            }
            _loc5_ = _loc6_.getSkillCd();
            _loc7_ = [_loc3_,_loc5_];
            _loc1_[_loc2_] = _loc7_;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function ObjCdArr() : Array
      {
         return SuppliesFactory.getSuppliesNameAndCD();
      }
      
      public function getSkillArr() : Array
      {
         return _skillArr;
      }
      
      public function setTransfer(param1:Number) : void
      {
         _transferArr[param1] = true;
      }
      
      public function setRebirth() : void
      {
         _rebirth = true;
      }
      
      public function AddKillPoint(param1:int) : *
      {
         _killPoint.setValue(_killPoint.getValue() + param1);
      }
      
      public function getKillPoint() : Number
      {
         return _killPoint.getValue();
      }
      
      public function getSkillNum(param1:uint = 0) : Number
      {
         var _loc8_:uint = 0;
         var _loc2_:Number = 0;
         var _loc3_:Array = getSkillArr();
         var _loc4_:Array = ["a8","a9","a10","a11","a12","a13","a14","a15"];
         var _loc5_:Array = ["b8","b9","b10","b11","b12","b13","b14","b15"];
         var _loc6_:Array = ["c8","c9","c10","c11","c12","c13","c14","c15"];
         var _loc7_:uint = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc4_.length)
            {
               if(_loc3_[_loc7_][0] == _loc4_[_loc8_])
               {
                  if(_loc3_[_loc7_][1] > param1)
                  {
                     _loc2_++;
                     break;
                  }
               }
               if(_loc3_[_loc7_][0] == _loc5_[_loc8_])
               {
                  if(_loc3_[_loc7_][1] > param1)
                  {
                     _loc2_++;
                     break;
                  }
               }
               if(_loc3_[_loc7_][0] == _loc6_[_loc8_])
               {
                  if(_loc3_[_loc7_][1] > param1)
                  {
                     _loc2_++;
                     break;
                  }
               }
               _loc8_++;
            }
            _loc7_++;
         }
         return _loc2_;
      }
   }
}

