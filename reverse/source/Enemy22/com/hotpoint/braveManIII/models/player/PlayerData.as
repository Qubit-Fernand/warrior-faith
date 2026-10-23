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
         trace("禁止killPoint_get1:",getQualifiedClassName(this));
         return this._killPoint;
      }
      
      public function set killPoint(value:VT) : void
      {
         trace("禁止killPoint_get2:",getQualifiedClassName(this));
         this._killPoint = value;
      }
      
      public function get Exp() : VT
      {
         trace("禁止get1:",getQualifiedClassName(this));
         return this._Exp;
      }
      
      public function set Exp(value:VT) : void
      {
         trace("禁止get2:",getQualifiedClassName(this));
         this._Exp = value;
      }
      
      public function get level() : VT
      {
         trace("禁止get3:",getQualifiedClassName(this));
         return this._level;
      }
      
      public function set level(value:VT) : void
      {
         trace("禁止get4:",getQualifiedClassName(this));
         this._level = value;
      }
      
      public function get skillArr() : Array
      {
         return this._skillArr;
      }
      
      public function set skillArr(value:Array) : void
      {
         trace("禁止get6:",getQualifiedClassName(this));
         this._skillArr = value;
      }
      
      public function get gold() : VT
      {
         trace("禁止get7:",getQualifiedClassName(this));
         return this._gold;
      }
      
      public function set gold(value:VT) : void
      {
         trace("禁止get8:",getQualifiedClassName(this));
         this._gold = value;
      }
      
      public function get points() : VT
      {
         trace("禁止get9:",getQualifiedClassName(this));
         return this._points;
      }
      
      public function set points(value:VT) : void
      {
         trace("禁止get10:",getQualifiedClassName(this));
         this._points = value;
      }
      
      public function get rebirth() : Boolean
      {
         trace("禁止get11:",getQualifiedClassName(this));
         return this._rebirth;
      }
      
      public function set rebirth(value:Boolean) : void
      {
         trace("禁止get12:",getQualifiedClassName(this));
         this._rebirth = value;
      }
      
      public function get transferArr() : Array
      {
         trace("禁止get13:",getQualifiedClassName(this));
         return this._transferArr;
      }
      
      public function set transferArr(value:Array) : void
      {
         trace("禁止get14:",getQualifiedClassName(this));
         this._transferArr = value;
      }
      
      public function get pickSkillArr() : Array
      {
         trace("禁止get15:",getQualifiedClassName(this));
         return this._pickSkillArr;
      }
      
      public function set pickSkillArr(value:Array) : void
      {
         trace("禁止get16:",getQualifiedClassName(this));
         this._pickSkillArr = value;
      }
      
      public function get bag() : Bag
      {
         trace("禁止get17:",getQualifiedClassName(this));
         return this._bag;
      }
      
      public function set bag(value:Bag) : void
      {
         trace("禁止get18:",getQualifiedClassName(this));
         this._bag = value;
      }
      
      public function get equipSkillSlot() : EquipSkillSlot
      {
         trace("禁止get21:",getQualifiedClassName(this));
         return this._equipSkillSlot;
      }
      
      public function set equipSkillSlot(value:EquipSkillSlot) : void
      {
         trace("禁止get22:",getQualifiedClassName(this));
         this._equipSkillSlot = value;
      }
      
      public function get equipSlot() : EquipSlot
      {
         return this._equipSlot;
      }
      
      public function set equipSlot(value:EquipSlot) : void
      {
         trace("禁止get24:",getQualifiedClassName(this));
         this._equipSlot = value;
      }
      
      public function get keyArr() : Array
      {
         trace("禁止get25:",getQualifiedClassName(this));
         return this._keyArr;
      }
      
      public function set keyArr(value:Array) : void
      {
         trace("禁止get26:",getQualifiedClassName(this));
         this._keyArr = value;
      }
      
      public function get suppliesSlot() : SuppliesSlot
      {
         trace("禁止get27:",getQualifiedClassName(this));
         return this._suppliesSlot;
      }
      
      public function set suppliesSlot(value:SuppliesSlot) : void
      {
         trace("禁止get28:",getQualifiedClassName(this));
         this._suppliesSlot = value;
      }
      
      public function get petSlot() : PetSlot
      {
         trace("禁止get29:",getQualifiedClassName(this));
         return this._petSlot;
      }
      
      public function set petSlot(value:PetSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         this._petSlot = value;
      }
      
      public function get badgeSlot() : BadgeSlot
      {
         trace("禁止get30:",getQualifiedClassName(this));
         return this._badgeSlot;
      }
      
      public function set badgeSlot(value:BadgeSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         this._badgeSlot = value;
      }
      
      public function get titleSlot() : TitleSlot
      {
         trace("禁止get30:",getQualifiedClassName(this));
         return this._titleSlot;
      }
      
      public function set titleSlot(value:TitleSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         this._titleSlot = value;
      }
      
      public function get stampSlot() : StampSlot
      {
         trace("禁止get30:",getQualifiedClassName(this));
         return this._stampSlot;
      }
      
      public function set stampSlot(value:StampSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         this._stampSlot = value;
      }
      
      public function get elvesSlot() : ElvesSlot
      {
         trace("禁止get30:",getQualifiedClassName(this));
         return this._elvesSlot;
      }
      
      public function set elvesSlot(value:ElvesSlot) : void
      {
         trace("禁止get30:",getQualifiedClassName(this));
         this._elvesSlot = value;
      }
      
      private function initSkillLevel() : void
      {
         this._skillArr[0] = ["a1",1];
         this._skillArr[1] = ["a2",1];
         this._skillArr[2] = ["a3",1];
         this._skillArr[3] = ["a4",1];
         this._skillArr[4] = ["a5",1];
         this._skillArr[5] = ["a6",1];
         this._skillArr[6] = ["a7",1];
         this._skillArr[7] = ["a8",0];
         this._skillArr[8] = ["a9",0];
         this._skillArr[9] = ["a10",0];
         this._skillArr[10] = ["a11",0];
         this._skillArr[11] = ["a12",0];
         this._skillArr[12] = ["a13",0];
         this._skillArr[13] = ["a14",0];
         this._skillArr[14] = ["a15",0];
         this._skillArr[15] = ["b1",1];
         this._skillArr[16] = ["b2",1];
         this._skillArr[17] = ["b3",1];
         this._skillArr[18] = ["b4",1];
         this._skillArr[19] = ["b5",1];
         this._skillArr[20] = ["b6",1];
         this._skillArr[21] = ["b7",1];
         this._skillArr[22] = ["b8",0];
         this._skillArr[23] = ["b9",0];
         this._skillArr[24] = ["b10",0];
         this._skillArr[25] = ["b11",0];
         this._skillArr[26] = ["b12",0];
         this._skillArr[27] = ["b13",0];
         this._skillArr[28] = ["b14",0];
         this._skillArr[29] = ["b15",0];
         this._skillArr[30] = ["c1",1];
         this._skillArr[31] = ["c2",1];
         this._skillArr[32] = ["c3",1];
         this._skillArr[33] = ["c4",1];
         this._skillArr[34] = ["c5",1];
         this._skillArr[35] = ["c6",1];
         this._skillArr[36] = ["c7",1];
         this._skillArr[37] = ["c8",0];
         this._skillArr[38] = ["c9",0];
         this._skillArr[39] = ["c10",0];
         this._skillArr[40] = ["c11",0];
         this._skillArr[41] = ["c12",0];
         this._skillArr[42] = ["c13",0];
         this._skillArr[43] = ["c14",0];
         this._skillArr[44] = ["c15",0];
         this._skillArr[45] = ["d1",0];
         this._skillArr[46] = ["d2",0];
         this._skillArr[47] = ["d3",0];
         this._skillArr[48] = ["d4",0];
         this._skillArr[49] = ["d5",0];
         this._skillArr[50] = ["d6",0];
         this._skillArr[51] = ["d7",0];
         this._skillArr[52] = ["d8",0];
         this._skillArr[53] = ["d9",0];
         this._skillArr[54] = ["d10",0];
         this._skillArr[55] = ["d11",0];
         this._skillArr[56] = ["d12",0];
         this._skillArr[57] = ["d13",0];
         this._skillArr[58] = ["d14",0];
         this._skillArr[59] = ["d15",0];
         this._skillArr[60] = ["d16",0];
      }
      
      public function getKeyArr() : Array
      {
         return DeepCopyUtil.clone(this._keyArr);
      }
      
      public function setKeyArr(arr:Array) : void
      {
         this._keyArr = DeepCopyUtil.clone(arr);
      }
      
      public function getBag() : Bag
      {
         return this._bag;
      }
      
      public function getPetSlot() : PetSlot
      {
         if(!this._petSlot)
         {
            this._petSlot = PetSlot.createPetSlot();
         }
         return this._petSlot;
      }
      
      public function getElvesSlot() : ElvesSlot
      {
         if(!this._elvesSlot)
         {
            this._elvesSlot = ElvesSlot.createElvesSlot();
         }
         return this._elvesSlot;
      }
      
      public function getBadgeSlot() : BadgeSlot
      {
         if(!this._badgeSlot)
         {
            this._badgeSlot = BadgeSlot.createBadgeSlot();
         }
         return this._badgeSlot;
      }
      
      public function getStampSlot() : StampSlot
      {
         if(!this._stampSlot)
         {
            this._stampSlot = StampSlot.createStampSlot();
         }
         return this._stampSlot;
      }
      
      public function getTitleSlot() : TitleSlot
      {
         if(!this._titleSlot)
         {
            this._titleSlot = TitleSlot.createTitleSlot();
         }
         return this._titleSlot;
      }
      
      public function getSuppliesSlot() : SuppliesSlot
      {
         return this._suppliesSlot;
      }
      
      public function getEquipSlot() : EquipSlot
      {
         return this._equipSlot;
      }
      
      public function getEquipSkillSlot() : EquipSkillSlot
      {
         return this._equipSkillSlot;
      }
      
      public function getPickSkill() : Array
      {
         return this._pickSkillArr;
      }
      
      public function getSkillLevel(typeId:String) : Number
      {
         for(var i:uint = 0; i < this._skillArr.length; i++)
         {
            if(this._skillArr[i][0] == typeId)
            {
               return this._skillArr[i][1];
            }
         }
         return -1;
      }
      
      public function aginSkillLevel(typeId:String) : void
      {
         for(var i:uint = 0; i < this._skillArr.length; i++)
         {
            if(this._skillArr[i][0] == typeId)
            {
               this._skillArr[i][1] = 0;
            }
         }
      }
      
      public function getGold() : Number
      {
         return this._gold.getValue();
      }
      
      public function getPoints() : Number
      {
         return this._points.getValue();
      }
      
      public function addSkillLevel(typeId:String) : void
      {
         for(var i:uint = 0; i < this._skillArr.length; i++)
         {
            if(this._skillArr[i][0] == typeId)
            {
               ++this._skillArr[i][1];
            }
         }
      }
      
      public function payGold(value:Number) : Boolean
      {
         if(this._gold.getValue() - value >= 0)
         {
            this._gold.setValue(this._gold.getValue() - value);
            return true;
         }
         return false;
      }
      
      public function addGold(value:Number) : void
      {
         var num:Number = this._gold.getValue() + value;
         if(num <= InitData.Money_max.getValue())
         {
            this._gold.setValue(num);
         }
      }
      
      public function SetGold(value:Number) : void
      {
         this._gold.setValue(value);
      }
      
      public function delPoints(type:Number) : void
      {
         if(this._points.getValue() - type >= 0)
         {
            this._points.setValue(this._points.getValue() - type);
         }
      }
      
      public function addPoint(type:Number) : void
      {
         this._points.setValue(this._points.getValue() + type);
      }
      
      public function getLevel() : Number
      {
         return this._level.getValue();
      }
      
      public function setLevel(num:int) : void
      {
         this._level.setValue(num);
      }
      
      public function isRebirth() : Boolean
      {
         return this._rebirth;
      }
      
      public function isTransfer(type:Number) : Boolean
      {
         return this._transferArr[type];
      }
      
      public function isTransferOk() : Boolean
      {
         for(var i:uint = 0; i < this._transferArr.length; i++)
         {
            if(this._transferArr[i])
            {
               return true;
            }
         }
         return false;
      }
      
      public function getTransferOk() : Array
      {
         var arr:Array = [];
         for(var i:uint = 0; i < this._transferArr.length; i++)
         {
            if(this._transferArr[i])
            {
               arr.push(i);
            }
         }
         return arr;
      }
      
      public function getEXP() : Number
      {
         return this._Exp.getValue();
      }
      
      public function setEXP(x:int) : *
      {
         this._Exp.setValue(x);
      }
      
      public function skillCdArr() : Array
      {
         var sName:String = null;
         var slLevel:Number = NaN;
         var XX:Number = NaN;
         var cd:Skill = null;
         var ARR:Array = null;
         var _allArr:Array = [];
         for(var i:uint = 0; i < this._skillArr.length; i++)
         {
            sName = this._skillArr[i][0];
            slLevel = Number(this._skillArr[i][1]);
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
         return this._skillArr;
      }
      
      public function setTransfer(num:Number) : void
      {
         this._transferArr[num] = true;
      }
      
      public function setRebirth() : void
      {
         this._rebirth = true;
      }
      
      public function AddKillPoint(i:int) : *
      {
         this._killPoint.setValue(this._killPoint.getValue() + i);
      }
      
      public function getKillPoint() : Number
      {
         return this._killPoint.getValue();
      }
      
      public function getSkillNum() : Number
      {
         var j:uint = 0;
         var num:Number = 0;
         var arr:Array = this.getSkillArr();
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

