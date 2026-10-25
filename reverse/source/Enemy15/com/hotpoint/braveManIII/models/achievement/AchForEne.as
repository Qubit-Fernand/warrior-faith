package com.hotpoint.braveManIII.models.achievement
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.achievement.*;
   
   public class AchForEne
   {
      
      private var _id:VT;
      
      private var _mapId:VT;
      
      private var _enemyNumed:Array = [];
      
      private var _allEnemyNum:VT;
      
      private var _agin:Boolean;
      
      public function AchForEne()
      {
         super();
      }
      
      public static function creatAchEne(id:Number) : AchForEne
      {
         var data:AchForEne = new AchForEne();
         data._id = VT.createVT(id);
         data._mapId = VT.createVT(-1);
         data.initEnemyNum();
         data._allEnemyNum = VT.createVT(0);
         data._agin = false;
         return data;
      }
      
      private function initEnemyNum() : void
      {
         var arr:Array = getEnemyId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            _enemyNumed[i] = 0;
         }
      }
      
      public function getEnemyed() : Array
      {
         return _enemyNumed;
      }
      
      public function duAcEnemyid(arr:Array) : void
      {
         _enemyNumed = arr;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getMapId() : Array
      {
         return AchEneFactory.getMapId(_id.getValue());
      }
      
      public function setMapId(num:Number) : void
      {
         if(num != 0)
         {
            _mapId.setValue(num);
         }
      }
      
      public function getEnemyId() : Array
      {
         return AchEneFactory.getEnemyId(_id.getValue());
      }
      
      public function getEneRy() : Boolean
      {
         return AchEneFactory.isEneRy(_id.getValue());
      }
      
      public function getEnemyNum() : Number
      {
         return AchEneFactory.getEnemyNum(_id.getValue());
      }
      
      public function setEneNum(id:Number) : void
      {
         var i:uint = 0;
         var arr:Array = getEnemyId();
         if(arr.length == 1 && arr[0].getValue() == -1)
         {
            if(getEneRy())
            {
               if(_enemyNumed[0] < getEnemyNum())
               {
                  ++_enemyNumed[0];
               }
            }
         }
         else if(arr.length > 0 && arr[0].getValue() != -1)
         {
            for(i = 0; i < arr.length; i++)
            {
               if((arr[i] as VT).getValue() == id)
               {
                  if(_enemyNumed[i] < getEnemyNum())
                  {
                     ++_enemyNumed[i];
                     break;
                  }
               }
            }
         }
      }
      
      public function isAginEne() : Boolean
      {
         return AchEneFactory.isEnemyAgin(_id.getValue);
      }
      
      public function isEnemyOk() : Boolean
      {
         if(isMapOk() && Boolean(isEneNumOk()))
         {
            return true;
         }
         return false;
      }
      
      public function isMapOk() : Boolean
      {
         var mapArr:Array = getMapId();
         if(mapArr[0].getValue() == -1)
         {
            return true;
         }
         if(mapArr[0].getValue() == _mapId.getValue())
         {
            trace("有地图要求,地图满足");
            return true;
         }
         return false;
      }
      
      private function isAginOk() : Boolean
      {
         if(isAginEne())
         {
            if(_agin)
            {
               return true;
            }
            return false;
         }
         return true;
      }
      
      private function isEneNumOk() : Boolean
      {
         var num:Number = NaN;
         var bo:Boolean = false;
         var i:uint = 0;
         var eId:Array = getEnemyId();
         if(eId.length == 1 && eId[0].getValue() == -1)
         {
            if(!getEneRy())
            {
               return true;
            }
            trace(getEnemyNum(),_enemyNumed[0]);
            if(getEnemyNum() == _enemyNumed[0])
            {
               trace("杀死任意怪物满足");
               return true;
            }
         }
         else
         {
            num = getEnemyNum();
            if(!getEneRy())
            {
               bo = true;
               for(i = 0; i < _enemyNumed.length; i++)
               {
                  if(_enemyNumed[i] != num)
                  {
                     bo = false;
                     break;
                  }
               }
               if(bo == true)
               {
                  trace("指定的每个都满足了");
               }
               return bo;
            }
            for(i = 0; i < _enemyNumed.length; i++)
            {
               if(_enemyNumed[i] == num)
               {
                  trace("多ID指定的满足了");
                  return true;
               }
            }
         }
         return false;
      }
      
      public function clearEnemyNum() : void
      {
         var arr:Array = getEnemyId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            _enemyNumed[i] = -1;
         }
      }
   }
}

