package com.hotpoint.braveManIII.views.playerTaskPanel
{
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.npcTaskPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import src.*;
   
   public class TaskText
   {
      
      public function TaskText()
      {
         super();
      }
      
      public static function creatTaskData() : TaskText
      {
         return new TaskText();
      }
      
      public function getIntroduction(param1:Object, param2:Number) : String
      {
         return param1.getTask(param2).getIntroduction();
      }
      
      public function getId(param1:Object, param2:Number) : Number
      {
         return (param1.getTask(param2) as Task).getId();
      }
      
      public function getDemand(param1:Object, param2:Number) : String
      {
         return param1.getTask(param2).getDemand();
      }
      
      public function getEnemyId(param1:Object, param2:Number) : Array
      {
         return param1.getTask(param2).getEnemyId();
      }
      
      public function getEnemyName(param1:Object, param2:Number) : Array
      {
         return (param1.getTask(param2) as Task).getEnemyName();
      }
      
      public function getEnemyNum(param1:Object, param2:Number) : Array
      {
         return param1.getTask(param2).getEnemyNum();
      }
      
      public function getEnemyedNum(param1:Object, param2:Number) : Array
      {
         return (param1.getTask(param2) as Task).getEnemyArr();
      }
      
      public function getGoodsId(param1:Object, param2:Number) : Array
      {
         return param1.getTask(param2).getGoodsId();
      }
      
      public function getGoodsNum(param1:Object, param2:Number) : Array
      {
         return param1.getTask(param2).getGoodsNum();
      }
      
      public function getGoodsedNum(param1:Object, param2:Number) : Array
      {
         return param1.getTask(param2).getGoodsedNum();
      }
      
      public function getExp(param1:Object, param2:Number) : Number
      {
         param2 = Number(param1.getTask(param2).getExp());
         if(param2 < 0)
         {
            param2 = 0;
         }
         return param2;
      }
      
      public function getGold(param1:Object, param2:Number) : Number
      {
         param2 = Number(param1.getTask(param2).getGold());
         if(param2 < 0)
         {
            param2 = 0;
         }
         return param2;
      }
      
      public function getAwardTypeAndId(param1:Object, param2:Number) : Array
      {
         return (param1.getTask(param2) as Task).getAwardTypeAndId();
      }
      
      public function getAwrdNum(param1:Object, param2:Number) : Array
      {
         return (param1.getTask(param2) as Task).getAwardNum();
      }
      
      public function getAwrdType(param1:Object, param2:Number) : Array
      {
         return (param1.getTask(param2) as Task).getAwardType();
      }
      
      public function addJl(param1:Object, param2:*) : Array
      {
         var _loc3_:Array = this.getAwardTypeAndId(param1,param2);
         var _loc4_:Array = this.getAwrdNum(param1,param2);
         var _loc5_:Array = this.addJlEqu(param1,param2);
         var _loc6_:Array = this.addJlGem(param1,param2);
         var _loc7_:Array = this.addJlSup(param1,param2);
         var _loc8_:Array = this.addJlOther(param1,param2);
         var _loc9_:Array = [];
         if(_loc5_.length > 0)
         {
            _loc9_.push(_loc5_);
         }
         if(_loc6_.length > 0)
         {
            _loc9_.push(_loc6_);
         }
         if(_loc7_.length > 0)
         {
            _loc9_.push(_loc7_);
         }
         if(_loc8_.length > 0)
         {
            _loc9_.push(_loc8_);
         }
         return _loc9_;
      }
      
      public function getOneObj(param1:Object, param2:Number) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:Array = this.getAwardTypeAndId(param1,param2);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_][0] == 1)
            {
               _loc3_.push(EquipFactory.createEquipByID(_loc4_[_loc5_][1]));
            }
            else if(_loc4_[_loc5_][0] == 2)
            {
               _loc3_.push(GemFactory.creatGemById(_loc4_[_loc5_][1]));
            }
            else if(_loc4_[_loc5_][0] == 3)
            {
               _loc3_.push(SuppliesFactory.getSuppliesById(_loc4_[_loc5_][1]));
            }
            else if(_loc4_[_loc5_][0] == 4)
            {
               _loc3_.push(OtherFactory.creatOther(_loc4_[_loc5_][1]));
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function addJlEqu(param1:Object, param2:*) : Array
      {
         var _loc7_:uint = 0;
         var _loc8_:Equip = null;
         var _loc3_:Array = this.getAwardTypeAndId(param1,param2);
         var _loc4_:Array = this.getAwrdNum(param1,param2);
         var _loc5_:Array = [];
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_.length)
         {
            if(_loc3_ != null)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc4_[_loc6_])
               {
                  if(_loc3_[_loc6_][0] == 1)
                  {
                     _loc8_ = EquipFactory.createEquipByID(_loc3_[_loc6_][1]);
                     _loc5_.push(_loc8_);
                  }
                  _loc7_++;
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function addJlGem(param1:Object, param2:*) : Array
      {
         var _loc7_:uint = 0;
         var _loc8_:Gem = null;
         var _loc3_:Array = this.getAwardTypeAndId(param1,param2);
         var _loc4_:Array = this.getAwrdNum(param1,param2);
         var _loc5_:Array = [];
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_.length)
         {
            if(_loc3_ != null)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc4_[_loc6_])
               {
                  if(_loc3_[_loc6_][0] == 2)
                  {
                     _loc8_ = GemFactory.creatGemById(_loc3_[_loc6_][1]);
                     _loc5_.push(_loc8_);
                  }
                  _loc7_++;
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function addJlSup(param1:Object, param2:*) : Array
      {
         var _loc7_:uint = 0;
         var _loc8_:Supplies = null;
         var _loc3_:Array = this.getAwardTypeAndId(param1,param2);
         var _loc4_:Array = this.getAwrdNum(param1,param2);
         var _loc5_:Array = [];
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_.length)
         {
            if(_loc3_ != null)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc4_[_loc6_])
               {
                  if(_loc3_[_loc6_][0] == 3)
                  {
                     _loc8_ = SuppliesFactory.getSuppliesById(_loc3_[_loc6_][1]);
                     _loc5_.push(_loc8_);
                  }
                  _loc7_++;
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function addJlOther(param1:Object, param2:*) : Array
      {
         var _loc7_:uint = 0;
         var _loc8_:Otherobj = null;
         var _loc3_:Array = this.getAwardTypeAndId(param1,param2);
         var _loc4_:Array = this.getAwrdNum(param1,param2);
         var _loc5_:Array = [];
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_.length)
         {
            if(_loc3_ != null)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc4_[_loc6_])
               {
                  if(_loc3_[_loc6_][0] == 4)
                  {
                     _loc8_ = OtherFactory.creatOther(_loc3_[_loc6_][1]);
                     _loc5_.push(_loc8_);
                  }
                  _loc7_++;
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function getAllId(param1:Object, param2:Number) : Array
      {
         var _loc7_:uint = 0;
         var _loc3_:Number = this.getId(param1,param2);
         var _loc4_:Array = [];
         var _loc5_:Array = this.getEnemyName(param1,param2);
         var _loc6_:Array = this.getGoodsId(param1,param2);
         if(_loc5_ != null)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc4_.push(_loc5_[_loc7_]);
               _loc7_++;
            }
         }
         if(_loc6_ != null)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               trace(_loc6_[_loc7_] + ":arr2[i])");
               if(_loc3_ != 210002)
               {
                  _loc4_.push(QuestFactory.getName(_loc6_[_loc7_]));
               }
               else
               {
                  _loc4_.push(OtherFactory.getName(_loc6_[_loc7_]));
               }
               _loc7_++;
            }
         }
         return _loc4_;
      }
      
      public function getAllNum(param1:Object, param2:Number) : Array
      {
         var _loc6_:uint = 0;
         var _loc3_:Array = [];
         var _loc4_:Array = this.getEnemyNum(param1,param2);
         var _loc5_:Array = this.getGoodsNum(param1,param2);
         if(_loc4_ != null)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc3_.push(_loc4_[_loc6_]);
               _loc6_++;
            }
         }
         if(_loc5_ != null)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc3_.push(_loc5_[_loc6_]);
               _loc6_++;
            }
         }
         return _loc3_;
      }
      
      public function getAllNuming(param1:Object, param2:Number) : Array
      {
         var _loc6_:uint = 0;
         var _loc3_:Array = [];
         var _loc4_:Array = this.getEnemyedNum(param1,param2);
         var _loc5_:Array = this.getGoodsedNum(param1,param2);
         if(_loc4_ != null)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc3_.push(_loc4_[_loc6_]);
               _loc6_++;
            }
         }
         if(_loc5_ != null)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc3_.push(_loc5_[_loc6_]);
               _loc6_++;
            }
         }
         return _loc3_;
      }
      
      public function bagNum(param1:Object, param2:Number) : Boolean
      {
         var _loc7_:uint = 0;
         var _loc3_:Array = [];
         var _loc4_:Array = this.getAwardTypeAndId(param1,param2);
         var _loc5_:Array = this.getAwrdNum(param1,param2);
         var _loc6_:Task = param1.getTask(param2);
         if(_loc4_.length < 1)
         {
            return true;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc3_.push(this.bagHow(_loc4_[_loc7_][0],_loc4_[_loc7_][1],_loc5_[_loc7_],_loc6_));
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            if(_loc3_[_loc7_] == false)
            {
               return false;
            }
            _loc7_++;
         }
         return true;
      }
      
      private function bagHow(param1:Number, param2:Number, param3:Number, param4:Task) : Boolean
      {
         if(param4.getWho() == 1)
         {
            return this.bbb(param1,param2,param3,Main.player1.getBag());
         }
         if(param4.getWho() == 2)
         {
            return this.bbb(param1,param2,param3,Main.player2.getBag());
         }
         if(param4.getWho() == 3)
         {
            if(Main.P1P2)
            {
               if(Boolean(this.bbb(param1,param2,param3,Main.player1.getBag())) && Boolean(this.bbb(param1,param2,param3,Main.player2.getBag())))
               {
                  return true;
               }
            }
            else if(this.bbb(param1,param2,param3,Main.player1.getBag()))
            {
               return true;
            }
         }
         return false;
      }
      
      private function bbb(param1:Number, param2:Number, param3:Number, param4:Bag) : Boolean
      {
         if(param1 == 1)
         {
            trace("装备背包剩余:" + param4.backequipBagNum());
            trace(param3 + "要放入的数量_装备+++++++");
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
            trace(param4.canPutOtherNum(param2) + "背包剩余数量_其他");
            trace(param3 + "要放入的数量_其他");
            if(param3 <= param4.canPutOtherNum(param2))
            {
               trace("其他栏没满" + param4.canPutOtherNum(param2));
               return true;
            }
         }
         return false;
      }
      
      public function overAward(param1:Object, param2:Number) : void
      {
         var _loc8_:uint = 0;
         var _loc3_:Array = this.addJlEqu(param1,param2);
         var _loc4_:Array = this.addJlGem(param1,param2);
         var _loc5_:Array = this.addJlSup(param1,param2);
         var _loc6_:Array = this.addJlOther(param1,param2);
         var _loc7_:Task = param1.getTask(param2);
         trace("Equ:" + _loc3_);
         trace("arrGem:" + _loc4_);
         trace("arrSup:" + _loc5_);
         trace("arrOth:" + _loc6_);
         if(_loc3_.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               this.howAward(_loc7_,_loc3_[_loc8_]);
               _loc8_++;
            }
         }
         if(_loc4_.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc4_.length)
            {
               this.howAward(_loc7_,_loc4_[_loc8_]);
               _loc8_++;
            }
         }
         if(_loc5_.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_.length)
            {
               this.howAward(_loc7_,_loc5_[_loc8_]);
               _loc8_++;
            }
         }
         if(_loc6_.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length)
            {
               this.howAward(_loc7_,_loc6_[_loc8_]);
               _loc8_++;
            }
         }
      }
      
      private function howAward(param1:Task, param2:Object) : void
      {
         var _loc3_:Object = null;
         if(param1.getWho() == 1)
         {
            this.p1orp2(param2,Main.player1.getBag());
         }
         else if(param1.getWho() == 2)
         {
            this.p1orp2(param2,Main.player2.getBag());
         }
         else if(param1.getWho() == 3)
         {
            _loc3_ = new Object();
            _loc3_ = DeepCopyUtil.clone(param2);
            this.p1orp2(param2,Main.player1.getBag());
            if(Main.P1P2)
            {
               this.p1orp2(_loc3_,Main.player2.getBag());
            }
         }
      }
      
      private function p1orp2(param1:Object, param2:Bag) : void
      {
         if(param1 is Equip)
         {
            trace("加入装备");
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
      
      public function overGoldAncExp(param1:Object, param2:Number) : void
      {
         var _loc3_:Task = param1.getTask(param2);
         if(_loc3_.getWho() == 1)
         {
            Main.player1.addGold(this.getGold(param1,param2));
            Main.player_1.ExpUP(int(this.getExp(param1,param2)));
         }
         else if(_loc3_.getWho() == 2)
         {
            Main.player2.addGold(this.getGold(param1,param2));
            Main.player_2.ExpUP(int(this.getExp(param1,param2)));
         }
         else if(_loc3_.getWho() == 3)
         {
            Main.player1.addGold(this.getGold(param1,param2));
            Main.player_1.ExpUP(int(this.getExp(param1,param2)));
            if(Main.P1P2)
            {
               Main.player2.addGold(this.getGold(param1,param2));
               Main.player_2.ExpUP(int(this.getExp(param1,param2)));
            }
         }
      }
      
      public function overPlayerStata(param1:Object, param2:Number) : void
      {
         var _loc3_:Task = param1.getTask(param2);
         trace("奖励类型:" + _loc3_.getAwardPlayerDate());
         trace("指定玩家:" + _loc3_.getWho());
         if(_loc3_.getAwardPlayerDate() == 1)
         {
            trace("奖励重生");
            if(_loc3_.getWho() == 1)
            {
               Main.player1.setRebirth();
            }
            else if(_loc3_.getWho() == 2)
            {
               Main.player2.setRebirth();
            }
            else if(_loc3_.getWho() == 3)
            {
               trace("角色1重生");
               Main.player1.setRebirth();
               if(Main.P1P2)
               {
                  trace("角色2重生");
                  Main.player2.setRebirth();
               }
            }
            TransferOkPanel.open(2);
            NpcTaskPanel.close();
            PlayerTaskPanel.close();
         }
      }
   }
}

