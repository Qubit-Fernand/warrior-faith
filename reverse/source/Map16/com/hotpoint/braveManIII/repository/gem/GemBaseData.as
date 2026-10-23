package com.hotpoint.braveManIII.repository.gem
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import flash.utils.*;
   
   public class GemBaseData
   {
      
      private var _id:VT;
      
      private var _frame:VT;
      
      private var _name:String;
      
      private var _times:VT;
      
      private var _type:VT;
      
      private var _isPile:Boolean;
      
      private var _isStrengthen:Boolean;
      
      private var _isCompound:Boolean;
      
      private var _dropLevel:VT;
      
      private var _useLevel:VT;
      
      private var _strengthenLevel:VT;
      
      private var _pileLimit:VT;
      
      private var _price:VT;
      
      private var _color:VT;
      
      private var _probability:VT;
      
      private var _descript:String;
      
      private var _addSkill:VT;
      
      private var _addAttrib:Array = [];
      
      public function GemBaseData()
      {
         super();
      }
      
      public static function cteateGemBaseData(id:Number, frame:Number, name:String, descript:String, times:Number, type:int, isPile:Boolean, isStrengthen:Boolean, isCompound:Boolean, dropLevel:Number, useLevel:Number, strengthenLevel:Number, pileLimit:Number, price:Number, color:Number, probability:Number, addAttrib:Array, addSkill:Number) : GemBaseData
      {
         var gemBaseData:GemBaseData = new GemBaseData();
         gemBaseData._id = VT.createVT(id);
         gemBaseData._frame = VT.createVT(frame);
         gemBaseData._name = name;
         gemBaseData._descript = descript;
         gemBaseData._times = VT.createVT(times);
         gemBaseData._type = VT.createVT(type);
         gemBaseData._isPile = isPile;
         gemBaseData._isStrengthen = isStrengthen;
         gemBaseData._isCompound = isCompound;
         gemBaseData._dropLevel = VT.createVT(dropLevel);
         gemBaseData._useLevel = VT.createVT(useLevel);
         gemBaseData._strengthenLevel = VT.createVT(strengthenLevel);
         gemBaseData._pileLimit = VT.createVT(pileLimit);
         gemBaseData._price = VT.createVT(price);
         gemBaseData._color = VT.createVT(color);
         gemBaseData._probability = VT.createVT(probability);
         gemBaseData._addAttrib = addAttrib;
         gemBaseData._addSkill = VT.createVT(addSkill);
         return gemBaseData;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _id = value;
      }
      
      public function get frame() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _frame;
      }
      
      public function set frame(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _frame = value;
      }
      
      public function get name() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _name;
      }
      
      public function set name(value:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _name = value;
      }
      
      public function get times() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _times = value;
      }
      
      public function get type() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _type;
      }
      
      public function set type(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _type = value;
      }
      
      public function get isPile() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _isPile;
      }
      
      public function set isPile(value:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _isPile = value;
      }
      
      public function get isStrengthen() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _isStrengthen;
      }
      
      public function set isStrengthen(value:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _isStrengthen = value;
      }
      
      public function get isCompound() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _isCompound;
      }
      
      public function set isCompound(value:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _isCompound = value;
      }
      
      public function get dropLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _dropLevel;
      }
      
      public function set dropLevel(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _dropLevel = value;
      }
      
      public function get useLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _useLevel;
      }
      
      public function set useLevel(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _useLevel = value;
      }
      
      public function get pileLimit() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _pileLimit;
      }
      
      public function set pileLimit(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _pileLimit = value;
      }
      
      public function get price() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _price;
      }
      
      public function set price(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _price = value;
      }
      
      public function get color() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _color;
      }
      
      public function set color(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _color = value;
      }
      
      public function get probability() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _probability;
      }
      
      public function set probability(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _probability = value;
      }
      
      public function get descript() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _descript;
      }
      
      public function set descript(value:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _descript = value;
      }
      
      public function get addSkill() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _addSkill;
      }
      
      public function set addSkill(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _addSkill = value;
      }
      
      public function get addAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _addAttrib;
      }
      
      public function set addAttrib(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _addAttrib = value;
      }
      
      public function get strengthenLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _strengthenLevel;
      }
      
      public function set strengthenLevel(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _strengthenLevel = value;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getIsStrengthen() : Boolean
      {
         return _isStrengthen;
      }
      
      public function getDropLevel() : Number
      {
         return _dropLevel.getValue();
      }
      
      public function getUseLevel() : Number
      {
         return _useLevel.getValue();
      }
      
      public function getStrengthenLevel() : Number
      {
         return _strengthenLevel.getValue();
      }
      
      public function getPrice() : Number
      {
         return _price.getValue();
      }
      
      public function getIsCompound() : Boolean
      {
         return _isCompound;
      }
      
      public function getColor() : Number
      {
         return _color.getValue();
      }
      
      public function getDescript() : String
      {
         return _descript;
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function getType() : int
      {
         return _type.getValue();
      }
      
      public function getIsPile() : Boolean
      {
         return _isPile;
      }
      
      public function getPileLimit() : Number
      {
         return _pileLimit.getValue();
      }
      
      public function getProbability() : Number
      {
         return _probability.getValue();
      }
      
      public function getAddSkill() : Number
      {
         return _addSkill.getValue();
      }
      
      private function getRandomType() : uint
      {
         var rdm:* = Math.random() * 100;
         if(rdm >= 0 && rdm < 16)
         {
            return 0;
         }
         if(rdm >= 16 && rdm < 33)
         {
            return 1;
         }
         if(rdm >= 33 && rdm < 50)
         {
            return 2;
         }
         if(rdm >= 50 && rdm < 67)
         {
            return 3;
         }
         if(rdm >= 67 && rdm < 84)
         {
            return 4;
         }
         return 5;
      }
      
      public function createGem() : Gem
      {
         var allAttrib:Array = null;
         var affectAttrib:Array = null;
         var attrib:Attribute = null;
         var att:Attribute = null;
         var index:int = 0;
         var number:* = 0;
         var index2:int = 0;
         var att2:Attribute = null;
         var number3:* = 0;
         var index3:int = 0;
         var att3:Attribute = null;
         if(_type.getValue() == GemTypeConst.ATTRIBSTONE)
         {
            allAttrib = [];
            affectAttrib = [];
            for each(attrib in _addAttrib)
            {
               allAttrib.push(attrib.getClone());
            }
            if(_color.getValue() == 1 && allAttrib.length > 0)
            {
               if(_isPile == true)
               {
                  att = allAttrib[0];
                  affectAttrib.push(att);
               }
               else
               {
                  index = int(getRandomType());
                  att = allAttrib[index] as Attribute;
                  affectAttrib.push(att);
               }
            }
            if(_color.getValue() == 2 && allAttrib.length > 0)
            {
               number = 2;
               while(number > 0)
               {
                  index2 = int(getRandomType());
                  att2 = allAttrib[index2] as Attribute;
                  affectAttrib.push(att2);
                  number--;
               }
            }
            if(_color.getValue() == 3 && allAttrib.length > 0)
            {
               number3 = 3;
               while(number3 > 0)
               {
                  index3 = int(getRandomType());
                  att3 = allAttrib[index3] as Attribute;
                  affectAttrib.push(att3);
                  number3--;
               }
            }
            return Gem.creatGem(_id.getValue(),_times.getValue(),affectAttrib);
         }
         affectAttrib = [];
         return Gem.creatGem(_id.getValue(),_times.getValue(),affectAttrib);
      }
      
      public function composeGem(attrib:Array) : Gem
      {
         return Gem.creatGem(_id.getValue(),_times.getValue(),attrib);
      }
      
      public function upLevelGem() : Gem
      {
         return Gem.creatGem(_id.getValue(),_times.getValue(),[]);
      }
   }
}

