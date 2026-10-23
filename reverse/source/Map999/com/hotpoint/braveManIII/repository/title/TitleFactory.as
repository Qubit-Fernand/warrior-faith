package com.hotpoint.braveManIII.repository.title
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.title.Title;
   import src.*;
   
   public class TitleFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function TitleFactory()
      {
         super();
      }
      
      public static function creatTitleFactory() : *
      {
         var title:TitleFactory = new TitleFactory();
         myXml = XMLAsset.createXML(Data2.title);
         title.creatTitleFactory();
      }
      
      public static function getTitleById(id:Number) : TitleBasicData
      {
         var tData:TitleBasicData = null;
         var data:TitleBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               tData = data;
            }
         }
         if(tData == null)
         {
         }
         return tData;
      }
      
      public static function getId(id:Number) : Number
      {
         return getTitleById(id).getId();
      }
      
      public static function getFrame(id:Number) : Number
      {
         return getTitleById(id).getFrame();
      }
      
      public static function getColor(id:Number) : Number
      {
         return getTitleById(id).getColor();
      }
      
      public static function getType(id:Number) : Number
      {
         return getTitleById(id).getType();
      }
      
      public static function getIntroductionSkill(id:Number) : String
      {
         return getTitleById(id).getIntroductionSkill();
      }
      
      public static function getIntroduction(id:Number) : String
      {
         return getTitleById(id).getIntroduction();
      }
      
      public static function getName(id:Number) : String
      {
         return getTitleById(id).getName();
      }
      
      public static function getRemainingTime(id:Number) : Number
      {
         return getTitleById(id).getRemainingTime();
      }
      
      public static function getDefaultTime(id:Number) : Number
      {
         return getTitleById(id).getDefaultTime();
      }
      
      public static function creatTitle(id:Number) : Title
      {
         return getTitleById(id).creatTitle();
      }
      
      private function creatTitleFactory() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var property:XML = null;
         var id:Number = NaN;
         var frame:Number = NaN;
         var name:String = null;
         var introduction:String = null;
         var introductionSkill:String = null;
         var color:Number = NaN;
         var type:Number = NaN;
         var remainingTime:Number = NaN;
         var defaultTime:Number = NaN;
         var attribList:XMLList = null;
         var attrib:Array = null;
         var att:XML = null;
         var data:TitleBasicData = null;
         for each(property in myXml.称号)
         {
            id = Number(property.编号);
            frame = Number(property.帧数);
            name = String(property.名字);
            introduction = String(property.描述);
            introductionSkill = String(property.技能描述);
            color = Number(property.颜色);
            type = Number(property.类型);
            remainingTime = Number(property.剩余时间);
            defaultTime = Number(property.默认时间);
            attribList = property.属性;
            attrib = [];
            for each(att in attribList)
            {
               if(att.生命 != "null")
               {
                  attrib.push(Attribute.creatAttribute(1,Number(att.生命)));
               }
               if(att.魔法 != "null")
               {
                  attrib.push(Attribute.creatAttribute(2,Number(att.魔法)));
               }
               if(att.攻击 != "null")
               {
                  attrib.push(Attribute.creatAttribute(3,Number(att.攻击)));
               }
               if(att.防御 != "null")
               {
                  attrib.push(Attribute.creatAttribute(4,Number(att.防御)));
               }
               if(att.暴击 != "null")
               {
                  attrib.push(Attribute.creatAttribute(5,Number(att.暴击)));
               }
               if(att.闪避 != "null")
               {
                  attrib.push(Attribute.creatAttribute(6,Number(att.闪避)));
               }
               if(att.移动速度 != "null")
               {
                  attrib.push(Attribute.creatAttribute(7,Number(att.移动速度)));
               }
            }
            data = TitleBasicData.creatTitleBasicData(id,frame,name,introduction,introductionSkill,color,type,attrib,remainingTime,defaultTime);
            allData.push(data);
         }
      }
   }
}

