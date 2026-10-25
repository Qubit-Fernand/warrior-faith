package com.hotpoint.braveManIII.repository.equip
{
   import com.hotpoint.braveManIII.models.equip.*;
   import flash.events.*;
   
   public class EquipFactory
   {
      
      public static var _equipDataList:Array = [];
      
      public static var isEquipOK:Boolean = false;
      
      public static var isSuitOK:Boolean = false;
      
      public static var _suitEquipList:Array = [];
      
      public static var myXml:XML = new XML();
      
      public static var suitXml:XML = new XML();
      
      public function EquipFactory()
      {
         super();
      }
      
      public static function creatEquipFactory() : *
      {
         var ef:EquipFactory = new EquipFactory();
         ef.creatEquipData();
      }
      
      public static function createEquipByShop() : Array
      {
         var data:EquipBaseData = null;
         var createDatas:Array = [];
         var datas:Array = getEquipBaseDatasByColor(1);
         for each(data in datas)
         {
            createDatas.push(data.createShopEquip());
         }
         return createDatas;
      }
      
      public static function createEquipByColorAndLevel(level:Array) : Equip
      {
         var data:EquipBaseData = null;
         var droplv:Number = NaN;
         var createDatas:Array = [];
         for each(data in _equipDataList)
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
         data = createDatas[random] as EquipBaseData;
         return data.createEquip();
      }
      
      public static function createEquipByID(id:Number) : Equip
      {
         var equipBaseData:EquipBaseData = getEquipBaseDataById(id);
         return equipBaseData.createEquip();
      }
      
      public static function getAllSuitEquipPostionAddName(suitId:Number) : Array
      {
         var data:EquipBaseData = null;
         var arr:Array = null;
         var temp:Boolean = true;
         var postionAddName:Array = [];
         for each(data in _equipDataList)
         {
            if(!(temp == false && data.getPosition() == 1))
            {
               if(data.getSuitId() == suitId)
               {
                  arr = [];
                  if(data.getPosition() == 1)
                  {
                     postionAddName[0] = arr;
                     arr[0] = data.getPosition();
                     arr[1] = data.getName();
                  }
                  else if(data.getPosition() == 2)
                  {
                     postionAddName[1] = arr;
                     arr[0] = data.getPosition();
                     arr[1] = data.getName();
                  }
                  else if(data.getPosition() == 3)
                  {
                     postionAddName[2] = arr;
                     arr[0] = data.getPosition();
                     arr[1] = data.getName();
                  }
                  else if(data.getPosition() == 4)
                  {
                     postionAddName[3] = arr;
                     arr[0] = data.getPosition();
                     arr[1] = data.getName();
                  }
               }
               if(data.getPosition() == 1 && data.getSuitId() == suitId)
               {
                  temp = false;
               }
            }
         }
         return postionAddName;
      }
      
      public static function getSuitEquip(suitId:Number) : SuitEquipAttrib
      {
         var suit:SuitEquipAttrib = null;
         var i:SuitEquipAttrib = null;
         for each(i in _suitEquipList)
         {
            if(i.getSuitId() == suitId)
            {
               suit = i;
               break;
            }
         }
         return suit;
      }
      
      public static function getSuitEquipSkillAttrib(suitId:Number) : String
      {
         var arr:Array = null;
         var suit:SuitEquipAttrib = null;
         var i:SuitEquipAttrib = null;
         var str:String = "";
         for each(i in _suitEquipList)
         {
            if(i.getSuitId() == suitId)
            {
               suit = i;
               break;
            }
         }
         if(suit == null)
         {
            throw new Error("不存在的套装:suitId:" + suitId);
         }
         arr = suit.getSuitBaseAttrib();
         for(var j:uint = 0; j < arr.length; j++)
         {
            str += arr[j] + "\n";
         }
         arr = suit.getSuitSkillAttrib();
         for(var k:uint = 0; k < arr.length; k++)
         {
            str += arr[k] + "\n";
         }
         return str;
      }
      
      public static function findBlessAttrib(id:Number) : Array
      {
         return getEquipBaseDataById(id).getBlessAttrib();
      }
      
      public static function findPosition(id:Number) : Number
      {
         return getEquipBaseDataById(id).getPosition();
      }
      
      public static function findDropLevel(id:Number) : Number
      {
         return getEquipBaseDataById(id).getDropLevel();
      }
      
      public static function findFrame(id:Number) : Number
      {
         return getEquipBaseDataById(id).getFrame();
      }
      
      public static function findDressLevel(id:Number) : Number
      {
         return getEquipBaseDataById(id).getDressLevel();
      }
      
      public static function findName(id:Number) : String
      {
         return getEquipBaseDataById(id).getName();
      }
      
      public static function findClassName(id:Number) : String
      {
         return getEquipBaseDataById(id).getClassName();
      }
      
      public static function findClassName2(id:Number) : String
      {
         return getEquipBaseDataById(id).getClassName2();
      }
      
      public static function findDescript(id:Number) : String
      {
         return getEquipBaseDataById(id).getDescript();
      }
      
      public static function findPrice(id:Number) : Number
      {
         return getEquipBaseDataById(id).getPrice();
      }
      
      public static function findReincarnationLimit(id:Number) : Number
      {
         return getEquipBaseDataById(id).getReincarnationLimit();
      }
      
      public static function findStar(id:Number) : Number
      {
         return getEquipBaseDataById(id).getStar();
      }
      
      public static function findRemainingTime(id:Number) : Number
      {
         return getEquipBaseDataById(id).getRemainingTime();
      }
      
      public static function findDefaultTime(id:Number) : Number
      {
         return getEquipBaseDataById(id).getDefaultTime();
      }
      
      public static function findColor(id:Number) : Number
      {
         return getEquipBaseDataById(id).getColor();
      }
      
      public static function findIsStrengthen(id:Number) : Boolean
      {
         return getEquipBaseDataById(id).getIsStrengthen();
      }
      
      public static function findJinHua(id:Number) : Number
      {
         return getEquipBaseDataById(id).getJinHua();
      }
      
      public static function findSuitId(id:Number) : Number
      {
         return getEquipBaseDataById(id).getSuitId();
      }
      
      private static function getEquipBaseDataById(id:Number) : EquipBaseData
      {
         var equipBaseData:EquipBaseData = null;
         var data:EquipBaseData = null;
         for each(data in _equipDataList)
         {
            if(data.getId() == id)
            {
               equipBaseData = data;
               break;
            }
         }
         if(equipBaseData == null)
         {
            throw new Error("找不到基础数据!id:" + id);
         }
         return equipBaseData;
      }
      
      private static function getEquipBaseDatasByColor(color:Number) : Array
      {
         var data:EquipBaseData = null;
         var datas:Array = [];
         for each(data in _equipDataList)
         {
            if(data.getColor() == color && data.getPosition() <= 7)
            {
               datas.push(data);
            }
         }
         if(datas.length < 1)
         {
            throw new Error("没有这个颜色的物品:color:" + color);
         }
         return datas;
      }
      
      private function creatEquipData() : *
      {
         xmlLoaded();
         suitxmlLoaded();
      }
      
      private function suitxmlLoaded() : *
      {
         var property:XML = null;
         var id:Number = NaN;
         var skillList:XMLList = null;
         var attribList:XMLList = null;
         var suitSkill:Array = null;
         var suitAttrib:Array = null;
         var skill:XML = null;
         var attrib:XML = null;
         for each(property in suitXml.套装)
         {
            id = Number(property.编号);
            skillList = property.套装技能;
            attribList = property.套装属性;
            suitSkill = [];
            suitAttrib = [];
            for each(skill in skillList)
            {
               if(skill.技能1 != "null")
               {
                  suitSkill.push(Number(skill.技能1));
               }
               if(skill.技能2 != "null")
               {
                  suitSkill.push(Number(skill.技能2));
               }
            }
            for each(attrib in attribList)
            {
               if(attrib.生命 != "null")
               {
                  suitAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,1,Number(attrib.生命)));
               }
               if(attrib.魔法 != "null")
               {
                  suitAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,2,Number(attrib.魔法)));
               }
               if(attrib.攻击 != "null")
               {
                  suitAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,3,Number(attrib.攻击)));
               }
               if(attrib.防御 != "null")
               {
                  suitAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,4,Number(attrib.防御)));
               }
               if(attrib.暴击 != "null")
               {
                  suitAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,5,Number(attrib.暴击)));
               }
               if(attrib.闪避 != "null")
               {
                  suitAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,6,Number(attrib.闪避)));
               }
               if(attrib.移动 != "null")
               {
                  suitAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,7,Number(attrib.移动)));
               }
               if(attrib.硬直 != "null")
               {
                  suitAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,8,Number(attrib.硬直)));
               }
            }
            _suitEquipList.push(SuitEquipAttrib.creatSuitEquipAttrib(id,suitSkill,suitAttrib));
         }
         isSuitOK = true;
      }
      
      private function xmlLoaded() : *
      {
         var property:XML = null;
         var name:String = null;
         var className:String = null;
         var className2:String = null;
         var frame:Number = NaN;
         var id:Number = NaN;
         var position:Number = NaN;
         var dressLevel:Number = NaN;
         var dropLevel:Number = NaN;
         var descript:String = null;
         var price:Number = NaN;
         var reincarnationLimit:Number = NaN;
         var color:Number = NaN;
         var isStrengthen:Boolean = false;
         var grid:Number = NaN;
         var suitId:Number = NaN;
         var fixedList:XMLList = null;
         var randomList:XMLList = null;
         var skillAttrib:Number = NaN;
         var star:Number = NaN;
         var remainingTime:Number = NaN;
         var defaultTime:Number = NaN;
         var jinhua:Number = NaN;
         var baseAttrib:Array = null;
         var blessAttrib:Array = null;
         var fixed:XML = null;
         var rdm:XML = null;
         var allData:EquipBaseData = null;
         for each(property in myXml.装备)
         {
            name = String(property.名称);
            className = String(property.类名);
            className2 = String(property.类名二);
            frame = Number(property.帧数);
            id = Number(property.编号);
            position = Number(property.部位);
            dressLevel = Number(property.穿戴等级);
            dropLevel = Number(property.掉落等级);
            descript = String(property.描述).replace(/\\n/g,"\n");
            price = Number(property.价钱);
            reincarnationLimit = Number(property.重生要求);
            color = Number(property.品质);
            isStrengthen = (property.是否强化.toString() == "true") as Boolean;
            grid = Number(property.格子数);
            suitId = Number(property.套装编号);
            fixedList = property.固定属性;
            randomList = property.随机属性;
            skillAttrib = Number(property.装备特性);
            star = Number(property.装备星级);
            remainingTime = Number(property.剩余时间);
            defaultTime = Number(property.默认时间);
            jinhua = Number(property.进化);
            baseAttrib = [];
            blessAttrib = [];
            for each(fixed in fixedList)
            {
               if(fixed.生命 != "null")
               {
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,1,Number(fixed.生命)));
               }
               if(fixed.魔法 != "null")
               {
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,2,Number(fixed.魔法)));
               }
               if(fixed.攻击 != "null")
               {
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,3,Number(fixed.攻击)));
               }
               if(fixed.防御 != "null")
               {
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(1,4,Number(fixed.防御)));
               }
            }
            for each(rdm in randomList)
            {
               if(color == 2)
               {
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(2,1,Number(rdm.附加生命)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(2,2,Number(rdm.附加魔法)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(2,3,Number(rdm.附加攻击)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(2,5,Number(rdm.附加暴击)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(2,6,Number(rdm.附加闪避)));
               }
               if(color == 3)
               {
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,1,Number(rdm.附加生命)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,2,Number(rdm.附加魔法)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,3,Number(rdm.附加攻击)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,5,Number(rdm.附加暴击)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,6,Number(rdm.附加闪避)));
               }
               if(color == 4)
               {
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,1,Number(rdm.附加生命)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,2,Number(rdm.附加魔法)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,3,Number(rdm.附加攻击)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,5,Number(rdm.附加暴击)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,6,Number(rdm.附加闪避)));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,1,Number(rdm.附加生命) * 3));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,2,Number(rdm.附加魔法) * 3));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,3,Number(rdm.附加攻击) * 3));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,5,Number(rdm.附加暴击) * 3));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,6,Number(rdm.附加闪避) * 3));
               }
               if(color == 5)
               {
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,1,Number(rdm.附加生命)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,2,Number(rdm.附加魔法)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,3,Number(rdm.附加攻击)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,5,Number(rdm.附加暴击)));
                  baseAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,6,Number(rdm.附加闪避)));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,1,Number(rdm.附加生命) * 3));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,2,Number(rdm.附加魔法) * 3));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,3,Number(rdm.附加攻击) * 3));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,5,Number(rdm.附加暴击) * 3));
                  blessAttrib.push(EquipBaseAttrib.creatEquipBaseAttrib(3,6,Number(rdm.附加闪避) * 3));
               }
            }
            allData = EquipBaseData.createEquipBaseData(id,frame,name,className,className2,position,dressLevel,dropLevel,descript,price,reincarnationLimit,color,isStrengthen,grid,suitId,star,remainingTime,defaultTime,jinhua,baseAttrib,blessAttrib,skillAttrib);
            _equipDataList.push(allData);
         }
         isEquipOK = true;
      }
   }
}

