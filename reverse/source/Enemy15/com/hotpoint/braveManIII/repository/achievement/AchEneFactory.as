package com.hotpoint.braveManIII.repository.achievement
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.achievement.AchForEne;
   import src.*;
   
   public class AchEneFactory
   {
      
      public static var allData:Array = [];
      
      public static var allEenData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function AchEneFactory()
      {
         super();
      }
      
      public static function creatAchEneFactory() : *
      {
         var tj:AchEneFactory = new AchEneFactory();
         myXml = XMLAsset.createXML(Data2.AchEnemy);
         tj.creatEneXml();
      }
      
      public static function getAcForEne(id:Number) : AchForEne
      {
         var data:AchForEne = null;
         var d1:AchForEne = null;
         for each(d1 in allEenData)
         {
            if(d1.getId() == id)
            {
               data = d1;
            }
         }
         if(data == null)
         {
            trace("没此ID的杀怪成就");
            return null;
         }
         return data;
      }
      
      public static function getDataById(id:Number) : AchForEnemyBasicData
      {
         var data:AchForEnemyBasicData = null;
         var dataMap:AchForEnemyBasicData = null;
         for each(dataMap in allData)
         {
            if(dataMap.getId() == id)
            {
               data = dataMap;
            }
         }
         if(data == null)
         {
            trace("成就没有条件1数据");
            return null;
         }
         return data;
      }
      
      public static function getMapId(id:Number) : Array
      {
         return getDataById(id).getMapId();
      }
      
      public static function getMapStar(id:Number) : Number
      {
         return getDataById(id).getStar();
      }
      
      public static function getEnemyId(id:Number) : Array
      {
         return getDataById(id).getEnemyId();
      }
      
      public static function isEneRy(id:Number) : Boolean
      {
         return getDataById(id).getEneRy();
      }
      
      public static function getEnemyNum(id:Number) : Number
      {
         return getDataById(id).getEnemyNum();
      }
      
      public static function isEnemyAgin(id:Number) : Boolean
      {
         return getDataById(id).isAginEne();
      }
      
      private function creatEneXml() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var property:XML = null;
         var id:Number = NaN;
         var mapId:String = null;
         var enemyId:String = null;
         var enemyRy:Boolean = false;
         var enemyNum:Number = NaN;
         var enemyAgin:Boolean = false;
         var data:AchForEnemyBasicData = null;
         for each(property in myXml.成就)
         {
            id = Number(property.id);
            mapId = String(property.地图id);
            enemyId = String(property.怪物id);
            enemyRy = (property.任意.toString() == "true") as Boolean;
            enemyNum = Number(property.怪物数量);
            enemyAgin = (property.是否同时.toString() == "true") as Boolean;
            data = AchForEnemyBasicData.creatAchEne(id,mapId,enemyId,enemyRy,enemyNum,enemyAgin);
            allData.push(data);
            allEenData.push(data.creatAchEne());
         }
         trace(allData);
         trace(allEenData);
      }
   }
}

