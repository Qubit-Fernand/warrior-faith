package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.equip.*;
   import flash.utils.*;
   
   public class EquipSlot
   {
      
      private var _slot:Array = new Array();
      
      public var who:PlayerData;
      
      public function EquipSlot()
      {
         super();
      }
      
      public static function createEquipSlot() : EquipSlot
      {
         var es:EquipSlot = null;
         var i:int = 0;
         es = new EquipSlot();
         for(i = 0; i < 6; i++)
         {
            es._slot[i] = null;
         }
         return es;
      }
      
      public function set slot(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _slot = value;
      }
      
      public function getAllDuck() : Number
      {
         var duck:Number = NaN;
         var i:* = undefined;
         duck = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               duck += _slot[i].getDuck();
            }
         }
         return duck + getSuitAllAttrib(EquipBaseAttribTypeConst.DUCK);
      }
      
      public function get slot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _slot;
      }
      
      private function getSuitAllAttrib(attribType:Number) : Number
      {
         var suit:SuitEquipAttrib = null;
         var arr:Array = null;
         var count:Number = NaN;
         var baseAttrib:EquipBaseAttrib = null;
         arr = [];
         count = 0;
         if(_slot[0] != null && _slot[1] != null && _slot[3] != null && _slot[4] != null)
         {
            if(_slot[0].getSuitId() == _slot[1].getSuitId() && _slot[1].getSuitId() == _slot[3].getSuitId() && _slot[3].getSuitId() == _slot[4].getSuitId() && _slot[4].getSuitId() != 0)
            {
               suit = EquipFactory.getSuitEquip(_slot[0].getSuitId());
               arr = suit.getSuitAttrib();
               for each(baseAttrib in arr)
               {
                  if(baseAttrib.getAttribType() == attribType)
                  {
                     count += baseAttrib.getValue();
                  }
               }
            }
         }
         return count;
      }
      
      public function getAllMoveSpeed() : Number
      {
         var speed:Number = NaN;
         var i:* = undefined;
         speed = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               speed += _slot[i].getMoveSpeed();
            }
         }
         return speed + getSuitAllAttrib(EquipBaseAttribTypeConst.MOVESPEED);
      }
      
      public function getAllEquipSkill() : Array
      {
         var skillArr:Array = null;
         var i:* = undefined;
         skillArr = [];
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               if(_slot[i].getSkillAttrib() != 0)
               {
                  skillArr.push(_slot[i].getSkillAttrib());
               }
            }
         }
         return skillArr;
      }
      
      public function getAllMP() : Number
      {
         var mp:Number = NaN;
         var i:* = undefined;
         mp = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               mp += _slot[i].getMP();
            }
         }
         return mp + getSuitAllAttrib(EquipBaseAttribTypeConst.MP);
      }
      
      public function getAllAttack() : Number
      {
         var att:Number = NaN;
         var i:* = undefined;
         att = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               att += _slot[i].getAttack();
            }
         }
         return att + getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACK);
      }
      
      public function getAllDefense() : Number
      {
         var def:Number = NaN;
         var i:* = undefined;
         def = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               def += _slot[i].getDefense();
            }
         }
         return def + getSuitAllAttrib(EquipBaseAttribTypeConst.DEFENSE);
      }
      
      public function getAllSuitSkill() : Array
      {
         var suit:SuitEquipAttrib = null;
         var arr:Array = null;
         arr = [];
         if(_slot[0] != null && _slot[1] != null && _slot[3] != null && _slot[4] != null)
         {
            if(_slot[0].getSuitId() != 0 && _slot[0].getSuitId() == _slot[1].getSuitId() && _slot[1].getSuitId() == _slot[3].getSuitId() && _slot[3].getSuitId() == _slot[4].getSuitId())
            {
               suit = EquipFactory.getSuitEquip(_slot[0].getSuitId());
               arr = suit.getSuitSkill();
            }
         }
         return arr;
      }
      
      public function addToSlot(value:Equip, num:Number) : Boolean
      {
         if(_slot[num] == null)
         {
            _slot[num] = value;
            return true;
         }
         return false;
      }
      
      public function getAllHardValue() : Number
      {
         var hard:Number = NaN;
         var i:* = undefined;
         hard = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               hard += _slot[i].getHardValue();
            }
         }
         return hard + getSuitAllAttrib(EquipBaseAttribTypeConst.HARDVALUE);
      }
      
      public function getEquipFromSlot(num:Number) : Equip
      {
         if(_slot[num] != null)
         {
            return _slot[num];
         }
         return null;
      }
      
      public function getSuitStrength() : Number
      {
         var lv:int = 0;
         lv = 0;
         if(_slot[0] != null && _slot[1] != null && _slot[2] != null && _slot[3] != null && _slot[4] != null && _slot[5] != null)
         {
            if(_slot[0].getReinforceLevel() > 3 && _slot[1].getReinforceLevel() > 3 && _slot[3].getReinforceLevel() > 3 && _slot[4].getReinforceLevel() > 3 && _slot[2].getReinforceLevel() > 3 && _slot[5].getReinforceLevel() > 3)
            {
               if(_slot[0].getReinforceLevel() >= slot[1].getReinforceLevel())
               {
                  lv = int(slot[1].getReinforceLevel());
               }
               else
               {
                  lv = int(_slot[0].getReinforceLevel());
               }
               if(lv >= _slot[2].getReinforceLevel())
               {
                  lv = int(slot[2].getReinforceLevel());
               }
               if(lv >= _slot[5].getReinforceLevel())
               {
                  lv = int(slot[5].getReinforceLevel());
               }
               if(lv >= _slot[3].getReinforceLevel())
               {
                  lv = int(slot[3].getReinforceLevel());
               }
               if(lv >= _slot[4].getReinforceLevel())
               {
                  lv = int(slot[4].getReinforceLevel());
               }
            }
         }
         return lv;
      }
      
      public function getAllCrit() : Number
      {
         var crit:Number = NaN;
         var i:* = undefined;
         crit = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               crit += _slot[i].getCrit();
            }
         }
         return crit + getSuitAllAttrib(EquipBaseAttribTypeConst.CRIT);
      }
      
      public function getAllWhiteAttack() : Number
      {
         var watt:Number = NaN;
         var i:* = undefined;
         watt = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               watt += _slot[i].getWhiteAttack();
            }
         }
         return watt;
      }
      
      public function delSlot(num:Number) : Equip
      {
         var eq:Equip = null;
         if(_slot[num] != null)
         {
            eq = _slot[num];
            _slot[num] = null;
         }
         return eq;
      }
      
      public function getAllHP() : Number
      {
         var hp:Number = NaN;
         var i:* = undefined;
         hp = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               hp += _slot[i].getHP();
            }
         }
         return hp + getSuitAllAttrib(EquipBaseAttribTypeConst.HP);
      }
      
      public function getAllEquipNewSkill() : Array
      {
         var skillArr:Array = null;
         var i:* = undefined;
         skillArr = [];
         for(i = 0; i < 6; i++)
         {
            if(_slot[i] != null)
            {
               if(_slot[i].getNewSkill() != 0)
               {
                  skillArr.push(_slot[i].getNewSkill());
               }
            }
         }
         return skillArr;
      }
      
      public function slotToSlot() : *
      {
         var temp:Equip = null;
         if(_slot[2] == null)
         {
            _slot[2] = _slot[5];
            _slot[5] = null;
         }
         else if(_slot[5] == null)
         {
            _slot[5] = _slot[2];
            _slot[2] = null;
         }
         else
         {
            temp = _slot[2];
            _slot[2] = _slot[5];
            _slot[5] = temp;
         }
      }
      
      public function getAllAttackIgnoreDefense() : Number
      {
         var datt:Number = NaN;
         var i:* = undefined;
         datt = 0;
         for(i = 0; i < 6; i++)
         {
            if(who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(_slot[i] != null)
            {
               datt += _slot[i].getAttackIgnoreDefense();
            }
         }
         return datt + getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE);
      }
   }
}

