package com.hotpoint.braveManIII.repository.achievement
{
   import com.hotpoint.braveManIII.models.achievement.*;
   import com.hotpoint.braveManIII.models.common.*;
   
   public class AchNumBasicData
   {
      
      private var _id:VT;
      
      private var _name:String;
      
      private var _frame:VT;
      
      private var _introduction:String;
      
      private var _type:Boolean;
      
      private var _numType:VT;
      
      private var _rewardAc:VT;
      
      private var _goodsId:Array;
      
      private var _goodsType:Array;
      
      private var _smallType:VT;
      
      private var _num:VT;
      
      private var _ts:VT;
      
      private var _ry:Boolean;
      
      private var _needType:VT;
      
      public function AchNumBasicData()
      {
         super();
      }
      
      public static function ceartAchNum(param1:Number, param2:String, param3:Number, param4:String, param5:Boolean, param6:Number, param7:Number, param8:String, param9:String, param10:Number, param11:Number, param12:Number, param13:Boolean, param14:Number) : AchNumBasicData
      {
         var _loc15_:AchNumBasicData = new AchNumBasicData();
         _loc15_._id = VT.createVT(param1);
         _loc15_._name = param2;
         _loc15_._frame = VT.createVT(param3);
         _loc15_._introduction = param4;
         _loc15_._type = param5;
         _loc15_._numType = VT.createVT(param6);
         _loc15_._rewardAc = VT.createVT(param7);
         _loc15_._goodsId = strToArr(param8);
         _loc15_._goodsType = strToArr(param9);
         _loc15_._smallType = VT.createVT(param10);
         _loc15_._num = VT.createVT(param11);
         _loc15_._ts = VT.createVT(param12);
         _loc15_._ry = param13;
         _loc15_._needType = VT.createVT(param14);
         return _loc15_;
      }
      
      private static function strToArr(param1:String) : Array
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_.push(VT.createVT(Number(_loc2_[_loc4_])));
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getIntroduction() : String
      {
         return this._introduction;
      }
      
      public function isEveryDady() : Boolean
      {
         return this._type;
      }
      
      public function getNumType() : Number
      {
         return this._numType.getValue();
      }
      
      public function getRewardAc() : Number
      {
         return this._rewardAc.getValue();
      }
      
      public function getGoddsId() : Array
      {
         return this._goodsId;
      }
      
      public function getSmall() : Number
      {
         return this._smallType.getValue();
      }
      
      public function getNum() : Number
      {
         return this._num.getValue();
      }
      
      public function getTs() : Number
      {
         return this._ts.getValue();
      }
      
      public function getGoodsType() : Array
      {
         return this._goodsType;
      }
      
      public function getRy() : Boolean
      {
         return this._ry;
      }
      
      public function getNeedType() : Number
      {
         return this._needType.getValue();
      }
      
      public function creatAcForNum() : Achievement
      {
         return Achievement.creatAchForNum(this._id.getValue());
      }
   }
}

