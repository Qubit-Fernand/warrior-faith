package com.hotpoint.braveManIII.views.npcTaskPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.playerTaskPanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   
   public class NpcTaskPanel extends MovieClip
   {
      
      private static var _instance:NpcTaskPanel;
      
      public static var npcNum:uint = 0;
      
      private var taskList:Array;
      
      private var slot:NpcTaskSlot;
      
      private var taskNum:Number = 10;
      
      private var taskingNum:Number = 0;
      
      private var jlNum:Number = 3;
      
      private var textData:TaskText;
      
      private var ii:uint = 0;
      
      private var tooltip:ItemsTooltip;
      
      private var hong:TextFormat;
      
      private var lv:TextFormat;
      
      private var hui:TextFormat;
      
      private var huang:TextFormat;
      
      private var urlData:String;
      
      public function NpcTaskPanel()
      {
         super();
      }
      
      public static function open(num:uint = 1) : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(NpcTaskPanel._instance == null)
         {
            NpcTaskPanel._instance = new NpcTaskPanel();
            NpcTaskPanel._instance.textData = new TaskText();
            NpcTaskPanel._instance.tooltip = new ItemsTooltip();
            NpcTaskPanel._instance.hong = new TextFormat();
            NpcTaskPanel._instance.hong.color = 16711680;
            NpcTaskPanel._instance.lv = new TextFormat();
            NpcTaskPanel._instance.lv.color = 3407616;
            NpcTaskPanel._instance.hui = new TextFormat();
            NpcTaskPanel._instance.hui.color = 10066329;
            NpcTaskPanel._instance.huang = new TextFormat();
            NpcTaskPanel._instance.huang.color = 16763904;
         }
         npcNum = num;
         if(Main.gameNum != 0)
         {
            PlayerTaskData.addTaskData();
         }
         PlayerTaskData.addGoodsNum();
         PlayerTaskData.addGold();
         PlayerTaskData.addLevel();
         NpcTaskPanel._instance.initNpcList(num);
         NpcTaskPanel._instance.initNpcTask(num);
         NpcTaskPanel._instance.initSlot();
         NpcTaskPanel._instance.initSlotVisble();
         NpcTaskPanel._instance.initText();
         NpcTaskPanel._instance.renwuInit();
         NpcTaskPanel._instance.btnStata();
         NpcTaskPanel._instance.initStataRenwu();
         Main._stage.addChild(NpcTaskPanel._instance);
         NpcTaskPanel._instance.addEvent();
         NpcTaskPanel._instance.visible = true;
         NpcTaskPanel._instance.tooltip.visible = false;
         NpcTaskPanel._instance.addChild(NpcTaskPanel._instance.tooltip);
         NpcTaskPanel._instance.x = 100;
         NpcTaskPanel._instance.y = 50;
         NpcTaskPanel._instance.mcGoTo(num);
         NpcTaskPanel._instance.btnStata();
         NpcTaskPanel._instance.getUrlTask();
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(NpcTaskPanel._instance != null)
         {
            if(NpcTaskPanel._instance.visible == true)
            {
               NpcTaskPanel._instance.visible = false;
            }
         }
      }
      
      public static function clearGold(task:Task) : void
      {
         if(task.getFinishGold() != -1)
         {
            Main.player1.payGold(task.getFinishGold());
            if(Main.P1P2)
            {
               Main.player2.payGold(task.getFinishGold());
            }
         }
      }
      
      public static function clearGoods(task:Task) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(task.getGoodsId() != null)
         {
            arr = task.getGoodsId();
            for(i = 0; i < arr.length; i++)
            {
               clearP1orP2(arr[i],task.getId());
            }
         }
      }
      
      public static function clearP1orP2(id:Number, taskId:Number) : void
      {
         if(taskId != 210002)
         {
            Main.player1.getBag().clearQuest(id);
            if(Main.P1P2)
            {
               Main.player2.getBag().clearQuest(id);
            }
         }
         else
         {
            Main.player1.getBag().clearOther(id);
            if(Main.P1P2)
            {
               Main.player2.getBag().clearOther(id);
            }
         }
      }
      
      public function initNpcList(num:Number = 1) : void
      {
         updeXh();
         if(num == 1)
         {
            NpcListData.setTaskZx(NpcTaskData.updateOne());
         }
         else if(num == 2)
         {
            NpcListData.setTaskZz(NpcTaskData.updateTow());
         }
         else if(num == 3)
         {
            NpcListData.setTaskTs(NpcTaskData.updateThree());
         }
         else if(num == 4)
         {
            NpcListData.setTaskXh(NpcTaskData.updateFour());
         }
         else if(num == 5)
         {
            NpcListData.setTaskCw(NpcTaskData.updateCw());
         }
      }
      
      private function mcGoTo(num:Number) : void
      {
         if(num == 1)
         {
            this.name_mc.gotoAndStop(1);
         }
         else if(num == 2)
         {
            this.name_mc.gotoAndStop(2);
         }
         else if(num == 3)
         {
            this.name_mc.gotoAndStop(4);
         }
         else if(num == 4)
         {
            this.name_mc.gotoAndStop(3);
         }
         else if(num == 5)
         {
            this.name_mc.gotoAndStop(3);
         }
      }
      
      public function initNpcTask(num:Number = 1) : void
      {
         if(num == 1)
         {
            taskList = NpcTaskData.levelOk(NpcListData.getTaskZx());
         }
         else if(num == 2)
         {
            taskList = NpcTaskData.levelOk(NpcListData.getTaskZz());
         }
         else if(num == 3)
         {
            taskList = NpcTaskData.levelOk(NpcListData.getTaskTs());
         }
         else if(num == 4)
         {
            taskList = NpcTaskData.levelOk(NpcListData.getTaskXh());
         }
         else if(num == 5)
         {
            taskList = NpcTaskData.levelOk(NpcListData.getTaskCw());
         }
      }
      
      public function initSlot() : void
      {
         var task:Task = null;
         slot = NpcTaskSlot.creatSlot();
         for(var i:uint = 0; i < taskList.length; i++)
         {
            task = taskList[i];
            if(task.getStata() != 3)
            {
               slot.addSlot(task);
            }
         }
      }
      
      private function isTaskOk() : void
      {
         for(var i:uint = 0; i < taskNum; i++)
         {
            if(slot.getTask(i) != null)
            {
               if(slot.getTask(i).istaskOk())
               {
                  slot.getTask(i).setStata(2);
               }
            }
         }
      }
      
      private function isTaskOkTow() : void
      {
         var task:Task = null;
         for(var i:uint = 0; i < taskNum; i++)
         {
            if(slot.getTask(i) != null)
            {
               task = slot.getTask(i);
               if(task.getStata() == 3)
               {
                  if(Main.serverTime.getValue() != task.getOverTimer())
                  {
                     task.setStata(0);
                  }
               }
            }
         }
      }
      
      private function updeXh() : void
      {
         var task:Task = null;
         var arr:Array = NpcListData.getTaskXh();
         if(arr.length < 1)
         {
            return;
         }
         for(var i:uint = 0; i < arr.length; i++)
         {
            task = arr[i];
            if(task.getStata() == 3)
            {
               if(Main.serverTime.getValue() != task.getOverTimer())
               {
                  NpcListData.clearXhOldTask();
                  task.setStata(0);
                  trace("重置循环任务______________________");
               }
            }
         }
      }
      
      public function initStataRenwu() : void
      {
         isTaskOk();
         for(var i:uint = 0; i < taskNum; i++)
         {
            if(slot.getTask(i))
            {
               if(slot.getTask(i).getStata() == 0)
               {
                  this["t_" + i].ox.text = "(未接取)";
                  this["t_" + i].ox.setTextFormat(hong);
               }
               else if(slot.getTask(i).getStata() == 1)
               {
                  this["t_" + i].ox.text = "(进行中)";
                  this["t_" + i].ox.setTextFormat(huang);
               }
               else if(slot.getTask(i).getStata() == 2)
               {
                  this["t_" + i].ox.text = "(已完成)";
                  this["t_" + i].ox.setTextFormat(lv);
               }
               else if(slot.getTask(i).getStata() == 3)
               {
                  this["t_" + i].ox.text = "(冷却中)";
                  this["t_" + i].ox.setTextFormat(hui);
               }
            }
         }
      }
      
      public function initSlotVisble() : void
      {
         var arr:Array = slot.getSlotArr();
         trace(arr);
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(arr[i] != -1)
            {
               this["t_" + i].visible = true;
               this["t_" + i].tx.text = (arr[i] as Task).getName();
            }
            else
            {
               this["t_" + i].visible = false;
            }
         }
      }
      
      public function initText(num:Number = 0) : void
      {
         if(slot.getTask(num))
         {
            jieshao.text = textData.getIntroduction(slot,num);
            need_1.text = textData.getDemand(slot,num);
            goldText.text = textData.getGold(slot,num);
            expText.text = textData.getExp(slot,num);
            needTextVisible(slot,num);
            jlVisible(textData.getOneObj(slot,num),textData.getAwrdNum(slot,num));
         }
         else
         {
            jieshaoText();
            textKong();
            ycJl();
         }
      }
      
      public function getUrlTask(num:Number = 0) : void
      {
         var task:Task = null;
         this.url_btn.visible = false;
         if(slot.getTask(num))
         {
            task = slot.getTask(num);
            if(task.getUrl() != "-1")
            {
               this.url_btn.visible = true;
            }
         }
      }
      
      public function needTextVisible(slot:Object, num:Number) : void
      {
         var arr1:Array = textData.getAllId(slot,num);
         var arr2:Array = textData.getAllNum(slot,num);
         var arr3:Array = textData.getAllNuming(slot,num);
         textKong();
         for(var i:uint = 0; i < arr1.length; i++)
         {
            this["n" + i].text = arr1[i] + ":" + "(" + arr3[i] + "/" + arr2[i] + ")";
         }
      }
      
      public function jlVisible(arr:Array, arr1:Array) : void
      {
         for(var i:uint = 0; i < jlNum; i++)
         {
            this["j_" + i].visible = false;
         }
         if(arr.length > 0)
         {
            for(i = 0; i < arr.length; i++)
            {
               this["j_" + i].visible = true;
               this["j_" + i].howNum.text = arr1[i];
               this["j_" + i].gotoAndStop(arr[i].getFrame());
            }
         }
      }
      
      public function ycJl() : void
      {
         for(var i:uint = 0; i < 3; i++)
         {
            this["j_" + i].visible = false;
         }
      }
      
      public function textKong() : void
      {
         for(var i:uint = 0; i < 4; i++)
         {
            this["n" + i].text = "";
         }
      }
      
      public function jieshaoText() : void
      {
         jieshao.text = "";
         need_1.text = "";
         goldText.text = "";
         expText.text = "";
      }
      
      public function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,doChange);
         this.addEventListener(BtnEvent.DO_CLICK,doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,doClose);
         this.addEventListener(BtnEvent.DO_OVER,doOver);
         this.addEventListener(BtnEvent.DO_OUT,doOut);
      }
      
      private function doOver(e:BtnEvent) : void
      {
         trace(e.target.name + "e.target.name");
         var arr:Array = textData.getOneObj(slot,taskingNum);
         var id:Number = Number(String(e.target.name).substr(2,1));
         switch(id)
         {
            case 0:
               tooVisible(arr[0]);
               break;
            case 1:
               tooVisible(arr[1]);
               break;
            case 2:
               tooVisible(arr[2]);
         }
         tooltip.x = mouseX;
         tooltip.y = mouseY;
         tooltip.visible = true;
      }
      
      private function tooVisible(ob:Object) : void
      {
         if(ob as Equip)
         {
            tooltip.equipTooltip(ob);
         }
         else if(ob as Gem)
         {
            tooltip.gemTooltip(ob);
         }
         else if(ob as Supplies)
         {
            tooltip.suppliesTooltip(ob);
         }
         else if(ob as Otherobj)
         {
            tooltip.otherTooltip(ob);
         }
      }
      
      public function doOut(e:BtnEvent) : void
      {
         tooltip.visible = false;
      }
      
      public function doClose(e:BtnEvent) : void
      {
         close();
      }
      
      public function btnStata() : void
      {
         var task:Task = getTaskStata0();
         if(task != null)
         {
            this.npcBtn.visible = true;
            if(task.getStata() == 0)
            {
               this.npcBtn.gotoAndStop(1);
               this.npcBtn.visible = true;
               this.finish_btn.visible = false;
               g_mc.visible = false;
            }
            else if(task.getStata() == 1)
            {
               this.finish_btn.visible = false;
               g_mc.visible = false;
               this.npcBtn.gotoAndStop(2);
            }
            else if(task.getStata() == 2)
            {
               this.finish_btn.visible = true;
               g_mc.visible = true;
               g_mc.mouseEnabled = false;
               this.npcBtn.gotoAndStop(2);
            }
            else if(task.getStata() == 3)
            {
               this.finish_btn.visible = false;
               g_mc.visible = false;
               this.npcBtn.visible = false;
            }
         }
         else
         {
            g_mc.visible = false;
            this.finish_btn.visible = false;
            this.npcBtn.gotoAndStop(1);
            this.npcBtn.visible = false;
         }
      }
      
      private function doChange(e:BtnEvent) : void
      {
         var mc:MovieClip = MovieClip(e.target);
         var id:Number = Number(mc.name.substr(2,1));
         initText(id);
         renwuInit(id);
         getUrlTask(id);
         btnStata();
      }
      
      private function renwuInit(id:Number = 0) : void
      {
         for(var i:uint = 0; i < taskNum; i++)
         {
            this["t_" + i].isClick = false;
         }
         this["t_" + id].isClick = true;
         taskingNum = id;
      }
      
      private function getTaskStata0() : Task
      {
         if(slot.getTask(taskingNum) != null)
         {
            return slot.getTask(taskingNum);
         }
         return null;
      }
      
      private function doClick(e:BtnEvent) : void
      {
         var tasking:Task = null;
         var taskId:Number = NaN;
         var request:URLRequest = null;
         trace(e.id);
         if(getTaskStata0() != null)
         {
            tasking = getTaskStata0();
            taskId = tasking.getId();
            if(e.id == 1)
            {
               if(NpcListData.getStata(taskId) == 0)
               {
                  if(tasking.getBranch() == 1)
                  {
                     if(NpcListData.zxNoGo())
                     {
                        NpcListData.setStata(taskId,1);
                     }
                     else
                     {
                        ShortTip.open(1);
                        trace("支线已接任务栏已满");
                     }
                  }
                  else if(NpcListData.tsNoGo())
                  {
                     NpcListData.setStata(taskId,1);
                  }
                  else
                  {
                     ShortTip.open(1);
                     trace("特殊已接任务栏已满");
                  }
               }
            }
            else if(e.id == 2)
            {
               trace("放弃");
               if(NpcListData.getStata(taskId) == 1 || NpcListData.getStata(taskId) == 2)
               {
                  tasking.clearKong();
                  clearGoods(tasking);
                  NpcListData.setStata(taskId,0);
                  PlayerTaskData.clearTask(taskId);
                  initText();
                  renwuInit();
                  taskingNum = 0;
               }
            }
            else if(e.id == 3)
            {
               if(NpcListData.getStata(taskId) == 2)
               {
                  if(textData.bagNum(slot,taskingNum))
                  {
                     textData.overAward(slot,taskingNum);
                     textData.overGoldAncExp(slot,taskingNum);
                     textData.overPlayerStata(slot,taskingNum);
                     clearGoods(tasking);
                     clearGold(tasking);
                     if(tasking.isAgin())
                     {
                        if(tasking.isRc())
                        {
                           NpcListData.setStata(taskId,3);
                           tasking.setOverTimer(Main.serverTime.getValue());
                        }
                        else
                        {
                           NpcListData.setStata(taskId,0);
                        }
                     }
                     else
                     {
                        NpcListData.clearTask(taskId);
                     }
                     NpcListData.setOldTask(tasking);
                     PlayerTaskData.clearTask(taskId);
                     initNpcList(npcNum);
                     initNpcTask(npcNum);
                     initSlot();
                     initSlotVisble();
                     initText();
                     renwuInit();
                     getUrlTask();
                     taskingNum = 0;
                  }
                  else
                  {
                     ShortTip.open(3);
                  }
               }
            }
            else if(e.id == 6)
            {
               request = new URLRequest(tasking.getUrl());
               navigateToURL(request,"_blank");
            }
            if(e.id != 6)
            {
               tasking.clearKong();
               initStataRenwu();
               btnStata();
            }
         }
         else
         {
            trace("没有选择的任务");
         }
      }
   }
}

