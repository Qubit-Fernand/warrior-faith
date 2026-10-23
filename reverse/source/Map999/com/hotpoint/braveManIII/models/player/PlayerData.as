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
      
      public static function creatPlayerData(num:int = 1) : PlayerData
      {
         var i:int = 0;
         var player:PlayerData = new PlayerData();
         player._stampSlot = StampSlot.createStampSlot();
         player._titleSlot = TitleSlot.createTitleSlot();
         player._petSlot = PetSlot.createPetSlot();
         player._elvesSlot = ElvesSlot.createElvesSlot();
         player._badgeSlot = BadgeSlot.createBadgeSlot();
         player._equipSlot = EquipSlot.createEquipSlot();
         player._equipSlot.who = player;
         player._equipSkillSlot = EquipSkillSlot.createEquipSkillSlot();
         player._suppliesSlot = SuppliesSlot.createSuppliesSlot();
         player._level = VT.createVT(VT.GetTempVT("8/8"));
         player._gold = VT.createVT(InitData.Money_init.getValue());
         player._points = VT.createVT(VT.GetTempVT("8/2"));
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
         return player;
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
      
      public function get killPoint() : VT
      {
         return _killPoint;
      }
      
      public function set killPoint(value:VT) : void
      {
         _killPoint = value;
      }
      
      public function get Exp() : VT
      {
         return _Exp;
      }
      
      public function set Exp(value:VT) : void
      {
         _Exp = value;
      }
      
      public function get level() : VT
      {
         return _level;
      }
      
      public function set level(value:VT) : void
      {
         _level = value;
      }
      
      public function get skillArr() : Array
      {
         return _skillArr;
      }
      
      public function set skillArr(value:Array) : void
      {
         _skillArr = value;
      }
      
      public function get gold() : VT
      {
         return _gold;
      }
      
      public function set gold(value:VT) : void
      {
         _gold = value;
      }
      
      public function get points() : VT
      {
         return _points;
      }
      
      public function set points(value:VT) : void
      {
         _points = value;
      }
      
      public function get rebirth() : Boolean
      {
         return _rebirth;
      }
      
      public function set rebirth(value:Boolean) : void
      {
         _rebirth = value;
      }
      
      public function get transferArr() : Array
      {
         return _transferArr;
      }
      
      public function set transferArr(value:Array) : void
      {
         _transferArr = value;
      }
      
      public function get pickSkillArr() : Array
      {
         return _pickSkillArr;
      }
      
      public function set pickSkillArr(value:Array) : void
      {
         _pickSkillArr = value;
      }
      
      public function get bag() : Bag
      {
         return _bag;
      }
      
      public function set bag(value:Bag) : void
      {
         _bag = value;
      }
      
      public function get equipSkillSlot() : EquipSkillSlot
      {
         return _equipSkillSlot;
      }
      
      public function set equipSkillSlot(value:EquipSkillSlot) : void
      {
         _equipSkillSlot = value;
      }
      
      public function get equipSlot() : EquipSlot
      {
         return _equipSlot;
      }
      
      public function set equipSlot(value:EquipSlot) : void
      {
         _equipSlot = value;
      }
      
      public function get keyArr() : Array
      {
         return _keyArr;
      }
      
      public function set keyArr(value:Array) : void
      {
         _keyArr = value;
      }
      
      public function get suppliesSlot() : SuppliesSlot
      {
         return _suppliesSlot;
      }
      
      public function set suppliesSlot(value:SuppliesSlot) : void
      {
         _suppliesSlot = value;
      }
      
      public function get petSlot() : PetSlot
      {
         return _petSlot;
      }
      
      public function set petSlot(value:PetSlot) : void
      {
         _petSlot = value;
      }
      
      public function get badgeSlot() : BadgeSlot
      {
         return _badgeSlot;
      }
      
      public function set badgeSlot(value:BadgeSlot) : void
      {
         _badgeSlot = value;
      }
      
      public function get titleSlot() : TitleSlot
      {
         return _titleSlot;
      }
      
      public function set titleSlot(value:TitleSlot) : void
      {
         _titleSlot = value;
      }
      
      public function get stampSlot() : StampSlot
      {
         return _stampSlot;
      }
      
      public function set stampSlot(value:StampSlot) : void
      {
         _stampSlot = value;
      }
      
      public function get elvesSlot() : ElvesSlot
      {
         return _elvesSlot;
      }
      
      public function set elvesSlot(value:ElvesSlot) : void
      {
         _elvesSlot = value;
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
      
      public function setKeyArr(arr:Array) : void
      {
         _keyArr = DeepCopyUtil.clone(arr);
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
      
      public function getSkillLevel(typeId:String) : Number
      {
         for(var i:uint = 0; i < _skillArr.length; i++)
         {
            if(_skillArr[i][0] == typeId)
            {
               return _skillArr[i][1];
            }
         }
         return -1;
      }
      
      public function aginSkillLevel(typeId:String) : void
      {
         for(var i:uint = 0; i < _skillArr.length; i++)
         {
            if(_skillArr[i][0] == typeId)
            {
               _skillArr[i][1] = 0;
            }
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
      
      public function addSkillLevel(typeId:String) : void
      {
         for(var i:uint = 0; i < _skillArr.length; i++)
         {
            if(_skillArr[i][0] == typeId)
            {
               ++_skillArr[i][1];
            }
         }
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
      
      public function addGold(value:Number) : void
      {
         var num:Number = _gold.getValue() + value;
         if(num <= InitData.Money_max.getValue())
         {
            _gold.setValue(num);
         }
      }
      
      public function SetGold(value:Number) : void
      {
         _gold.setValue(value);
      }
      
      public function delPoints(type:Number) : void
      {
         if(_points.getValue() - type >= 0)
         {
            _points.setValue(_points.getValue() - type);
         }
      }
      
      public function addPoint(type:Number) : void
      {
         _points.setValue(_points.getValue() + type);
      }
      
      public function getLevel() : Number
      {
         return _level.getValue();
      }
      
      public function setLevel(num:int) : void
      {
         _level.setValue(num);
      }
      
      public function isRebirth() : Boolean
      {
         return _rebirth;
      }
      
      public function isTransfer(type:Number) : Boolean
      {
         return _transferArr[type];
      }
      
      public function isTransferOk() : Boolean
      {
         for(var i:uint = 0; i < _transferArr.length; i++)
         {
            if(_transferArr[i])
            {
               return true;
            }
         }
         return false;
      }
      
      public function getTransferOk() : Array
      {
         var arr:Array = [];
         for(var i:uint = 0; i < _transferArr.length; i++)
         {
            if(_transferArr[i])
            {
               arr.push(i);
            }
         }
         return arr;
      }
      
      public function getEXP() : Number
      {
         return _Exp.getValue();
      }
      
      public function setEXP(x:int) : *
      {
         _Exp.setValue(x);
      }
      
      public function skillCdArr() : Array
      {
         var sName:String = null;
         var slLevel:Number = NaN;
         var XX:Number = NaN;
         var cd:Skill = null;
         var ARR:Array = null;
         var _allArr:Array = [];
         for(var i:uint = 0; i < _skillArr.length; i++)
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
      
      public function ObjCdArr() : Array
      {
         return SuppliesFactory.getSuppliesNameAndCD();
      }
      
      public function getSkillArr() : Array
      {
         return _skillArr;
      }
      
      public function setTransfer(num:Number) : void
      {
         _transferArr[num] = true;
      }
      
      public function setRebirth() : void
      {
         _rebirth = true;
      }
      
      public function AddKillPoint(i:int) : *
      {
         _killPoint.setValue(_killPoint.getValue() + i);
      }
      
      public function getKillPoint() : Number
      {
         return _killPoint.getValue();
      }
      
      public function getSkillNum() : Number
      {
         var j:uint = 0;
         var num:Number = 0;
         var arr:Array = getSkillArr();
         var arr1:Array = ["a8","a9","a10","a11","a12","a13","a14","a15"];
         var arr2:Array = ["b8","b9","b10","b11","b12","b13","b14","b15"];
         var arr3:Array = ["c8","c9","c10","c11","c12","c13","c14","c15"];
         for(var i:uint = 0; i < arr.length; i++)
         {
            for(j = 0; j < arr1.length; j++)
            {
               if(arr[i][0] == arr1[j])
               {
                  if(arr[i][1] > 0)
                  {
                     num++;
                     break;
                  }
               }
               if(arr[i][0] == arr2[j])
               {
                  if(arr[i][1] > 0)
                  {
                     num++;
                     break;
                  }
               }
               if(arr[i][0] == arr3[j])
               {
                  if(arr[i][1] > 0)
                  {
                     num++;
                     break;
                  }
               }
            }
         }
         return num;
      }
   }
}

