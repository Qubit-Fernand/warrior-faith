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
      
      public static function ceartAchNum(id:Number, name:String, frame:Number, sm:String, type:Boolean, numType:Number, rewardAc:Number, goodsId:String, goodsType:String, smallType:Number, num:Number, ts:Number, ry:Boolean, needType:Number) : AchNumBasicData
      {
         var data:AchNumBasicData = new AchNumBasicData();
         data._id = VT.createVT(id);
         data._name = name;
         data._frame = VT.createVT(frame);
         data._introduction = sm;
         data._type = type;
         data._numType = VT.createVT(numType);
         data._rewardAc = VT.createVT(rewardAc);
         data._goodsId = strToArr(goodsId);
         data._goodsType = strToArr(goodsType);
         data._smallType = VT.createVT(smallType);
         data._num = VT.createVT(num);
         data._ts = VT.createVT(ts);
         data._ry = ry;
         data._needType = VT.createVT(needType);
         return data;
      }
      
      private static function strToArr(str:String) : Array
      {
         var arr:Array = str.split(",");
         var vtArr:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            vtArr.push(VT.createVT(Number(arr[i])));
         }
         return vtArr;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function isEveryDady() : Boolean
      {
         return _type;
      }
      
      public function getNumType() : Number
      {
         return _numType.getValue();
      }
      
      public function getRewardAc() : Number
      {
         return _rewardAc.getValue();
      }
      
      public function getGoddsId() : Array
      {
         return _goodsId;
      }
      
      public function getSmall() : Number
      {
         return _smallType.getValue();
      }
      
      public function getNum() : Number
      {
         return _num.getValue();
      }
      
      public function getTs() : Number
      {
         return _ts.getValue();
      }
      
      public function getGoodsType() : Array
      {
         return _goodsType;
      }
      
      public function getRy() : Boolean
      {
         return _ry;
      }
      
      public function getNeedType() : Number
      {
         return _needType.getValue();
      }
      
      public function creatAcForNum() : Achievement
      {
         return Achievement.creatAchForNum(_id.getValue());
      }
   }
}

