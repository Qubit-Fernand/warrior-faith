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
         return _times.getValue();
      }
      
      public function addTimes(num:int = 1) : *
      {
         if(_times.getValue() <= 2)
         {
            _times.setValue(_times.getValue() + num);
            NewMC.Open("获得卡片",Main._this,480,290,30,0,true,2,getName());
         }
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return MonsterFactory.getName(_id.getValue());
      }
      
      public function getFrame() : Number
      {
         return MonsterFactory.getFrame(_id.getValue());
      }
      
      public function getFrame2() : Number
      {
         return MonsterFactory.getFrame2(_id.getValue());
      }
      
      public function getType() : Number
      {
         return MonsterFactory.getType(_id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return MonsterFactory.getIntroduction(_id.getValue());
      }
      
      public function getAttup() : Number
      {
         return MonsterFactory.getAttup(_id.getValue());
      }
      
      public function getDefup() : Number
      {
         return MonsterFactory.getDefup(_id.getValue());
      }
      
      public function getCritup() : Number
      {
         return MonsterFactory.getCritup(_id.getValue());
      }
      
      public function getHpup() : Number
      {
         return MonsterFactory.getHpup(_id.getValue());
      }
      
      public function getMpup() : Number
      {
         return MonsterFactory.getMpup(_id.getValue());
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         _times = value;
      }
   }
}

