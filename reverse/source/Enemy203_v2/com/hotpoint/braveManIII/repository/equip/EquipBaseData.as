package com.hotpoint.braveManIII.repository.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import flash.utils.*;
   
   public class EquipBaseData
   {
      
      private var _id:VT;
      
      private var _frame:VT;
      
      private var _name:String;
      
      private var _className:String;
      
      private var _className2:String;
      
      private var _position:VT;
      
      private var _dressLevel:VT;
      
      private var _dropLevel:VT;
      
      private var _descript:String;
      
      private var _price:VT;
      
      private var _reincarnationLimit:VT;
      
      private var _color:VT;
      
      private var _isStrengthen:Boolean;
      
      private var _grid:VT;
      
      private var _suitId:VT;
      
      private var _star:VT;
      
      private var _remainingTime:VT;
      
      private var _defaultTime:VT;
      
      private var _jinhua:VT;
      
      private var _baseAttrib:Array = [];
      
      private var _skillAttrib:VT;
      
      private var _blessAttrib:Array = [];
      
      public function EquipBaseData()
      {
         super();
      }
      
      public static function createEquipBaseData(param1:Number, param2:Number, param3:String, param4:String, param5:String, param6:Number, param7:Number, param8:Number, param9:String, param10:Number, param11:Number, param12:Number, param13:Boolean, param14:Number, param15:Number, param16:Number, param17:Number, param18:Number, param19:Number, param20:Array, param21:Array, param22:Number) : EquipBaseData
      {
         var _loc23_:EquipBaseData = new EquipBaseData();
         _loc23_._name = param3;
         _loc23_._className = param4;
         _loc23_._className2 = param5;
         _loc23_._descript = param9;
         _loc23_._isStrengthen = param13;
         _loc23_._baseAttrib = param20;
         _loc23_._blessAttrib = param21;
         _loc23_._id = VT.createVT(param1);
         _loc23_._frame = VT.createVT(param2);
         _loc23_._position = VT.createVT(param6);
         _loc23_._dressLevel = VT.createVT(param7);
         _loc23_._dropLevel = VT.createVT(param8);
         _loc23_._price = VT.createVT(param10);
         _loc23_._reincarnationLimit = VT.createVT(param11);
         _loc23_._color = VT.createVT(param12);
         _loc23_._grid = VT.createVT(param14);
         _loc23_._suitId = VT.createVT(param15);
         _loc23_._star = VT.createVT(param16);
         _loc23_._remainingTime = VT.createVT(param17);
         _loc23_._defaultTime = VT.createVT(param18);
         _loc23_._jinhua = VT.createVT(param19);
         _loc23_._skillAttrib = VT.createVT(param22);
         return _loc23_;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._id = param1;
      }
      
      public function get frame() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._frame;
      }
      
      public function set frame(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._frame = param1;
      }
      
      public function get name() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._name = param1;
      }
      
      public function get position() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._position;
      }
      
      public function set position(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._position = param1;
      }
      
      public function get dressLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._dressLevel;
      }
      
      public function set dressLevel(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._dressLevel = param1;
      }
      
      public function get dropLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._dropLevel;
      }
      
      public function set dropLevel(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._dropLevel = param1;
      }
      
      public function get descript() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._descript;
      }
      
      public function set descript(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._descript = param1;
      }
      
      public function get price() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._price;
      }
      
      public function set price(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._price = param1;
      }
      
      public function get reincarnationLimit() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._reincarnationLimit;
      }
      
      public function set reincarnationLimit(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._reincarnationLimit = param1;
      }
      
      public function get color() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._color;
      }
      
      public function set color(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._color = param1;
      }
      
      public function get isStrengthen() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._isStrengthen;
      }
      
      public function set isStrengthen(param1:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._isStrengthen = param1;
      }
      
      public function get grid() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._grid;
      }
      
      public function set grid(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._grid = param1;
      }
      
      public function get suitId() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._suitId;
      }
      
      public function set suitId(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._suitId = param1;
      }
      
      public function get baseAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._baseAttrib;
      }
      
      public function set baseAttrib(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._baseAttrib = param1;
      }
      
      public function get skillAttrib() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._skillAttrib;
      }
      
      public function set skillAttrib(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._skillAttrib = param1;
      }
      
      public function get className() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._className;
      }
      
      public function set className(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._className = param1;
      }
      
      public function get star() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._star;
      }
      
      public function set star(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._star = param1;
      }
      
      public function get remainingTime() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._remainingTime;
      }
      
      public function set remainingTime(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._remainingTime = param1;
      }
      
      public function get className2() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._className2;
      }
      
      public function set className2(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._className2 = param1;
      }
      
      public function get defaultTime() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._defaultTime;
      }
      
      public function set defaultTime(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._defaultTime = param1;
      }
      
      public function get blessAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._blessAttrib;
      }
      
      public function set blessAttrib(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._blessAttrib = param1;
      }
      
      public function get jinhua() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._jinhua;
      }
      
      public function set jinhua(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._jinhua = param1;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getPosition() : Number
      {
         return this._position.getValue();
      }
      
      public function getDressLevel() : Number
      {
         return this._dressLevel.getValue();
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getClassName() : String
      {
         return this._className;
      }
      
      public function getClassName2() : String
      {
         return this._className2;
      }
      
      public function getDescript() : String
      {
         return this._descript;
      }
      
      public function getPrice() : Number
      {
         return this._price.getValue();
      }
      
      public function getReincarnationLimit() : Number
      {
         return this._reincarnationLimit.getValue();
      }
      
      public function getColor() : Number
      {
         return this._color.getValue();
      }
      
      public function getStar() : Number
      {
         return this._star.getValue();
      }
      
      public function getRemainingTime() : Number
      {
         return this._remainingTime.getValue();
      }
      
      public function getDefaultTime() : Number
      {
         return this._defaultTime.getValue();
      }
      
      public function getJinHua() : Number
      {
         return this._jinhua.getValue();
      }
      
      public function getGrid() : Number
      {
         return this._grid.getValue();
      }
      
      public function getSuitId() : Number
      {
         return this._suitId.getValue();
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getIsStrengthen() : Boolean
      {
         return this._isStrengthen;
      }
      
      public function getDropLevel() : Number
      {
         return this._dropLevel.getValue();
      }
      
      public function getBlessAttrib() : Array
      {
         return this._blessAttrib;
      }
      
      private function getRandomType() : uint
      {
         var _loc1_:* = Math.random() * 100;
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
      
      public function createEquip() : Equip
      {
         var _loc1_:uint = 0;
         var _loc2_:Equip = null;
         var _loc7_:EquipBaseAttrib = null;
         var _loc9_:int = 0;
         var _loc10_:EquipBaseAttrib = null;
         var _loc11_:* = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:EquipBaseAttrib = null;
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         for each(_loc7_ in this._baseAttrib)
         {
            if(this._position.getValue() <= 7 || this._position.getValue() >= 10)
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
         }
         if(this._color.getValue() == 2 && _loc4_.length > 0)
         {
            _loc9_ = int(this.getRandomType());
            _loc10_ = _loc4_[_loc9_] as EquipBaseAttrib;
            _loc3_.push(_loc10_);
         }
         if((this._color.getValue() == 3 || this._color.getValue() == 4) && _loc5_.length > 0)
         {
            _loc11_ = 2;
            _loc12_ = -1;
            while(_loc11_ > 0)
            {
               _loc13_ = int(this.getRandomType());
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
         if(this._color.getValue() >= 5 && _loc5_.length > 0)
         {
            _loc11_ = 3;
            while(_loc11_ > 0)
            {
               _loc13_ = int(this.getRandomType());
               _loc14_ = _loc5_[_loc13_] as EquipBaseAttrib;
               _loc3_.push(_loc14_);
               _loc11_--;
               if(_loc5_.length <= 0)
               {
                  break;
               }
            }
            trace("深红装备~！");
         }
         var _loc8_:int = int(this._skillAttrib.getValue());
         _loc3_ = this.setFloat(_loc3_);
         if(this._position.getValue() == 8 || this._position.getValue() == 9)
         {
            _loc3_ = null;
         }
         return Equip.creatEquip(this._id.getValue(),_loc3_,_loc8_,this._grid.getValue());
      }
      
      private function setFloat(param1:Array) : Array
      {
         var _loc3_:EquipBaseAttrib = null;
         var _loc4_:* = undefined;
         var _loc2_:Array = [];
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
      
      public function createShopEquip() : Equip
      {
         var _loc1_:uint = 0;
         var _loc2_:Equip = null;
         var _loc6_:EquipBaseAttrib = null;
         var _loc8_:int = 0;
         var _loc9_:EquipBaseAttrib = null;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:EquipBaseAttrib = null;
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         for each(_loc6_ in this._baseAttrib)
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
         if(this._color.getValue() == 2 && _loc4_.length > 0)
         {
            _loc8_ = int(this.getRandomType());
            _loc9_ = _loc4_[_loc8_] as EquipBaseAttrib;
            _loc3_.push(_loc9_);
         }
         if(this._color.getValue() == 3 && _loc5_.length > 0)
         {
            _loc10_ = 2;
            _loc11_ = -1;
            while(_loc10_ > 0)
            {
               _loc12_ = int(this.getRandomType());
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
         var _loc7_:int = int(this._skillAttrib.getValue());
         if(this._position.getValue() == 5)
         {
            if(Math.random() * 10 < 5)
            {
               _loc7_ = 0;
            }
         }
         return Equip.creatEquip(this._id.getValue(),_loc3_,_loc7_,this._grid.getValue());
      }
   }
}

