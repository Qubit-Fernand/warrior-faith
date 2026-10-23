package com.hotpoint.braveManIII.repository.gem
{
   import com.hotpoint.braveManIII.models.gem.*;
   import flash.events.*;
   
   public class GemFactory
   {
      
      public static var isGemOK:Boolean = false;
      
      public static var _GemDataList:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function GemFactory()
      {
         super();
      }
      
      public static function creatGemFactory() : *
      {
         var gf:GemFactory = new GemFactory();
         gf.creatGemData();
      }
      
      private static function getGemBaseDataById(id:Number) : GemBaseData
      {
         var gemBaseData:GemBaseData = null;
         var data:GemBaseData = null;
         for each(data in _GemDataList)
         {
            if(data.getId() == id)
            {
               gemBaseData = data;
               break;
            }
         }
         if(gemBaseData == null)
         {
            throw new Error("找不到基础数据!id:" + id);
         }
         return gemBaseData;
      }
      
      public static function creatGemById(id:Number) : Gem
      {
         var gemBaseData:GemBaseData = getGemBaseDataById(id);
         return gemBaseData.createGem();
      }
      
      public static function createGemByStrengthen(name:String, level:Number) : Gem
      {
         var gemBaseData:GemBaseData = null;
         var data2:GemBaseData = null;
         var datas:Array = getGemBaseDataByName(name);
         for each(data2 in datas)
         {
            trace(data2.getStrengthenLevel());
            if(data2.getStrengthenLevel() == level + 1)
            {
               gemBaseData = data2;
            }
         }
         if(gemBaseData == null)
         {
            throw new Error("找不到基础数据!");
         }
         return gemBaseData.upLevelGem();
      }
      
      public static function createGemByCompose(color:Number, level:Number, attrib:Array) : Gem
      {
         var gemBaseData:GemBaseData = null;
         var data2:GemBaseData = null;
         var datas:Array = getGemBaseDataByColor(color);
         for each(data2 in datas)
         {
            if(data2.getStrengthenLevel() == level)
            {
               gemBaseData = data2;
            }
         }
         if(gemBaseData == null)
         {
            throw new Error("找不到基础数据!");
         }
         return gemBaseData.composeGem(attrib);
      }
      
      public static function createGemByColorAndLevel(level:Array) : Gem
      {
         var data:GemBaseData = null;
         var droplv:Number = NaN;
         var createDatas:Array = [];
         for each(data in _GemDataList)
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
         var random:int = Math.floor(Math.random() * createDatas.length);
         data = createDatas[random] as GemBaseData;
         return data.createGem();
      }
      
      private static function getGemBaseDataByColor(color:Number) : Array
      {
         var data:GemBaseData = null;
         var datas:Array = [];
         for each(data in _GemDataList)
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
      
      private static function getGemBaseDataByName(name:String) : Array
      {
         var data:GemBaseData = null;
         var datas:Array = [];
         for each(data in _GemDataList)
         {
            if(data.getName() == name)
            {
               datas.push(data);
            }
         }
         if(datas.length < 1)
         {
            throw new Error("没有这个名称的宝石:color:" + name);
         }
         return datas;
      }
      
      public static function findFrame(id:Number) : Number
      {
         return getGemBaseDataById(id).getFrame();
      }
      
      public static function findName(id:Number) : String
      {
         return getGemBaseDataById(id).getName();
      }
      
      public static function findDescript(id:Number) : String
      {
         return getGemBaseDataById(id).getDescript();
      }
      
      public static function findTimes(id:Number) : Number
      {
         return getGemBaseDataById(id).getTimes();
      }
      
      public static function findType(id:Number) : int
      {
         return getGemBaseDataById(id).getType();
      }
      
      public static function findIsPile(id:Number) : Boolean
      {
         return getGemBaseDataById(id).getIsPile();
      }
      
      public static function findIsStrengthen(id:Number) : Boolean
      {
         return getGemBaseDataById(id).getIsStrengthen();
      }
      
      public static function findIsCompound(id:Number) : Boolean
      {
         return getGemBaseDataById(id).getIsCompound();
      }
      
      public static function findDropLevel(id:Number) : Number
      {
         return getGemBaseDataById(id).getDropLevel();
      }
      
      public static function findUseLevel(id:Number) : Number
      {
         return getGemBaseDataById(id).getUseLevel();
      }
      
      public static function findPileLimit(id:Number) : Number
      {
         return getGemBaseDataById(id).getPileLimit();
      }
      
      public static function findPrice(id:Number) : Number
      {
         return getGemBaseDataById(id).getPrice();
      }
      
      public static function findColor(id:Number) : Number
      {
         return getGemBaseDataById(id).getColor();
      }
      
      public static function findProbability(id:Number) : Number
      {
         return getGemBaseDataById(id).getProbability();
      }
      
      public static function findStrengthenLevel(id:Number) : Number
      {
         return getGemBaseDataById(id).getStrengthenLevel();
      }
      
      public static function findSkill(id:Number) : Number
      {
         return getGemBaseDataById(id).getAddSkill();
      }
      
      private function creatGemData() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var property:XML = null;
         var name:String = null;
         var frame:Number = NaN;
         var id:Number = NaN;
         var descript:String = null;
         var useLevel:Number = NaN;
         var dropLevel:Number = NaN;
         var strengthenLevel:Number = NaN;
         var price:Number = NaN;
         var type:int = 0;
         var times:Number = NaN;
         var color:Number = NaN;
         var isPile:Boolean = false;
         var isStrengthen:Boolean = false;
         var isCompound:Boolean = false;
         var pileLimit:Number = NaN;
         var probability:Number = NaN;
         var gemSkill:Number = NaN;
         var gemAttribList:XMLList = null;
         var gemAttrib:Array = null;
         var att:XML = null;
         var allData:GemBaseData = null;
         for each(property in myXml.宝石)
         {
            name = String(property.名称);
            frame = Number(property.帧数);
            id = Number(property.编号);
            descript = String(property.描述);
            useLevel = Number(property.使用等级);
            dropLevel = Number(property.掉落等级);
            strengthenLevel = Number(property.强化等级);
            price = Number(property.价钱);
            type = int(property.类型);
            times = Number(property.堆叠次数);
            color = Number(property.颜色);
            isPile = (property.是否堆叠.toString() == "true") as Boolean;
            isStrengthen = (property.是否强化.toString() == "true") as Boolean;
            isCompound = (property.是否合成.toString() == "true") as Boolean;
            pileLimit = Number(property.堆叠上限);
            probability = Number(property.概率);
            gemSkill = Number(property.宝石技能);
            gemAttribList = property.宝石属性;
            gemAttrib = [];
            for each(att in gemAttribList)
            {
               if(att.生命 != "null")
               {
                  gemAttrib.push(Attribute.creatAttribute(1,Number(att.生命)));
               }
               if(att.魔法 != "null")
               {
                  gemAttrib.push(Attribute.creatAttribute(2,Number(att.魔法)));
               }
               if(att.攻击 != "null")
               {
                  gemAttrib.push(Attribute.creatAttribute(3,Number(att.攻击)));
               }
               if(att.防御 != "null")
               {
                  gemAttrib.push(Attribute.creatAttribute(4,Number(att.防御)));
               }
               if(att.暴击 != "null")
               {
                  gemAttrib.push(Attribute.creatAttribute(5,Number(att.暴击)));
               }
               if(att.闪避 != "null")
               {
                  gemAttrib.push(Attribute.creatAttribute(6,Number(att.闪避)));
               }
               if(att.移动速度 != "null")
               {
                  gemAttrib.push(Attribute.creatAttribute(7,Number(att.移动速度)));
               }
               if(att.硬直 != "null")
               {
                  gemAttrib.push(Attribute.creatAttribute(8,Number(att.硬直)));
               }
            }
            allData = GemBaseData.cteateGemBaseData(id,frame,name,descript,times,type,isPile,isStrengthen,isCompound,dropLevel,useLevel,strengthenLevel,pileLimit,price,color,probability,gemAttrib,gemSkill);
            _GemDataList.push(allData);
         }
         GemFactory.isGemOK = true;
      }
   }
}

