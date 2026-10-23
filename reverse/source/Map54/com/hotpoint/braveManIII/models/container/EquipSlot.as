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
         var _loc1_:EquipSlot = new EquipSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 13)
         {
            _loc1_._slot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get slot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _slot;
      }
      
      public function set slot(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _slot = param1;
      }
      
      public function getEquipFromSlot(param1:Number) : Equip
      {
         if(_slot[param1] != null)
         {
            return _slot[param1];
         }
         return null;
      }
      
      public function addToSlot(param1:Equip, param2:Number) : Boolean
      {
         if(_slot[param2] == null)
         {
            _slot[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function delSlot(param1:Number) : Equip
      {
         var _loc2_:Equip = null;
         if(_slot[param1] != null)
         {
            _loc2_ = _slot[param1];
            _slot[param1] = null;
         }
         return _loc2_;
      }
      
      public function slotToSlot() : *
      {
         var _loc1_:Equip = null;
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
            _loc1_ = _slot[2];
            _slot[2] = _slot[5];
            _slot[5] = _loc1_;
         }
      }
      
      public function getAllHP() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getHP();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.HP);
      }
      
      public function getAllMP() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getMP();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.MP);
      }
      
      public function getAllAttack() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getAttack();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACK);
      }
      
      public function getAllWhiteAttack() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               _loc1_ += _slot[_loc2_].getWhiteAttack();
            }
         }
         return _loc1_;
      }
      
      public function getAllAttackIgnoreDefense() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getAttackIgnoreDefense();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE);
      }
      
      public function getAllDefense() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getDefense();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.DEFENSE);
      }
      
      public function getAllMoveSpeed() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getMoveSpeed();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.MOVESPEED);
      }
      
      public function getAllCrit() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getCrit();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.CRIT);
      }
      
      public function getAllDuck() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getDuck();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.DUCK);
      }
      
      public function getAllHardValue() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getHardValue();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.HARDVALUE);
      }
      
      public function getAllMOKANG() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getMOKANG();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.MOKANG);
      }
      
      public function getAllPOMO() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(!((_slot[_loc2_] as Equip).getRemainingTime() <= 0))
               {
                  _loc1_ += _slot[_loc2_].getPOMO();
               }
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.POMO);
      }
      
      public function getAllEquipSkill() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:* = 0;
         for(; _loc2_ < 13; _loc2_++)
         {
            if(who.skinNum == 0)
            {
               if(_loc2_ == 5)
               {
                  continue;
               }
            }
            else if(who.skinNum == 1)
            {
               if(_loc2_ == 2)
               {
                  continue;
               }
            }
            if(_slot[_loc2_] != null)
            {
               if(_slot[_loc2_].getSkillAttrib() != 0)
               {
                  _loc1_.push(_slot[_loc2_].getSkillAttrib());
               }
            }
         }
         return _loc1_;
      }
      
      public function getAllEquipNewSkill() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:* = 0;
         while(_loc2_ < 13)
         {
            if(_slot[_loc2_] != null)
            {
               if(_slot[_loc2_].getNewSkill() != 0)
               {
                  _loc1_.push(_slot[_loc2_].getNewSkill());
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
         if(_slot[0] != null && _slot[1] != null && _slot[3] != null && _slot[4] != null)
         {
            if(_slot[0].getSuitId() != 0 && _slot[0].getSuitId() == _slot[1].getSuitId() && _slot[1].getSuitId() == _slot[3].getSuitId() && _slot[3].getSuitId() == _slot[4].getSuitId())
            {
               _loc1_ = EquipFactory.getSuitEquip(_slot[0].getSuitId());
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
         if(_slot[0] != null && _slot[1] != null && _slot[3] != null && _slot[4] != null)
         {
            if(_slot[0].getSuitId() == _slot[1].getSuitId() && _slot[1].getSuitId() == _slot[3].getSuitId() && _slot[3].getSuitId() == _slot[4].getSuitId() && _slot[4].getSuitId() != 0)
            {
               _loc2_ = EquipFactory.getSuitEquip(_slot[0].getSuitId());
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
         if(_slot[0] != null && _slot[1] != null && _slot[2] != null && _slot[3] != null && _slot[4] != null && _slot[5] != null)
         {
            if(_slot[0].getReinforceLevel() > 3 && _slot[1].getReinforceLevel() > 3 && _slot[3].getReinforceLevel() > 3 && _slot[4].getReinforceLevel() > 3 && _slot[2].getReinforceLevel() > 3 && _slot[5].getReinforceLevel() > 3)
            {
               if(_slot[0].getReinforceLevel() >= slot[1].getReinforceLevel())
               {
                  _loc1_ = int(slot[1].getReinforceLevel());
               }
               else
               {
                  _loc1_ = int(_slot[0].getReinforceLevel());
               }
               if(_loc1_ >= _slot[2].getReinforceLevel())
               {
                  _loc1_ = int(slot[2].getReinforceLevel());
               }
               if(_loc1_ >= _slot[5].getReinforceLevel())
               {
                  _loc1_ = int(slot[5].getReinforceLevel());
               }
               if(_loc1_ >= _slot[3].getReinforceLevel())
               {
                  _loc1_ = int(slot[3].getReinforceLevel());
               }
               if(_loc1_ >= _slot[4].getReinforceLevel())
               {
                  _loc1_ = int(slot[4].getReinforceLevel());
               }
            }
         }
         return _loc1_;
      }
      
      public function testAllEquip() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         loop0:
         while(_loc1_ < 13)
         {
            _loc2_ = 0;
            while(true)
            {
               if(_loc2_ >= arr.length)
               {
                  _loc1_++;
                  continue loop0;
               }
               if(Boolean(_slot[_loc1_]) && (_slot[_loc1_] as Equip).getId() == arr[_loc2_])
               {
                  break;
               }
               _loc2_++;
            }
            return true;
         }
         return false;
      }
   }
}

