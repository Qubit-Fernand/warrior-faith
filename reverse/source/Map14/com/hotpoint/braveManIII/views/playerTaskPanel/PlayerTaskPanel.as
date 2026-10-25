package com.hotpoint.braveManIII.views.playerTaskPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.npcTaskPanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
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
         initZxSlot();
         initTsSlot();
         initZxSlotVisible();
         initTsSlotVisible();
         isZxTaskOk();
         isTsTaskOk();
         zxTaskStata();
         tsTaskStata();
         zxOrTs();
         addEvent();
         finishBtn();
      }
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,doChange);
         this.addEventListener(BtnEvent.DO_CLICK,doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,doClose);
         this.addEventListener(BtnEvent.DO_OVER,doOver);
         this.addEventListener(BtnEvent.DO_OUT,doOut);
      }
      
      private function doOver(e:BtnEvent) : void
      {
         var arr:Array = [];
         if(nameId == "z")
         {
            arr = textData.getOneObj(zxSlot,taskingNum);
         }
         else if(nameId == "t")
         {
            arr = textData.getOneObj(tsSlot,taskingNum);
         }
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
      
      private function doChange(e:BtnEvent) : void
      {
         var mc:MovieClip = MovieClip(e.target);
         var id:Number = Number(mc.name.substr(2,1));
         taskingNum = id;
         trace("选中:+" + taskingNum);
         nameId = mc.name.substr(0,1);
         textVisible(nameId,taskingNum);
         renwuInit(nameId,id);
         finishBtn();
      }
      
      private function finishBtn() : void
      {
         var task:Task = null;
         g_mc.mouseEnabled = false;
         if(nameId == "z")
         {
            if(zxSlot.getTask(taskingNum) != null)
            {
               task = zxSlot.getTask(taskingNum);
            }
         }
         else if(nameId == "t")
         {
            if(tsSlot.getTask(taskingNum) != null)
            {
               task = tsSlot.getTask(taskingNum);
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
               whoSlot(zxSlot,num);
            }
            else if(ss == "t")
            {
               trace("显示特殊");
               whoSlot(tsSlot,num);
            }
         }
         else
         {
            textKong();
            jieshaoText();
            ycJl();
         }
      }
      
      public function whoSlot(slot:Object, num:Number) : void
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
      
      public function ycJl() : void
      {
         for(var i:uint = 0; i < 3; i++)
         {
            this["j_" + i].visible = false;
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
         if(e.target.name == "fq_btn")
         {
            if(nameId == "z")
            {
               zxTaskId = Number(zxSlot.getTask(taskingNum).getId());
               zxTk = zxSlot.getTask(taskingNum);
               NpcTaskPanel.clearGoods(zxTk);
               zxSlot.clearTask(taskingNum);
               NpcListData.setStata(zxTaskId,0);
               PlayerTaskData.clearTask(zxTaskId);
               initZxSlot();
               initZxSlotVisible();
               whoSlot(zxSlot,taskingNum);
            }
            else if(nameId == "t")
            {
               tsTaskId = Number(tsSlot.getTask(taskingNum).getId());
               tsTk = tsSlot.getTask(taskingNum);
               NpcTaskPanel.clearGoods(tsTk);
               tsSlot.clearTask(taskingNum);
               NpcListData.setStata(tsTaskId,0);
               PlayerTaskData.clearTask(tsTaskId);
               initTsSlot();
               initTsSlotVisible();
               whoSlot(tsSlot,taskingNum);
            }
         }
         else if(e.target.name == "finish_btn")
         {
            if(nameId == "z")
            {
               if(zxSlot.getTask(taskingNum) != null)
               {
                  finishTask(zxSlot,taskingNum);
               }
               initZxSlot();
               initZxSlotVisible();
               whoSlot(zxSlot,taskingNum);
            }
            else if(nameId == "t")
            {
               if(tsSlot.getTask(taskingNum) != null)
               {
                  finishTask(tsSlot,taskingNum);
               }
               initTsSlot();
               initTsSlotVisible();
               whoSlot(tsSlot,taskingNum);
            }
         }
         finishBtn();
         zxOrTs();
         zxTaskStata();
         tsTaskStata();
      }
      
      private function finishTask(slot:Object, taskingNum:Number) : void
      {
         var tasking:Task = null;
         var taskId:Number = Number(slot.getTask(taskingNum).getId());
         trace("任务状态:" + NpcListData.getStata(taskId));
         if(NpcListData.getStata(taskId) == 2)
         {
            if(textData.bagNum(slot,taskingNum))
            {
               tasking = slot.getTask(taskingNum);
               textData.overAward(slot,taskingNum);
               textData.overGoldAncExp(slot,taskingNum);
               textData.overPlayerStata(slot,taskingNum);
               NpcTaskPanel.clearGoods(tasking);
               NpcTaskPanel.clearGold(tasking);
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
         zxSlot.allclearTask();
         var zxArr:Array = PlayerTaskData.getTaskZx();
         for(var i:uint = 0; i < zxTaskNum; i++)
         {
            if(zxArr[i] != null)
            {
               task = zxArr[i] as Task;
               zxSlot.addSlot(task);
            }
         }
      }
      
      private function initTsSlot() : void
      {
         var task:Task = null;
         tsSlot.allclearTask();
         var tsArr:Array = PlayerTaskData.getTaskTs();
         for(var i:uint = 0; i < tsTaskNum; i++)
         {
            if(tsArr[i] != null)
            {
               task = tsArr[i] as Task;
               tsSlot.addSlot(task);
            }
         }
      }
      
      private function initZxSlotVisible() : void
      {
         for(var i:uint = 0; i < zxTaskNum; i++)
         {
            if(zxSlot.getTask(i) != null)
            {
               this["z_" + i].visible = true;
               this["z_" + i].tx.text = zxSlot.getTask(i).getName();
            }
            else
            {
               this["z_" + i].visible = false;
            }
         }
      }
      
      private function initTsSlotVisible() : void
      {
         for(var i:uint = 0; i < tsTaskNum; i++)
         {
            if(tsSlot.getTask(i) != null)
            {
               this["t_" + i].visible = true;
               this["t_" + i].tx.text = tsSlot.getTask(i).getName();
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
            for(i = 0; i < zxTaskNum; i++)
            {
               this["z_" + i].isClick = false;
            }
            for(i = 0; i < tsTaskNum; i++)
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
         taskingNum = id;
      }
      
      private function zxOrTs() : void
      {
         if(PlayerTaskData.noZxTask())
         {
            nameId = "z";
         }
         else if(PlayerTaskData.noTsTask())
         {
            nameId = "t";
         }
         else
         {
            nameId = null;
         }
         textVisible(nameId,0);
         renwuInit(nameId);
      }
      
      private function isZxTaskOk() : void
      {
         for(var i:uint = 0; i < zxTaskNum; i++)
         {
            if(zxSlot.getTask(i) != null)
            {
               if(zxSlot.getTask(i).istaskOk())
               {
                  zxSlot.getTask(i).setStata(2);
               }
            }
         }
      }
      
      private function zxTaskStata() : void
      {
         for(var i:uint = 0; i < zxTaskNum; i++)
         {
            if(zxSlot.getTask(i) != null)
            {
               if(zxSlot.getTask(i).getStata() == 1)
               {
                  this["z_" + i].ox.text = "(进行中)";
                  this["z_" + i].ox.setTextFormat(huang);
               }
               else if(zxSlot.getTask(i).getStata() == 2)
               {
                  this["z_" + i].ox.text = "(完成)";
                  this["z_" + i].ox.setTextFormat(lv);
               }
            }
         }
      }
      
      private function isTsTaskOk() : void
      {
         for(var i:uint = 0; i < zxTaskNum; i++)
         {
            if(tsSlot.getTask(i) != null)
            {
               if(tsSlot.getTask(i).istaskOk())
               {
                  tsSlot.getTask(i).setStata(2);
               }
            }
         }
      }
      
      private function tsTaskStata() : void
      {
         for(var i:uint = 0; i < tsTaskNum; i++)
         {
            if(tsSlot.getTask(i) != null)
            {
               if(tsSlot.getTask(i).getStata() == 1)
               {
                  this["t_" + i].ox.text = "(进行中)";
                  this["t_" + i].ox.setTextFormat(huang);
               }
               else if(tsSlot.getTask(i).getStata() == 2)
               {
                  this["t_" + i].ox.text = "(完成)";
                  this["t_" + i].ox.setTextFormat(lv);
               }
            }
         }
      }
   }
}

