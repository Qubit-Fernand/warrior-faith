package com.hotpoint.braveManIII.repository.chest
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class ChecstBasicData
   {
      
      private var _id:VT;
      
      private var _rewardId:VT;
      
      private var _type:VT;
      
      private var _probability:VT;
      
      public function ChecstBasicData()
      {
         super();
      }
      
      public static function creatChestBasicData(param1:Number, param2:Number, param3:Number, param4:Number) : ChecstBasicData
      {
         var _loc5_:ChecstBasicData = new ChecstBasicData();
         _loc5_._id = VT.createVT(param1);
         _loc5_._rewardId = VT.createVT(param2);
         _loc5_._type = VT.createVT(param3);
         _loc5_._probability = VT.createVT(param4);
         return _loc5_;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getRewardId() : Number
      {
         return this._rewardId.getValue();
      }
      
      public function getType() : Number
      {
         return this._type.getValue();
      }
      
      public function getProbability() : Number
      {
         return this._probability.getValue();
      }
   }
}

