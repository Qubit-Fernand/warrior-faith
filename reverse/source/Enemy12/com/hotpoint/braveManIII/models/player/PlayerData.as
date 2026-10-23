package com.hotpoint.braveManIII.models.player
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.skill.Skill;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.setProfession.*;
   import flash.utils.*;
   
   public class PlayerData
   {
      
      private var _points:VT;
      
      private var _level:VT = VT.createVT();
      
      public var _keyArr:Array = [];
      
      public var skinArr:Array = [0,1];
      
      private var _rebirth:Boolean;
      
      private var _skillArr:Array = [];
      
      private var _transferArr:Array = [];
      
      private var _Exp:VT = VT.createVT();
      
      private var _gold:VT;
      
      private var _equipSkillSlot:EquipSkillSlot;
      
      private var _bag:Bag = new Bag();
      
      private var _suppliesSlot:SuppliesSlot;
      
      private var _equipSlot:EquipSlot;
      
      public var skinNum:int = 0;
      
      public var _pickSkillArr:Array = [];
      
      public function PlayerData()
      {
         super();
      }
      
      private static function 选武器(who:PlayerData, id:int, num:int) : *
      {
         if(num == 0)
         {
            who.getEquipSlot().addToSlot(EquipFactory.createEquipByID(id),2);
         }
         else
         {
            who.getEquipSlot().addToSlot(EquipFactory.createEquipByID(id),5);
         }
      }
      
      public static function creatPlayerData(num:int = 1) : PlayerData
      {
         var player:PlayerData = null;
         var i:int = 0;
         player = new PlayerData();
         player._equipSlot = EquipSlot.createEquipSlot();
         player._equipSlot.who = player;
         player._equipSkillSlot = EquipSkillSlot.createEquipSkillSlot();
         player._suppliesSlot = SuppliesSlot.createSuppliesSlot();
         player._level = VT.createVT(50);
         player._gold = VT.createVT(4399999);
         player._points = VT.createVT(40000);
         player._rebirth = false;
         player._transferArr = [false,false,false];
         player._pickSkillArr = [false,false,false];
         player.skinArr = SetProfession["skinArr" + num];
         for(i = 0; i < 2; i++)
         {
            if(player.skinArr[i] == 0)
            {
               player._pickSkillArr[0] = true;
               选武器(player,11110,i);
            }
            else if(player.skinArr[i] == 1)
            {
               player._pickSkillArr[1] = true;
               选武器(player,11210,i);
            }
            else if(player.skinArr[i] == 2)
            {
               player._pickSkillArr[2] = true;
               选武器(player,11310,i);
            }
         }
         if(num == 1)
         {
            player._keyArr = DeepCopyUtil.clone(SetKeyPanel.ysArr);
         }
         else if(num == 2)
         {
            player._keyArr = DeepCopyUtil.clone(SetKeyPanel.ysArr2);
         }
         player.initSkillLevel();
         player.getEquipSlot().addToSlot(EquipFactory.createEquipByID(11510),0);
         player.getEquipSlot().addToSlot(EquipFactory.createEquipByID(11410),1);
         player.getEquipSlot().addToSlot(EquipFactory.createEquipByID(11710),3);
         player.getEquipSlot().addToSlot(EquipFactory.createEquipByID(11610),4);
         for(i = 0; i < 8; i++)
         {
            player.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(21110));
            player.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(21210));
         }
         player.getSuppliesSlot().setToSuppliesSlot(SuppliesFactory.getSuppliesById(21110),0);
         player.getSuppliesSlot().setToSuppliesSlot(SuppliesFactory.getSuppliesById(21210),1);
         for(i = 0; i < 1; i++)
         {
            player._bag.addOtherobjBag(OtherFactory.creatOther(63102));
         }
         player._bag.addOtherobjBag(OtherFactory.creatOther(63108));
         player._bag.addOtherobjBag(OtherFactory.creatOther(63109));
         player._bag.addOtherobjBag(OtherFactory.creatOther(63110));
         player._bag.addOtherobjBag(OtherFactory.creatOther(63111));
         player._bag.addOtherobjBag(OtherFactory.creatOther(63106));
         player._bag.addOtherobjBag(OtherFactory.creatOther(63106));
         return player;
      }
      
      public function set level(value:VT) : void
      {
         trace("禁止get4:",getQualifiedClassName(this));
         _level = value;
      }
      
      public function get keyArr() : Array
      {
         trace("禁止get25:",getQualifiedClassName(this));
         return _keyArr;
      }
      
      public function get level() : VT
      {
         trace("禁止get3:",getQualifiedClassName(this));
         return _level;
      }
      
      public function set bag(value:Bag) : void
      {
         trace("禁止get18:",getQualifiedClassName(this));
         _bag = value;
      }
      
      public function get pickSkillArr() : Array
      {
         trace("禁止get15:",getQualifiedClassName(this));
         return _pickSkillArr;
      }
      
      public function set keyArr(value:Array) : void
      {
         trace("禁止get26:",getQualifiedClassName(this));
         _keyArr = value;
      }
      
      public function getEquipSkillSlot() : EquipSkillSlot
      {
         return _equipSkillSlot;
      }
      
      public function get bag() : Bag
      {
         trace("禁止get17:",getQualifiedClassName(this));
         return _bag;
      }
      
      public function getEquipSlot() : EquipSlot
      {
         return _equipSlot;
      }
      
      public function set equipSlot(value:EquipSlot) : void
      {
         trace("禁止get24:",getQualifiedClassName(this));
         _equipSlot = value;
      }
      
      public function getTransferOk() : Array
      {
         var arr:Array = null;
         var i:uint = 0;
         arr = [];
         for(i = 0; i < _transferArr.length; i++)
         {
            if(_transferArr[i])
            {
               arr.push(i);
            }
         }
         return arr;
      }
      
      public function get equipSkillSlot() : EquipSkillSlot
      {
         trace("禁止get21:",getQualifiedClassName(this));
         return _equipSkillSlot;
      }
      
      public function set skillArr(value:Array) : void
      {
         trace("禁止get6:",getQualifiedClassName(this));
         _skillArr = value;
      }
      
      public function set pickSkillArr(value:Array) : void
      {
         trace("禁止get16:",getQualifiedClassName(this));
         _pickSkillArr = value;
      }
      
      public function setKeyArr(arr:Array) : void
      {
         _keyArr = DeepCopyUtil.clone(arr);
      }
      
      public function getPickSkill() : Array
      {
         return _pickSkillArr;
      }
      
      public function payGold(value:Number) : Boolean
      {
         if(_gold.getValue() - value >= 0)
         {
            _gold.setValue(_gold.getValue() - value);
            return true;
         }
         return false;
      }
      
      public function getSkillLevel(typeId:String) : Number
      {
         var i:uint = 0;
         for(i = 0; i < _skillArr.length; i++)
         {
            if(_skillArr[i][0] == typeId)
            {
               return _skillArr[i][1];
            }
         }
         return -1;
      }
      
      public function setRebirth() : void
      {
         trace("_rebirth" + _rebirth);
         _rebirth = true;
      }
      
      public function addGold(value:Number) : void
      {
         var num:Number = NaN;
         num = _gold.getValue() + value;
         _gold.setValue(num);
      }
      
      public function addSkillLevel(typeId:String) : void
      {
         var i:uint = 0;
         for(i = 0; i < _skillArr.length; i++)
         {
            if(_skillArr[i][0] == typeId)
            {
               ++_skillArr[i][1];
            }
         }
      }
      
      public function isTransfer(type:Number) : Boolean
      {
         return _transferArr[type];
      }
      
      public function ObjCdArr() : Array
      {
         var arr:Array = null;
         return SuppliesFactory.getSuppliesNameAndCD();
      }
      
      public function set gold(value:VT) : void
      {
         trace("禁止get8:",getQualifiedClassName(this));
         _gold = value;
      }
      
      public function skillCdArr() : Array
      {
         var _allArr:Array = null;
         var i:uint = 0;
         var sName:String = null;
         var slLevel:Number = NaN;
         var XX:Number = NaN;
         var cd:Skill = null;
         var ARR:Array = null;
         _allArr = [];
         for(i = 0; i < _skillArr.length; i++)
         {
            sName = _skillArr[i][0];
            slLevel = Number(_skillArr[i][1]);
            if(slLevel != 0)
            {
               cd = SkillFactory.getSkillByTypeIAndLevel(sName,slLevel);
            }
            else
            {
               cd = SkillFactory.getSkillByTypeIAndLevel(sName,1);
            }
            XX = cd.getSkillCd();
            ARR = [sName,XX];
            _allArr[i] = ARR;
         }
         return _allArr;
      }
      
      public function set points(value:VT) : void
      {
         trace("禁止get10:",getQualifiedClassName(this));
         _points = value;
      }
      
      public function set equipSkillSlot(value:EquipSkillSlot) : void
      {
         trace("禁止get22:",getQualifiedClassName(this));
         _equipSkillSlot = value;
      }
      
      public function get equipSlot() : EquipSlot
      {
         return _equipSlot;
      }
      
      public function getBag() : Bag
      {
         return _bag;
      }
      
      public function getLevel() : Number
      {
         return _level.getValue();
      }
      
      public function set suppliesSlot(value:SuppliesSlot) : void
      {
         trace("禁止get28:",getQualifiedClassName(this));
         _suppliesSlot = value;
      }
      
      public function get skillArr() : Array
      {
         return _skillArr;
      }
      
      public function set rebirth(value:Boolean) : void
      {
         trace("禁止get12:",getQualifiedClassName(this));
         _rebirth = value;
      }
      
      public function getPoints() : Number
      {
         return _points.getValue();
      }
      
      public function setEXP(x:int) : *
      {
         _Exp.setValue(x);
      }
      
      public function getGold() : Number
      {
         return _gold.getValue();
      }
      
      public function get gold() : VT
      {
         trace("禁止get7:",getQualifiedClassName(this));
         return _gold;
      }
      
      public function getSuppliesSlot() : SuppliesSlot
      {
         return _suppliesSlot;
      }
      
      public function isRebirth() : Boolean
      {
         return _rebirth;
      }
      
      public function get points() : VT
      {
         trace("禁止get9:",getQualifiedClassName(this));
         return _points;
      }
      
      public function aginSkillLevel(typeId:String) : void
      {
         var i:uint = 0;
         for(i = 0; i < _skillArr.length; i++)
         {
            if(_skillArr[i][0] == typeId)
            {
               _skillArr[i][1] = 0;
            }
         }
      }
      
      public function getSkillArr() : Array
      {
         return _skillArr;
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
      
      public function get suppliesSlot() : SuppliesSlot
      {
         trace("禁止get27:",getQualifiedClassName(this));
         return _suppliesSlot;
      }
      
      public function get rebirth() : Boolean
      {
         trace("禁止get11:",getQualifiedClassName(this));
         return _rebirth;
      }
      
      public function setTransfer(num:Number) : void
      {
         _transferArr[num] = true;
      }
      
      public function addPoint(type:Number) : void
      {
         _points.setValue(_points.getValue() + type);
      }
      
      public function isTransferOk() : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < _transferArr.length; i++)
         {
            if(_transferArr[i])
            {
               return true;
            }
         }
         return false;
      }
      
      public function set transferArr(value:Array) : void
      {
         trace("禁止get14:",getQualifiedClassName(this));
         _transferArr = value;
      }
      
      public function setPoints(type:Number) : void
      {
         if(_points.getValue() - type >= 0)
         {
            _points.setValue(_points.getValue() - type);
         }
      }
      
      public function get transferArr() : Array
      {
         trace("禁止get13:",getQualifiedClassName(this));
         return _transferArr;
      }
      
      public function getKeyArr() : Array
      {
         return DeepCopyUtil.clone(_keyArr);
      }
      
      public function set Exp(value:VT) : void
      {
         trace("禁止get2:",getQualifiedClassName(this));
         _Exp = value;
      }
      
      public function get Exp() : VT
      {
         trace("禁止get1:",getQualifiedClassName(this));
         return _Exp;
      }
      
      public function getEXP() : Number
      {
         return _Exp.getValue();
      }
   }
}

