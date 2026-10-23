package com.hotpoint.braveManIII.repository.achievement
{
   import com.hotpoint.braveManIII.models.achievement.*;
   import com.hotpoint.braveManIII.models.common.*;
   
   public class AchSmBasicData
   {
      
      private var _id:VT;
      
      private var _name:String;
      
      private var _frame:VT;
      
      private var _introduction:String;
      
      private var _type:Boolean;
      
      private var _numType:VT;
      
      private var _whoType:VT;
      
      private var _rewardAc:VT;
      
      private var _rewardGood:VT;
      
      public function AchSmBasicData()
      {
         super();
      }
      
      public static function creatSm(id:Number, name:String, frame:Number, introduction:String, type:Boolean, numType:Number, whoType:Number, rewardAc:Number) : AchSmBasicData
      {
         var data:AchSmBasicData = new AchSmBasicData();
         data._id = VT.createVT(id);
         data._name = name;
         data._frame = VT.createVT(frame);
         data._introduction = introduction;
         data._type = type;
         data._numType = VT.createVT(numType);
         data._whoType = VT.createVT(whoType);
         data._rewardAc = VT.createVT(rewardAc);
         return data;
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
      
      public function getWhoType() : Number
      {
         return _whoType.getValue();
      }
      
      public function getRewardAc() : Number
      {
         return _rewardAc.getValue();
      }
      
      public function creatAch() : Achievement
      {
         return Achievement.creatAch(_id.getValue());
      }
   }
}

