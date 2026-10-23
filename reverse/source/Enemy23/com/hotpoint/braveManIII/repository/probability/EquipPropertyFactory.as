package com.hotpoint.braveManIII.repository.probability
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class EquipPropertyFactory
   {
      
      public static var isPropertyOk:Boolean;
      
      public static var allDataArr:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function EquipPropertyFactory()
      {
         super();
      }
      
      public static function creatEquipData() : *
      {
         var data:EquipPropertyFactory = new EquipPropertyFactory();
         myXml = XMLAsset.createXML(Data2.property);
         data.creatLoader();
      }
      
      public static function getProbabilltyByFallId(fallId:Number, pos:Number) : EquipPropertyBaseData
      {
         var data:EquipPropertyBaseData = null;
         var data1:EquipPropertyBaseData = null;
         var proData:EquipPropertyBaseData = null;
         var fallArr:Array = [];
         for each(data in allDataArr)
         {
            if(data.getFalllevel() == fallId)
            {
               proData = data;
               fallArr.push(proData);
            }
         }
         if(fallArr.length < 1)
         {
            trace("找不到此掉落等级！！");
         }
         for each(data1 in fallArr)
         {
            if(data1.getPosi() == pos)
            {
               proData = data1;
            }
         }
         if(proData == null)
         {
            trace("找不到此部位掉落等级");
         }
         return proData;
      }
      
      public static function getProperty(fallId:Number, posi:Number, GemColor:Number, strengthenLevel:Number) : Number
      {
         return getProbabilltyByFallId(fallId,posi).getPropety(GemColor,strengthenLevel);
      }
      
      private function creatLoader() : void
      {
         xmlLoaded();
      }
      
      internal function xmlLoaded() : *
      {
         var property:XML = null;
         var position:Number = NaN;
         var fallLevel:Number = NaN;
         var color:Number = NaN;
         var probabilityArr1:XMLList = null;
         var probabilityArr2:XMLList = null;
         var probabilityArr3:XMLList = null;
         var myArr1:Array = null;
         var myArr2:Array = null;
         var myArr3:Array = null;
         var equipPropertyData:EquipPropertyBaseData = null;
         for each(property in myXml.强化数据)
         {
            position = Number(property.装备部位);
            fallLevel = Number(property.掉落等级);
            color = Number(property.颜色);
            probabilityArr1 = property.具体值.宝石A.强化等级;
            probabilityArr2 = property.具体值.宝石B.强化等级;
            probabilityArr3 = property.具体值.宝石C.强化等级;
            myArr1 = [];
            myArr2 = [];
            myArr3 = [];
            for each(property in probabilityArr1)
            {
               myArr1.push(property);
            }
            for each(property in probabilityArr2)
            {
               myArr2.push(property);
            }
            for each(property in probabilityArr3)
            {
               myArr3.push(property);
            }
            equipPropertyData = EquipPropertyBaseData.ceatPropertyData(position,fallLevel,color,myArr1,myArr2,myArr3);
            allDataArr.push(equipPropertyData);
         }
         isPropertyOk = true;
      }
   }
}

