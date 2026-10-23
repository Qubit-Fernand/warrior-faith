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
   import flash.display.*;
   import src.*;
   
   public class PlayerTaskPanel extends MovieClip
   {
      
      private static var _instance:PlayerTaskPanel;
      
      private var jlNum:Number = 3;
      
      private var taskingNum:Number = 0;
      
      private var nameId:String;
      
      private var tooltip:ItemsTooltip;
      
      private var tsSlot:PlayerTaskSlotTs;
      
      private var zxSlot:PlayerTaskSlotZx;
      
      private var textData:TaskText;
      
      private var tsTaskNum:Number = 5;
      
      private var zxTaskNum:Number = 5;
      
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
      
      public function ycJl() : void
      {
         var i:uint = 0;
         for(i = 0; i < 3; i++)
         {
            this["j_" + i].visible = false;
         }
      }
      
      private function doChange(e:BtnEvent) : void
      {
         var mc:MovieClip = null;
         var id:Number = NaN;
         mc = MovieClip(e.target);
         id = Number(mc.name.substr(2,1));
         taskingNum = id;
         trace("选中:+" + taskingNum);
         nameId = mc.name.substr(0,1);
         textVisible(nameId,taskingNum);
         renwuInit(nameId,id);
      }
      
      private function doClose(e:BtnEvent) : void
      {
         close();
      }
      
      public function jieshaoText() : void
      {
         jieshao.text = "";
         need_1.text = "";
         goldText.text = "";
         expText.text = "";
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
            jlVisible(textData.addJl(slot,num),textData.getAwrdNum(slot,num));
         }
         else
         {
            jieshaoText();
            textKong();
            ycJl();
         }
      }
      
      public function needTextVisible(slot:Object, num:Number) : void
      {
         var arr1:Array = null;
         var arr2:Array = null;
         var arr3:Array = null;
         var i:uint = 0;
         arr1 = textData.getAllId(slot,num);
         arr2 = textData.getAllNum(slot,num);
         arr3 = textData.getAllNuming(slot,num);
         textKong();
         for(i = 0; i < arr1.length; i++)
         {
            this["n" + i].text = arr1[i] + ":" + "(" + arr3[i] + "/" + arr2[i] + ")";
         }
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
      
      private function tsTaskStata() : void
      {
         var i:uint = 0;
         for(i = 0; i < tsTaskNum; i++)
         {
            if(tsSlot.getTask(i) != null)
            {
               if(tsSlot.getTask(i).getStata() == 1)
               {
                  this["t_" + i].ox.text = "(进行中)";
               }
               else if(tsSlot.getTask(i).getStata() == 2)
               {
                  this["t_" + i].ox.text = "(完成)";
               }
            }
         }
      }
      
      private function renwuInit(str:String, id:Number = 0) : void
      {
         var i:uint = 0;
         trace(str + "____另个名字");
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
      
      private function zxTaskStata() : void
      {
         var i:uint = 0;
         for(i = 0; i < zxTaskNum; i++)
         {
            if(zxSlot.getTask(i) != null)
            {
               if(zxSlot.getTask(i).getStata() == 1)
               {
                  this["z_" + i].ox.text = "(进行中)";
               }
               else if(zxSlot.getTask(i).getStata() == 2)
               {
                  this["z_" + i].ox.text = "(完成)";
               }
            }
         }
      }
      
      private function isZxTaskOk() : void
      {
         var i:uint = 0;
         for(i = 0; i < zxTaskNum; i++)
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
      
      private function initTsSlotVisible() : void
      {
         var i:uint = 0;
         for(i = 0; i < tsTaskNum; i++)
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
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,doChange);
         this.addEventListener(BtnEvent.DO_CLICK,doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,doClose);
         this.addEventListener(BtnEvent.DO_OVER,doOver);
         this.addEventListener(BtnEvent.DO_OUT,doOut);
      }
      
      private function initZxSlotVisible() : void
      {
         var i:uint = 0;
         for(i = 0; i < zxTaskNum; i++)
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
      
      private function initTsSlot() : void
      {
         var tsArr:Array = null;
         var i:uint = 0;
         var task:Task = null;
         tsSlot.allclearTask();
         tsArr = PlayerTaskData.getTaskTs();
         for(i = 0; i < tsTaskNum; i++)
         {
            if(tsArr[i] != null)
            {
               task = tsArr[i] as Task;
               tsSlot.addSlot(task);
            }
         }
      }
      
      public function textVisible(ss:String, num:Number) : void
      {
         trace("进入");
         trace(ss + "名字",num + "位置");
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
      
      private function initZxSlot() : void
      {
         var zxArr:Array = null;
         var i:uint = 0;
         var task:Task = null;
         zxSlot.allclearTask();
         zxArr = PlayerTaskData.getTaskZx();
         for(i = 0; i < zxTaskNum; i++)
         {
            if(zxArr[i] != null)
            {
               task = zxArr[i] as Task;
               zxSlot.addSlot(task);
            }
         }
      }
      
      private function doClick(e:BtnEvent) : void
      {
         var zxTaskId:Number = NaN;
         var tsTaskId:Number = NaN;
         trace(taskingNum + ":删除第几个??????");
         trace(nameId + "名字");
         if(nameId == "z")
         {
            zxTaskId = Number(zxSlot.getTask(taskingNum).getId());
            zxSlot.clearTask(taskingNum);
            NpcListData.setStata(zxTaskId,0);
            PlayerTaskData.clearTask(zxTaskId);
            initZxSlot();
            initZxSlotVisible();
            whoSlot(tsSlot,zxSlot);
         }
         else if(nameId == "t")
         {
            tsTaskId = Number(tsSlot.getTask(taskingNum).getId());
            tsSlot.clearTask(taskingNum);
            NpcListData.setStata(tsTaskId,0);
            PlayerTaskData.clearTask(tsTaskId);
            initTsSlot();
            initTsSlotVisible();
            whoSlot(tsSlot,taskingNum);
         }
         zxOrTs();
      }
      
      public function doOut(e:BtnEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function initPanel() : void
      {
         PlayerTaskData.addGoodsNum();
         PlayerTaskData.addGold();
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
      }
      
      public function jlVisible(arr:Array, arr1:Array) : void
      {
         var i:uint = 0;
         for(i = 0; i < jlNum; i++)
         {
            this["j_" + i].visible = false;
         }
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               this["j_" + i].visible = true;
               this["j_" + i].howNum.text = arr1[i];
               this["j_" + i].gotoAndStop(arr[i][0].getFrame());
            }
         }
      }
      
      public function textKong() : void
      {
         var i:uint = 0;
         for(i = 0; i < 4; i++)
         {
            this["n" + i].text = "";
         }
      }
      
      private function isTsTaskOk() : void
      {
         var i:uint = 0;
         for(i = 0; i < zxTaskNum; i++)
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
      
      private function doOver(e:BtnEvent) : void
      {
         var arr:Array = null;
         var id:Number = NaN;
         arr = [];
         if(nameId == "z")
         {
            arr = textData.addJl(zxSlot,taskingNum);
         }
         else if(nameId == "t")
         {
            arr = textData.addJl(tsSlot,taskingNum);
         }
         id = Number(String(e.target.name).substr(2,1));
         switch(id)
         {
            case 0:
               tooVisible(arr[0][0]);
               break;
            case 1:
               tooVisible(arr[1][0]);
               break;
            case 2:
               tooVisible(arr[2][0]);
         }
         tooltip.x = mouseX;
         tooltip.y = mouseY;
         tooltip.visible = true;
      }
   }
}

