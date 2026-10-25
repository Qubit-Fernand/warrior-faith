package com.hotpoint.braveManIII.repository.achievement
{
   import com.hotpoint.braveManIII.models.achievement.*;
   import com.hotpoint.braveManIII.models.common.*;
   
   public class AchForEnemyBasicData
   {
      
      private var _id:VT;
      
      private var _mapId:String;
      
      private var _enemyId:String;
      
      private var _eneRy:Boolean;
      
      private var _eneNum:VT;
      
      private var _eneAgin:Boolean;
      
      public function AchForEnemyBasicData()
      {
         super();
      }
      
      public static function creatAchEne(id:Number, mapId:String, eId:String, eRy:Boolean, eneNum:Number, eAgin:Boolean) : AchForEnemyBasicData
      {
         var data:AchForEnemyBasicData = new AchForEnemyBasicData();
         data._id = VT.createVT(id);
         data._mapId = mapId;
         data._enemyId = eId;
         data._eneRy = eRy;
         data._eneNum = VT.createVT(eneNum);
         data._eneAgin = eAgin;
         return data;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getMapId() : Array
      {
         return strToArr(_mapId);
      }
      
      public function getEnemyId() : Array
      {
         return strToArr(_enemyId);
      }
      
      public function getEneRy() : Boolean
      {
         return _eneRy;
      }
      
      public function getEnemyNum() : Number
      {
         return _eneNum.getValue();
      }
      
      public function isAginEne() : Boolean
      {
         return _eneAgin;
      }
      
      private function strToArr(str:String) : Array
      {
         var arr:Array = str.split(",");
         var vtArr:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            vtArr.push(VT.createVT(Number(arr[i])));
         }
         return vtArr;
      }
      
      public function creatAchEne() : AchForEne
      {
         return AchForEne.creatAchEne(_id.getValue());
      }
   }
}

