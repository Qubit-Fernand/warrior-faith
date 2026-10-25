package com.hotpoint.braveManIII.repository.gem
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.gem.*;
   
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
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(value:VT) : void
      {
         this._frame = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get times() : VT
      {
         return this._times;
      }
      
      public function set times(value:VT) : void
      {
         this._times = value;
      }
      
      public function get type() : VT
      {
         return this._type;
      }
      
      public function set type(value:VT) : void
      {
         this._type = value;
      }
      
      public function get isPile() : Boolean
      {
         return this._isPile;
      }
      
      public function set isPile(value:Boolean) : void
      {
         this._isPile = value;
      }
      
      public function get isStrengthen() : Boolean
      {
         return this._isStrengthen;
      }
      
      public function set isStrengthen(value:Boolean) : void
      {
         this._isStrengthen = value;
      }
      
      public function get isCompound() : Boolean
      {
         return this._isCompound;
      }
      
      public function set isCompound(value:Boolean) : void
      {
         this._isCompound = value;
      }
      
      public function get dropLevel() : VT
      {
         return this._dropLevel;
      }
      
      public function set dropLevel(value:VT) : void
      {
         this._dropLevel = value;
      }
      
      public function get useLevel() : VT
      {
         return this._useLevel;
      }
      
      public function set useLevel(value:VT) : void
      {
         this._useLevel = value;
      }
      
      public function get pileLimit() : VT
      {
         return this._pileLimit;
      }
      
      public function set pileLimit(value:VT) : void
      {
         this._pileLimit = value;
      }
      
      public function get price() : VT
      {
         return this._price;
      }
      
      public function set price(value:VT) : void
      {
         this._price = value;
      }
      
      public function get color() : VT
      {
         return this._color;
      }
      
      public function set color(value:VT) : void
      {
         this._color = value;
      }
      
      public function get probability() : VT
      {
         return this._probability;
      }
      
      public function set probability(value:VT) : void
      {
         this._probability = value;
      }
      
      public function get descript() : String
      {
         return this._descript;
      }
      
      public function set descript(value:String) : void
      {
         this._descript = value;
      }
      
      public function get addSkill() : VT
      {
         return this._addSkill;
      }
      
      public function set addSkill(value:VT) : void
      {
         this._addSkill = value;
      }
      
      public function get addAttrib() : Array
      {
         return this._addAttrib;
      }
      
      public function set addAttrib(value:Array) : void
      {
         this._addAttrib = value;
      }
      
      public function get strengthenLevel() : VT
      {
         return this._strengthenLevel;
      }
      
      public function set strengthenLevel(value:VT) : void
      {
         this._strengthenLevel = value;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getIsStrengthen() : Boolean
      {
         return this._isStrengthen;
      }
      
      public function getDropLevel() : Number
      {
         return this._dropLevel.getValue();
      }
      
      public function getUseLevel() : Number
      {
         return this._useLevel.getValue();
      }
      
      public function getStrengthenLevel() : Number
      {
         return this._strengthenLevel.getValue();
      }
      
      public function getPrice() : Number
      {
         return this._price.getValue();
      }
      
      public function getIsCompound() : Boolean
      {
         return this._isCompound;
      }
      
      public function getColor() : Number
      {
         return this._color.getValue();
      }
      
      public function getDescript() : String
      {
         return this._descript;
      }
      
      public function getTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function getType() : int
      {
         return this._type.getValue();
      }
      
      public function getIsPile() : Boolean
      {
         return this._isPile;
      }
      
      public function getPileLimit() : Number
      {
         return this._pileLimit.getValue();
      }
      
      public function getProbability() : Number
      {
         return this._probability.getValue();
      }
      
      public function getAddSkill() : Number
      {
         return this._addSkill.getValue();
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
         if(this._type.getValue() == GemTypeConst.ATTRIBSTONE)
         {
            allAttrib = [];
            affectAttrib = [];
            for each(attrib in this._addAttrib)
            {
               allAttrib.push(attrib.getClone());
            }
            if(this._color.getValue() == 1 && allAttrib.length > 0)
            {
               if(this._isPile == true)
               {
                  att = allAttrib[0];
                  affectAttrib.push(att);
               }
               else
               {
                  index = int(this.getRandomType());
                  att = allAttrib[index] as Attribute;
                  affectAttrib.push(att);
               }
            }
            if(this._color.getValue() == 2 && allAttrib.length > 0)
            {
               number = 2;
               while(number > 0)
               {
                  index2 = int(this.getRandomType());
                  att2 = allAttrib[index2] as Attribute;
                  affectAttrib.push(att2);
                  number--;
               }
            }
            if(this._color.getValue() == 3 && allAttrib.length > 0)
            {
               number3 = 3;
               while(number3 > 0)
               {
                  index3 = int(this.getRandomType());
                  att3 = allAttrib[index3] as Attribute;
                  affectAttrib.push(att3);
                  number3--;
               }
            }
            return Gem.creatGem(this._id.getValue(),this._times.getValue(),affectAttrib);
         }
         affectAttrib = [];
         return Gem.creatGem(this._id.getValue(),this._times.getValue(),affectAttrib);
      }
      
      public function composeGem(attrib:Array) : Gem
      {
         return Gem.creatGem(this._id.getValue(),this._times.getValue(),attrib);
      }
      
      public function upLevelGem() : Gem
      {
         return Gem.creatGem(this._id.getValue(),this._times.getValue(),[]);
      }
   }
}

