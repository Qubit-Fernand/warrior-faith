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
         var _loc1_:EquipSlot = null;
         var _loc2_:int = 0;
         _loc1_ = new EquipSlot();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_._slot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function set slot(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _slot = param1;
      }
      
      public function getAllDuck() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
               _loc1_ += _slot[_loc2_].getDuck();
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.DUCK);
      }
      
      public function get slot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _slot;
      }
      
      private function getSuitAllAttrib(param1:Number) : Number
      {
         var _loc2_:SuitEquipAttrib = null;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:EquipBaseAttrib = null;
         _loc3_ = [];
         _loc4_ = 0;
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
      
      public function getAllMoveSpeed() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
               _loc1_ += _slot[_loc2_].getMoveSpeed();
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.MOVESPEED);
      }
      
      public function getAllEquipSkill() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:* = undefined;
         _loc1_ = [];
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
      
      public function getAllMP() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
               _loc1_ += _slot[_loc2_].getMP();
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.MP);
      }
      
      public function getAllAttack() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
               _loc1_ += _slot[_loc2_].getAttack();
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACK);
      }
      
      public function getAllDefense() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
               _loc1_ += _slot[_loc2_].getDefense();
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.DEFENSE);
      }
      
      public function getAllSuitSkill() : Array
      {
         var _loc1_:SuitEquipAttrib = null;
         var _loc2_:Array = null;
         _loc2_ = [];
         if(_slot[0] != null && _slot[1] != null && _slot[3] != null && _slot[4] != null)
         {
            if(_slot[0].getSuitId() == _slot[1].getSuitId() && _slot[1].getSuitId() == _slot[3].getSuitId() && _slot[3].getSuitId() == _slot[4].getSuitId())
            {
               _loc1_ = EquipFactory.getSuitEquip(_slot[0].getSuitId());
               _loc2_ = _loc1_.getSuitSkill();
            }
         }
         return _loc2_;
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
      
      public function getAllHardValue() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
               _loc1_ += _slot[_loc2_].getHardValue();
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.HARDVALUE);
      }
      
      public function getEquipFromSlot(param1:Number) : Equip
      {
         if(_slot[param1] != null)
         {
            return _slot[param1];
         }
         return null;
      }
      
      public function getAllCrit() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
               _loc1_ += _slot[_loc2_].getCrit();
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.CRIT);
      }
      
      public function getAllWhiteAttack() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
      
      public function getAllHP() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
               _loc1_ += _slot[_loc2_].getHP();
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.HP);
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
      
      public function getAllAttackIgnoreDefense() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         for(; _loc2_ < 6; _loc2_++)
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
               _loc1_ += _slot[_loc2_].getAttackIgnoreDefense();
            }
         }
         return _loc1_ + getSuitAllAttrib(EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE);
      }
   }
}

