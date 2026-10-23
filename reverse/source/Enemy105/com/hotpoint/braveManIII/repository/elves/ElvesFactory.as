package com.hotpoint.braveManIII.repository.elves
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.elves.Elves;
   import src.*;
   
   public class ElvesFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function ElvesFactory()
      {
         super();
      }
      
      public static function creatElvesFactory() : *
      {
         var elves:ElvesFactory = new ElvesFactory();
         myXml = XMLAsset.createXML(Data2.elves);
         elves.creatElvesFactory();
      }
      
      public static function getElvesById(id:Number) : ElvesBasicData
      {
         var elvesData:ElvesBasicData = null;
         var data:ElvesBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               elvesData = data;
            }
         }
         if(elvesData == null)
         {
            trace("找不到");
         }
         return elvesData;
      }
      
      public static function getId(id:Number) : Number
      {
         return getElvesById(id).getId();
      }
      
      public static function getName(id:Number) : String
      {
         return getElvesById(id).getName();
      }
      
      public static function getClassName(id:Number) : String
      {
         return getElvesById(id).getClassName();
      }
      
      public static function getFrame(id:Number) : Number
      {
         return getElvesById(id).getFrame();
      }
      
      public static function getColor(id:Number) : Number
      {
         return getElvesById(id).getColor();
      }
      
      public static function getIntroduction(id:Number) : String
      {
         return getElvesById(id).getIntroduction();
      }
      
      public static function getBlueLV(id:Number) : Number
      {
         return getElvesById(id).getBlueLV();
      }
      
      public static function getPinkLV(id:Number) : Number
      {
         return getElvesById(id).getPinkLV();
      }
      
      public static function getGoldLV(id:Number) : Number
      {
         return getElvesById(id).getGoldLV();
      }
      
      public static function getBlueNum(id:Number) : Number
      {
         return getElvesById(id).getBlueNum();
      }
      
      public static function getPinkNum(id:Number) : Number
      {
         return getElvesById(id).getPinkNum();
      }
      
      public static function getGoldNum(id:Number) : Number
      {
         return getElvesById(id).getGoldNum();
      }
      
      public static function getTimeX(id:Number) : Number
      {
         return getElvesById(id).getTimeX();
      }
      
      public static function creatElves(id:Number) : Elves
      {
         return getElvesById(id).creatElves();
      }
      
      private function creatElvesFactory() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var property:XML = null;
         var id:Number = NaN;
         var frame:Number = NaN;
         var name:String = null;
         var className:String = null;
         var introduction:String = null;
         var color:Number = NaN;
         var blueLV:Number = NaN;
         var pinkLV:Number = NaN;
         var goldLV:Number = NaN;
         var blueNum:Number = NaN;
         var pinkNum:Number = NaN;
         var goldNum:Number = NaN;
         var timeX:Number = NaN;
         var data:ElvesBasicData = null;
         for each(property in myXml.精灵)
         {
            id = Number(property.编号);
            frame = Number(property.帧数);
            name = String(property.名字);
            className = String(property.类名);
            introduction = String(property.描述);
            color = Number(property.颜色);
            blueLV = Number(property.蓝色等级);
            pinkLV = Number(property.粉色等级);
            goldLV = Number(property.金色等级);
            blueNum = Number(property.蓝色数量);
            pinkNum = Number(property.粉色数量);
            goldNum = Number(property.金色数量);
            timeX = Number(property.减少时间);
            data = ElvesBasicData.creatElvesBasicData(id,name,className,frame,introduction,color,blueLV,pinkLV,goldLV,blueNum,pinkNum,goldNum,timeX);
            allData.push(data);
         }
      }
   }
}

