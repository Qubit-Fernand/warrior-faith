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
         var _loc1_:EquipSlot = new EquipSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            _loc1_._slot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get slot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._slot;
      }
      
      public function set slot(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._slot = param1;
      }
      
      public function getEquipFromSlot(param1:Number) : Equip
      {
         if(this._slot[param1] != null)
         {
            return this._slot[param1];
         }
         return null;
      }
      
      public function addToSlot(param1:Equip, param2:Number) : Boolean
      {
         if(this._slot[param2] == null)
         {
            this._slot[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function delSlot(param1:Number) : Equip
      {
         var _loc2_:Equip = null;
         if(this._slot[param1] != null)
         {
            _loc2_ = this._slot[param1];
            this._slot[param1] = null;
         }
         return _loc2_;
      }
      
      public function slotToSlot() : *
      {
         var _loc1_:Equip = null;
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
            _loc1_ = this._slot[2];
            this._slot[2] = this._slot[5];
            this._slot[5] = _loc1_;
         }
      }
      
      public function getAllHP() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(!((this._slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += this._slot[_loc2_].getHP();
               }
            }
         }
         return _loc1_ + this.getSuitAllAttrib(EquipBaseAttribTypeConst.HP);
      }
      
      public function getAllMP() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(!((this._slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += this._slot[_loc2_].getMP();
               }
            }
         }
         return _loc1_ + this.getSuitAllAttrib(EquipBaseAttribTypeConst.MP);
      }
      
      public function getAllAttack() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(!((this._slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += this._slot[_loc2_].getAttack();
               }
            }
         }
         return _loc1_ + this.getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACK);
      }
      
      public function getAllWhiteAttack() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               _loc1_ += this._slot[_loc2_].getWhiteAttack();
            }
         }
         return _loc1_;
      }
      
      public function getAllAttackIgnoreDefense() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(!((this._slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += this._slot[_loc2_].getAttackIgnoreDefense();
               }
            }
         }
         return _loc1_ + this.getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE);
      }
      
      public function getAllDefense() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(!((this._slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += this._slot[_loc2_].getDefense();
               }
            }
         }
         return _loc1_ + this.getSuitAllAttrib(EquipBaseAttribTypeConst.DEFENSE);
      }
      
      public function getAllMoveSpeed() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(!((this._slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += this._slot[_loc2_].getMoveSpeed();
               }
            }
         }
         return _loc1_ + this.getSuitAllAttrib(EquipBaseAttribTypeConst.MOVESPEED);
      }
      
      public function getAllCrit() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(!((this._slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += this._slot[_loc2_].getCrit();
               }
            }
         }
         return _loc1_ + this.getSuitAllAttrib(EquipBaseAttribTypeConst.CRIT);
      }
      
      public function getAllDuck() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(!((this._slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += this._slot[_loc2_].getDuck();
               }
            }
         }
         return _loc1_ + this.getSuitAllAttrib(EquipBaseAttribTypeConst.DUCK);
      }
      
      public function getAllHardValue() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(!((this._slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += this._slot[_loc2_].getHardValue();
               }
            }
         }
         return _loc1_ + this.getSuitAllAttrib(EquipBaseAttribTypeConst.HARDVALUE);
      }
      
      public function getAllEquipSkill() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:* = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(this.who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(this.who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(this._slot[_loc2_] != null)
            {
               if(this._slot[_loc2_].getSkillAttrib() != 0)
               {
                  _loc1_.push(this._slot[_loc2_].getSkillAttrib());
               }
            }
         }
         return _loc1_;
      }
      
      public function getAllEquipNewSkill() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:* = 0;
         while(_loc2_ < 8)
         {
            if(this._slot[_loc2_] != null)
            {
               if(this._slot[_loc2_].getNewSkill() != 0)
               {
                  _loc1_.push(this._slot[_loc2_].getNewSkill());
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getAllSuitSkill() : Array
      {
         var _loc1_:SuitEquipAttrib = null;
         var _loc2_:Array = [];
         if(this._slot[0] != null && this._slot[1] != null && this._slot[3] != null && this._slot[4] != null)
         {
            if(this._slot[0].getSuitId() != 0 && this._slot[0].getSuitId() == this._slot[1].getSuitId() && this._slot[1].getSuitId() == this._slot[3].getSuitId() && this._slot[3].getSuitId() == this._slot[4].getSuitId())
            {
               _loc1_ = EquipFactory.getSuitEquip(this._slot[0].getSuitId());
               _loc2_ = _loc1_.getSuitSkill();
            }
         }
         return _loc2_;
      }
      
      private function getSuitAllAttrib(param1:Number) : Number
      {
         var _loc2_:SuitEquipAttrib = null;
         var _loc5_:EquipBaseAttrib = null;
         var _loc3_:Array = [];
         var _loc4_:Number = 0;
         if(this._slot[0] != null && this._slot[1] != null && this._slot[3] != null && this._slot[4] != null)
         {
            if(this._slot[0].getSuitId() == this._slot[1].getSuitId() && this._slot[1].getSuitId() == this._slot[3].getSuitId() && this._slot[3].getSuitId() == this._slot[4].getSuitId() && this._slot[4].getSuitId() != 0)
            {
               _loc2_ = EquipFactory.getSuitEquip(this._slot[0].getSuitId());
               _loc3_ = _loc2_.getSuitAttrib();
               for each(_loc5_ in _loc3_)
               {
                  if(_loc5_.getAttribType() == param1)
                  {
                     _loc4_ += _loc5_.getValue();
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function getSuitStrength() : Number
      {
         var _loc1_:int = 0;
         if(this._slot[0] != null && this._slot[1] != null && this._slot[2] != null && this._slot[3] != null && this._slot[4] != null && this._slot[5] != null)
         {
            if(this._slot[0].getReinforceLevel() > 3 && this._slot[1].getReinforceLevel() > 3 && this._slot[3].getReinforceLevel() > 3 && this._slot[4].getReinforceLevel() > 3 && this._slot[2].getReinforceLevel() > 3 && this._slot[5].getReinforceLevel() > 3)
            {
               if(this._slot[0].getReinforceLevel() >= this.slot[1].getReinforceLevel())
               {
                  _loc1_ = int(this.slot[1].getReinforceLevel());
               }
               else
               {
                  _loc1_ = int(this._slot[0].getReinforceLevel());
               }
               if(_loc1_ >= this._slot[2].getReinforceLevel())
               {
                  _loc1_ = int(this.slot[2].getReinforceLevel());
               }
               if(_loc1_ >= this._slot[5].getReinforceLevel())
               {
                  _loc1_ = int(this.slot[5].getReinforceLevel());
               }
               if(_loc1_ >= this._slot[3].getReinforceLevel())
               {
                  _loc1_ = int(this.slot[3].getReinforceLevel());
               }
               if(_loc1_ >= this._slot[4].getReinforceLevel())
               {
                  _loc1_ = int(this.slot[4].getReinforceLevel());
               }
            }
         }
         return _loc1_;
      }
   }
}

