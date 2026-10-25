package com.hotpoint.braveManIII.repository.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import flash.utils.*;
   
   public class EquipBaseData
   {
      
      private var _position:VT;
      
      private var _reincarnationLimit:VT;
      
      private var _baseAttrib:Array = [];
      
      private var _className:String;
      
      private var _grid:VT;
      
      private var _suitId:VT;
      
      private var _dressLevel:VT;
      
      private var _id:VT;
      
      private var _skillAttrib:VT;
      
      private var _price:VT;
      
      private var _isStrengthen:Boolean;
      
      private var _dropLevel:VT;
      
      private var _color:VT;
      
      private var _name:String;
      
      private var _descript:String;
      
      private var _frame:VT;
      
      public function EquipBaseData()
      {
         super();
      }
      
      public static function createEquipBaseData(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:Number, param7:Number, param8:String, param9:Number, param10:Number, param11:Number, param12:Boolean, param13:Number, param14:Number, param15:Array, param16:Number) : EquipBaseData
      {
         var _loc17_:EquipBaseData = null;
         _loc17_ = new EquipBaseData();
         _loc17_._name = param3;
         _loc17_._className = param4;
         _loc17_._descript = param8;
         _loc17_._isStrengthen = param12;
         _loc17_._baseAttrib = param15;
         _loc17_._id = VT.createVT(param1);
         _loc17_._frame = VT.createVT(param2);
         _loc17_._position = VT.createVT(param5);
         _loc17_._dressLevel = VT.createVT(param6);
         _loc17_._dropLevel = VT.createVT(param7);
         _loc17_._price = VT.createVT(param9);
         _loc17_._reincarnationLimit = VT.createVT(param10);
         _loc17_._color = VT.createVT(param11);
         _loc17_._grid = VT.createVT(param13);
         _loc17_._suitId = VT.createVT(param14);
         _loc17_._skillAttrib = VT.createVT(param16);
         return _loc17_;
      }
      
      public function get baseAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _baseAttrib;
      }
      
      public function getDressLevel() : Number
      {
         return _dressLevel.getValue();
      }
      
      public function getDescript() : String
      {
         return _descript;
      }
      
      public function get skillAttrib() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _skillAttrib;
      }
      
      public function get name() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _name;
      }
      
      public function get descript() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _descript;
      }
      
      public function get dressLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _dressLevel;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function set price(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _price = param1;
      }
      
      public function set grid(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _grid = param1;
      }
      
      public function set name(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _name = param1;
      }
      
      public function set descript(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _descript = param1;
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _id;
      }
      
      public function set suitId(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suitId = param1;
      }
      
      public function get suitId() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suitId;
      }
      
      public function set dressLevel(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _dressLevel = param1;
      }
      
      public function getPrice() : Number
      {
         return _price.getValue();
      }
      
      public function get className() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _className;
      }
      
      public function get position() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _position;
      }
      
      public function set dropLevel(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _dropLevel = param1;
      }
      
      private function getRandomType() : uint
      {
         var _loc1_:* = undefined;
         _loc1_ = Math.random() * 100;
         if(_loc1_ >= 0 && _loc1_ < 22)
         {
            return 0;
         }
         if(_loc1_ >= 22 && _loc1_ < 44)
         {
            return 1;
         }
         if(_loc1_ >= 44 && _loc1_ < 66)
         {
            return 2;
         }
         if(_loc1_ >= 66 && _loc1_ < 83)
         {
            return 3;
         }
         return 4;
      }
      
      public function getColor() : Number
      {
         return _color.getValue();
      }
      
      private function setFloat(param1:Array) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:EquipBaseAttrib = null;
         var _loc4_:* = undefined;
         _loc2_ = [];
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_.getValue();
            if(_loc4_ > 2 && _loc4_ <= 10)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random()));
            }
            else if(_loc4_ > 10 && _loc4_ <= 20)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 2));
            }
            else if(_loc4_ > 20 && _loc4_ <= 30)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 3));
            }
            else if(_loc4_ > 30 && _loc4_ <= 40)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 3));
            }
            else if(_loc4_ > 40 && _loc4_ <= 50)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 4));
            }
            else if(_loc4_ > 50 && _loc4_ <= 60)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 4));
            }
            else if(_loc4_ > 60 && _loc4_ <= 70)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 5));
            }
            else if(_loc4_ > 70 && _loc4_ <= 80)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 5));
            }
            else if(_loc4_ > 80 && _loc4_ <= 90)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 6));
            }
            else if(_loc4_ > 90 && _loc4_ <= 100)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 6));
            }
            else if(_loc4_ > 100 && _loc4_ <= 120)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 7));
            }
            else if(_loc4_ > 120 && _loc4_ <= 140)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 7));
            }
            else if(_loc4_ > 140 && _loc4_ <= 160)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 7));
            }
            else if(_loc4_ > 160 && _loc4_ <= 200)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 8));
            }
            else if(_loc4_ > 200 && _loc4_ <= 260)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 9));
            }
            else if(_loc4_ > 260 && _loc4_ <= 330)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 9));
            }
            else if(_loc4_ > 330 && _loc4_ <= 400)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 10));
            }
            else if(_loc4_ > 400 && _loc4_ <= 500)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 12));
            }
            else if(_loc4_ > 500 && _loc4_ <= 600)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 14));
            }
            else if(_loc4_ > 600 && _loc4_ <= 700)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 14));
            }
            else if(_loc4_ > 700 && _loc4_ <= 800)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 15));
            }
            else if(_loc4_ > 800 && _loc4_ <= 900)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 15));
            }
            else if(_loc4_ > 900 && _loc4_ <= 1000)
            {
               _loc3_.setValue(_loc4_ - Math.round(Math.random() * 15));
            }
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public function set id(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _id = param1;
      }
      
      public function getPosition() : Number
      {
         return _position.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getDropLevel() : Number
      {
         return _dropLevel.getValue();
      }
      
      public function getGrid() : Number
      {
         return _grid.getValue();
      }
      
      public function createShopEquip() : Equip
      {
         var _loc1_:uint = 0;
         var _loc2_:Equip = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:EquipBaseAttrib = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:EquipBaseAttrib = null;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:EquipBaseAttrib = null;
         _loc3_ = [];
         _loc4_ = [];
         _loc5_ = [];
         for each(_loc6_ in _baseAttrib)
         {
            if(_loc6_.getColorType() == 1)
            {
               _loc3_.push(_loc6_.getClone());
            }
            else if(_loc6_.getColorType() == 2)
            {
               _loc4_.push(_loc6_.getClone());
            }
            else if(_loc6_.getColorType() == 3)
            {
               _loc5_.push(_loc6_.getClone());
            }
         }
         if(_color.getValue() == 2 && _loc4_.length > 0)
         {
            _loc8_ = int(getRandomType());
            _loc9_ = _loc4_[_loc8_] as EquipBaseAttrib;
            _loc3_.push(_loc9_);
         }
         if(_color.getValue() == 3 && _loc5_.length > 0)
         {
            _loc10_ = 2;
            _loc11_ = -1;
            while(_loc10_ > 0)
            {
               _loc12_ = int(getRandomType());
               if(_loc11_ != _loc12_)
               {
                  _loc13_ = _loc5_[_loc12_] as EquipBaseAttrib;
                  _loc3_.push(_loc13_);
                  _loc10_--;
                  _loc11_ = _loc12_;
                  if(_loc5_.length <= 0)
                  {
                     break;
                  }
               }
            }
         }
         _loc7_ = int(_skillAttrib.getValue());
         if(_position.getValue() == 5)
         {
            if(Math.random() * 10 < 5)
            {
               _loc7_ = 0;
            }
         }
         return Equip.creatEquip(_id.getValue(),_loc3_,_loc7_,_grid.getValue());
      }
      
      public function set color(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _color = param1;
      }
      
      public function get price() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _price;
      }
      
      public function get grid() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _grid;
      }
      
      public function set position(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _position = param1;
      }
      
      public function get dropLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _dropLevel;
      }
      
      public function set frame(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _frame = param1;
      }
      
      public function set className(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _className = param1;
      }
      
      public function get color() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _color;
      }
      
      public function set isStrengthen(param1:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _isStrengthen = param1;
      }
      
      public function get frame() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _frame;
      }
      
      public function set reincarnationLimit(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _reincarnationLimit = param1;
      }
      
      public function getIsStrengthen() : Boolean
      {
         return _isStrengthen;
      }
      
      public function getReincarnationLimit() : Number
      {
         return _reincarnationLimit.getValue();
      }
      
      public function set baseAttrib(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _baseAttrib = param1;
      }
      
      public function createEquip() : Equip
      {
         var _loc1_:uint = 0;
         var _loc2_:Equip = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:EquipBaseAttrib = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:EquipBaseAttrib = null;
         var _loc11_:* = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:EquipBaseAttrib = null;
         _loc3_ = [];
         _loc4_ = [];
         _loc5_ = [];
         _loc6_ = [];
         for each(_loc7_ in _baseAttrib)
         {
            if(_loc7_.getColorType() == 1)
            {
               _loc3_.push(_loc7_.getClone());
            }
            else if(_loc7_.getColorType() == 2)
            {
               _loc4_.push(_loc7_.getClone());
            }
            else if(_loc7_.getColorType() == 3)
            {
               _loc5_.push(_loc7_.getClone());
            }
         }
         if(_color.getValue() == 2 && _loc4_.length > 0)
         {
            _loc9_ = int(getRandomType());
            _loc10_ = _loc4_[_loc9_] as EquipBaseAttrib;
            _loc3_.push(_loc10_);
         }
         if((_color.getValue() == 3 || _color.getValue() == 4) && _loc5_.length > 0)
         {
            _loc11_ = 2;
            _loc12_ = -1;
            while(_loc11_ > 0)
            {
               _loc13_ = int(getRandomType());
               if(_loc12_ != _loc13_)
               {
                  _loc14_ = _loc5_[_loc13_] as EquipBaseAttrib;
                  _loc3_.push(_loc14_);
                  _loc11_--;
                  _loc12_ = _loc13_;
                  if(_loc5_.length <= 0)
                  {
                     break;
                  }
               }
            }
         }
         _loc8_ = int(_skillAttrib.getValue());
         if(_position.getValue() == 5 || _position.getValue() == 6 || _position.getValue() == 7)
         {
            if(Math.random() * 10 < 4)
            {
               _loc8_ = 0;
            }
         }
         _loc3_ = setFloat(_loc3_);
         return Equip.creatEquip(_id.getValue(),_loc3_,_loc8_,_grid.getValue());
      }
      
      public function get isStrengthen() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _isStrengthen;
      }
      
      public function getClassName() : String
      {
         return _className;
      }
      
      public function set skillAttrib(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _skillAttrib = param1;
      }
      
      public function getSuitId() : Number
      {
         return _suitId.getValue();
      }
      
      public function get reincarnationLimit() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _reincarnationLimit;
      }
   }
}

