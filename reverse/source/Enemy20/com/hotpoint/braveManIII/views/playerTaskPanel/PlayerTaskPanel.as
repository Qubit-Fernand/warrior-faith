package com.hotpoint.braveManIII.views.playerTaskPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.npcTaskPanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   
   public class PlayerTaskPanel extends MovieClip
   {
      
      private static var _instance:PlayerTaskPanel;
      
      private var zxSlot:PlayerTaskSlotZx;
      
      private var tsSlot:PlayerTaskSlotTs;
      
      private var zxTaskNum:Number = 5;
      
      private var tsTaskNum:Number = 5;
      
      private var jlNum:Number = 3;
      
      private var taskingNum:Number = 0;
      
      private var nameId:String;
      
      private var textData:TaskText;
      
      private var tooltip:ItemsTooltip;
      
      private var hong:TextFormat;
      
      private var lv:TextFormat;
      
      private var hui:TextFormat;
      
      private var huang:TextFormat;
      
      public function PlayerTaskPanel()
      {
         super();
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(PlayerTaskPanel._instance == null)
         {
            PlayerTaskPanel._instance = new PlayerTaskPanel();
            PlayerTaskPanel._instance.zxSlot = PlayerTaskSlotZx.creatSlot();
            PlayerTaskPanel._instance.tsSlot = PlayerTaskSlotTs.creatSlot();
            PlayerTaskPanel._instance.textData = TaskText.creatTaskData();
            PlayerTaskPanel._instance.tooltip = new ItemsTooltip();
            PlayerTaskPanel._instance.hong = new TextFormat();
            PlayerTaskPanel._instance.hong.color = 16711680;
            PlayerTaskPanel._instance.lv = new TextFormat();
            PlayerTaskPanel._instance.lv.color = 3407616;
            PlayerTaskPanel._instance.hui = new TextFormat();
            PlayerTaskPanel._instance.hui.color = 10066329;
            PlayerTaskPanel._instance.huang = new TextFormat();
            PlayerTaskPanel._instance.huang.color = 16763904;
         }
         PlayerTaskPanel._instance.initPanel();
         Main._stage.addChild(PlayerTaskPanel._instance);
         PlayerTaskPanel._instance.visible = true;
         PlayerTaskPanel._instance.tooltip.visible = false;
         PlayerTaskPanel._instance.addChild(PlayerTaskPanel._instance.tooltip);
         PlayerTaskPanel._instance.x = 100;
         PlayerTaskPanel._instance.y = 50;
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(PlayerTaskPanel._instance != null)
         {
            if(PlayerTaskPanel._instance.visible == true)
            {
               PlayerTaskPanel._instance.visible = false;
            }
         }
      }
      
      private function initPanel() : void
      {
         if(Main.gameNum != 0)
         {
            PlayerTaskData.addTaskData();
         }
         PlayerTaskData.addGold();
         PlayerTaskData.addGoodsNum();
         PlayerTaskData.addLevel();
         this.initZxSlot();
         this.initTsSlot();
         this.initZxSlotVisible();
         this.initTsSlotVisible();
         this.isZxTaskOk();
         this.isTsTaskOk();
         this.zxTaskStata();
         this.tsTaskStata();
         this.zxOrTs();
         this.addEvent();
         this.finishBtn();
      }
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,this.doChange);
         this.addEventListener(BtnEvent.DO_CLICK,this.doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,this.doClose);
         this.addEventListener(BtnEvent.DO_OVER,this.doOver);
         this.addEventListener(BtnEvent.DO_OUT,this.doOut);
      }
      
      private function doOver(e:BtnEvent) : void
      {
         var arr:Array = [];
         if(this.nameId == "z")
         {
            arr = this.textData.getOneObj(this.zxSlot,this.taskingNum);
         }
         else if(this.nameId == "t")
         {
            arr = this.textData.getOneObj(this.tsSlot,this.taskingNum);
         }
         var id:Number = Number(String(e.target.name).substr(2,1));
         switch(id)
         {
            case 0:
               this.tooVisible(arr[0]);
               break;
            case 1:
               this.tooVisible(arr[1]);
               break;
            case 2:
               this.tooVisible(arr[2]);
         }
         this.tooltip.x = mouseX;
         this.tooltip.y = mouseY;
         this.tooltip.visible = true;
      }
      
      private function tooVisible(ob:Object) : void
      {
         if(ob as Equip)
         {
            this.tooltip.equipTooltip(ob);
         }
         else if(ob as Gem)
         {
            this.tooltip.gemTooltip(ob);
         }
         else if(ob as Supplies)
         {
            this.tooltip.suppliesTooltip(ob);
         }
         else if(ob as Otherobj)
         {
            this.tooltip.otherTooltip(ob);
         }
      }
      
      public function doOut(e:BtnEvent) : void
      {
         this.tooltip.visible = false;
      }
      
      private function doChange(e:BtnEvent) : void
      {
         var mc:MovieClip = MovieClip(e.target);
         var id:Number = Number(mc.name.substr(2,1));
         this.taskingNum = id;
         trace("选中:+" + this.taskingNum);
         this.nameId = mc.name.substr(0,1);
         this.textVisible(this.nameId,this.taskingNum);
         this.renwuInit(this.nameId,id);
         this.finishBtn();
      }
      
      private function finishBtn() : void
      {
         var task:Task = null;
         g_mc.mouseEnabled = false;
         if(this.nameId == "z")
         {
            if(this.zxSlot.getTask(this.taskingNum) != null)
            {
               task = this.zxSlot.getTask(this.taskingNum);
            }
         }
         else if(this.nameId == "t")
         {
            if(this.tsSlot.getTask(this.taskingNum) != null)
            {
               task = this.tsSlot.getTask(this.taskingNum);
            }
         }
         if(task != null)
         {
            this.fq_btn.visible = true;
            if(task.getStata() == 2)
            {
               this.finish_btn.visible = true;
               g_mc.visible = true;
            }
            else
            {
               this.finish_btn.visible = false;
               g_mc.visible = false;
            }
         }
         else
         {
            this.finish_btn.visible = false;
            g_mc.visible = false;
            this.fq_btn.visible = false;
         }
      }
      
      public function textKong() : void
      {
         for(var i:uint = 0; i < 4; i++)
         {
            this["n" + i].text = "";
         }
      }
      
      public function textVisible(ss:String, num:Number) : void
      {
         if(ss != null)
         {
            if(ss == "z")
            {
               trace("显示支线");
               this.whoSlot(this.zxSlot,num);
               this.getUrlTask(this.zxSlot,num);
            }
            else if(ss == "t")
            {
               trace("显示特殊");
               this.whoSlot(this.tsSlot,num);
               this.getUrlTask(this.tsSlot,num);
            }
         }
         else
         {
            this.textKong();
            this.jieshaoText();
            this.ycJl();
            this.url_btn.visible = false;
         }
      }
      
      public function getUrlTask(slot:Object, num:Number = 0) : void
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
      
      public function whoSlot(slot:Object, num:Number) : void
      {
         if(slot.getTask(num))
         {
            jieshao.text = this.textData.getIntroduction(slot,num);
            need_1.text = this.textData.getDemand(slot,num);
            goldText.text = this.textData.getGold(slot,num);
            expText.text = this.textData.getExp(slot,num);
            this.needTextVisible(slot,num);
            this.jlVisible(this.textData.getOneObj(slot,num),this.textData.getAwrdNum(slot,num));
         }
         else
         {
            this.jieshaoText();
            this.textKong();
            this.ycJl();
         }
      }
      
      public function ycJl() : void
      {
         for(var i:uint = 0; i < 3; i++)
         {
            this["j_" + i].visible = false;
         }
      }
      
      public function needTextVisible(slot:Object, num:Number) : void
      {
         var arr1:Array = this.textData.getAllId(slot,num);
         var arr2:Array = this.textData.getAllNum(slot,num);
         var arr3:Array = this.textData.getAllNuming(slot,num);
         this.textKong();
         for(var i:uint = 0; i < arr1.length; i++)
         {
            this["n" + i].text = arr1[i] + ":" + "(" + arr3[i] + "/" + arr2[i] + ")";
         }
      }
      
      public function jlVisible(arr:Array, arr1:Array) : void
      {
         for(var i:uint = 0; i < this.jlNum; i++)
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
      
      public function jieshaoText() : void
      {
         jieshao.text = "";
         need_1.text = "";
         goldText.text = "";
         expText.text = "";
      }
      
      private function doClose(e:BtnEvent) : void
      {
         close();
      }
      
      private function doClick(e:BtnEvent) : void
      {
         var zxTaskId:Number = NaN;
         var zxTk:Task = null;
         var tsTaskId:Number = NaN;
         var tsTk:Task = null;
         var taskXX:Task = null;
         var request:URLRequest = null;
         if(e.target.name == "fq_btn")
         {
            if(this.nameId == "z")
            {
               zxTaskId = Number(this.zxSlot.getTask(this.taskingNum).getId());
               zxTk = this.zxSlot.getTask(this.taskingNum);
               NpcTaskPanel.clearGoods(zxTk);
               this.zxSlot.clearTask(this.taskingNum);
               NpcListData.setStata(zxTaskId,0);
               PlayerTaskData.clearTask(zxTaskId);
               this.initZxSlot();
               this.initZxSlotVisible();
               this.whoSlot(this.zxSlot,this.taskingNum);
               this.getUrlTask(this.zxSlot,this.taskingNum);
            }
            else if(this.nameId == "t")
            {
               tsTaskId = Number(this.tsSlot.getTask(this.taskingNum).getId());
               tsTk = this.tsSlot.getTask(this.taskingNum);
               NpcTaskPanel.clearGoods(tsTk);
               this.tsSlot.clearTask(this.taskingNum);
               NpcListData.setStata(tsTaskId,0);
               PlayerTaskData.clearTask(tsTaskId);
               this.initTsSlot();
               this.initTsSlotVisible();
               this.whoSlot(this.tsSlot,this.taskingNum);
               this.getUrlTask(this.tsSlot,this.taskingNum);
            }
         }
         else if(e.target.name == "finish_btn")
         {
            if(this.nameId == "z")
            {
               if(this.zxSlot.getTask(this.taskingNum) != null)
               {
                  this.finishTask(this.zxSlot,this.taskingNum);
               }
               this.initZxSlot();
               this.initZxSlotVisible();
               this.whoSlot(this.zxSlot,this.taskingNum);
               this.getUrlTask(this.zxSlot,this.taskingNum);
            }
            else if(this.nameId == "t")
            {
               if(this.tsSlot.getTask(this.taskingNum) != null)
               {
                  this.finishTask(this.tsSlot,this.taskingNum);
               }
               this.initTsSlot();
               this.initTsSlotVisible();
               this.whoSlot(this.tsSlot,this.taskingNum);
               this.getUrlTask(this.tsSlot,this.taskingNum);
            }
         }
         else if(e.target.name == "url_btn")
         {
            if(this.nameId == "z")
            {
               taskXX = this.zxSlot.getTask(this.taskingNum);
            }
            else if(this.nameId == "t")
            {
               taskXX = this.tsSlot.getTask(this.taskingNum);
            }
            request = new URLRequest(taskXX.getUrl());
            navigateToURL(request,"_blank");
         }
         if(e.target.name != "url_btn")
         {
            this.finishBtn();
            this.zxOrTs();
            this.zxTaskStata();
            this.tsTaskStata();
         }
      }
      
      private function finishTask(slot:Object, taskingNum:Number) : void
      {
         var tasking:Task = null;
         var taskId:Number = Number(slot.getTask(taskingNum).getId());
         trace("任务状态:" + NpcListData.getStata(taskId));
         if(NpcListData.getStata(taskId) == 2)
         {
            if(this.textData.bagNum(slot,taskingNum))
            {
               tasking = slot.getTask(taskingNum);
               this.textData.overAward(slot,taskingNum);
               this.textData.overGoldAncExp(slot,taskingNum);
               this.textData.overPlayerStata(slot,taskingNum);
               NpcTaskPanel.clearGoods(tasking);
               NpcTaskPanel.clearGold(tasking);
               if(tasking.isAgin())
               {
                  if(tasking.isRc())
                  {
                     NpcListData.setStata(taskId,3);
                     tasking.setOverTimer(Main.serverTime.getValue());
                     AchData.setRcTask();
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
               tasking.clearKong();
            }
            else
            {
               ShortTip.open(3);
            }
         }
      }
      
      private function initZxSlot() : void
      {
         var task:Task = null;
         this.zxSlot.allclearTask();
         var zxArr:Array = PlayerTaskData.getTaskZx();
         for(var i:uint = 0; i < this.zxTaskNum; i++)
         {
            if(zxArr[i] != null)
            {
               task = zxArr[i] as Task;
               this.zxSlot.addSlot(task);
            }
         }
      }
      
      private function initTsSlot() : void
      {
         var task:Task = null;
         this.tsSlot.allclearTask();
         var tsArr:Array = PlayerTaskData.getTaskTs();
         for(var i:uint = 0; i < this.tsTaskNum; i++)
         {
            if(tsArr[i] != null)
            {
               task = tsArr[i] as Task;
               this.tsSlot.addSlot(task);
            }
         }
      }
      
      private function initZxSlotVisible() : void
      {
         for(var i:uint = 0; i < this.zxTaskNum; i++)
         {
            if(this.zxSlot.getTask(i) != null)
            {
               this["z_" + i].visible = true;
               this["z_" + i].tx.text = this.zxSlot.getTask(i).getName();
            }
            else
            {
               this["z_" + i].visible = false;
            }
         }
      }
      
      private function initTsSlotVisible() : void
      {
         for(var i:uint = 0; i < this.tsTaskNum; i++)
         {
            if(this.tsSlot.getTask(i) != null)
            {
               this["t_" + i].visible = true;
               this["t_" + i].tx.text = this.tsSlot.getTask(i).getName();
            }
            else
            {
               this["t_" + i].visible = false;
            }
         }
      }
      
      private function renwuInit(str:String, id:Number = 0) : void
      {
         var i:uint = 0;
         if(str != null)
         {
            for(i = 0; i < this.zxTaskNum; i++)
            {
               this["z_" + i].isClick = false;
            }
            for(i = 0; i < this.tsTaskNum; i++)
            {
               this["t_" + i].isClick = false;
            }
            if(str == "z")
            {
               this["z_" + id].isClick = true;
            }
            else if(str == "t")
            {
               this["t_" + id].isClick = true;
            }
         }
         this.taskingNum = id;
      }
      
      private function zxOrTs() : void
      {
         if(PlayerTaskData.noZxTask())
         {
            this.nameId = "z";
         }
         else if(PlayerTaskData.noTsTask())
         {
            this.nameId = "t";
         }
         else
         {
            this.nameId = null;
         }
         this.textVisible(this.nameId,0);
         this.renwuInit(this.nameId);
      }
      
      private function isZxTaskOk() : void
      {
         for(var i:uint = 0; i < this.zxTaskNum; i++)
         {
            if(this.zxSlot.getTask(i) != null)
            {
               if(this.zxSlot.getTask(i).istaskOk())
               {
                  this.zxSlot.getTask(i).setStata(2);
               }
            }
         }
      }
      
      private function zxTaskStata() : void
      {
         for(var i:uint = 0; i < this.zxTaskNum; i++)
         {
            if(this.zxSlot.getTask(i) != null)
            {
               if(this.zxSlot.getTask(i).getStata() == 1)
               {
                  this["z_" + i].ox.text = "(进行中)";
                  this["z_" + i].ox.setTextFormat(this.huang);
               }
               else if(this.zxSlot.getTask(i).getStata() == 2)
               {
                  this["z_" + i].ox.text = "(完成)";
                  this["z_" + i].ox.setTextFormat(this.lv);
               }
            }
         }
      }
      
      private function isTsTaskOk() : void
      {
         for(var i:uint = 0; i < this.zxTaskNum; i++)
         {
            if(this.tsSlot.getTask(i) != null)
            {
               if(this.tsSlot.getTask(i).istaskOk())
               {
                  this.tsSlot.getTask(i).setStata(2);
               }
            }
         }
      }
      
      private function tsTaskStata() : void
      {
         for(var i:uint = 0; i < this.tsTaskNum; i++)
         {
            if(this.tsSlot.getTask(i) != null)
            {
               if(this.tsSlot.getTask(i).getStata() == 1)
               {
                  this["t_" + i].ox.text = "(进行中)";
                  this["t_" + i].ox.setTextFormat(this.huang);
               }
               else if(this.tsSlot.getTask(i).getStata() == 2)
               {
                  this["t_" + i].ox.text = "(完成)";
                  this["t_" + i].ox.setTextFormat(this.lv);
               }
            }
         }
      }
   }
}

