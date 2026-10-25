package com.hotpoint.braveManIII.repository.achievement
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class AchNumFactory
   {
      
      public static var allData:Array = [];
      
      public static var allAc:Array = [];
      
      public function AchNumFactory()
      {
         super();
      }
      
      public static function creatAchNumFactory() : *
      {
         var tj:AchNumFactory = new AchNumFactory();
         myXml = XMLAsset.createXML(Data2.AchNum);
         tj.creatNumXml();
      }
      
      public static function getDatabyId(id:Number) : AchNumBasicData
      {
         var numData:AchNumBasicData = null;
         var data:AchNumBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               numData = data;
            }
         }
         if(numData == null)
         {
            trace("没有此ID数据");
         }
         return numData;
      }
      
      public static function getGoodId(id:Number) : Array
      {
         return getDatabyId(id).getGoddsId();
      }
      
      public static function getName(id:Number) : String
      {
         return getDatabyId(id).getName();
      }
      
      public static function getFrame(id:Number) : Number
      {
         return getDatabyId(id).getFrame();
      }
      
      public static function getSm(id:Number) : String
      {
         return getDatabyId(id).getIntroduction();
      }
      
      public static function isEveryDady(id:Number) : Boolean
      {
         return getDatabyId(id).isEveryDady();
      }
      
      public static function getType(id:Number) : Number
      {
         return getDatabyId(id).getNumType();
      }
      
      public static function getRewardAc(id:Number) : Number
      {
         return getDatabyId(id).getRewardAc();
      }
      
      public static function getSmallType(id:Number) : Number
      {
         return getDatabyId(id).getSmall();
      }
      
      public static function getFinishNum(id:Number) : Number
      {
         return getDatabyId(id).getNum();
      }
      
      public static function getTs(id:Number) : Number
      {
         return getDatabyId(id).getTs();
      }
      
      public static function getGoodsType(id:Number) : Array
      {
         return getDatabyId(id).getGoodsType();
      }
      
      public static function isRy(id:Number) : Boolean
      {
         return getDatabyId(id).getRy();
      }
      
      public static function getNeedType(id:Number) : Number
      {
         return getDatabyId(id).getNeedType();
      }
      
      private function creatNumXml() : *
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
         var rewardAc:Number = NaN;
         var goodsId:String = null;
         var smallId:Number = NaN;
         var num:Number = NaN;
         var ts:Number = NaN;
         var ry:Boolean = false;
         var goodsType:String = null;
         var nType:Number = NaN;
         var data:AchNumBasicData = null;
         for each(property in myXml.成就)
         {
            id = Number(property.编号);
            name = String(property.名字);
            frame = Number(property.帧数);
            sm = String(property.说明);
            everyDady = (property.是否每日.toString() == "true") as Boolean;
            numType = Number(property.类型);
            rewardAc = Number(property.奖励成就点);
            goodsId = String(property.指定id);
            smallId = Number(property.具体类型);
            num = Number(property.数量1);
            ts = Number(property.数量2);
            ry = (property.是否同时.toString() == "true") as Boolean;
            goodsType = String(property.id类型);
            nType = Number(property.获取方式);
            data = AchNumBasicData.ceartAchNum(id,name,frame,sm,everyDady,numType,rewardAc,goodsId,goodsType,smallId,num,ts,ry,nType);
            allData.push(data);
            allAc.push(data.creatAcForNum());
         }
      }
   }
}

