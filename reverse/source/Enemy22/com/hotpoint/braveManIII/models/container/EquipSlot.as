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
      
      public function EquipSlot()
      {
         super();
      }
      
      public static function createEquipSlot() : EquipSlot
      {
         var es:EquipSlot = new EquipSlot();
         for(var i:int = 0; i < 8; i++)
         {
            es._slot[i] = null;
         }
         return es;
      }
      
      public function get slot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._slot;
      }
      
      public function set slot(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._slot = value;
      }
      
      public function getEquipFromSlot(num:Number) : Equip
      {
         if(this._slot[num] != null)
         {
            return this._slot[num];
         }
         return null;
      }
      
      public function addToSlot(value:Equip, num:Number) : Boolean
      {
         if(this._slot[num] == null)
         {
            this._slot[num] = value;
            return true;
         }
         return false;
      }
      
      public function delSlot(num:Number) : Equip
      {
         var eq:Equip = null;
         if(this._slot[num] != null)
         {
            eq = this._slot[num];
            this._slot[num] = null;
         }
         return eq;
      }
      
      public function slotToSlot() : *
      {
         var temp:Equip = null;
         if(this._slot[2] == null)
         {
            this._slot[2] = this._slot[5];
            this._slot[5] = null;
         }
         else if(this._slot[5] == null)
         {
            this._slot[5] = this._slot[2];
            this._slot[2] = null;
         }
         else
         {
            temp = this._slot[2];
            this._slot[2] = this._slot[5];
            this._slot[5] = temp;
         }
      }
      
      public function getAllHP() : Number
      {
         var hp:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(!((this._slot[i] as Equip).getRemainingTime() <= 0))
               {
                  hp += this._slot[i].getHP();
               }
            }
         }
         return hp + this.getSuitAllAttrib(EquipBaseAttribTypeConst.HP);
      }
      
      public function getAllMP() : Number
      {
         var mp:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(!((this._slot[i] as Equip).getRemainingTime() <= 0))
               {
                  mp += this._slot[i].getMP();
               }
            }
         }
         return mp + this.getSuitAllAttrib(EquipBaseAttribTypeConst.MP);
      }
      
      public function getAllAttack() : Number
      {
         var att:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(!((this._slot[i] as Equip).getRemainingTime() <= 0))
               {
                  att += this._slot[i].getAttack();
               }
            }
         }
         return att + this.getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACK);
      }
      
      public function getAllWhiteAttack() : Number
      {
         var watt:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               watt += this._slot[i].getWhiteAttack();
            }
         }
         return watt;
      }
      
      public function getAllAttackIgnoreDefense() : Number
      {
         var datt:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(!((this._slot[i] as Equip).getRemainingTime() <= 0))
               {
                  datt += this._slot[i].getAttackIgnoreDefense();
               }
            }
         }
         return datt + this.getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE);
      }
      
      public function getAllDefense() : Number
      {
         var def:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(!((this._slot[i] as Equip).getRemainingTime() <= 0))
               {
                  def += this._slot[i].getDefense();
               }
            }
         }
         return def + this.getSuitAllAttrib(EquipBaseAttribTypeConst.DEFENSE);
      }
      
      public function getAllMoveSpeed() : Number
      {
         var speed:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(!((this._slot[i] as Equip).getRemainingTime() <= 0))
               {
                  speed += this._slot[i].getMoveSpeed();
               }
            }
         }
         return speed + this.getSuitAllAttrib(EquipBaseAttribTypeConst.MOVESPEED);
      }
      
      public function getAllCrit() : Number
      {
         var crit:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(!((this._slot[i] as Equip).getRemainingTime() <= 0))
               {
                  crit += this._slot[i].getCrit();
               }
            }
         }
         return crit + this.getSuitAllAttrib(EquipBaseAttribTypeConst.CRIT);
      }
      
      public function getAllDuck() : Number
      {
         var duck:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(!((this._slot[i] as Equip).getRemainingTime() <= 0))
               {
                  duck += this._slot[i].getDuck();
               }
            }
         }
         return duck + this.getSuitAllAttrib(EquipBaseAttribTypeConst.DUCK);
      }
      
      public function getAllHardValue() : Number
      {
         var hard:Number = 0;
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(!((this._slot[i] as Equip).getRemainingTime() <= 0))
               {
                  hard += this._slot[i].getHardValue();
               }
            }
         }
         return hard + this.getSuitAllAttrib(EquipBaseAttribTypeConst.HARDVALUE);
      }
      
      public function getAllEquipSkill() : Array
      {
         var skillArr:Array = [];
         for(var i:* = 0; i < 8; i++)
         {
            if(this.who.skinNum == 0)
            {
               if(i == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(i == 2)
               {
                  continue;
               }
            }
            if(this._slot[i] != null)
            {
               if(this._slot[i].getSkillAttrib() != 0)
               {
                  skillArr.push(this._slot[i].getSkillAttrib());
               }
            }
         }
         return skillArr;
      }
      
      public function getAllEquipNewSkill() : Array
      {
         var skillArr:Array = [];
         for(var i:* = 0; i < 8; i++)
         {
            if(this._slot[i] != null)
            {
               if(this._slot[i].getNewSkill() != 0)
               {
                  skillArr.push(this._slot[i].getNewSkill());
               }
            }
         }
         return skillArr;
      }
      
      public function getAllSuitSkill() : Array
      {
         var suit:SuitEquipAttrib = null;
         var arr:Array = [];
         if(this._slot[0] != null && this._slot[1] != null && this._slot[3] != null && this._slot[4] != null)
         {
            if(this._slot[0].getSuitId() != 0 && this._slot[0].getSuitId() == this._slot[1].getSuitId() && this._slot[1].getSuitId() == this._slot[3].getSuitId() && this._slot[3].getSuitId() == this._slot[4].getSuitId())
            {
               suit = EquipFactory.getSuitEquip(this._slot[0].getSuitId());
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
         if(this._slot[0] != null && this._slot[1] != null && this._slot[3] != null && this._slot[4] != null)
         {
            if(this._slot[0].getSuitId() == this._slot[1].getSuitId() && this._slot[1].getSuitId() == this._slot[3].getSuitId() && this._slot[3].getSuitId() == this._slot[4].getSuitId() && this._slot[4].getSuitId() != 0)
            {
               suit = EquipFactory.getSuitEquip(this._slot[0].getSuitId());
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
         if(this._slot[0] != null && this._slot[1] != null && this._slot[2] != null && this._slot[3] != null && this._slot[4] != null && this._slot[5] != null)
         {
            if(this._slot[0].getReinforceLevel() > 3 && this._slot[1].getReinforceLevel() > 3 && this._slot[3].getReinforceLevel() > 3 && this._slot[4].getReinforceLevel() > 3 && this._slot[2].getReinforceLevel() > 3 && this._slot[5].getReinforceLevel() > 3)
            {
               if(this._slot[0].getReinforceLevel() >= this.slot[1].getReinforceLevel())
               {
                  lv = int(this.slot[1].getReinforceLevel());
               }
               else
               {
                  lv = int(this._slot[0].getReinforceLevel());
               }
               if(lv >= this._slot[2].getReinforceLevel())
               {
                  lv = int(this.slot[2].getReinforceLevel());
               }
               if(lv >= this._slot[5].getReinforceLevel())
               {
                  lv = int(this.slot[5].getReinforceLevel());
               }
               if(lv >= this._slot[3].getReinforceLevel())
               {
                  lv = int(this.slot[3].getReinforceLevel());
               }
               if(lv >= this._slot[4].getReinforceLevel())
               {
                  lv = int(this.slot[4].getReinforceLevel());
               }
            }
         }
         return lv;
      }
   }
}

