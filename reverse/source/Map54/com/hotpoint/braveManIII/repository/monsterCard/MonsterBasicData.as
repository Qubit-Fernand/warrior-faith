package com.hotpoint.braveManIII.repository.monsterCard
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.monsterCard.*;
   
   public class MonsterBasicData
   {
      
      private var _id:VT;
      
      private var _type:VT;
      
      private var _name:String;
      
      private var _frame:VT;
      
      private var _frame2:VT;
      
      private var _introduction:String;
      
      private var _attup:VT;
      
      private var _defup:VT;
      
      private var _critup:VT;
      
      private var _hpup:VT;
      
      private var _mpup:VT;
      
      public function MonsterBasicData()
      {
         super();
      }
      
      public static function creatMonsterBasicData(param1:Number, param2:Number, param3:String, param4:Number, param5:Number, param6:String, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number) : MonsterBasicData
      {
         var _loc12_:MonsterBasicData = new MonsterBasicData();
         _loc12_._id = VT.createVT(param1);
         _loc12_._name = param3;
         _loc12_._type = VT.createVT(param2);
         _loc12_._frame = VT.createVT(param4);
         _loc12_._frame2 = VT.createVT(param5);
         _loc12_._introduction = param6;
         _loc12_._attup = VT.createVT(param7);
         _loc12_._defup = VT.createVT(param8);
         _loc12_._critup = VT.createVT(param9);
         _loc12_._hpup = VT.createVT(param10);
         _loc12_._mpup = VT.createVT(param11);
         return _loc12_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function set type(param1:VT) : void
      {
         _type = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(param1:VT) : void
      {
         _frame = param1;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         _introduction = param1;
      }
      
      public function get attup() : VT
      {
         return _attup;
      }
      
      public function set attup(param1:VT) : void
      {
         _attup = param1;
      }
      
      public function get defup() : VT
      {
         return _defup;
      }
      
      public function set defup(param1:VT) : void
      {
         _defup = param1;
      }
      
      public function get critup() : VT
      {
         return _critup;
      }
      
      public function set critup(param1:VT) : void
      {
         _critup = param1;
      }
      
      public function get hpup() : VT
      {
         return _hpup;
      }
      
      public function set hpup(param1:VT) : void
      {
         _hpup = param1;
      }
      
      public function get mpup() : VT
      {
         return _mpup;
      }
      
      public function set mpup(param1:VT) : void
      {
         _mpup = param1;
      }
      
      public function get frame2() : VT
      {
         return _frame2;
      }
      
      public function set frame2(param1:VT) : void
      {
         _frame2 = param1;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getType() : Number
      {
         return _type.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getFrame2() : Number
      {
         return _frame2.getValue();
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function getAttup() : Number
      {
         return _attup.getValue();
      }
      
      public function getDefup() : Number
      {
         return _defup.getValue();
      }
      
      public function getCritup() : Number
      {
         return _critup.getValue();
      }
      
      public function getHpup() : Number
      {
         return _hpup.getValue();
      }
      
      public function getMpup() : Number
      {
         return _mpup.getValue();
      }
      
      public function creatMonsterCard() : MonsterCard
      {
         return MonsterCard.creatMonsterCard(_id.getValue());
      }
   }
}

