package com.hotpoint.braveManIII.views.strPanel
{
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.repository.probability.*;
   
   public class StrData
   {
      
      public function StrData()
      {
         super();
      }
      
      public static function getEquipOrSkillGem() : Array
      {
         var _loc1_:Array = [];
         if(StrPanel.state == 0)
         {
            if(StrPanel.stateTow == 0)
            {
               _loc1_ = StrPanel.data.getBag().getEquipAndPoint();
            }
            else if(StrPanel.stateTow == 1)
            {
               _loc1_ = getStrGem();
            }
         }
         else if(StrPanel.state == 1)
         {
            if(StrPanel.stateTow == 0)
            {
               _loc1_ = StrPanel.data.getBag().getGemByType(4);
            }
            else if(StrPanel.stateTow == 1)
            {
               _loc1_ = getStrGem();
            }
         }
         return _loc1_;
      }
      
      private static function getStrGem() : Array
      {
         var _loc6_:uint = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         if(StrPanel.state == 0)
         {
            _loc4_ = StrPanel.data.getBag().getGemByType(1);
            _loc5_ = StrPanel.data.getBag().getGemByType(2);
         }
         else if(StrPanel.state == 1)
         {
            _loc4_ = StrPanel.data.getBag().getGemByType(0);
            _loc5_ = StrPanel.data.getBag().getGemByType(2);
         }
         if(_loc4_ != null)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_[0].length)
            {
               _loc2_.push(_loc4_[0][_loc6_]);
               _loc3_.push(_loc4_[1][_loc6_]);
               _loc6_++;
            }
         }
         if(_loc5_ != null)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_[0].length)
            {
               _loc2_.push(_loc5_[0][_loc6_]);
               _loc3_.push(_loc5_[1][_loc6_]);
               _loc6_++;
            }
         }
         _loc1_ = [_loc2_,_loc3_];
         if(_loc2_.length < 1)
         {
            return null;
         }
         return _loc1_;
      }
      
      public static function getGemUpLevel(param1:Gem) : Number
      {
         return param1.getProbability();
      }
      
      public static function getEquipUpLevel(param1:Equip, param2:Gem = null) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = Number(EquipProbabilityFactory.getPorbabillty(param1.getDropLevel(),param1.getReinforceLevel()));
         var _loc5_:Number = param2.getUseLevel() - param1.getReinforceLevel();
         if(param2.getUseLevel() < 10)
         {
            _loc3_ = _loc4_ + _loc5_;
         }
         else
         {
            _loc3_ = _loc4_ + _loc5_ + 2;
         }
         return _loc3_;
      }
      
      public static function getLuckGemPosition(param1:Gem) : Number
      {
         if(param1.getType() == 2)
         {
            if(param1.getDropLevel() == 92315)
            {
               trace("品质1幸运宝石");
               return 10;
            }
            if(param1.getDropLevel() == 92316)
            {
               trace("品质2幸运宝石");
               return 50;
            }
            if(param1.getDropLevel() == 92317)
            {
               trace("品质3幸运宝石");
               return 100;
            }
         }
         return 0;
      }
      
      public static function setEquipPosition(param1:Gem, param2:Equip) : Number
      {
         return EquipPropertyFactory.getProperty(param2.getDropLevel(),param2.getPosition(),param1.getColor(),param2.getReinforceLevel());
      }
      
      private static function setAddAttribType(param1:Number) : Number
      {
         switch(param1)
         {
            case 1:
               return 2;
            case 2:
               return 1;
            case 3:
               return 6;
            case 4:
               return 5;
            case 5:
               return 3;
            case 6:
               return 3;
            case 7:
               return 3;
            case 8:
               return 4;
            case 9:
               return 3;
            default:
               return 0;
         }
      }
      
      public static function strengthenOver(param1:Equip, param2:Gem) : void
      {
         var _loc3_:Number = setEquipPosition(param2,param1);
         var _loc4_:Number = param1.getPosition();
         _loc4_ = Number(setAddAttribType(_loc4_));
         switch(_loc4_)
         {
            case 3:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACK,_loc3_);
               break;
            case 10:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE,_loc3_);
               break;
            case 5:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.CRIT,_loc3_);
               break;
            case 4:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DEFENSE,_loc3_);
               break;
            case 6:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DUCK,_loc3_);
               break;
            case 9:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACK,_loc3_);
               break;
            case 1:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.HP,_loc3_);
               break;
            case 11:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.HPREGEN,_loc3_);
               break;
            case 7:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MOVESPEED,_loc3_);
               break;
            case 2:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MP,_loc3_);
               break;
            case 12:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MPREGEN,_loc3_);
               break;
            case 8:
               param1.changeReinforce(param1.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DEFENSE,_loc3_);
         }
      }
      
      public static function strengthenSkillOver(param1:Gem) : Gem
      {
         return param1.setUpGem();
      }
      
      public static function getStrenthenGold(param1:Equip) : Number
      {
         return EquipProbabilityFactory.getGold(param1.getDropLevel(),param1.getReinforceLevel());
      }
      
      public static function getGemUpGold(param1:Gem) : Number
      {
         return GemProbabilityFactory.getGold(param1.getDropLevel(),param1.getStrengthenLevel());
      }
      
      public function getStrenthenGold(param1:Equip) : Number
      {
         return EquipProbabilityFactory.getGold(param1.getDropLevel(),param1.getReinforceLevel());
      }
   }
}

