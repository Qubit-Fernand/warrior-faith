package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.monsterCard.*;
   import com.hotpoint.braveManIII.repository.monsterCard.*;
   import src.*;
   import src.tool.*;
   
   public class MonsterSlot
   {
      
      private var _slot:Array = [];
      
      private var _lqTimes:VT = VT.createVT(0);
      
      public function MonsterSlot()
      {
         super();
      }
      
      public static function creatMonsterSlot() : MonsterSlot
      {
         var _loc1_:MonsterSlot = new MonsterSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 80)
         {
            _loc1_._slot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function testMonsterSlot() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 80)
         {
            if(this._slot[_loc1_])
            {
               if((this._slot[_loc1_] as MonsterCard).getId() != _loc1_)
               {
                  this._slot[_loc1_] = null;
               }
            }
            _loc1_++;
         }
      }
      
      public function getMonsterSlotLength() : Number
      {
         return this._slot.length;
      }
      
      public function getMonsterSlotNum(param1:int) : MonsterCard
      {
         if(this._slot[param1])
         {
            return this._slot[param1];
         }
         return null;
      }
      
      public function addMonsterSlot(param1:int) : *
      {
         var _loc2_:int = 0;
         if(MonsterFactory.getMonsterByType(param1))
         {
            _loc2_ = int(MonsterFactory.getMonsterByType(param1).getId());
            if(this._slot[_loc2_])
            {
               (this._slot[_loc2_] as MonsterCard).addTimes();
            }
            else
            {
               this._slot[_loc2_] = MonsterFactory.creatMonsterType(param1);
            }
         }
      }
      
      public function addLqTimes(param1:int = 1) : *
      {
         this._lqTimes.setValue(this._lqTimes.getValue() + param1);
      }
      
      public function getLqTimes() : int
      {
         return this._lqTimes.getValue();
      }
      
      public function getAllStarNum() : int
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.slot.length)
         {
            if(this._slot[_loc2_])
            {
               _loc1_ += (this._slot[_loc2_] as MonsterCard).getTimes();
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function addMonsterCard(param1:Number) : *
      {
         var _loc2_:Number = Math.random() * 100;
         if(_loc2_ < 5)
         {
            this.addMonsterSlot(param1);
         }
      }
      
      public function getAllAttup() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.slot.length)
         {
            if(this._slot[_loc2_])
            {
               if(Boolean(this._slot[_loc2_]) && (this._slot[_loc2_] as MonsterCard).getTimes() >= 3)
               {
                  _loc1_ += (this._slot[_loc2_] as MonsterCard).getAttup();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getAllDefup() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.slot.length)
         {
            if(this._slot[_loc2_])
            {
               if(Boolean(this._slot[_loc2_]) && (this._slot[_loc2_] as MonsterCard).getTimes() >= 3)
               {
                  _loc1_ += (this._slot[_loc2_] as MonsterCard).getDefup();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getAllCritup() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.slot.length)
         {
            if(this._slot[_loc2_])
            {
               if(Boolean(this._slot[_loc2_]) && (this._slot[_loc2_] as MonsterCard).getTimes() >= 3)
               {
                  _loc1_ += (this._slot[_loc2_] as MonsterCard).getCritup();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getAllHpup() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.slot.length)
         {
            if(this._slot[_loc2_])
            {
               if(Boolean(this._slot[_loc2_]) && (this._slot[_loc2_] as MonsterCard).getTimes() >= 3)
               {
                  _loc1_ += (this._slot[_loc2_] as MonsterCard).getHpup();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getAllMpup() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.slot.length)
         {
            if(this._slot[_loc2_])
            {
               if(Boolean(this._slot[_loc2_]) && (this._slot[_loc2_] as MonsterCard).getTimes() >= 3)
               {
                  _loc1_ += (this._slot[_loc2_] as MonsterCard).getMpup();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get slot() : Array
      {
         return this._slot;
      }
      
      public function set slot(param1:Array) : void
      {
         this._slot = param1;
      }
      
      public function get lqTimes() : VT
      {
         return this._lqTimes;
      }
      
      public function set lqTimes(param1:VT) : void
      {
         this._lqTimes = param1;
      }
   }
}

