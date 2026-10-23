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
         var _loc1_:Task = null;
         xh_mc.visible = false;
         if(state == 3)
         {
            xh_mc.visible = true;
         }
         else if(state == 0)
         {
            if(taskSlot.getTask(targetId) != null)
            {
               _loc1_ = taskSlot.getTask(targetId);
               if(_loc1_.getSmallType() == 1)
               {
                  xh_mc.visible = true;
               }
            }
         }
      }
      
      private function sbtnNum() : void
      {
         var _loc1_:Array = TaskData.nowArr;
         var _loc2_:uint = 1;
         while(_loc2_ < 6)
         {
            this["b_" + _loc2_].sbtn.visible = false;
            this["new_" + _loc2_].visible = false;
            if(_loc1_[_loc2_] != 0)
            {
               this["b_" + _loc2_].sbtn.visible = true;
               this["new_" + _loc2_].visible = true;
               this["new_" + _loc2_].numText.text = String(_loc1_[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      private function btnDisplay() : void
      {
         var _loc1_:Task = null;
         if(state == 0)
         {
            jsBtn.visible = false;
            finishBtn.visible = true;
            if(taskSlot.getTask(targetId) != null)
            {
               _loc1_ = taskSlot.getTask(targetId);
               if(_loc1_.getState() == 1)
               {
                  finishBtn.gotoAndStop(1);
               }
               else if(_loc1_.getState() == 2)
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
      
      private function initData(param1:uint, param2:uint) : void
      {
         nowData = TaskData.getTypeByBtn(param1);
         addSlot(nowData,param2);
         taskDisplay();
         taskClose(param1);
         byeNum(this.yText,param2,nowData);
      }
      
      private function addSlot(param1:Array, param2:Number) : void
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         taskSlot.clearTask();
         if(param1 != null)
         {
            _loc3_ = param1[param2];
            if(_loc3_ != null && _loc3_.length != 0)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  taskSlot.addTask(_loc3_[_loc4_]);
                  _loc4_++;
               }
            }
         }
      }
      
      private function taskDisplay() : void
      {
         var _loc2_:Task = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 15)
         {
            this["n_" + _loc1_].visible = false;
            if(taskSlot.getTask(_loc1_) != null)
            {
               _loc2_ = taskSlot.getTask(_loc1_);
               this["n_" + _loc1_].visible = true;
               this["n_" + _loc1_].name_text.text = _loc2_.getName();
            }
            _loc1_++;
         }
      }
      
      private function taskClose(param1:uint) : void
      {
         var _loc2_:uint = 0;
         if(param1 == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < 15)
            {
               this["x_" + _loc2_].visible = false;
               if(taskSlot.getTask(_loc2_) != null)
               {
                  this["x_" + _loc2_].visible = true;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 15)
            {
               this["x_" + _loc2_].visible = false;
               _loc2_++;
            }
         }
      }
      
      private function jieShao(param1:Task) : void
      {
         jieshao.text = param1.getTaskIntroduction();
         xuqiu.text = param1.getDemand();
         wtrName.text = param1.getWtr();
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
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            this["t_" + _loc1_].text = "";
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this["a_" + _loc1_].text = "";
            this["j_" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      public function needTextVisible(param1:Number) : void
      {
         var _loc2_:Task = null;
         textKong();
         if(taskSlot.getTask(param1) != null)
         {
            _loc2_ = taskSlot.getTask(param1);
            needTexting(_loc2_);
            jieShao(_loc2_);
            textGoldExp(_loc2_);
            awNumText(_loc2_);
            awFrame(_loc2_);
         }
      }
      
      private function awFrame(param1:Task) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         if(textDisplay.awObj(param1).length != 0)
         {
            _loc2_ = textDisplay.awObj(param1);
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               this["j_" + _loc3_].visible = true;
               this["j_" + _loc3_].gotoAndStop(_loc2_[_loc3_].getFrame());
               _loc3_++;
            }
         }
      }
      
      private function textGoldExp(param1:Task) : void
      {
         if(param1.getAwardExp() != -1)
         {
            exp_mc.visible = true;
            exp.text = param1.getAwardExp();
         }
         if(param1.getAwardGold() != -1)
         {
            gold_mc.visible = true;
            gold.text = param1.getAwardGold();
         }
      }
      
      private function awNumText(param1:Task) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:Array = param1.getAwardNum();
         if(_loc2_[0].getValue() != -1)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_].getValue() != -1)
               {
                  this["a_" + _loc3_].text = String(_loc2_[_loc3_].getValue());
               }
               _loc3_++;
            }
         }
      }
      
      private function needTexting(param1:Task) : void
      {
         var _loc5_:uint = 0;
         var _loc2_:Array = textDisplay.getAllId(param1);
         var _loc3_:Array = textDisplay.getAllNum(param1);
         var _loc4_:Array = textDisplay.getAllNuming(param1);
         if(_loc2_.length != 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               this["t_" + _loc5_].text = _loc2_[_loc5_] + ":" + "(" + _loc4_[_loc5_] + "/" + _loc3_[_loc5_] + ")";
               _loc5_++;
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
      
      private function doOut(param1:BtnEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function doOver(param1:BtnEvent) : void
      {
         var _loc3_:Task = null;
         var _loc4_:Array = null;
         var _loc2_:Number = Number(String(param1.target.name).substr(2,1));
         if(taskSlot.getTask(targetId) != null)
         {
            _loc3_ = taskSlot.getTask(targetId);
            _loc4_ = textDisplay.awObj(_loc3_);
            if(_loc4_.length != 0)
            {
               switch(_loc2_)
               {
                  case 0:
                     tooVisible(_loc4_[0]);
                     break;
                  case 1:
                     tooVisible(_loc4_[1]);
                     break;
                  case 2:
                     tooVisible(_loc4_[2]);
               }
               tooltip.x = mouseX;
               tooltip.y = mouseY - 100;
               tooltip.visible = true;
            }
         }
      }
      
      private function tooVisible(param1:Object) : void
      {
         if(param1 as Equip)
         {
            tooltip.equipTooltip(param1);
         }
         else if(param1 as Gem)
         {
            tooltip.gemTooltip(param1);
         }
         else if(param1 as Supplies)
         {
            tooltip.suppliesTooltip(param1);
         }
         else if(param1 as Otherobj)
         {
            tooltip.otherTooltip(param1);
         }
      }
      
      private function doClose(param1:BtnEvent) : void
      {
         Play_Interface.TiShiShow(false);
         close();
      }
      
      private function doClick(param1:BtnEvent) : void
      {
         var _loc2_:String = String(param1.target.name).substr(0,1);
         var _loc3_:Number = Number(String(param1.target.name).substr(2,1));
         if(_loc2_ == "f")
         {
            taskAw();
         }
         else if(_loc2_ == "j")
         {
            taskJs();
         }
         else if(_loc2_ == "y")
         {
            yeFunction(_loc3_);
         }
         else if(_loc2_ == "x")
         {
            task_mast.visible = true;
         }
         if(param1.target.name == "qd_btn")
         {
            taskClick();
            task_mast.visible = false;
         }
         else if(param1.target.name == "qx_btn")
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
         var _loc1_:Array = null;
         if(nowData != null)
         {
            _loc1_ = nowData[smallState];
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
         var _loc1_:Task = null;
         if(taskSlot.getTask(targetId) != null)
         {
            _loc1_ = taskSlot.getTask(targetId);
            _loc1_.setState(1);
            TaskData.statePlayer();
            TaskData.clearOldTaskNum(_loc1_);
            if(Main.gameNum.getValue() != 0)
            {
               _loc1_.setMapId(Main.gameNum.getValue());
               _loc1_.setMapStar(GameData.gameLV);
            }
            _loc1_.isTaskOk();
            goToOne();
         }
      }
      
      private function taskFinsh(param1:Task) : void
      {
         if(param1.getSmallType() == 0)
         {
            param1.setState(0);
            param1.setOldTime(param1.getOldTime() + 1);
         }
         else if(param1.getSmallType() == 1)
         {
            param1.setState(0);
            param1.setOldTime(param1.getOldTime() + 1);
         }
         else if(param1.getSmallType() == 2)
         {
            param1.setState(3);
            param1.setOldTime(param1.getOldTime() + 1);
            param1.setOverTime(Main.serverTime.getValue());
            AchData.setRcTask();
         }
      }
      
      private function taskAw() : void
      {
         var _loc1_:Task = null;
         var _loc2_:Array = null;
         if(taskSlot.getTask(targetId) != null && taskSlot.getTask(targetId).getState() == 2)
         {
            _loc1_ = taskSlot.getTask(targetId);
            if(textDisplay.bagNum(_loc1_))
            {
               taskFinsh(_loc1_);
               _loc1_.clearData();
               TaskData.clearGoods(_loc1_);
               TaskData.clearGold(_loc1_);
               glNum0 = VT.createVT(100);
               glNum1 = VT.createVT(100);
               glNum2 = VT.createVT(100);
               glNum0.setValue(glNum0.getValue() * Math.random());
               glNum1.setValue(glNum1.getValue() * Math.random());
               glNum2.setValue(glNum2.getValue() * Math.random());
               _loc2_ = [glNum0,glNum1,glNum2];
               textDisplay.overAward(_loc1_,_loc2_);
               textDisplay.overGoldAncExp(_loc1_);
               textDisplay.overPlayerStata(_loc1_);
               TaskData.addGoodsNum();
               TaskData.addGoodsNumTow();
               TaskData.isOkTow();
               goToOne();
               TaskData.initNewText();
               sbtnNum();
               Main.Save();
            }
            else
            {
               ShortTip.open(3);
            }
         }
      }
      
      private function taskClick() : void
      {
         var _loc1_:Task = null;
         if(taskSlot.getTask(targetId) != null)
         {
            _loc1_ = taskSlot.getTask(targetId);
            _loc1_.setState(0);
            _loc1_.clearData();
            TaskData.clearGoods(_loc1_,1);
            goToOne();
            TaskData.initNewText();
            sbtnNum();
         }
      }
      
      private function yeFunction(param1:Number) : void
      {
         smallState = addOrJian(param1,smallState,nowData);
         goToOne();
      }
      
      private function addOrJian(param1:Number, param2:Number, param3:Array) : Number
      {
         var _loc4_:Number = param2;
         if(param3 != null)
         {
            if(param1 == 0)
            {
               if(_loc4_ > 0)
               {
                  _loc4_--;
               }
            }
            else if(param1 == 1)
            {
               if(_loc4_ < param3.length - 1)
               {
                  _loc4_++;
               }
            }
         }
         return _loc4_;
      }
      
      private function doChange(param1:BtnEvent) : void
      {
         var _loc2_:String = String(param1.target.name).substr(0,1);
         var _loc3_:Number = Number(String(param1.target.name).substr(2));
         if(_loc2_ == "b")
         {
            btnFunction(_loc3_);
         }
         else if(_loc2_ == "n")
         {
            tiaoFunction(_loc3_);
         }
      }
      
      private function btnFunction(param1:Number) : void
      {
         state = param1;
         smallState = 0;
         targetId = 0;
         initData(state,smallState);
         needTextVisible(targetId);
         btnDisplay();
         btnStata(0,15,"n_");
         btnStata(param1,6,"b_");
         TaskData.setOldArr(param1);
         TaskData.initNewText();
         sbtnNum();
         xhmcFun();
      }
      
      private function tiaoFunction(param1:Number) : void
      {
         targetId = param1;
         needTextVisible(targetId);
         btnDisplay();
         btnStata(param1,15,"n_");
         xhmcFun();
      }
      
      private function btnStata(param1:Number, param2:Number, param3:String) : void
      {
         this[param3 + param1].isClick = true;
         var _loc4_:uint = 0;
         while(_loc4_ < param2)
         {
            if(param1 != _loc4_)
            {
               this[param3 + _loc4_].isClick = false;
            }
            _loc4_++;
         }
      }
      
      private function byeNum(param1:TextField, param2:Number, param3:Array) : void
      {
         var _loc4_:* = undefined;
         if(param3 != null)
         {
            _loc4_ = param3.length;
            if(_loc4_ < 1)
            {
               _loc4_ = 1;
            }
            param1.text = param2 + 1 + "/" + _loc4_;
         }
         else
         {
            param1.text = param2 + 1 + "/" + 1;
         }
      }
   }
}

