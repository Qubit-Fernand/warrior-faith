package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.equip.*;
   import flash.utils.*;
   
   public class EquipSlot
   {
      
      public var who:PlayerData;
      
      private var _slot:Array = new Array();
      
      internal var arr:Array = [14573,14597,14549,14525,14419,14424,14429];
      
      public function EquipSlot()
      {
         super();
      }
      
      public static function createEquipSlot() : EquipSlot
      {
         var es:EquipSlot = new EquipSlot();
         for(var i:int = 0; i < 13; i++)
         {
            es._slot[i] = null;
         }
         return es;
      }
      
      public function get slot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _slot;
      }
      
      public function set slot(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _slot = value;
      }
      
      public function getEquipFromSlot(num:Number) : Equip
      {
         if(_slot[num] != null)
         {
            return _slot[num];
         }
         return null;
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
      
      public function getAllHP() : Number
      {
         var hp:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  hp += _slot[i].getHP();
               }
            }
         }
         return hp + getSuitAllAttrib(EquipBaseAttribTypeConst.HP);
      }
      
      public function getAllMP() : Number
      {
         var mp:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  mp += _slot[i].getMP();
               }
            }
         }
         return mp + getSuitAllAttrib(EquipBaseAttribTypeConst.MP);
      }
      
      public function getAllAttack() : Number
      {
         var att:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  att += _slot[i].getAttack();
               }
            }
         }
         return att + getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACK);
      }
      
      public function getAllWhiteAttack() : Number
      {
         var watt:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
      
      public function getAllAttackIgnoreDefense() : Number
      {
         var datt:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  datt += _slot[i].getAttackIgnoreDefense();
               }
            }
         }
         return datt + getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE);
      }
      
      public function getAllDefense() : Number
      {
         var def:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  def += _slot[i].getDefense();
               }
            }
         }
         return def + getSuitAllAttrib(EquipBaseAttribTypeConst.DEFENSE);
      }
      
      public function getAllMoveSpeed() : Number
      {
         var speed:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  speed += _slot[i].getMoveSpeed();
               }
            }
         }
         return speed + getSuitAllAttrib(EquipBaseAttribTypeConst.MOVESPEED);
      }
      
      public function getAllCrit() : Number
      {
         var crit:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  crit += _slot[i].getCrit();
               }
            }
         }
         return crit + getSuitAllAttrib(EquipBaseAttribTypeConst.CRIT);
      }
      
      public function getAllDuck() : Number
      {
         var duck:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  duck += _slot[i].getDuck();
               }
            }
         }
         return duck + getSuitAllAttrib(EquipBaseAttribTypeConst.DUCK);
      }
      
      public function getAllHardValue() : Number
      {
         var hard:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  hard += _slot[i].getHardValue();
               }
            }
         }
         return hard + getSuitAllAttrib(EquipBaseAttribTypeConst.HARDVALUE);
      }
      
      public function getAllMOKANG() : Number
      {
         var mokang:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  mokang += _slot[i].getMOKANG();
               }
            }
         }
         return mokang + getSuitAllAttrib(EquipBaseAttribTypeConst.MOKANG);
      }
      
      public function getAllPOMO() : Number
      {
         var pomo:Number = 0;
         for(var i:* = 0; i < 13; i++)
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
               if((_slot[i] as Equip).getRemainingTime() > 0)
               {
                  pomo += _slot[i].getPOMO();
               }
            }
         }
         return pomo + getSuitAllAttrib(EquipBaseAttribTypeConst.POMO);
      }
      
      public function getAllEquipSkill() : Array
      {
         var skillArr:Array = [];
         for(var i:* = 0; i < 13; i++)
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
      
      public function getAllEquipNewSkill() : Array
      {
         var skillArr:Array = [];
         for(var i:* = 0; i < 13; i++)
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
      
      public function getAllSuitSkill() : Array
      {
         var suit:SuitEquipAttrib = null;
         var arr:Array = [];
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
      
      private function getSuitAllAttrib(attribType:Number) : Number
      {
         var suit:SuitEquipAttrib = null;
         var baseAttrib:EquipBaseAttrib = null;
         var arr:Array = [];
         var count:Number = 0;
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
      
      public function getSuitStrength() : Number
      {
         var lv:int = 0;
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
      
      public function testAllEquip() : Boolean
      {
         var j:int = 0;
         loop0:
         for(var i:int = 0; i < 13; )
         {
            j = 0;
            while(true)
            {
               if(j >= arr.length)
               {
                  i++;
                  continue loop0;
               }
               if(Boolean(_slot[i]) && (_slot[i] as Equip).getId() == arr[j])
               {
                  break;
               }
               j++;
            }
            return true;
         }
         return false;
      }
   }
}

