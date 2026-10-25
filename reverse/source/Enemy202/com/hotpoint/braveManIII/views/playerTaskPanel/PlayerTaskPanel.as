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
         if(Main.gameNum.getValue() != 0)
         {
            PlayerTaskData.addTaskData();
         }
         PlayerTaskData.addGold();
         PlayerTaskData.addGoodsNum();
         PlayerTaskData.addLevel();
         this.updeXh();
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
      
      private function updeXh() : void
      {
         var _loc3_:Task = null;
         var _loc1_:Array = NpcListData.getTaskXh();
         if(_loc1_.length < 1)
         {
            return;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            trace(_loc3_.getName(),_loc3_.getStata(),"______________sdfds____");
            if(_loc3_.getStata() == 3)
            {
               trace(Main.serverTime.getValue(),_loc3_.getOverTimer(),"Main.serverTime.getValue()!=task.getOverTimer()");
               if(Main.serverTime.getValue() != _loc3_.getOverTimer())
               {
                  NpcListData.clearXhOldTask();
                  _loc3_.setStata(0);
                  trace("重置循环任务______________________");
               }
            }
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,this.doChange);
         this.addEventListener(BtnEvent.DO_CLICK,this.doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,this.doClose);
         this.addEventListener(BtnEvent.DO_OVER,this.doOver);
         this.addEventListener(BtnEvent.DO_OUT,this.doOut);
      }
      
      private function doOver(param1:BtnEvent) : void
      {
         var _loc2_:Array = [];
         if(this.nameId == "z")
         {
            _loc2_ = this.textData.getOneObj(this.zxSlot,this.taskingNum);
         }
         else if(this.nameId == "t")
         {
            _loc2_ = this.textData.getOneObj(this.tsSlot,this.taskingNum);
         }
         var _loc3_:Number = Number(String(param1.target.name).substr(2,1));
         switch(_loc3_)
         {
            case 0:
               this.tooVisible(_loc2_[0]);
               break;
            case 1:
               this.tooVisible(_loc2_[1]);
               break;
            case 2:
               this.tooVisible(_loc2_[2]);
         }
         this.tooltip.x = mouseX;
         this.tooltip.y = mouseY;
         this.tooltip.visible = true;
      }
      
      private function tooVisible(param1:Object) : void
      {
         if(param1 as Equip)
         {
            this.tooltip.equipTooltip(param1);
         }
         else if(param1 as Gem)
         {
            this.tooltip.gemTooltip(param1);
         }
         else if(param1 as Supplies)
         {
            this.tooltip.suppliesTooltip(param1);
         }
         else if(param1 as Otherobj)
         {
            this.tooltip.otherTooltip(param1);
         }
      }
      
      public function doOut(param1:BtnEvent) : void
      {
         this.tooltip.visible = false;
      }
      
      private function doChange(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.target);
         var _loc3_:Number = Number(_loc2_.name.substr(2,1));
         this.taskingNum = _loc3_;
         trace("选中:+" + this.taskingNum);
         this.nameId = _loc2_.name.substr(0,1);
         this.textVisible(this.nameId,this.taskingNum);
         this.renwuInit(this.nameId,_loc3_);
         this.finishBtn();
      }
      
      private function finishBtn() : void
      {
         var _loc1_:Task = null;
         g_mc.mouseEnabled = false;
         if(this.nameId == "z")
         {
            if(this.zxSlot.getTask(this.taskingNum) != null)
            {
               _loc1_ = this.zxSlot.getTask(this.taskingNum);
            }
         }
         else if(this.nameId == "t")
         {
            if(this.tsSlot.getTask(this.taskingNum) != null)
            {
               _loc1_ = this.tsSlot.getTask(this.taskingNum);
            }
         }
         if(_loc1_ != null)
         {
            this.fq_btn.visible = true;
            if(_loc1_.getStata() == 2)
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
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this["n" + _loc1_].text = "";
            _loc1_++;
         }
      }
      
      public function textVisible(param1:String, param2:Number) : void
      {
         if(param1 != null)
         {
            if(param1 == "z")
            {
               trace("显示支线");
               this.whoSlot(this.zxSlot,param2);
               this.getUrlTask(this.zxSlot,param2);
            }
            else if(param1 == "t")
            {
               trace("显示特殊");
               this.whoSlot(this.tsSlot,param2);
               this.getUrlTask(this.tsSlot,param2);
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
      
      public function getUrlTask(param1:Object, param2:Number = 0) : void
      {
         var _loc3_:Task = null;
         this.url_btn.visible = false;
         if(param1.getTask(param2))
         {
            _loc3_ = param1.getTask(param2);
            if(_loc3_.getUrl() != "-1")
            {
               this.url_btn.visible = true;
            }
         }
      }
      
      public function whoSlot(param1:Object, param2:Number) : void
      {
         if(param1.getTask(param2))
         {
            jieshao.text = this.textData.getIntroduction(param1,param2);
            need_1.text = this.textData.getDemand(param1,param2);
            goldText.text = this.textData.getGold(param1,param2);
            expText.text = this.textData.getExp(param1,param2);
            this.needTextVisible(param1,param2);
            this.jlVisible(this.textData.getOneObj(param1,param2),this.textData.getAwrdNum(param1,param2));
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
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            this["j_" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      public function needTextVisible(param1:Object, param2:Number) : void
      {
         var _loc3_:Array = this.textData.getAllId(param1,param2);
         var _loc4_:Array = this.textData.getAllNum(param1,param2);
         var _loc5_:Array = this.textData.getAllNuming(param1,param2);
         this.textKong();
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_.length)
         {
            this["n" + _loc6_].text = _loc3_[_loc6_] + ":" + "(" + _loc5_[_loc6_] + "/" + _loc4_[_loc6_] + ")";
            _loc6_++;
         }
      }
      
      public function jlVisible(param1:Array, param2:Array) : void
      {
         var _loc3_:uint = 0;
         while(_loc3_ < this.jlNum)
         {
            this["j_" + _loc3_].visible = false;
            _loc3_++;
         }
         if(param1.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               this["j_" + _loc3_].visible = true;
               this["j_" + _loc3_].howNum.text = param2[_loc3_];
               this["j_" + _loc3_].gotoAndStop(param1[_loc3_].getFrame());
               _loc3_++;
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
      
      private function doClose(param1:BtnEvent) : void
      {
         close();
      }
      
      private function doClick(param1:BtnEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Task = null;
         var _loc4_:Number = NaN;
         var _loc5_:Task = null;
         var _loc6_:Task = null;
         var _loc7_:URLRequest = null;
         if(param1.target.name == "fq_btn")
         {
            if(this.nameId == "z")
            {
               _loc2_ = Number(this.zxSlot.getTask(this.taskingNum).getId());
               _loc3_ = this.zxSlot.getTask(this.taskingNum);
               NpcTaskPanel.clearGoods(_loc3_);
               this.zxSlot.clearTask(this.taskingNum);
               NpcListData.setStata(_loc2_,0);
               PlayerTaskData.clearTask(_loc2_);
               this.initZxSlot();
               this.initZxSlotVisible();
               this.whoSlot(this.zxSlot,this.taskingNum);
               this.getUrlTask(this.zxSlot,this.taskingNum);
            }
            else if(this.nameId == "t")
            {
               _loc4_ = Number(this.tsSlot.getTask(this.taskingNum).getId());
               _loc5_ = this.tsSlot.getTask(this.taskingNum);
               NpcTaskPanel.clearGoods(_loc5_);
               this.tsSlot.clearTask(this.taskingNum);
               NpcListData.setStata(_loc4_,0);
               PlayerTaskData.clearTask(_loc4_);
               this.initTsSlot();
               this.initTsSlotVisible();
               this.whoSlot(this.tsSlot,this.taskingNum);
               this.getUrlTask(this.tsSlot,this.taskingNum);
            }
         }
         else if(param1.target.name == "finish_btn")
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
         else if(param1.target.name == "url_btn")
         {
            if(this.nameId == "z")
            {
               _loc6_ = this.zxSlot.getTask(this.taskingNum);
            }
            else if(this.nameId == "t")
            {
               _loc6_ = this.tsSlot.getTask(this.taskingNum);
            }
            _loc7_ = new URLRequest(_loc6_.getUrl());
            navigateToURL(_loc7_,"_blank");
         }
         if(param1.target.name != "url_btn")
         {
            this.finishBtn();
            this.zxOrTs();
            this.zxTaskStata();
            this.tsTaskStata();
         }
      }
      
      private function finishTask(param1:Object, param2:Number) : void
      {
         var _loc4_:Task = null;
         var _loc3_:Number = Number(param1.getTask(param2).getId());
         trace("任务状态:" + NpcListData.getStata(_loc3_));
         if(NpcListData.getStata(_loc3_) == 2)
         {
            if(this.textData.bagNum(param1,param2))
            {
               _loc4_ = param1.getTask(param2);
               this.textData.overAward(param1,param2);
               this.textData.overGoldAncExp(param1,param2);
               this.textData.overPlayerStata(param1,param2);
               NpcTaskPanel.clearGoods(_loc4_);
               NpcTaskPanel.clearGold(_loc4_);
               if(_loc4_.isAgin())
               {
                  if(_loc4_.isRc())
                  {
                     NpcListData.setStata(_loc3_,3);
                     _loc4_.setOverTimer(Main.serverTime.getValue());
                     AchData.setRcTask();
                  }
                  else
                  {
                     NpcListData.setStata(_loc3_,0);
                  }
               }
               else
               {
                  NpcListData.clearTask(_loc3_);
               }
               NpcListData.setOldTask(_loc4_);
               PlayerTaskData.clearTask(_loc3_);
               _loc4_.clearKong();
            }
            else
            {
               ShortTip.open(3);
            }
         }
      }
      
      private function initZxSlot() : void
      {
         var _loc3_:Task = null;
         this.zxSlot.allclearTask();
         var _loc1_:Array = PlayerTaskData.getTaskZx();
         var _loc2_:uint = 0;
         while(_loc2_ < this.zxTaskNum)
         {
            if(_loc1_[_loc2_] != null)
            {
               _loc3_ = _loc1_[_loc2_] as Task;
               this.zxSlot.addSlot(_loc3_);
            }
            _loc2_++;
         }
      }
      
      private function initTsSlot() : void
      {
         var _loc3_:Task = null;
         this.tsSlot.allclearTask();
         var _loc1_:Array = PlayerTaskData.getTaskTs();
         var _loc2_:uint = 0;
         while(_loc2_ < this.tsTaskNum)
         {
            if(_loc1_[_loc2_] != null)
            {
               _loc3_ = _loc1_[_loc2_] as Task;
               this.tsSlot.addSlot(_loc3_);
            }
            _loc2_++;
         }
      }
      
      private function initZxSlotVisible() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.zxTaskNum)
         {
            if(this.zxSlot.getTask(_loc1_) != null)
            {
               this["z_" + _loc1_].visible = true;
               this["z_" + _loc1_].tx.text = this.zxSlot.getTask(_loc1_).getName();
            }
            else
            {
               this["z_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      private function initTsSlotVisible() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.tsTaskNum)
         {
            if(this.tsSlot.getTask(_loc1_) != null)
            {
               this["t_" + _loc1_].visible = true;
               this["t_" + _loc1_].tx.text = this.tsSlot.getTask(_loc1_).getName();
            }
            else
            {
               this["t_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      private function renwuInit(param1:String, param2:Number = 0) : void
      {
         var _loc3_:uint = 0;
         if(param1 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < this.zxTaskNum)
            {
               this["z_" + _loc3_].isClick = false;
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.tsTaskNum)
            {
               this["t_" + _loc3_].isClick = false;
               _loc3_++;
            }
            if(param1 == "z")
            {
               this["z_" + param2].isClick = true;
            }
            else if(param1 == "t")
            {
               this["t_" + param2].isClick = true;
            }
         }
         this.taskingNum = param2;
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
         var _loc1_:uint = 0;
         while(_loc1_ < this.zxTaskNum)
         {
            if(this.zxSlot.getTask(_loc1_) != null)
            {
               if(this.zxSlot.getTask(_loc1_).istaskOk())
               {
                  this.zxSlot.getTask(_loc1_).setStata(2);
               }
            }
            _loc1_++;
         }
      }
      
      private function zxTaskStata() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.zxTaskNum)
         {
            if(this.zxSlot.getTask(_loc1_) != null)
            {
               if(this.zxSlot.getTask(_loc1_).getStata() == 1)
               {
                  this["z_" + _loc1_].ox.text = "(进行中)";
                  this["z_" + _loc1_].ox.setTextFormat(this.huang);
               }
               else if(this.zxSlot.getTask(_loc1_).getStata() == 2)
               {
                  this["z_" + _loc1_].ox.text = "(完成)";
                  this["z_" + _loc1_].ox.setTextFormat(this.lv);
               }
            }
            _loc1_++;
         }
      }
      
      private function isTsTaskOk() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.zxTaskNum)
         {
            if(this.tsSlot.getTask(_loc1_) != null)
            {
               if(this.tsSlot.getTask(_loc1_).istaskOk())
               {
                  this.tsSlot.getTask(_loc1_).setStata(2);
               }
            }
            _loc1_++;
         }
      }
      
      private function tsTaskStata() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.tsTaskNum)
         {
            if(this.tsSlot.getTask(_loc1_) != null)
            {
               if(this.tsSlot.getTask(_loc1_).getStata() == 1)
               {
                  this["t_" + _loc1_].ox.text = "(进行中)";
                  this["t_" + _loc1_].ox.setTextFormat(this.huang);
               }
               else if(this.tsSlot.getTask(_loc1_).getStata() == 2)
               {
                  this["t_" + _loc1_].ox.text = "(完成)";
                  this["t_" + _loc1_].ox.setTextFormat(this.lv);
               }
            }
            _loc1_++;
         }
      }
   }
}

