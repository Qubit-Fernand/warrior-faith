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
         var ms:MonsterSlot = new MonsterSlot();
         for(var i:int = 0; i < 80; i++)
         {
            ms._slot[i] = null;
         }
         return ms;
      }
      
      public function testMonsterSlot() : *
      {
         for(var i:int = 0; i < 80; i++)
         {
            if(this._slot[i])
            {
               if((this._slot[i] as MonsterCard).getId() != i)
               {
                  this._slot[i] = null;
               }
            }
         }
      }
      
      public function getMonsterSlotLength() : Number
      {
         return this._slot.length;
      }
      
      public function getMonsterSlotNum(num:int) : MonsterCard
      {
         if(this._slot[num])
         {
            return this._slot[num];
         }
         return null;
      }
      
      public function addMonsterSlot(mcID:int) : *
      {
         var id:int = 0;
         if(MonsterFactory.getMonsterByType(mcID))
         {
            id = int(MonsterFactory.getMonsterByType(mcID).getId());
            if(this._slot[id])
            {
               (this._slot[id] as MonsterCard).addTimes();
            }
            else
            {
               this._slot[id] = MonsterFactory.creatMonsterType(mcID);
            }
         }
      }
      
      public function addLqTimes(num:int = 1) : *
      {
         this._lqTimes.setValue(this._lqTimes.getValue() + num);
      }
      
      public function getLqTimes() : int
      {
         return this._lqTimes.getValue();
      }
      
      public function getAllStarNum() : int
      {
         var count:Number = 0;
         for(var i:int = 0; i < this.slot.length; i++)
         {
            if(this._slot[i])
            {
               count += (this._slot[i] as MonsterCard).getTimes();
            }
         }
         return count;
      }
      
      public function addMonsterCard(id:Number) : *
      {
         var rdm:Number = Math.random() * 100;
         if(rdm < 5)
         {
            this.addMonsterSlot(id);
         }
      }
      
      public function getAllAttup() : Number
      {
         var count:Number = 0;
         for(var i:int = 0; i < this.slot.length; i++)
         {
            if(this._slot[i])
            {
               if(Boolean(this._slot[i]) && (this._slot[i] as MonsterCard).getTimes() >= 3)
               {
                  count += (this._slot[i] as MonsterCard).getAttup();
               }
            }
         }
         return count;
      }
      
      public function getAllDefup() : Number
      {
         var count:Number = 0;
         for(var i:int = 0; i < this.slot.length; i++)
         {
            if(this._slot[i])
            {
               if(Boolean(this._slot[i]) && (this._slot[i] as MonsterCard).getTimes() >= 3)
               {
                  count += (this._slot[i] as MonsterCard).getDefup();
               }
            }
         }
         return count;
      }
      
      public function getAllCritup() : Number
      {
         var count:Number = 0;
         for(var i:int = 0; i < this.slot.length; i++)
         {
            if(this._slot[i])
            {
               if(Boolean(this._slot[i]) && (this._slot[i] as MonsterCard).getTimes() >= 3)
               {
                  count += (this._slot[i] as MonsterCard).getCritup();
               }
            }
         }
         return count;
      }
      
      public function getAllHpup() : Number
      {
         var count:Number = 0;
         for(var i:int = 0; i < this.slot.length; i++)
         {
            if(this._slot[i])
            {
               if(Boolean(this._slot[i]) && (this._slot[i] as MonsterCard).getTimes() >= 3)
               {
                  count += (this._slot[i] as MonsterCard).getHpup();
               }
            }
         }
         return count;
      }
      
      public function getAllMpup() : Number
      {
         var count:Number = 0;
         for(var i:int = 0; i < this.slot.length; i++)
         {
            if(this._slot[i])
            {
               if(Boolean(this._slot[i]) && (this._slot[i] as MonsterCard).getTimes() >= 3)
               {
                  count += (this._slot[i] as MonsterCard).getMpup();
               }
            }
         }
         return count;
      }
      
      public function get slot() : Array
      {
         return this._slot;
      }
      
      public function set slot(value:Array) : void
      {
         this._slot = value;
      }
      
      public function get lqTimes() : VT
      {
         return this._lqTimes;
      }
      
      public function set lqTimes(value:VT) : void
      {
         this._lqTimes = value;
      }
   }
}

