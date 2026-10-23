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
      
      public static function creatMonsterBasicData(id:Number, type:Number, name:String, frame:Number, frame2:Number, introduction:String, attup:Number, defup:Number, critup:Number, hpup:Number, mpup:Number) : MonsterBasicData
      {
         var mbd:MonsterBasicData = new MonsterBasicData();
         mbd._id = VT.createVT(id);
         mbd._name = name;
         mbd._type = VT.createVT(type);
         mbd._frame = VT.createVT(frame);
         mbd._frame2 = VT.createVT(frame2);
         mbd._introduction = introduction;
         mbd._attup = VT.createVT(attup);
         mbd._defup = VT.createVT(defup);
         mbd._critup = VT.createVT(critup);
         mbd._hpup = VT.createVT(hpup);
         mbd._mpup = VT.createVT(mpup);
         return mbd;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function set type(value:VT) : void
      {
         _type = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(value:VT) : void
      {
         _frame = value;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(value:String) : void
      {
         _introduction = value;
      }
      
      public function get attup() : VT
      {
         return _attup;
      }
      
      public function set attup(value:VT) : void
      {
         _attup = value;
      }
      
      public function get defup() : VT
      {
         return _defup;
      }
      
      public function set defup(value:VT) : void
      {
         _defup = value;
      }
      
      public function get critup() : VT
      {
         return _critup;
      }
      
      public function set critup(value:VT) : void
      {
         _critup = value;
      }
      
      public function get hpup() : VT
      {
         return _hpup;
      }
      
      public function set hpup(value:VT) : void
      {
         _hpup = value;
      }
      
      public function get mpup() : VT
      {
         return _mpup;
      }
      
      public function set mpup(value:VT) : void
      {
         _mpup = value;
      }
      
      public function get frame2() : VT
      {
         return _frame2;
      }
      
      public function set frame2(value:VT) : void
      {
         _frame2 = value;
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

