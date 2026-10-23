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
      
      public static function creatChestBasicData(id:Number, rewardId:Number, type:Number, probability:Number) : ChecstBasicData
      {
         var data:ChecstBasicData = new ChecstBasicData();
         data._id = VT.createVT(id);
         data._rewardId = VT.createVT(rewardId);
         data._type = VT.createVT(type);
         data._probability = VT.createVT(probability);
         return data;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getRewardId() : Number
      {
         return _rewardId.getValue();
      }
      
      public function getType() : Number
      {
         return _type.getValue();
      }
      
      public function getProbability() : Number
      {
         return _probability.getValue();
      }
   }
}

