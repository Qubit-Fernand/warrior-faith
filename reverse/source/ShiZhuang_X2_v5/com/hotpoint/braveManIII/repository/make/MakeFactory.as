package com.hotpoint.braveManIII.repository.make
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class MakeFactory
   {
      
      public static var myXml:XML = new XML();
      
      public static var allData:Array = [];
      
      public static var makeData:Array = [];
      
      public function MakeFactory()
      {
         super();
      }
      
      public static function creatMakeFactory() : void
      {
         var data:MakeFactory = new MakeFactory();
         data.creatLoard();
      }
      
      private static function getDataById(id:Number) : MakeBasicData
      {
         var data:MakeBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               return data;
            }
         }
         return null;
      }
      
      public static function getDataByType(type:Number) : Array
      {
         var data:MakeBasicData = null;
         var dataArr:Array = [];
         for each(data in allData)
         {
            if(data.getType() == type)
            {
               dataArr.push(data);
            }
         }
         return dataArr;
      }
      
      public static function getType(id:Number) : Number
      {
         return getDataById(id).getType();
      }
      
      public static function getName(id:Number) : String
      {
         return getDataById(id).getName();
      }
      
      public static function getFrame(id:Number) : Number
      {
         return getDataById(id).getFrame();
      }
      
      public static function getSm(id:Number) : String
      {
         return getDataById(id).getSm();
      }
      
      public static function getNeedId(id:Number) : Array
      {
         var arr:Array = [];
         var arr1:Array = getDataById(id).getNeedId();
         for(var i:uint = 0; i < arr1.length; i++)
         {
            arr.push(arr1[i].getValue());
         }
         return arr;
      }
      
      public static function getNeedType(id:Number) : Array
      {
         var arr:Array = [];
         var arr1:Array = getDataById(id).getNeedType();
         for(var i:uint = 0; i < arr1.length; i++)
         {
            arr.push(arr1[i].getValue());
         }
         return arr;
      }
      
      public static function getNeedNum(id:Number) : Array
      {
         var arr:Array = [];
         var arr1:Array = getDataById(id).getNeedNum();
         for(var i:uint = 0; i < arr1.length; i++)
         {
            arr.push(arr1[i].getValue());
         }
         return arr;
      }
      
      public static function getFinishNum(id:Number) : Number
      {
         return getDataById(id).getFinishNum();
      }
      
      public static function getGold(id:Number) : Number
      {
         return getDataById(id).getGold();
      }
      
      public static function getDj(id:Number) : Number
      {
         return getDataById(id).getDj();
      }
      
      public static function getFinishId(id:Number) : Number
      {
         return getDataById(id).getFinishId();
      }
      
      private function creatLoard() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var property:XML = null;
         var id:Number = NaN;
         var name:String = null;
         var type:Number = NaN;
         var frame:Number = NaN;
         var ms:String = null;
         var gold:Number = NaN;
         var needAll:XMLList = null;
         var finishId:Number = NaN;
         var finishNum:Number = NaN;
         var dj:Number = NaN;
         var nId:Array = null;
         var nType:Array = null;
         var nNum:Array = null;
         var data:MakeBasicData = null;
         for each(property in myXml.卷轴)
         {
            id = Number(property.id);
            name = property.名称;
            type = Number(property.类型);
            frame = Number(property.帧数);
            ms = property.说明;
            gold = Number(property.金币);
            needAll = property.必需品;
            finishId = Number(property.完成品Id);
            finishNum = Number(property.完成品数量);
            gold = Number(property.金币);
            dj = Number(property.点卷);
            nId = [];
            nType = [];
            nNum = [];
            for each(property in needAll)
            {
               nId.push(VT.createVT(needAll.需要品id0));
               nId.push(VT.createVT(needAll.需要品id1));
               nId.push(VT.createVT(needAll.需要品id2));
               nId.push(VT.createVT(needAll.需要品id3));
               nId.push(VT.createVT(needAll.需要品id4));
               nType.push(VT.createVT(needAll.需要品类型0));
               nType.push(VT.createVT(needAll.需要品类型1));
               nType.push(VT.createVT(needAll.需要品类型2));
               nType.push(VT.createVT(needAll.需要品类型3));
               nType.push(VT.createVT(needAll.需要品类型4));
               nNum.push(VT.createVT(needAll.需要品数量0));
               nNum.push(VT.createVT(needAll.需要品数量1));
               nNum.push(VT.createVT(needAll.需要品数量2));
               nNum.push(VT.createVT(needAll.需要品数量3));
               nNum.push(VT.createVT(needAll.需要品数量4));
            }
            data = MakeBasicData.creatMakeBasic(id,name,type,frame,ms,nId,nType,nNum,finishId,gold,finishNum,dj);
            allData.push(data);
            makeData.push(data.creatMake());
         }
      }
   }
}

