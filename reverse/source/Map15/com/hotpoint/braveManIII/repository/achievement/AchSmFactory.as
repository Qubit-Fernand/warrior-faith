package com.hotpoint.braveManIII.repository.achievement
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class AchSmFactory
   {
      
      public static var allData:Array = [];
      
      public static var allAc:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function AchSmFactory()
      {
         super();
      }
      
      public static function creatAchSmFactory() : *
      {
         var sm:AchSmFactory = new AchSmFactory();
         myXml = XMLAsset.createXML(Data2.AchSm);
         sm.creatSmFactory();
      }
      
      public static function getBasicDataById(id:Number) : AchSmBasicData
      {
         var dataSm:AchSmBasicData = null;
         var data:AchSmBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               dataSm = data;
            }
         }
         if(dataSm == null)
         {
            trace("没有此成就");
         }
         return dataSm;
      }
      
      public static function getName(id:Number) : String
      {
         return getBasicDataById(id).getName();
      }
      
      public static function getFrame(id:Number) : Number
      {
         var data:AchSmBasicData = getBasicDataById(id);
         return data.getFrame();
      }
      
      public static function getSm(id:Number) : String
      {
         var data:AchSmBasicData = getBasicDataById(id);
         return data.getIntroduction();
      }
      
      public static function isEveryDady(id:Number) : Boolean
      {
         var data:AchSmBasicData = getBasicDataById(id);
         return data.isEveryDady();
      }
      
      public static function getType(id:Number) : Number
      {
         var data:AchSmBasicData = getBasicDataById(id);
         return data.getNumType();
      }
      
      public static function getWhoType(id:Number) : Number
      {
         var data:AchSmBasicData = getBasicDataById(id);
         return data.getWhoType();
      }
      
      public static function getRewardAc(id:Number) : Number
      {
         var data:AchSmBasicData = getBasicDataById(id);
         return data.getRewardAc();
      }
      
      private function creatSmFactory() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var property:XML = null;
         var id:Number = NaN;
         var name:String = null;
         var frame:Number = NaN;
         var sm:String = null;
         var everyDady:Boolean = false;
         var numType:Number = NaN;
         var whoType:Number = NaN;
         var rewardAc:Number = NaN;
         var data:AchSmBasicData = null;
         for each(property in myXml.成就)
         {
            id = Number(property.id);
            name = String(property.名字);
            frame = Number(property.帧数);
            sm = String(property.说明);
            everyDady = (property.是否每日.toString() == "true") as Boolean;
            numType = Number(property.类型);
            whoType = Number(property.小类型);
            rewardAc = Number(property.奖励成就点);
            data = AchSmBasicData.creatSm(id,name,frame,sm,everyDady,numType,whoType,rewardAc);
            allData.push(data);
            allAc.push(data.creatAch());
         }
      }
   }
}

