package com.hotpoint.braveManIII.repository.task
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class TaskFactory
   {
      
      public static var allData:Array = [];
      
      public static var allTask:Array = [];
      
      public function TaskFactory()
      {
         super();
      }
      
      public static function creatTaskFactory() : *
      {
         var data:TaskFactory = new TaskFactory();
         myXml = XMLAsset.createXML(Data2.taskData);
         data.creatTaskXml();
      }
      
      private static function getDataById(id:Number) : TaskBasicData
      {
         var data:TaskBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               return data;
            }
         }
         trace("没有此ID的任务数据");
         return null;
      }
      
      public static function getName(id:Number) : String
      {
         return getDataById(id).getName();
      }
      
      public static function getLevel(id:Number) : Number
      {
         return getDataById(id).getLevel();
      }
      
      public static function getTaskIntroduction(id:Number) : String
      {
         return getDataById(id).getTaskIntroduction();
      }
      
      public static function getDemand(id:Number) : String
      {
         return getDataById(id).getDemand();
      }
      
      public static function getBigType(id:Number) : Number
      {
         return getDataById(id).getBigType();
      }
      
      public static function getSmallType(id:Number) : Number
      {
         return getDataById(id).getSmallType();
      }
      
      public static function getWtr(id:Number) : String
      {
         return getDataById(id).getWtr();
      }
      
      public static function getBeforeTaskId(id:Number) : Number
      {
         return getDataById(id).getBeforeTaskId();
      }
      
      public static function getRebirth(id:Number) : Boolean
      {
         return getDataById(id).getRebirth();
      }
      
      public static function getMapId(id:Number) : Number
      {
         return getDataById(id).getMapId();
      }
      
      public static function getMapStar(id:Number) : Number
      {
         return getDataById(id).getMapStar();
      }
      
      public static function getEnemyId(id:Number) : Array
      {
         return getDataById(id).getEnemyId();
      }
      
      public static function getEnemyName(id:Number) : Array
      {
         return getDataById(id).getEnemyName();
      }
      
      public static function getEnemyNum(id:Number) : Array
      {
         return getDataById(id).getEnemyNum();
      }
      
      public static function getGoodsId(id:Number) : Array
      {
         return getDataById(id).getGoodsId();
      }
      
      public static function getGoodsNum(id:Number) : Array
      {
         return getDataById(id).getGoodsNum();
      }
      
      public static function getLianjiNum(id:Number) : Number
      {
         return getDataById(id).getLianjiNum();
      }
      
      public static function getFightNum(id:Number) : Number
      {
         return getDataById(id).getFightNum();
      }
      
      public static function getTime(id:Number) : Number
      {
         return getDataById(id).getTimeNum();
      }
      
      public static function getFinishGold(id:Number) : Number
      {
         return getDataById(id).getFinishGold();
      }
      
      public static function getFinishLevel(id:Number) : Number
      {
         return getDataById(id).getFinishLevel();
      }
      
      public static function getTg(id:Number) : Boolean
      {
         return getDataById(id).getTg();
      }
      
      public static function getNpc(id:Number) : Number
      {
         return getDataById(id).getNpc();
      }
      
      public static function getYhd(id:Number) : Number
      {
         return getDataById(id).getYhd();
      }
      
      public static function getPhb(id:Number) : Number
      {
         return getDataById(id).getPhb();
      }
      
      public static function getAwardId(id:Number) : Array
      {
         return getDataById(id).getAwardId();
      }
      
      public static function getAwardType(id:Number) : Array
      {
         return getDataById(id).getAwardType();
      }
      
      public static function getAwardNum(id:Number) : Array
      {
         return getDataById(id).getAwardNum();
      }
      
      public static function getAwardGold(id:Number) : Number
      {
         return getDataById(id).getGold();
      }
      
      public static function getAwardExp(id:Number) : Number
      {
         return getDataById(id).getExp();
      }
      
      public static function getAwardPs(id:Number) : Number
      {
         return getDataById(id).getPlayerStata();
      }
      
      public static function getAwardGl(id:Number) : Array
      {
         return getDataById(id).getGl();
      }
      
      public static function getGoodsMaxNum(id:Number, fallId:Number) : Number
      {
         var i:uint = 0;
         var goodsId:Array = getGoodsId(id);
         var goodsNum:Array = getGoodsNum(id);
         if(goodsId[0].getValue() != -1)
         {
            for(i = 0; i < goodsId.length; i++)
            {
               if(goodsId[i].getValue() == fallId)
               {
                  return goodsNum[i].getValue();
               }
            }
         }
         return -1;
      }
      
      private function creatTaskXml() : *
      {
         this.xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var property:XML = null;
         var id:Number = NaN;
         var name:String = null;
         var level:Number = NaN;
         var taskIn:String = null;
         var taskDe:String = null;
         var bigType:Number = NaN;
         var smallType:Number = NaN;
         var wtr:String = null;
         var mapId:Number = NaN;
         var mapStar:Number = NaN;
         var enemyId:String = null;
         var enemyName:String = null;
         var enemyNum:String = null;
         var goodsId:String = null;
         var goodsNum:String = null;
         var lianjiNum:Number = NaN;
         var fightNum:Number = NaN;
         var timeNum:Number = NaN;
         var finishGold:Number = NaN;
         var finishLevel:Number = NaN;
         var tg:Boolean = false;
         var npc:Number = NaN;
         var yhd:Number = NaN;
         var phb:Number = NaN;
         var beforeTaskId:Number = NaN;
         var rebirth:Boolean = false;
         var awardType:String = null;
         var awardId:String = null;
         var awardNum:String = null;
         var gold:Number = NaN;
         var exp:Number = NaN;
         var playersDate:Number = NaN;
         var gl:String = null;
         var taskData:TaskBasicData = null;
         for each(property in myXml.任务)
         {
            id = Number(property.ID);
            name = String(property.名称);
            level = Number(property.级数);
            taskIn = String(property.介绍);
            taskDe = String(property.需求);
            bigType = Number(property.大类型);
            smallType = Number(property.小类型);
            wtr = String(property.委托人);
            mapId = Number(property.完成条件.地图ID);
            mapStar = Number(property.完成条件.地图星级);
            enemyId = String(property.完成条件.怪物ID);
            enemyName = String(property.完成条件.怪物名字);
            enemyNum = String(property.完成条件.怪物数量);
            goodsId = String(property.完成条件.物品ID);
            goodsNum = String(property.完成条件.物品数量);
            lianjiNum = Number(property.完成条件.连击数);
            fightNum = Number(property.完成条件.被击打数);
            timeNum = Number(property.完成条件.时间);
            finishGold = Number(property.完成条件.完成金币);
            finishLevel = Number(property.完成条件.完成等级);
            tg = (property.完成条件.通关.toString() == "true") as Boolean;
            npc = Number(property.完成条件.npc);
            yhd = Number(property.完成条件.友好度);
            phb = Number(property.完成条件.排行榜);
            beforeTaskId = Number(property.出现任务条件.前置任务ID);
            rebirth = (property.出现任务条件.重生.toString() == "true") as Boolean;
            awardType = String(property.奖励.奖励类型);
            awardId = String(property.奖励.奖励id);
            awardNum = String(property.奖励.奖励数量);
            gold = Number(property.奖励.金币);
            exp = Number(property.奖励.经验);
            playersDate = Number(property.奖励.奖励状态);
            gl = String(property.奖励.奖励概率);
            taskData = TaskBasicData.creatTaskBasicData(id,name,level,taskIn,taskDe,bigType,smallType,wtr,beforeTaskId,rebirth,mapId,mapStar,enemyId,enemyName,enemyNum,goodsId,goodsNum,lianjiNum,fightNum,timeNum,finishGold,finishLevel,tg,npc,yhd,phb,awardType,awardId,awardNum,gold,exp,playersDate,gl);
            allData.push(taskData);
            allTask.push(taskData.creatTask());
         }
      }
   }
}

