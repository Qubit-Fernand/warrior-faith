package com.hotpoint.braveManIII.views.achPanel
{
   import com.hotpoint.braveManIII.models.achievement.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.achievement.*;
   import src.*;
   
   public class AchData
   {
      
      public static var allDataArr:Array = [];
      
      public static var xxx:Array = [];
      
      public static var cjPointSave:Array = new Array();
      
      public static var cjPoint_1:VT = new VT();
      
      public static var cjPoint_2:VT = new VT();
      
      public static var cjPoint_RiQi:VT = new VT();
      
      public function AchData()
      {
         super();
      }
      
      public static function getAllAch() : Array
      {
         if(allDataArr.length == 0)
         {
            allDataArr = AchSmFactory.allAc;
            duAc();
            cjPointSave = [AchData.cjPoint_1,AchData.cjPoint_2,AchData.cjPoint_RiQi];
         }
         return allDataArr;
      }
      
      public static function addEnemyNum(enemyId:Number) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            if(data.getStata() == 0 && data.getWhoType() == 0)
            {
               if((data.getObj() as AchForEne).isMapOk())
               {
                  (data.getObj() as AchForEne).setEneNum(enemyId);
               }
            }
         }
      }
      
      public static function addMapEnemy(map:Number) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            if(data.getStata() == 0 && data.getWhoType() == 0)
            {
               (data.getObj() as AchForEne).setMapId(map);
            }
         }
      }
      
      public static function isAcOk() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            if(data.getStata() == 0 && data.isOk())
            {
               if(data.isEveryDady())
               {
                  data.setStata(3);
                  data.setOverTimer(Main.serverTime.getValue());
                  cjPoint_1.setValue(cjPoint_1.getValue() + InitData.cjPoint.getValue());
                  cjPoint_2.setValue(cjPoint_2.getValue() + InitData.cjPoint.getValue());
               }
               else
               {
                  data.setStata(2);
                  cjPoint_2.setValue(cjPoint_2.getValue() + InitData.cjPoint.getValue());
               }
               trace("成就完成");
            }
         }
      }
      
      public static function upPoint() : void
      {
         var data:Achievement = null;
         var num:VT = new VT();
         var arr:Array = [];
         for each(data in allDataArr)
         {
            if(!data.isEveryDady() && data.getStata() == 2)
            {
               arr.push(data);
            }
         }
         num.setValue(arr.length);
         if(Main.serverTime.getValue() > cjPointSave[2].getValue())
         {
            cjPoint_2.setValue(cjPoint_2.getValue() + num.getValue());
            cjPoint_RiQi.setValue(Main.serverTime.getValue());
         }
      }
      
      public static function save() : Array
      {
         var data:Achievement = null;
         var arr:Array = null;
         cjPointSave = [AchData.cjPoint_1,AchData.cjPoint_2,AchData.cjPoint_RiQi];
         trace("allDataArr.length:" + allDataArr.length);
         for(var z:uint = 0; z < allDataArr.length; z++)
         {
            data = allDataArr[z];
            if(data.getWhoType() == 0)
            {
               if(!xxx[0])
               {
                  xxx[0] = [];
               }
               arr = (data.getObj() as AchForEne).getEnemyed();
               xxx[0][data.getId()] = [data.getStata(),arr,data.getOverTimer()];
            }
         }
         return xxx;
      }
      
      public static function duAc() : void
      {
         var i:uint = 0;
         var j:uint = 0;
         var z:uint = 0;
         var data:Achievement = null;
         var id:Number = NaN;
         for(i in xxx)
         {
            for(j in xxx[i])
            {
               for(z = 0; z < allDataArr.length; z++)
               {
                  data = allDataArr[z];
                  id = data.getId();
                  if(i == 0)
                  {
                     trace("\nid = " + id + ",xxx[i][id] = " + xxx[i][id]);
                     data.setStata(xxx[i][id][0]);
                     data.setOverTimer(xxx[i][id][2]);
                     (data.getObj() as AchForEne).duAcEnemyid(xxx[i][id][1]);
                  }
               }
            }
         }
      }
      
      public function getEdAc() : Array
      {
         var data:Achievement = null;
         var arr:Array = [];
         for each(data in allDataArr)
         {
            if(data.isEveryDady())
            {
               arr.push(data);
            }
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function getGaAc() : Array
      {
         var data:Achievement = null;
         var arr:Array = [];
         for each(data in allDataArr)
         {
            if(!data.isEveryDady())
            {
               arr.push(data);
            }
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function getEvOrGa(type:Number = 0, num:Number = 0) : Array
      {
         var data:Achievement = null;
         var arr:Array = [];
         var typeArr:Array = [];
         if(type == 1)
         {
            arr = getGaAc();
         }
         else if(type == 0)
         {
            arr = getEdAc();
         }
         if(arr != null)
         {
            for each(data in arr)
            {
               if(data.getType() == num)
               {
                  typeArr.push(data);
               }
            }
         }
         if(typeArr.length < 1)
         {
            return null;
         }
         return getArr10(typeArr);
      }
      
      private function getArr10(arr:Array) : Array
      {
         if(arr == null)
         {
            return null;
         }
         var arr2:Array = [];
         var allArr:Array = [];
         for(var i:uint = 0; i < 100; i++)
         {
            if(arr.length < 10)
            {
               arr2 = arr.splice(0);
               if(arr2.length > 0)
               {
                  allArr.push(arr2);
               }
               break;
            }
            arr2 = arr.splice(0,10);
            allArr.push(arr2);
         }
         return allArr;
      }
   }
}

