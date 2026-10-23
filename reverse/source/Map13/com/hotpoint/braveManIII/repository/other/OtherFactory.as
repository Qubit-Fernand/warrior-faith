package com.hotpoint.braveManIII.repository.other
{
   import com.hotpoint.braveManIII.models.other.Otherobj;
   
   public class OtherFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function OtherFactory()
      {
         super();
      }
      
      public static function getRemaining(id:Number) : Number
      {
         return getOtherById(id).getRemaining();
      }
      
      public static function getName(id:Number) : String
      {
         return getOtherById(id).getName();
      }
      
      public static function creatOtherFactory() : *
      {
         var qe:OtherFactory = null;
         qe = new OtherFactory();
         qe.creatOtherFactory();
      }
      
      public static function getGold(id:Number) : Number
      {
         return getOtherById(id).getGold();
      }
      
      public static function getMultiple(id:Number) : Number
      {
         return getOtherById(id).getMultiple();
      }
      
      public static function creatOther(id:Number) : Otherobj
      {
         return getOtherById(id).creatOther();
      }
      
      public static function getTimes(id:Number) : Number
      {
         return getOtherById(id).getTimes();
      }
      
      public static function isMany(id:Number) : Boolean
      {
         return getOtherById(id).isMany();
      }
      
      public static function getOtherById(id:Number) : OtherBasicData
      {
         var otherData:OtherBasicData = null;
         var data:OtherBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               otherData = data;
            }
         }
         if(otherData == null)
         {
            trace("找不到此其他物品掉落等级");
         }
         return otherData;
      }
      
      public static function getColor(id:Number) : Number
      {
         return getOtherById(id).getColor();
      }
      
      public static function getValue_2(id:Number) : Number
      {
         return getOtherById(id).getValue_2();
      }
      
      public static function getType(id:Number) : Number
      {
         return getOtherById(id).getType();
      }
      
      public static function getId(id:Number) : Number
      {
         return getOtherById(id).getId();
      }
      
      public static function getFallLevel(id:Number) : Number
      {
         return getOtherById(id).getFallLevel();
      }
      
      public static function getValue_1(id:Number) : Number
      {
         return getOtherById(id).getValue_1();
      }
      
      public static function getFrame(id:Number) : Number
      {
         return getOtherById(id).getFrame();
      }
      
      public static function getPileLimit(id:Number) : Number
      {
         return getOtherById(id).getPileLimit();
      }
      
      public static function getIntroduction(id:Number) : String
      {
         return getOtherById(id).getIntroduction();
      }
      
      private function creatOtherFactory() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var property:XML = null;
         var id:Number = NaN;
         var name:String = null;
         var type:Number = NaN;
         var frame:Number = NaN;
         var fallLevel:Number = NaN;
         var introduction:String = null;
         var many:Boolean = false;
         var pileLimit:Number = NaN;
         var times:Number = NaN;
         var gold:Number = NaN;
         var remaining:Number = NaN;
         var multiple:Number = NaN;
         var value_1:Number = NaN;
         var value_2:Number = NaN;
         var color:Number = NaN;
         var data:OtherBasicData = null;
         for each(property in myXml.其他道具)
         {
            id = Number(property.编号);
            name = String(property.名字);
            type = Number(property.类型);
            frame = Number(property.帧数);
            fallLevel = Number(property.掉落等级);
            introduction = String(property.介绍);
            many = (property.叠加.toString() == "true") as Boolean;
            pileLimit = Number(property.堆叠上限);
            times = Number(property.堆叠次数);
            gold = Number(property.金币);
            remaining = Number(property.剩余时间);
            multiple = Number(property.倍数);
            value_1 = Number(property.数值1);
            value_2 = Number(property.数值2);
            color = Number(property.数值3);
            data = OtherBasicData.creatOtherBasicData(id,fallLevel,type,name,frame,color,introduction,many,pileLimit,times,gold,remaining,multiple,value_1,value_2);
            allData.push(data);
         }
      }
   }
}

