package com.hotpoint.braveManIII.repository.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   
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
      
      private var _baseAttrib:Array = [];
      
      private var _skillAttrib:VT;
      
      private var _blessAttrib:Array = [];
      
      public function EquipBaseData()
      {
         super();
      }
      
      public static function createEquipBaseData(id:Number, frame:Number, name:String, className:String, className2:String, position:Number, dressLevel:Number, dropLevel:Number, descript:String, price:Number, reincarnationLimit:Number, color:Number, isStrengthen:Boolean, grid:Number, suitId:Number, star:Number, remainingTime:Number, defaultTime:Number, baseAttrib:Array, blessAttrib:Array, skillAttrib:Number) : EquipBaseData
      {
         var equipBaseData:EquipBaseData = new EquipBaseData();
         equipBaseData._name = name;
         equipBaseData._className = className;
         equipBaseData._className2 = className2;
         equipBaseData._descript = descript;
         equipBaseData._isStrengthen = isStrengthen;
         equipBaseData._baseAttrib = baseAttrib;
         equipBaseData._blessAttrib = blessAttrib;
         equipBaseData._id = VT.createVT(id);
         equipBaseData._frame = VT.createVT(frame);
         equipBaseData._position = VT.createVT(position);
         equipBaseData._dressLevel = VT.createVT(dressLevel);
         equipBaseData._dropLevel = VT.createVT(dropLevel);
         equipBaseData._price = VT.createVT(price);
         equipBaseData._reincarnationLimit = VT.createVT(reincarnationLimit);
         equipBaseData._color = VT.createVT(color);
         equipBaseData._grid = VT.createVT(grid);
         equipBaseData._suitId = VT.createVT(suitId);
         equipBaseData._star = VT.createVT(star);
         equipBaseData._remainingTime = VT.createVT(remainingTime);
         equipBaseData._defaultTime = VT.createVT(defaultTime);
         equipBaseData._skillAttrib = VT.createVT(skillAttrib);
         return equipBaseData;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(value:VT) : void
      {
         _frame = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get position() : VT
      {
         return _position;
      }
      
      public function set position(value:VT) : void
      {
         _position = value;
      }
      
      public function get dressLevel() : VT
      {
         return _dressLevel;
      }
      
      public function set dressLevel(value:VT) : void
      {
         _dressLevel = value;
      }
      
      public function get dropLevel() : VT
      {
         return _dropLevel;
      }
      
      public function set dropLevel(value:VT) : void
      {
         _dropLevel = value;
      }
      
      public function get descript() : String
      {
         return _descript;
      }
      
      public function set descript(value:String) : void
      {
         _descript = value;
      }
      
      public function get price() : VT
      {
         return _price;
      }
      
      public function set price(value:VT) : void
      {
         _price = value;
      }
      
      public function get reincarnationLimit() : VT
      {
         return _reincarnationLimit;
      }
      
      public function set reincarnationLimit(value:VT) : void
      {
         _reincarnationLimit = value;
      }
      
      public function get color() : VT
      {
         return _color;
      }
      
      public function set color(value:VT) : void
      {
         _color = value;
      }
      
      public function get isStrengthen() : Boolean
      {
         return _isStrengthen;
      }
      
      public function set isStrengthen(value:Boolean) : void
      {
         _isStrengthen = value;
      }
      
      public function get grid() : VT
      {
         return _grid;
      }
      
      public function set grid(value:VT) : void
      {
         _grid = value;
      }
      
      public function get suitId() : VT
      {
         return _suitId;
      }
      
      public function set suitId(value:VT) : void
      {
         _suitId = value;
      }
      
      public function get baseAttrib() : Array
      {
         return _baseAttrib;
      }
      
      public function set baseAttrib(value:Array) : void
      {
         _baseAttrib = value;
      }
      
      public function get skillAttrib() : VT
      {
         return _skillAttrib;
      }
      
      public function set skillAttrib(value:VT) : void
      {
         _skillAttrib = value;
      }
      
      public function get className() : String
      {
         return _className;
      }
      
      public function set className(value:String) : void
      {
         _className = value;
      }
      
      public function get star() : VT
      {
         return _star;
      }
      
      public function set star(value:VT) : void
      {
         _star = value;
      }
      
      public function get remainingTime() : VT
      {
         return _remainingTime;
      }
      
      public function set remainingTime(value:VT) : void
      {
         _remainingTime = value;
      }
      
      public function get className2() : String
      {
         return _className2;
      }
      
      public function set className2(value:String) : void
      {
         _className2 = value;
      }
      
      public function get defaultTime() : VT
      {
         return _defaultTime;
      }
      
      public function set defaultTime(value:VT) : void
      {
         _defaultTime = value;
      }
      
      public function get blessAttrib() : Array
      {
         return _blessAttrib;
      }
      
      public function set blessAttrib(value:Array) : void
      {
         _blessAttrib = value;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getPosition() : Number
      {
         return _position.getValue();
      }
      
      public function getDressLevel() : Number
      {
         return _dressLevel.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getClassName() : String
      {
         return _className;
      }
      
      public function getClassName2() : String
      {
         return _className2;
      }
      
      public function getDescript() : String
      {
         return _descript;
      }
      
      public function getPrice() : Number
      {
         return _price.getValue();
      }
      
      public function getReincarnationLimit() : Number
      {
         return _reincarnationLimit.getValue();
      }
      
      public function getColor() : Number
      {
         return _color.getValue();
      }
      
      public function getStar() : Number
      {
         return _star.getValue();
      }
      
      public function getRemainingTime() : Number
      {
         return _remainingTime.getValue();
      }
      
      public function getDefaultTime() : Number
      {
         return _defaultTime.getValue();
      }
      
      public function getGrid() : Number
      {
         return _grid.getValue();
      }
      
      public function getSuitId() : Number
      {
         return _suitId.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getIsStrengthen() : Boolean
      {
         return _isStrengthen;
      }
      
      public function getDropLevel() : Number
      {
         return _dropLevel.getValue();
      }
      
      public function getBlessAttrib() : Array
      {
         return _blessAttrib;
      }
      
      private function getRandomType() : uint
      {
         var rdm:* = Math.random() * 100;
         if(rdm >= 0 && rdm < 22)
         {
            return 0;
         }
         if(rdm >= 22 && rdm < 44)
         {
            return 1;
         }
         if(rdm >= 44 && rdm < 66)
         {
            return 2;
         }
         if(rdm >= 66 && rdm < 83)
         {
            return 3;
         }
         return 4;
      }
      
      public function createEquip() : Equip
      {
         var type:uint = 0;
         var equip:Equip = null;
         var attrib:EquipBaseAttrib = null;
         var index:int = 0;
         var blueBaseAttrib:EquipBaseAttrib = null;
         var number:* = 0;
         var temp:int = 0;
         var pinkIndex:int = 0;
         var pinkBaseAttrib:EquipBaseAttrib = null;
         var baseAttrib:Array = [];
         var blueAttrib:Array = [];
         var pinkAttrib:Array = [];
         var goldAttrib:Array = [];
         for each(attrib in _baseAttrib)
         {
            if(attrib.getColorType() == 1)
            {
               baseAttrib.push(attrib.getClone());
            }
            else if(attrib.getColorType() == 2)
            {
               blueAttrib.push(attrib.getClone());
            }
            else if(attrib.getColorType() == 3)
            {
               pinkAttrib.push(attrib.getClone());
            }
         }
         if(_color.getValue() == 2 && blueAttrib.length > 0)
         {
            index = int(getRandomType());
            blueBaseAttrib = blueAttrib[index] as EquipBaseAttrib;
            baseAttrib.push(blueBaseAttrib);
         }
         if((_color.getValue() == 3 || _color.getValue() == 4) && pinkAttrib.length > 0)
         {
            number = 2;
            temp = -1;
            while(number > 0)
            {
               pinkIndex = int(getRandomType());
               if(temp != pinkIndex)
               {
                  pinkBaseAttrib = pinkAttrib[pinkIndex] as EquipBaseAttrib;
                  baseAttrib.push(pinkBaseAttrib);
                  number--;
                  temp = pinkIndex;
                  if(pinkAttrib.length <= 0)
                  {
                     break;
                  }
               }
            }
         }
         if(_color.getValue() == 5 && pinkAttrib.length > 0)
         {
            number = 3;
            while(number > 0)
            {
               pinkIndex = int(getRandomType());
               pinkBaseAttrib = pinkAttrib[pinkIndex] as EquipBaseAttrib;
               baseAttrib.push(pinkBaseAttrib);
               number--;
               if(pinkAttrib.length <= 0)
               {
                  break;
               }
            }
         }
         var sk:int = int(_skillAttrib.getValue());
         baseAttrib = setFloat(baseAttrib);
         if(_position.getValue() == 8 || _position.getValue() == 9)
         {
            baseAttrib = null;
         }
         return Equip.creatEquip(_id.getValue(),baseAttrib,sk,_grid.getValue());
      }
      
      private function setFloat(baseAttribArr:Array) : Array
      {
         var attrib:EquipBaseAttrib = null;
         var numValue:* = undefined;
         var returnArr:Array = [];
         for each(attrib in baseAttribArr)
         {
            numValue = attrib.getValue();
            if(numValue > 2 && numValue <= 10)
            {
               attrib.setValue(numValue - Math.round(Math.random()));
            }
            else if(numValue > 10 && numValue <= 20)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 2));
            }
            else if(numValue > 20 && numValue <= 30)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 3));
            }
            else if(numValue > 30 && numValue <= 40)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 3));
            }
            else if(numValue > 40 && numValue <= 50)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 4));
            }
            else if(numValue > 50 && numValue <= 60)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 4));
            }
            else if(numValue > 60 && numValue <= 70)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 5));
            }
            else if(numValue > 70 && numValue <= 80)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 5));
            }
            else if(numValue > 80 && numValue <= 90)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 6));
            }
            else if(numValue > 90 && numValue <= 100)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 6));
            }
            else if(numValue > 100 && numValue <= 120)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 7));
            }
            else if(numValue > 120 && numValue <= 140)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 7));
            }
            else if(numValue > 140 && numValue <= 160)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 7));
            }
            else if(numValue > 160 && numValue <= 200)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 8));
            }
            else if(numValue > 200 && numValue <= 260)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 9));
            }
            else if(numValue > 260 && numValue <= 330)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 9));
            }
            else if(numValue > 330 && numValue <= 400)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 10));
            }
            else if(numValue > 400 && numValue <= 500)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 12));
            }
            else if(numValue > 500 && numValue <= 600)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 14));
            }
            else if(numValue > 600 && numValue <= 700)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 14));
            }
            else if(numValue > 700 && numValue <= 800)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 15));
            }
            else if(numValue > 800 && numValue <= 900)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 15));
            }
            else if(numValue > 900 && numValue <= 1000)
            {
               attrib.setValue(numValue - Math.round(Math.random() * 15));
            }
            returnArr.push(attrib);
         }
         return returnArr;
      }
      
      public function createShopEquip() : Equip
      {
         var type:uint = 0;
         var equip:Equip = null;
         var attrib:EquipBaseAttrib = null;
         var index:int = 0;
         var blueBaseAttrib:EquipBaseAttrib = null;
         var number:* = 0;
         var temp:int = 0;
         var pinkIndex:int = 0;
         var pinkBaseAttrib:EquipBaseAttrib = null;
         var baseAttrib:Array = [];
         var blueAttrib:Array = [];
         var pinkAttrib:Array = [];
         for each(attrib in _baseAttrib)
         {
            if(attrib.getColorType() == 1)
            {
               baseAttrib.push(attrib.getClone());
            }
            else if(attrib.getColorType() == 2)
            {
               blueAttrib.push(attrib.getClone());
            }
            else if(attrib.getColorType() == 3)
            {
               pinkAttrib.push(attrib.getClone());
            }
         }
         if(_color.getValue() == 2 && blueAttrib.length > 0)
         {
            index = int(getRandomType());
            blueBaseAttrib = blueAttrib[index] as EquipBaseAttrib;
            baseAttrib.push(blueBaseAttrib);
         }
         if(_color.getValue() == 3 && pinkAttrib.length > 0)
         {
            number = 2;
            temp = -1;
            while(number > 0)
            {
               pinkIndex = int(getRandomType());
               if(temp != pinkIndex)
               {
                  pinkBaseAttrib = pinkAttrib[pinkIndex] as EquipBaseAttrib;
                  baseAttrib.push(pinkBaseAttrib);
                  number--;
                  temp = pinkIndex;
                  if(pinkAttrib.length <= 0)
                  {
                     break;
                  }
               }
            }
         }
         var sk:int = int(_skillAttrib.getValue());
         if(_position.getValue() == 5)
         {
            if(Math.random() * 10 < 5)
            {
               sk = 0;
            }
         }
         return Equip.creatEquip(_id.getValue(),baseAttrib,sk,_grid.getValue());
      }
   }
}

