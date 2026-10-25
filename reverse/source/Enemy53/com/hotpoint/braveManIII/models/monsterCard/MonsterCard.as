package com.hotpoint.braveManIII.models.monsterCard
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.monsterCard.*;
   import src.*;
   
   public class MonsterCard
   {
      
      private var _id:VT;
      
      private var _times:VT = VT.createVT(0);
      
      public function MonsterCard()
      {
         super();
      }
      
      public static function creatMonsterCard(id:*) : MonsterCard
      {
         var mc:MonsterCard = new MonsterCard();
         mc._id = VT.createVT(id);
         mc.addTimes();
         return mc;
      }
      
      public function getTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function addTimes(num:int = 1) : *
      {
         if(this._times.getValue() <= 2)
         {
            this._times.setValue(this._times.getValue() + num);
            NewMC.Open("获得卡片",Main._this,480,290,30,0,true,2,this.getName());
         }
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return MonsterFactory.getName(this._id.getValue());
      }
      
      public function getFrame() : Number
      {
         return MonsterFactory.getFrame(this._id.getValue());
      }
      
      public function getFrame2() : Number
      {
         return MonsterFactory.getFrame2(this._id.getValue());
      }
      
      public function getType() : Number
      {
         return MonsterFactory.getType(this._id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return MonsterFactory.getIntroduction(this._id.getValue());
      }
      
      public function getAttup() : Number
      {
         return MonsterFactory.getAttup(this._id.getValue());
      }
      
      public function getDefup() : Number
      {
         return MonsterFactory.getDefup(this._id.getValue());
      }
      
      public function getCritup() : Number
      {
         return MonsterFactory.getCritup(this._id.getValue());
      }
      
      public function getHpup() : Number
      {
         return MonsterFactory.getHpup(this._id.getValue());
      }
      
      public function getMpup() : Number
      {
         return MonsterFactory.getMpup(this._id.getValue());
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get times() : VT
      {
         return this._times;
      }
      
      public function set times(value:VT) : void
      {
         this._times = value;
      }
   }
}

