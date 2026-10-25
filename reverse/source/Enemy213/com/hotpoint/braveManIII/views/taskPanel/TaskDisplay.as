package com.hotpoint.braveManIII.views.taskPanel
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.Task;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import src.*;
   
   public class TaskDisplay
   {
      
      public function TaskDisplay()
      {
         super();
      }
      
      public function getAllId(param1:Task) : Array
      {
         var _loc6_:uint = 0;
         var _loc2_:Number = param1.getId();
         var _loc3_:Array = [];
         var _loc4_:Array = param1.getEnemyName();
         var _loc5_:Array = param1.getGoodsId();
         if(_loc4_[0] is VT)
         {
            if(_loc4_[0].getValue() != -1)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc4_.length)
               {
                  _loc3_.push(_loc4_[_loc6_]);
                  _loc6_++;
               }
            }
         }
         else if(_loc4_[0] != -1)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc3_.push(_loc4_[_loc6_]);
               _loc6_++;
            }
         }
         if(_loc5_[0].getValue() != -1)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               if(_loc2_ != 210002 && TaskData.isTsTask(_loc2_) == false)
               {
                  _loc3_.push(QuestFactory.getName(_loc5_[_loc6_].getValue()));
               }
               else
               {
                  _loc3_.push(OtherFactory.getName(_loc5_[_loc6_].getValue()));
               }
               _loc6_++;
            }
         }
         return _loc3_;
      }
      
      public function getAllNum(param1:Task) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = param1.getEnemyNum();
         var _loc4_:Array = param1.getGoodsNum();
         if(_loc3_[0].getValue() != -1)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc2_.push(_loc3_[_loc5_].getValue());
               _loc5_++;
            }
         }
         if(_loc4_[0].getValue() != -1)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc2_.push(_loc4_[_loc5_].getValue());
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      public function getAllNuming(param1:Task) : Array
      {
         var _loc7_:uint = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = param1.getEnemyId();
         var _loc4_:Array = param1.getGoodsId();
         var _loc5_:Array = param1.getEenemyedNum();
         var _loc6_:Array = param1.getGoodsedNum();
         _loc7_ = 0;
         while(_loc7_ < _loc6_.length)
         {
            if(_loc6_[_loc7_] is VT)
            {
               break;
            }
            _loc6_[_loc7_] = VT.createVT(_loc6_[_loc7_]);
            _loc7_++;
         }
         if(_loc3_[0].getValue() != -1)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc2_.push(_loc5_[_loc7_].getValue());
               _loc7_++;
            }
         }
         if(_loc4_[0].getValue() != -1 && _loc6_.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc2_.push(_loc6_[_loc7_].getValue());
               _loc7_++;
            }
         }
         return _loc2_;
      }
      
      public function getExp(param1:Task) : Number
      {
         return param1.getAwardExp();
      }
      
      public function getGold(param1:Task) : Number
      {
         return param1.getAwardGold();
      }
      
      public function getAwId(param1:Task) : Array
      {
         return param1.getAwardId();
      }
      
      public function getAwType(param1:Task) : Array
      {
         return param1.getAwardType();
      }
      
      public function getAwNum(param1:Task) : Array
      {
         return param1.getAwardNum();
      }
      
      public function getAwGl(param1:Task) : Array
      {
         return param1.getAwardGl();
      }
      
      public function getAwPs(param1:Task) : Number
      {
         return param1.getAwardPs();
      }
      
      public function awObj(param1:Task) : Array
      {
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:Array = param1.getAwardId();
         var _loc3_:Array = param1.getAwardType();
         var _loc4_:Array = [];
         if(_loc2_[0].getValue() != -1 && _loc3_[0].getValue() != -1)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               if(_loc2_[_loc5_].getValue() != -1)
               {
                  _loc6_ = Number(_loc2_[_loc5_].getValue());
                  _loc7_ = Number(_loc3_[_loc5_].getValue());
                  _loc8_ = 0;
                  if(_loc7_ == 1)
                  {
                     _loc4_.push(EquipFactory.createEquipByID(_loc6_));
                  }
                  else if(_loc7_ == 2)
                  {
                     _loc4_.push(GemFactory.creatGemById(_loc6_));
                  }
                  else if(_loc7_ == 3)
                  {
                     _loc4_.push(SuppliesFactory.getSuppliesById(_loc6_));
                  }
                  else if(_loc7_ == 4)
                  {
                     _loc4_.push(OtherFactory.creatOther(_loc6_));
                  }
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public function overAward(param1:Task, param2:Array) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:Array = this.addJl(param1,param2);
         if(_loc3_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               this.howAward(_loc3_[_loc4_]);
               _loc4_++;
            }
         }
      }
      
      public function addJl(param1:Task, param2:Array) : Array
      {
         var _loc11_:uint = 0;
         var _loc12_:Equip = null;
         var _loc13_:Gem = null;
         var _loc14_:Supplies = null;
         var _loc15_:Otherobj = null;
         var _loc3_:Array = param1.getAwardId();
         var _loc4_:Array = param1.getAwardType();
         var _loc5_:Array = param1.getAwardNum();
         var _loc6_:Array = param1.getAwardGl();
         var _loc7_:Array = [];
         var _loc8_:Array = [];
         var _loc9_:Array = [];
         var _loc10_:uint = 0;
         while(_loc10_ < _loc3_.length)
         {
            if(_loc3_[_loc10_].getValue() != -1 && int(param2[_loc10_].getValue()) <= _loc6_[_loc10_].getValue())
            {
               _loc11_ = 0;
               while(_loc11_ < _loc5_[_loc10_].getValue())
               {
                  if(_loc4_[_loc10_].getValue() == 1)
                  {
                     _loc12_ = EquipFactory.createEquipByID(_loc3_[_loc10_].getValue());
                     _loc7_.push(_loc12_);
                  }
                  else if(_loc4_[_loc10_].getValue() == 2)
                  {
                     _loc13_ = GemFactory.creatGemById(_loc3_[_loc10_].getValue());
                     _loc7_.push(_loc13_);
                  }
                  else if(_loc4_[_loc10_].getValue() == 3)
                  {
                     _loc14_ = SuppliesFactory.getSuppliesById(_loc3_[_loc10_].getValue());
                     _loc7_.push(_loc14_);
                  }
                  else if(_loc4_[_loc10_].getValue() == 4)
                  {
                     _loc15_ = OtherFactory.creatOther(_loc3_[_loc10_].getValue());
                     _loc7_.push(_loc15_);
                  }
                  _loc11_++;
               }
               if(_loc4_[_loc10_].getValue() == 1)
               {
                  _loc12_ = EquipFactory.createEquipByID(_loc3_[_loc10_].getValue());
                  _loc8_.push(_loc12_);
               }
               else if(_loc4_[_loc10_].getValue() == 2)
               {
                  _loc13_ = GemFactory.creatGemById(_loc3_[_loc10_].getValue());
                  _loc8_.push(_loc13_);
               }
               else if(_loc4_[_loc10_].getValue() == 3)
               {
                  _loc14_ = SuppliesFactory.getSuppliesById(_loc3_[_loc10_].getValue());
                  _loc8_.push(_loc14_);
               }
               else if(_loc4_[_loc10_].getValue() == 4)
               {
                  _loc15_ = OtherFactory.creatOther(_loc3_[_loc10_].getValue());
                  _loc8_.push(_loc15_);
               }
               _loc9_.push(_loc5_[_loc10_]);
            }
            _loc10_++;
         }
         if(_loc8_.length != 0)
         {
            AwardPanel.open(_loc8_,_loc9_);
         }
         return _loc7_;
      }
      
      private function howAward(param1:Object) : void
      {
         var _loc2_:Object = new Object();
         _loc2_ = DeepCopyUtil.clone(param1);
         this.p1orp2(param1,Main.player1.getBag());
         if(Main.P1P2)
         {
            this.p1orp2(_loc2_,Main.player2.getBag());
         }
      }
      
      private function p1orp2(param1:Object, param2:Bag) : void
      {
         if(param1 is Equip)
         {
            param2.addEquipBag(param1 as Equip);
         }
         else if(param1 is Gem)
         {
            param2.addGemBag(param1 as Gem);
         }
         else if(param1 is Supplies)
         {
            param2.addSuppliesBag(param1 as Supplies);
         }
         else if(param1 is Otherobj)
         {
            param2.addOtherobjBag(param1 as Otherobj);
         }
      }
      
      public function bagNum(param1:Task) : Boolean
      {
         var _loc6_:uint = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = param1.getAwardId();
         var _loc4_:Array = param1.getAwardType();
         var _loc5_:Array = param1.getAwardNum();
         if(_loc3_[0].getValue() == -1)
         {
            return true;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc2_.push(this.bagHow(_loc3_[_loc6_].getValue(),_loc4_[_loc6_].getValue(),_loc5_[_loc6_].getValue()));
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            if(_loc2_[_loc6_] == false)
            {
               return false;
            }
            _loc6_++;
         }
         return true;
      }
      
      private function bagHow(param1:Number, param2:Number, param3:Number) : Boolean
      {
         if(Main.P1P2)
         {
            if(Boolean(this.bbb(param2,param1,param3,Main.player1.getBag())) && Boolean(this.bbb(param2,param1,param3,Main.player2.getBag())))
            {
               return true;
            }
         }
         else if(this.bbb(param2,param1,param3,Main.player1.getBag()))
         {
            return true;
         }
         return false;
      }
      
      private function bbb(param1:Number, param2:Number, param3:Number, param4:Bag) : Boolean
      {
         if(param1 == 1)
         {
            if(param3 <= param4.backequipBagNum())
            {
               return true;
            }
         }
         else if(param1 == 2)
         {
            if(param3 <= param4.canPutGemNum(param2))
            {
               return true;
            }
         }
         else if(param1 == 3)
         {
            if(param3 <= param4.backSuppliesBagNum())
            {
               return true;
            }
         }
         else if(param1 == 4)
         {
            if(param3 <= param4.canPutOtherNum(param2))
            {
               return true;
            }
         }
         return false;
      }
      
      public function overGoldAncExp(param1:Task) : void
      {
         Main.player1.addGold(this.getGold(param1));
         Main.player_1.ExpUP(this.getExp(param1));
         if(Main.P1P2)
         {
            Main.player2.addGold(this.getGold(param1));
            Main.player_2.ExpUP(this.getExp(param1));
         }
      }
      
      public function overPlayerStata(param1:Task) : void
      {
         if(param1.getAwardPs() == 1)
         {
            Main.player1.setRebirth();
            if(Main.P1P2)
            {
               Main.player2.setRebirth();
            }
            TransferOkPanel.open(2);
            TaskPanel.close();
         }
      }
   }
}

