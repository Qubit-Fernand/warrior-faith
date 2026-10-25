package com.hotpoint.braveManIII.views.strengthenPanel
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.container.promptSlot;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.probability.*;
   import flash.display.MovieClip;
   import src.*;
   
   public class StrenthenPanlMove
   {
      
      public var pNum:VT;
      
      public function StrenthenPanlMove()
      {
         super();
         pNum = VT.createVT(100.153);
      }
      
      public static function creatMove() : StrenthenPanlMove
      {
         return new StrenthenPanlMove();
      }
      
      public function bagGemMoveToStr(param1:uint, param2:MovieClip, param3:Array, param4:*, param5:Bag) : void
      {
         var _loc9_:Gem = null;
         var _loc6_:uint = uint(param2.id);
         var _loc7_:Gem = param5.getGemFromBag(_loc6_);
         var _loc8_:uint = 0;
         while(_loc8_ < param3.length)
         {
            if(_loc7_.getType() == param3[_loc8_])
            {
               if(param4.getProp(param1) == -1)
               {
                  param4.addToSlot(param5.delGem(_loc6_,1),param1);
               }
               else
               {
                  _loc9_ = param4.getProp(param1);
                  if(_loc7_.getType() == _loc9_.getType())
                  {
                     if(_loc7_.getColor() == _loc9_.getColor())
                     {
                        param4.addToSlot(param5.delGem(_loc6_,1),param1);
                        if(param5.backGemBagNum() > 0)
                        {
                           param5.addGemBag(_loc9_);
                        }
                     }
                     else
                     {
                        param4.addToSlot(param5.delGem(_loc6_,1),param1);
                        if(param5.backGemBagNum() > 0)
                        {
                           param5.addGemBag(_loc9_);
                        }
                     }
                  }
                  else
                  {
                     param4.addToSlot(param5.delGem(_loc6_,1),param1);
                     if(param5.backGemBagNum() > 0)
                     {
                        param5.addGemBag(_loc9_);
                     }
                  }
               }
            }
            _loc8_++;
         }
      }
      
      public function gemBackToBag(param1:Gem, param2:Bag, param3:*, param4:int, param5:int = -1) : void
      {
         var _loc6_:* = param2.getGemBag();
         if(param2.isGemBagEmpty(param1))
         {
            param3.delSlot(param4);
            if(param5 == -1)
            {
               param2.addGemBag(param1);
            }
            else if(_loc6_[param5] == null)
            {
               param2.addToGemBag(param1,param5);
            }
            else
            {
               param2.addGemBag(param1);
            }
         }
      }
      
      public function equipMoveTostrenthen(param1:uint, param2:int, param3:Object, param4:Bag) : void
      {
         var _loc5_:Equip = null;
         if(param1 == 0)
         {
            if(param3.getProp(0) == -1)
            {
               param3.addToSlot(param4.delEquip(param2),0);
            }
            else if(param3.getPropEquip(0))
            {
               _loc5_ = param3.getProp(0);
               param3.addToSlot(param4.delEquip(param2),0);
               param4.addToEquipBag(_loc5_,param2);
            }
         }
      }
      
      public function equipMoveToBag(param1:Equip, param2:*, param3:Bag, param4:int = 0, param5:int = -1) : void
      {
         if(param5 != -1)
         {
            if(param3.getEquipFromBag(param5) == null)
            {
               param2.delSlot(param4);
               param3.addToEquipBag(param1,param5);
            }
            else
            {
               param2.delSlot(param4);
               param3.addEquipBag(param1);
            }
         }
         else
         {
            param2.delSlot(param4);
            param3.addEquipBag(param1);
         }
      }
      
      public function getEquipUpLevel(param1:Equip, param2:Gem) : Number
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
      
      public function getStrenthenGold(param1:Equip) : Number
      {
         return EquipProbabilityFactory.getGold(param1.getDropLevel(),param1.getReinforceLevel());
      }
      
      public function getMosicGold(param1:Equip, param2:Gem) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = 0;
         _loc3_ = int(GoldFactory.getMosaicGold(param1.getDropLevel()));
         if(param2.getColor() == 1)
         {
            _loc4_ = int(_loc3_ * 1);
         }
         if(param2.getColor() == 2)
         {
            _loc4_ = int(_loc3_ * 1);
         }
         if(param2.getColor() == 3)
         {
            _loc4_ = int(_loc3_ * 1);
         }
         return _loc4_;
      }
      
      public function getDeleteGold(param1:Equip) : Number
      {
         return int(GoldFactory.getDeleteGold(param1.getDropLevel()));
      }
      
      public function getEquipOuitGem(param1:Gem) : Number
      {
         return param1.getProbability();
      }
      
      public function getGemUpLevel(param1:Gem) : Number
      {
         return param1.getProbability();
      }
      
      public function getGemUpGold(param1:Gem) : Number
      {
         return GemProbabilityFactory.getGold(param1.getDropLevel(),param1.getStrengthenLevel());
      }
      
      public function getLuckGemPosition(param1:Gem) : Number
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
      
      public function setEquipPosition(param1:Gem, param2:Equip) : Number
      {
         return EquipPropertyFactory.getProperty(param2.getDropLevel(),param2.getPosition(),param1.getColor(),param2.getReinforceLevel());
      }
      
      private function setAddAttribType(param1:Number) : Number
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
            default:
               return 0;
         }
      }
      
      public function strengthenOver(param1:Number, param2:Equip, param3:Gem, param4:*, param5:MovieClip, param6:promptSlot, param7:MovieClip) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = 0;
         param7.visible = false;
         _loc8_ = Math.random() * pNum.getValue();
         trace("强化概率:" + param1,"随机数:" + _loc8_);
         if(_loc8_ < param1)
         {
            _loc9_ = setEquipPosition(param4.getProp(1),param4.getProp(0));
            _loc10_ = param2.getPosition();
            _loc10_ = Number(setAddAttribType(_loc10_));
            switch(_loc10_)
            {
               case EquipBaseAttribTypeConst.ATTACK:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACK,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.CRIT:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.CRIT,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.DEFENSE:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DEFENSE,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.DUCK:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DUCK,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.EXPERIENCE:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.EXPERIENCE,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.HP:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.HP,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.HPREGEN:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.HPREGEN,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.MOVESPEED:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MOVESPEED,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.MP:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MP,_loc9_);
                  break;
               case EquipBaseAttribTypeConst.MPREGEN:
                  param2.changeReinforce(param2.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MPREGEN,_loc9_);
            }
            param5.visible = true;
            dofunction(param5,1,param2.getFrame());
            param6.addToSlot(param2,0);
            stOver();
         }
         else
         {
            param5.visible = true;
            dofunction(param5,2,param2.getFrame());
            param6.addToSlot(param2,0);
            trace("强化失败");
         }
      }
      
      public function dofunction(param1:MovieClip, param2:Number, param3:Number = -1) : void
      {
         param1.visible = true;
         param1.gotoAndStop(param2);
         if(param3 != -1)
         {
            param1.prompt_1.gotoAndStop(param3);
         }
      }
      
      public function strengthenSkillOver(param1:int, param2:*, param3:Bag, param4:MovieClip, param5:promptSlot, param6:MovieClip) : void
      {
         var _loc8_:Gem = null;
         param6.visible = false;
         var _loc7_:Number = 0;
         _loc7_ = Math.random() * pNum.getValue();
         trace("强化技能成功率" + param1);
         trace("随机数" + _loc7_);
         _loc8_ = param2.getProp(0);
         if(_loc7_ < param1)
         {
            trace("强化技能石成功");
            _loc8_ = _loc8_.setUpGem();
            param4.visible = true;
            dofunction(param4,1,_loc8_.getFrame());
            param5.addToSlot(_loc8_,0);
            param3.addGemBag(_loc8_);
            param2.clearSlot();
            stOver();
         }
         else
         {
            trace("强化技能石失败");
            param4.visible = true;
            dofunction(param4,2,param2.getProp(0).getFrame());
            param5.addToSlot(_loc8_,0);
            param3.addGemBag(_loc8_);
            param2.clearSlot();
         }
      }
      
      public function strengthenHcOver(param1:int, param2:*, param3:Bag, param4:MovieClip, param5:promptSlot, param6:MovieClip) : void
      {
         var _loc8_:Gem = null;
         var _loc9_:Gem = null;
         var _loc10_:Gem = null;
         var _loc11_:Gem = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:Array = null;
         var _loc15_:uint = 0;
         var _loc7_:Number = 0;
         _loc7_ = 100;
         param6.visible = false;
         if(param3.backGemBagNum() > 0)
         {
            if(_loc7_ <= param1)
            {
               _loc9_ = param2.getProp(0);
               _loc10_ = param2.getProp(1);
               if(_loc9_.getUseLevel() >= _loc10_.getUseLevel())
               {
                  _loc11_ = _loc9_;
               }
               else
               {
                  _loc11_ = _loc10_;
               }
               switch(param2.getType(0))
               {
                  case 0:
                     _loc8_ = GemFactory.createGemByCompose(1,_loc9_.getStrengthenLevel() + 1,[]);
                     if(param3.isGemBagEmpty(_loc8_))
                     {
                        param3.addGemBag(_loc8_);
                     }
                     break;
                  case 1:
                     _loc8_ = GemFactory.createGemByCompose(2,_loc9_.getStrengthenLevel(),[]);
                     if(param3.isGemBagEmpty(_loc8_))
                     {
                        param3.addGemBag(_loc8_);
                     }
                     break;
                  case 3:
                     _loc12_ = [];
                     _loc13_ = [];
                     _loc14_ = [];
                     _loc13_ = param2.getProp(0).getGemAttrib();
                     _loc14_ = param2.getProp(1).getGemAttrib();
                     _loc15_ = 0;
                     while(_loc15_ < _loc13_.length)
                     {
                        _loc12_.push(_loc13_[_loc15_]);
                        _loc15_++;
                     }
                     _loc15_ = 0;
                     while(_loc15_ < _loc14_.length)
                     {
                        _loc12_.push(_loc14_[_loc15_]);
                        _loc15_++;
                     }
                     _loc8_ = GemFactory.createGemByCompose(2,_loc11_.getStrengthenLevel(),_loc12_);
                     if(param3.isGemBagEmpty(_loc8_))
                     {
                        param3.addGemBag(_loc8_);
                     }
                     _loc12_ = [];
               }
               param4.visible = true;
               dofunction(param4,5,_loc8_.getFrame());
               param5.addToSlot(_loc8_,0);
               param2.clearSlot();
               stOver();
            }
            else
            {
               trace("合成失败");
               trace("合成成功率为100");
            }
         }
         else
         {
            trace("背包满,合成失败");
            param3.addGemBag(param2.getProp(0));
            param3.addGemBag(param2.getProp(1));
            param2.clearSlot();
         }
      }
      
      public function strengthenXqOver(param1:int, param2:*, param3:MovieClip, param4:promptSlot, param5:MovieClip) : void
      {
         param5.visible = false;
         var _loc6_:Number = 0;
         _loc6_ = 100;
         if(_loc6_ <= param1)
         {
            trace("镶嵌成功");
            param2.getProp(0).setInGem(param2.getProp(1));
            param3.visible = true;
            dofunction(param3,7,param2.getProp(0).getFrame());
            param4.addToSlot(param2.getProp(0),0);
            stOver();
         }
      }
      
      public function strengthenWkOver(param1:int, param2:*, param3:Bag, param4:MovieClip, param5:promptSlot, param6:MovieClip) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Gem = null;
         param6.visible = false;
         _loc7_ = Math.random() * pNum.getValue();
         trace("成功率:" + param1);
         trace("随机数:" + _loc7_);
         if(_loc7_ < param1)
         {
            if(param3.backGemBagNum() > 0)
            {
               trace("挖空成功");
               _loc8_ = param2.getProp(0).getOutGem();
               param3.addEquipBag(param2.getProp(0));
               param3.addGemBag(_loc8_);
               param4.visible = true;
               dofunction(param4,3,param2.getProp(0).getFrame());
               param5.addToSlot(param2.getProp(0),0);
               param5.addToSlot(_loc8_,1);
            }
            else
            {
               trace("背包满了");
               param3.addEquipBag(param2.getProp(0));
            }
            stOver();
         }
         else
         {
            trace("挖空失败");
            _loc8_ = param2.getProp(0).getOutGem();
            param3.addEquipBag(param2.getProp(0));
            param4.visible = true;
            dofunction(param4,4,_loc8_.getFrame());
            param5.addToSlot(_loc8_,0);
         }
         param2.clearSlot();
      }
      
      public function strengThenOverMoveEquip(param1:Boolean, param2:*, param3:Bag, param4:Bag) : void
      {
         if(!param1)
         {
            equipMoveToBag(param2.getProp(0),param2,param3);
         }
         else
         {
            equipMoveToBag(param2.getProp(0),param2,param4);
         }
         param2.clearSlot();
      }
      
      public function stOver() : void
      {
         Main.player_1.LoadPlayerLvData();
         if(Main.player_2 != null)
         {
            Main.player_2.LoadPlayerLvData();
         }
      }
   }
}

