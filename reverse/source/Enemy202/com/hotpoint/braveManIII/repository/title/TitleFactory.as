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
         var _loc1_:TitleFactory = new TitleFactory();
         myXml = XMLAsset.createXML(Data2.title);
         _loc1_.creatTitleFactory();
      }
      
      public static function getTitleById(param1:Number) : TitleBasicData
      {
         var _loc2_:TitleBasicData = null;
         var _loc3_:TitleBasicData = null;
         for each(_loc3_ in allData)
         {
            if(_loc3_.getId() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            trace("找不到");
         }
         return _loc2_;
      }
      
      public static function getId(param1:Number) : Number
      {
         return getTitleById(param1).getId();
      }
      
      public static function getFrame(param1:Number) : Number
      {
         return getTitleById(param1).getFrame();
      }
      
      public static function getColor(param1:Number) : Number
      {
         return getTitleById(param1).getColor();
      }
      
      public static function getType(param1:Number) : Number
      {
         return getTitleById(param1).getType();
      }
      
      public static function getIntroductionSkill(param1:Number) : String
      {
         return getTitleById(param1).getIntroductionSkill();
      }
      
      public static function getIntroduction(param1:Number) : String
      {
         return getTitleById(param1).getIntroduction();
      }
      
      public static function getName(param1:Number) : String
      {
         return getTitleById(param1).getName();
      }
      
      public static function getRemainingTime(param1:Number) : Number
      {
         return getTitleById(param1).getRemainingTime();
      }
      
      public static function getDefaultTime(param1:Number) : Number
      {
         return getTitleById(param1).getDefaultTime();
      }
      
      public static function creatTitle(param1:Number) : Title
      {
         return getTitleById(param1).creatTitle();
      }
      
      private function creatTitleFactory() : *
      {
         this.xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:XMLList = null;
         var _loc12_:Array = null;
         var _loc13_:XML = null;
         var _loc14_:TitleBasicData = null;
         for each(_loc1_ in myXml.称号)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = Number(_loc1_.帧数);
            _loc4_ = String(_loc1_.名字);
            _loc5_ = String(_loc1_.描述);
            _loc6_ = String(_loc1_.技能描述);
            _loc7_ = Number(_loc1_.颜色);
            _loc8_ = Number(_loc1_.类型);
            _loc9_ = Number(_loc1_.剩余时间);
            _loc10_ = Number(_loc1_.默认时间);
            _loc11_ = _loc1_.属性;
            _loc12_ = [];
            for each(_loc13_ in _loc11_)
            {
               if(_loc13_.生命 != "null")
               {
                  _loc12_.push(Attribute.creatAttribute(1,Number(_loc13_.生命)));
               }
               if(_loc13_.魔法 != "null")
               {
                  _loc12_.push(Attribute.creatAttribute(2,Number(_loc13_.魔法)));
               }
               if(_loc13_.攻击 != "null")
               {
                  _loc12_.push(Attribute.creatAttribute(3,Number(_loc13_.攻击)));
               }
               if(_loc13_.防御 != "null")
               {
                  _loc12_.push(Attribute.creatAttribute(4,Number(_loc13_.防御)));
               }
               if(_loc13_.暴击 != "null")
               {
                  _loc12_.push(Attribute.creatAttribute(5,Number(_loc13_.暴击)));
               }
               if(_loc13_.闪避 != "null")
               {
                  _loc12_.push(Attribute.creatAttribute(6,Number(_loc13_.闪避)));
               }
               if(_loc13_.移动速度 != "null")
               {
                  _loc12_.push(Attribute.creatAttribute(7,Number(_loc13_.移动速度)));
               }
            }
            _loc14_ = TitleBasicData.creatTitleBasicData(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc12_,_loc9_,_loc10_);
            allData.push(_loc14_);
         }
      }
   }
}

