package com.hotpoint.braveManIII.repository.supplies
{
   import com.hotpoint.braveManIII.models.supplies.*;
   import flash.events.*;
   
   public class SuppliesFactory
   {
      
      public static var _suppliesDataList:Array = [];
      
      public static var isSuppiesOK:Boolean = false;
      
      public static var myXml:XML = new XML();
      
      public function SuppliesFactory()
      {
         super();
      }
      
      public static function findTimes(id:Number) : Number
      {
         return getSuppliesBaseDataById(id).getTimes();
      }
      
      public static function findCoolDowns(id:Number) : Number
      {
         return getSuppliesBaseDataById(id).getCoolDowns();
      }
      
      public static function findPrice(id:Number) : Number
      {
         return getSuppliesBaseDataById(id).getPrice();
      }
      
      public static function findIsPile(id:Number) : Boolean
      {
         return getSuppliesBaseDataById(id).getIsPile();
      }
      
      public static function findUseLevel(id:Number) : Number
      {
         return getSuppliesBaseDataById(id).getUseLevel();
      }
      
      public static function findDropLevel(id:Number) : Number
      {
         return getSuppliesBaseDataById(id).getDropLevel();
      }
      
      public static function findName(id:Number) : String
      {
         return getSuppliesBaseDataById(id).getName();
      }
      
      public static function findDescript(id:Number) : String
      {
         return getSuppliesBaseDataById(id).getDescript();
      }
      
      public static function getSuppliesNameAndCD() : Array
      {
         var suppliesArr:Array = null;
         var data:SuppliesBaseData = null;
         var arr:Array = null;
         suppliesArr = [];
         for each(data in _suppliesDataList)
         {
            arr = [];
            arr.push(data.getName());
            arr.push(data.getCoolDowns());
            suppliesArr.push(arr);
         }
         if(suppliesArr.length < 1)
         {
            throw new Error("找不到基础数据!");
         }
         return suppliesArr;
      }
      
      public static function findDuration(id:Number) : Number
      {
         return getSuppliesBaseDataById(id).getDuration();
      }
      
      public static function findAffect(id:Number) : Array
      {
         return getSuppliesBaseDataById(id).getAffect();
      }
      
      private static function getSuppliesBaseDataById(id:Number) : SuppliesBaseData
      {
         var suppliesBaseData:SuppliesBaseData = null;
         var data:SuppliesBaseData = null;
         for each(data in _suppliesDataList)
         {
            if(data.getId() == id)
            {
               suppliesBaseData = data;
               break;
            }
         }
         if(suppliesBaseData == null)
         {
            throw new Error("找不到基础数据!id:" + id);
         }
         return suppliesBaseData;
      }
      
      public static function findAffectMode(id:Number) : Number
      {
         return getSuppliesBaseDataById(id).getAffectMode();
      }
      
      public static function findFrame(id:Number) : Number
      {
         return getSuppliesBaseDataById(id).getFrame();
      }
      
      public static function getSuppliesBaseDataByColor(color:Number) : Array
      {
         var datas:Array = null;
         var data:SuppliesBaseData = null;
         datas = [];
         for each(data in _suppliesDataList)
         {
            if(data.getColor() == color)
            {
               datas.push(data);
            }
         }
         if(datas.length < 1)
         {
            throw new Error("没有这个颜色的宝石:color:" + color);
         }
         return datas;
      }
      
      public static function createSuppliesByShop() : Array
      {
         var createDatas:Array = null;
         var datas:Array = null;
         var data:SuppliesBaseData = null;
         createDatas = [];
         datas = getSuppliesBaseDataByColor(1);
         for each(data in datas)
         {
            createDatas.push(data.createSupplies());
         }
         return createDatas;
      }
      
      public static function createSuppliesByColorAndLevel(level:Array) : Supplies
      {
         var createDatas:Array = null;
         var data:SuppliesBaseData = null;
         var random:int = 0;
         var droplv:Number = NaN;
         createDatas = [];
         for each(data in _suppliesDataList)
         {
            for each(droplv in level)
            {
               if(data.getDropLevel() == droplv)
               {
                  createDatas.push(data);
               }
            }
         }
         if(createDatas.length < 1)
         {
            throw new Error("没有这个的等级物品:" + level);
         }
         random = Math.floor(Math.random() * createDatas.length);
         data = createDatas[random] as SuppliesBaseData;
         return data.createSupplies();
      }
      
      public static function findColor(id:Number) : Number
      {
         return getSuppliesBaseDataById(id).getColor();
      }
      
      public static function creatSuppliesFactory() : *
      {
         var sf:SuppliesFactory = null;
         sf = new SuppliesFactory();
         sf.creatSuppliesData();
      }
      
      public static function getSuppliesById(id:Number) : Supplies
      {
         var suppliesBaseData:SuppliesBaseData = null;
         suppliesBaseData = getSuppliesBaseDataById(id);
         return suppliesBaseData.createSupplies();
      }
      
      private function creatSuppliesData() : *
      {
         xmlLoaded();
      }
      
      internal function xmlLoaded() : *
      {
         var property:XML = null;
         var name:String = null;
         var frame:Number = NaN;
         var id:Number = NaN;
         var descript:String = null;
         var useLevel:Number = NaN;
         var dropLevel:Number = NaN;
         var price:Number = NaN;
         var coolDowns:Number = NaN;
         var times:Number = NaN;
         var color:Number = NaN;
         var isPile:Boolean = false;
         var affectMode:Number = NaN;
         var duration:Number = NaN;
         var affectList:XMLList = null;
         var affect:Array = null;
         var aff:XML = null;
         var allData:SuppliesBaseData = null;
         for each(property in myXml.消耗品)
         {
            name = String(property.名称);
            frame = Number(property.帧数);
            id = Number(property.编号);
            descript = String(property.描述);
            useLevel = Number(property.使用等级);
            dropLevel = Number(property.掉落等级);
            price = Number(property.价钱);
            coolDowns = Number(property.冷却时间);
            times = Number(property.堆叠次数);
            color = Number(property.品质);
            isPile = (property.是否堆叠.toString() == "true") as Boolean;
            affectMode = Number(property.作用模式);
            duration = Number(property.持续时间);
            affectList = property.具体作用;
            affect = [];
            for each(aff in affectList)
            {
               if(aff.生命 != "null")
               {
                  affect.push(SuppliesAffect.creatSuppliesAffect(1,Number(aff.生命)));
               }
               if(aff.魔法 != "null")
               {
                  affect.push(SuppliesAffect.creatSuppliesAffect(2,Number(aff.魔法)));
               }
               if(aff.攻击 != "null")
               {
                  affect.push(SuppliesAffect.creatSuppliesAffect(3,Number(aff.攻击)));
               }
               if(aff.防御 != "null")
               {
                  affect.push(SuppliesAffect.creatSuppliesAffect(4,Number(aff.防御)));
               }
               if(aff.暴击 != "null")
               {
                  affect.push(SuppliesAffect.creatSuppliesAffect(5,Number(aff.暴击)));
               }
               if(aff.闪避 != "null")
               {
                  affect.push(SuppliesAffect.creatSuppliesAffect(6,Number(aff.闪避)));
               }
               if(aff.移动速度 != "null")
               {
                  affect.push(SuppliesAffect.creatSuppliesAffect(7,Number(aff.移动速度)));
               }
               if(aff.硬直 != "null")
               {
                  affect.push(SuppliesAffect.creatSuppliesAffect(8,Number(aff.硬直)));
               }
               if(aff.经验 != "null")
               {
                  affect.push(SuppliesAffect.creatSuppliesAffect(9,Number(aff.经验)));
               }
            }
            allData = SuppliesBaseData.createSuppliesBaseData(id,frame,name,descript,useLevel,dropLevel,price,coolDowns,times,color,isPile,affectMode,duration,affect);
            _suppliesDataList.push(allData);
         }
         isSuppiesOK = true;
      }
   }
}

