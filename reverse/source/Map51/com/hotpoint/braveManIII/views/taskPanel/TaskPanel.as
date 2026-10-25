package com.hotpoint.braveManIII.views.taskPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.Task;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import src.*;
   
   public class TaskPanel extends MovieClip
   {
      
      private static var _instance:TaskPanel;
      
      private var state:uint = 0;
      
      private var smallState:uint = 0;
      
      private var targetId:uint = 0;
      
      private var taskSlot:TaskSlot;
      
      private var textDisplay:TaskDisplay;
      
      private var nowData:Array = [];
      
      private var glNum0:VT;
      
      private var glNum1:VT;
      
      private var glNum2:VT;
      
      private var tooltip:ItemsTooltip;
      
      public function TaskPanel()
      {
         super();
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         if(TaskPanel._instance == null)
         {
            TaskPanel._instance = new TaskPanel();
            TaskPanel._instance.taskSlot = TaskSlot.creatSlot();
            TaskPanel._instance.textDisplay = new TaskDisplay();
            TaskPanel._instance.tooltip = new ItemsTooltip();
         }
         Main._stage.addChild(TaskPanel._instance);
         TaskPanel._instance.initPanel();
         TaskPanel._instance.addEvent();
         TaskPanel._instance.visible = true;
         TaskPanel._instance.y = 0;
         TaskPanel._instance.x = 0;
         TaskPanel._instance.tooltip.visible = false;
         TaskPanel._instance.addChild(TaskPanel._instance.tooltip);
      }
      
      public static function close() : void
      {
         if(TaskPanel._instance != null)
         {
            if(TaskPanel._instance.visible == true)
            {
               TaskPanel._instance.visible = false;
            }
         }
      }
      
      private function initPanel() : void
      {
         Play_Interface.TiShiShow(false);
         TaskData.updateEd();
         TaskData.addGoodsNum();
         TaskData.isOk();
         TaskData.addGoodsNumTow();
         TaskData.isOkTow();
         state = 0;
         smallState = 0;
         targetId = 0;
         initData(state,smallState);
         needTextVisible(targetId);
         btnDisplay();
         btnStata(0,6,"b_");
         btnStata(0,15,"n_");
         TaskData.setOldArr(0);
         TaskData.initNewText();
         sbtnNum();
         task_mast.visible = false;
         xhmcFun();
      }
      
      private function xhmcFun() : void
      {
         var task:Task = null;
         xh_mc.visible = false;
         if(state == 3)
         {
            xh_mc.visible = true;
         }
         else if(state == 0)
         {
            if(taskSlot.getTask(targetId) != null)
            {
               task = taskSlot.getTask(targetId);
               if(task.getSmallType() == 1)
               {
                  xh_mc.visible = true;
               }
            }
         }
      }
      
      private function sbtnNum() : void
      {
         var arr:Array = TaskData.nowArr;
         for(var i:uint = 1; i < 6; i++)
         {
            this["b_" + i].sbtn.visible = false;
            this["new_" + i].visible = false;
            if(arr[i] != 0)
            {
               this["b_" + i].sbtn.visible = true;
               this["new_" + i].visible = true;
               this["new_" + i].numText.text = String(arr[i]);
            }
         }
      }
      
      private function btnDisplay() : void
      {
         var task:Task = null;
         if(state == 0)
         {
            jsBtn.visible = false;
            finishBtn.visible = true;
            if(taskSlot.getTask(targetId) != null)
            {
               task = taskSlot.getTask(targetId);
               if(task.getState() == 1)
               {
                  finishBtn.gotoAndStop(1);
               }
               else if(task.getState() == 2)
               {
                  finishBtn.gotoAndStop(2);
               }
            }
         }
         else
         {
            jsBtn.visible = false;
            finishBtn.visible = false;
            if(taskSlot.getTask(targetId) != null)
            {
               jsBtn.visible = true;
            }
         }
      }
      
      private function initData(type:uint, sType:uint) : void
      {
         nowData = TaskData.getTypeByBtn(type);
         addSlot(nowData,sType);
         taskDisplay();
         taskClose(type);
         byeNum(this.yText,sType,nowData);
      }
      
      private function addSlot(arr:Array, num:Number) : void
      {
         var sArr:Array = null;
         var i:uint = 0;
         taskSlot.clearTask();
         if(arr != null)
         {
            sArr = arr[num];
            if(sArr != null && sArr.length != 0)
            {
               for(i = 0; i < sArr.length; i++)
               {
                  taskSlot.addTask(sArr[i]);
               }
            }
         }
      }
      
      private function taskDisplay() : void
      {
         var task:Task = null;
         for(var i:uint = 0; i < 15; i++)
         {
            this["n_" + i].visible = false;
            if(taskSlot.getTask(i) != null)
            {
               task = taskSlot.getTask(i);
               this["n_" + i].visible = true;
               this["n_" + i].name_text.text = task.getName();
            }
         }
      }
      
      private function taskClose(type:uint) : void
      {
         var i:uint = 0;
         if(type == 0)
         {
            for(i = 0; i < 15; i++)
            {
               this["x_" + i].visible = false;
               if(taskSlot.getTask(i) != null)
               {
                  this["x_" + i].visible = true;
               }
            }
         }
         else
         {
            for(i = 0; i < 15; i++)
            {
               this["x_" + i].visible = false;
            }
         }
      }
      
      private function jieShao(task:Task) : void
      {
         jieshao.text = task.getTaskIntroduction();
         xuqiu.text = task.getDemand();
         wtrName.text = task.getWtr();
      }
      
      public function textKong() : void
      {
         jieshao.text = "";
         xuqiu.text = "";
         exp.text = "";
         gold.text = "";
         wtrName.text = "";
         gold_mc.visible = false;
         exp_mc.visible = false;
         for(var i:uint = 0; i < 6; i++)
         {
            this["t_" + i].text = "";
         }
         for(i = 0; i < 3; i++)
         {
            this["a_" + i].text = "";
            this["j_" + i].visible = false;
         }
      }
      
      public function needTextVisible(num:Number) : void
      {
         var task:Task = null;
         textKong();
         if(taskSlot.getTask(num) != null)
         {
            task = taskSlot.getTask(num);
            needTexting(task);
            jieShao(task);
            textGoldExp(task);
            awNumText(task);
            awFrame(task);
         }
      }
      
      private function awFrame(task:Task) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(textDisplay.awObj(task).length != 0)
         {
            arr = textDisplay.awObj(task);
            for(i = 0; i < arr.length; i++)
            {
               this["j_" + i].visible = true;
               this["j_" + i].gotoAndStop(arr[i].getFrame());
            }
         }
      }
      
      private function textGoldExp(task:Task) : void
      {
         if(task.getAwardExp() != -1)
         {
            exp_mc.visible = true;
            exp.text = task.getAwardExp();
         }
         if(task.getAwardGold() != -1)
         {
            gold_mc.visible = true;
            gold.text = task.getAwardGold();
         }
      }
      
      private function awNumText(task:Task) : void
      {
         var i:uint = 0;
         var arr:Array = task.getAwardNum();
         if(arr[0].getValue() != -1)
         {
            for(i = 0; i < arr.length; i++)
            {
               if(arr[i].getValue() != -1)
               {
                  this["a_" + i].text = String(arr[i].getValue());
               }
            }
         }
      }
      
      private function needTexting(task:Task) : void
      {
         var i:uint = 0;
         var arr1:Array = textDisplay.getAllId(task);
         var arr2:Array = textDisplay.getAllNum(task);
         var arr3:Array = textDisplay.getAllNuming(task);
         if(arr1.length != 0)
         {
            for(i = 0; i < arr1.length; i++)
            {
               this["t_" + i].text = arr1[i] + ":" + "(" + arr3[i] + "/" + arr2[i] + ")";
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
      
      private function doOut(e:BtnEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function doOver(e:BtnEvent) : void
      {
         var task:Task = null;
         var arr:Array = null;
         var id:Number = Number(String(e.target.name).substr(2,1));
         if(taskSlot.getTask(targetId) != null)
         {
            task = taskSlot.getTask(targetId);
            arr = textDisplay.awObj(task);
            if(arr.length != 0)
            {
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
               tooltip.y = mouseY - 100;
               tooltip.visible = true;
            }
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
      
      private function doClose(e:BtnEvent) : void
      {
         Play_Interface.TiShiShow(false);
         close();
      }
      
      private function doClick(e:BtnEvent) : void
      {
         var nameId:String = String(e.target.name).substr(0,1);
         var id:Number = Number(String(e.target.name).substr(2,1));
         if(nameId == "f")
         {
            taskAw();
         }
         else if(nameId == "j")
         {
            taskJs();
         }
         else if(nameId == "y")
         {
            yeFunction(id);
         }
         else if(nameId == "x")
         {
            task_mast.visible = true;
         }
         if(e.target.name == "qd_btn")
         {
            taskClick();
            task_mast.visible = false;
         }
         else if(e.target.name == "qx_btn")
         {
            task_mast.visible = false;
         }
      }
      
      private function goToOne() : void
      {
         targetId = 0;
         smallStateNum();
         initData(state,smallState);
         needTextVisible(targetId);
         btnDisplay();
         btnStata(0,15,"n_");
      }
      
      private function smallStateNum() : void
      {
         var arr:Array = null;
         if(nowData != null)
         {
            arr = nowData[smallState];
            if(smallState > 0)
            {
               if(nowData[smallState].length == 1)
               {
                  --smallState;
               }
            }
         }
      }
      
      private function taskJs() : void
      {
         var task:Task = null;
         if(taskSlot.getTask(targetId) != null)
         {
            task = taskSlot.getTask(targetId);
            task.setState(1);
            TaskData.statePlayer();
            TaskData.clearOldTaskNum(task);
            if(Main.gameNum.getValue() != 0)
            {
               task.setMapId(Main.gameNum.getValue());
               task.setMapStar(GameData.gameLV);
            }
            task.isTaskOk();
            goToOne();
         }
      }
      
      private function taskFinsh(task:Task) : void
      {
         if(task.getSmallType() == 0)
         {
            task.setState(0);
            task.setOldTime(task.getOldTime() + 1);
         }
         else if(task.getSmallType() == 1)
         {
            task.setState(0);
            task.setOldTime(task.getOldTime() + 1);
         }
         else if(task.getSmallType() == 2)
         {
            task.setState(3);
            task.setOldTime(task.getOldTime() + 1);
            task.setOverTime(Main.serverTime.getValue());
            AchData.setRcTask();
         }
      }
      
      private function taskAw() : void
      {
         var task:Task = null;
         var arr:Array = null;
         if(taskSlot.getTask(targetId) != null && taskSlot.getTask(targetId).getState() == 2)
         {
            task = taskSlot.getTask(targetId);
            if(textDisplay.bagNum(task))
            {
               taskFinsh(task);
               task.clearData();
               TaskData.clearGoods(task);
               TaskData.clearGold(task);
               glNum0 = VT.createVT(100);
               glNum1 = VT.createVT(100);
               glNum2 = VT.createVT(100);
               glNum0.setValue(glNum0.getValue() * Math.random());
               glNum1.setValue(glNum1.getValue() * Math.random());
               glNum2.setValue(glNum2.getValue() * Math.random());
               arr = [glNum0,glNum1,glNum2];
               textDisplay.overAward(task,arr);
               textDisplay.overGoldAncExp(task);
               textDisplay.overPlayerStata(task);
               TaskData.addGoodsNum();
               TaskData.addGoodsNumTow();
               TaskData.isOkTow();
               goToOne();
               TaskData.initNewText();
               sbtnNum();
               Main.Save();
               Play_Interface.TiShiShow(false,task.getId());
            }
            else
            {
               ShortTip.open(3);
            }
         }
      }
      
      private function taskClick() : void
      {
         var task:Task = null;
         if(taskSlot.getTask(targetId) != null)
         {
            task = taskSlot.getTask(targetId);
            task.setState(0);
            task.clearData();
            TaskData.clearGoods(task,1);
            goToOne();
            TaskData.initNewText();
            sbtnNum();
         }
      }
      
      private function yeFunction(id:Number) : void
      {
         smallState = addOrJian(id,smallState,nowData);
         goToOne();
      }
      
      private function addOrJian(btnId:Number, ye:Number, allNum:Array) : Number
      {
         var num:Number = ye;
         if(allNum != null)
         {
            if(btnId == 0)
            {
               if(num > 0)
               {
                  num--;
               }
            }
            else if(btnId == 1)
            {
               if(num < allNum.length - 1)
               {
                  num++;
               }
            }
         }
         return num;
      }
      
      private function doChange(e:BtnEvent) : void
      {
         var nameId:String = String(e.target.name).substr(0,1);
         var id:Number = Number(String(e.target.name).substr(2));
         if(nameId == "b")
         {
            btnFunction(id);
         }
         else if(nameId == "n")
         {
            tiaoFunction(id);
         }
      }
      
      private function btnFunction(id:Number) : void
      {
         state = id;
         smallState = 0;
         targetId = 0;
         initData(state,smallState);
         needTextVisible(targetId);
         btnDisplay();
         btnStata(0,15,"n_");
         btnStata(id,6,"b_");
         TaskData.setOldArr(id);
         TaskData.initNewText();
         sbtnNum();
         xhmcFun();
      }
      
      private function tiaoFunction(id:Number) : void
      {
         targetId = id;
         needTextVisible(targetId);
         btnDisplay();
         btnStata(id,15,"n_");
         xhmcFun();
      }
      
      private function btnStata(id:Number, num:Number, str:String) : void
      {
         this[str + id].isClick = true;
         for(var i:uint = 0; i < num; i++)
         {
            if(id != i)
            {
               this[str + i].isClick = false;
            }
         }
      }
      
      private function byeNum(t:TextField, nowNum:Number, arr:Array) : void
      {
         var allNum:* = undefined;
         if(arr != null)
         {
            allNum = arr.length;
            if(allNum < 1)
            {
               allNum = 1;
            }
            t.text = nowNum + 1 + "/" + allNum;
         }
         else
         {
            t.text = nowNum + 1 + "/" + 1;
         }
      }
   }
}

