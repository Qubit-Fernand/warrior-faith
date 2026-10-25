package com.hotpoint.braveManIII.repository.monsterCard
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.monsterCard.MonsterCard;
   import src.*;
   
   public class MonsterFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function MonsterFactory()
      {
         super();
      }
      
      public static function creatMonsterFactory() : *
      {
         var mst:MonsterFactory = new MonsterFactory();
         myXml = XMLAsset.createXML(Data2.monster);
         mst.creatMonsterFactory();
      }
      
      public static function getMonsterById(id:Number) : MonsterBasicData
      {
         var monsterData:MonsterBasicData = null;
         var data:MonsterBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               monsterData = data;
            }
         }
         if(monsterData == null)
         {
            trace("找不到");
         }
         return monsterData;
      }
      
      public static function getMonsterByType(type:Number) : MonsterBasicData
      {
         var monsterData:MonsterBasicData = null;
         var data:MonsterBasicData = null;
         for each(data in allData)
         {
            if(data.getType() == type)
            {
               monsterData = data;
            }
         }
         if(monsterData == null)
         {
            return null;
         }
         return monsterData;
      }
      
      public static function getId(id:Number) : Number
      {
         return getMonsterById(id).getId();
      }
      
      public static function getName(id:Number) : String
      {
         return getMonsterById(id).getName();
      }
      
      public static function getType(id:Number) : Number
      {
         return getMonsterById(id).getType();
      }
      
      public static function getFrame(id:Number) : Number
      {
         return getMonsterById(id).getFrame();
      }
      
      public static function getFrame2(id:Number) : Number
      {
         return getMonsterById(id).getFrame2();
      }
      
      public static function getIntroduction(id:Number) : String
      {
         return getMonsterById(id).getIntroduction();
      }
      
      public static function getAttup(id:Number) : Number
      {
         return getMonsterById(id).getAttup();
      }
      
      public static function getDefup(id:Number) : Number
      {
         return getMonsterById(id).getDefup();
      }
      
      public static function getCritup(id:Number) : Number
      {
         return getMonsterById(id).getCritup();
      }
      
      public static function getHpup(id:Number) : Number
      {
         return getMonsterById(id).getHpup();
      }
      
      public static function getMpup(id:Number) : Number
      {
         return getMonsterById(id).getMpup();
      }
      
      public static function creatMonster(id:Number) : MonsterCard
      {
         return getMonsterById(id).creatMonsterCard();
      }
      
      public static function creatMonsterType(type:Number) : MonsterCard
      {
         if(getMonsterByType(type))
         {
            return getMonsterByType(type).creatMonsterCard();
         }
         return null;
      }
      
      private function creatMonsterFactory() : *
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
         var frame2:Number = NaN;
         var introduction:String = null;
         var attup:Number = NaN;
         var defup:Number = NaN;
         var critup:Number = NaN;
         var hpup:Number = NaN;
         var mpup:Number = NaN;
         var data:MonsterBasicData = null;
         for each(property in myXml.怪物图鉴)
         {
            id = Number(property.编号);
            name = String(property.名字);
            type = Number(property.类型);
            frame = Number(property.帧数);
            frame2 = Number(property.帧数二);
            introduction = String(property.描述);
            attup = Number(property.攻击成长);
            defup = Number(property.防御成长);
            critup = Number(property.暴击成长);
            hpup = Number(property.生命成长);
            mpup = Number(property.魔法成长);
            data = MonsterBasicData.creatMonsterBasicData(id,type,name,frame,frame2,introduction,attup,defup,critup,hpup,mpup);
            allData.push(data);
         }
      }
   }
}

