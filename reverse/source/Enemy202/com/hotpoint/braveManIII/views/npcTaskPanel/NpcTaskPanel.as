package com.hotpoint.braveManIII.views.npcTaskPanel
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
      
      public static function open(param1:uint = 1) : void
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
         npcNum = param1;
         if(Main.gameNum.getValue() != 0)
         {
            PlayerTaskData.addTaskData();
         }
         PlayerTaskData.addGoodsNum();
         PlayerTaskData.addGold();
         PlayerTaskData.addLevel();
         NpcTaskPanel._instance.initNpcList(param1);
         NpcTaskPanel._instance.initNpcTask(param1);
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
         NpcTaskPanel._instance.mcGoTo(param1);
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
      
      public static function clearGold(param1:Task) : void
      {
         if(param1.getFinishGold() != -1)
         {
            Main.player1.payGold(param1.getFinishGold());
            if(Main.P1P2)
            {
               Main.player2.payGold(param1.getFinishGold());
            }
         }
      }
      
      public static function clearGoods(param1:Task) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         if(param1.getGoodsId() != null)
         {
            _loc2_ = param1.getGoodsId();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               clearP1orP2(_loc2_[_loc3_],param1.getId());
               _loc3_++;
            }
         }
      }
      
      public static function clearP1orP2(param1:Number, param2:Number) : void
      {
         if(param2 != 210002)
         {
            Main.player1.getBag().clearQuest(param1);
            if(Main.P1P2)
            {
               Main.player2.getBag().clearQuest(param1);
            }
         }
         else
         {
            Main.player1.getBag().clearOther(param1);
            if(Main.P1P2)
            {
               Main.player2.getBag().clearOther(param1);
            }
         }
      }
      
      public function initNpcList(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            NpcListData.setTaskZx(NpcTaskData.updateOne());
         }
         else if(param1 == 2)
         {
            NpcListData.setTaskZz(NpcTaskData.updateTow());
         }
         else if(param1 == 3)
         {
            NpcListData.setTaskTs(NpcTaskData.updateThree());
         }
         else if(param1 == 4)
         {
            NpcListData.setTaskXh(NpcTaskData.updateFour());
         }
         else if(param1 == 5)
         {
            NpcListData.setTaskCw(NpcTaskData.updateCw());
         }
         this.updeXh();
      }
      
      private function mcGoTo(param1:Number) : void
      {
         if(param1 == 1)
         {
            this.name_mc.gotoAndStop(1);
         }
         else if(param1 == 2)
         {
            this.name_mc.gotoAndStop(2);
         }
         else if(param1 == 3)
         {
            this.name_mc.gotoAndStop(4);
         }
         else if(param1 == 4)
         {
            this.name_mc.gotoAndStop(3);
         }
         else if(param1 == 5)
         {
            this.name_mc.gotoAndStop(1);
         }
      }
      
      public function initNpcTask(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            this.taskList = NpcTaskData.levelOk(NpcListData.getTaskZx());
         }
         else if(param1 == 2)
         {
            this.taskList = NpcTaskData.levelOk(NpcListData.getTaskZz());
         }
         else if(param1 == 3)
         {
            this.taskList = NpcTaskData.levelOk(NpcListData.getTaskTs());
         }
         else if(param1 == 4)
         {
            this.taskList = NpcTaskData.levelOk(NpcListData.getTaskXh());
         }
         else if(param1 == 5)
         {
            this.taskList = NpcTaskData.levelOk(NpcListData.getTaskCw());
         }
      }
      
      public function initSlot() : void
      {
         var _loc2_:Task = null;
         this.slot = NpcTaskSlot.creatSlot();
         var _loc1_:uint = 0;
         while(_loc1_ < this.taskList.length)
         {
            _loc2_ = this.taskList[_loc1_];
            if(_loc2_.getStata() != 3)
            {
               this.slot.addSlot(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function isTaskOk() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.taskNum)
         {
            if(this.slot.getTask(_loc1_) != null)
            {
               if(this.slot.getTask(_loc1_).istaskOk())
               {
                  this.slot.getTask(_loc1_).setStata(2);
               }
            }
            _loc1_++;
         }
      }
      
      private function isTaskOkTow() : void
      {
         var _loc2_:Task = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.taskNum)
         {
            if(this.slot.getTask(_loc1_) != null)
            {
               _loc2_ = this.slot.getTask(_loc1_);
               if(_loc2_.getStata() == 3)
               {
                  if(Main.serverTime.getValue() != _loc2_.getOverTimer())
                  {
                     _loc2_.setStata(0);
                  }
               }
            }
            _loc1_++;
         }
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
      
      public function initStataRenwu() : void
      {
         this.isTaskOk();
         var _loc1_:uint = 0;
         while(_loc1_ < this.taskNum)
         {
            if(this.slot.getTask(_loc1_))
            {
               if(this.slot.getTask(_loc1_).getStata() == 0)
               {
                  this["t_" + _loc1_].ox.text = "(未接取)";
                  this["t_" + _loc1_].ox.setTextFormat(this.hong);
               }
               else if(this.slot.getTask(_loc1_).getStata() == 1)
               {
                  this["t_" + _loc1_].ox.text = "(进行中)";
                  this["t_" + _loc1_].ox.setTextFormat(this.huang);
               }
               else if(this.slot.getTask(_loc1_).getStata() == 2)
               {
                  this["t_" + _loc1_].ox.text = "(已完成)";
                  this["t_" + _loc1_].ox.setTextFormat(this.lv);
               }
               else if(this.slot.getTask(_loc1_).getStata() == 3)
               {
                  this["t_" + _loc1_].ox.text = "(冷却中)";
                  this["t_" + _loc1_].ox.setTextFormat(this.hui);
               }
            }
            _loc1_++;
         }
      }
      
      public function initSlotVisble() : void
      {
         var _loc1_:Array = this.slot.getSlotArr();
         trace(_loc1_);
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_] != -1)
            {
               this["t_" + _loc2_].visible = true;
               this["t_" + _loc2_].tx.text = (_loc1_[_loc2_] as Task).getName();
            }
            else
            {
               this["t_" + _loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      public function initText(param1:Number = 0) : void
      {
         if(this.slot.getTask(param1))
         {
            jieshao.text = this.textData.getIntroduction(this.slot,param1);
            need_1.text = this.textData.getDemand(this.slot,param1);
            goldText.text = this.textData.getGold(this.slot,param1);
            expText.text = this.textData.getExp(this.slot,param1);
            this.needTextVisible(this.slot,param1);
            this.jlVisible(this.textData.getOneObj(this.slot,param1),this.textData.getAwrdNum(this.slot,param1));
         }
         else
         {
            this.jieshaoText();
            this.textKong();
            this.ycJl();
         }
      }
      
      public function getUrlTask(param1:Number = 0) : void
      {
         var _loc2_:Task = null;
         this.url_btn.visible = false;
         if(this.slot.getTask(param1))
         {
            _loc2_ = this.slot.getTask(param1);
            if(_loc2_.getUrl() != "-1")
            {
               this.url_btn.visible = true;
            }
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
      
      public function ycJl() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            this["j_" + _loc1_].visible = false;
            _loc1_++;
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
      
      public function jieshaoText() : void
      {
         jieshao.text = "";
         need_1.text = "";
         goldText.text = "";
         expText.text = "";
      }
      
      public function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,this.doChange);
         this.addEventListener(BtnEvent.DO_CLICK,this.doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,this.doClose);
         this.addEventListener(BtnEvent.DO_OVER,this.doOver);
         this.addEventListener(BtnEvent.DO_OUT,this.doOut);
      }
      
      private function doOver(param1:BtnEvent) : void
      {
         trace(param1.target.name + "e.target.name");
         var _loc2_:Array = this.textData.getOneObj(this.slot,this.taskingNum);
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
      
      public function doClose(param1:BtnEvent) : void
      {
         close();
      }
      
      public function btnStata() : void
      {
         var _loc1_:Task = this.getTaskStata0();
         if(_loc1_ != null)
         {
            this.npcBtn.visible = true;
            if(_loc1_.getStata() == 0)
            {
               this.npcBtn.gotoAndStop(1);
               this.npcBtn.visible = true;
               this.finish_btn.visible = false;
               g_mc.visible = false;
            }
            else if(_loc1_.getStata() == 1)
            {
               this.finish_btn.visible = false;
               g_mc.visible = false;
               this.npcBtn.gotoAndStop(2);
            }
            else if(_loc1_.getStata() == 2)
            {
               this.finish_btn.visible = true;
               g_mc.visible = true;
               g_mc.mouseEnabled = false;
               this.npcBtn.gotoAndStop(2);
            }
            else if(_loc1_.getStata() == 3)
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
      
      private function doChange(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.target);
         var _loc3_:Number = Number(_loc2_.name.substr(2,1));
         this.initText(_loc3_);
         this.renwuInit(_loc3_);
         this.getUrlTask(_loc3_);
         this.btnStata();
      }
      
      private function renwuInit(param1:Number = 0) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.taskNum)
         {
            this["t_" + _loc2_].isClick = false;
            _loc2_++;
         }
         this["t_" + param1].isClick = true;
         this.taskingNum = param1;
      }
      
      private function getTaskStata0() : Task
      {
         if(this.slot.getTask(this.taskingNum) != null)
         {
            return this.slot.getTask(this.taskingNum);
         }
         return null;
      }
      
      private function doClick(param1:BtnEvent) : void
      {
         var _loc2_:Task = null;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:URLRequest = null;
         trace(param1.id);
         if(this.getTaskStata0() != null)
         {
            _loc2_ = this.getTaskStata0();
            _loc3_ = _loc2_.getId();
            if(param1.id == 1)
            {
               if(NpcListData.getStata(_loc3_) == 0)
               {
                  if(_loc2_.getBranch() == 1)
                  {
                     if(NpcListData.zxNoGo())
                     {
                        NpcListData.setStata(_loc3_,1);
                     }
                     else
                     {
                        ShortTip.open(1);
                        trace("支线已接任务栏已满");
                     }
                  }
                  else if(NpcListData.tsNoGo())
                  {
                     NpcListData.setStata(_loc3_,1);
                  }
                  else
                  {
                     ShortTip.open(1);
                     trace("特殊已接任务栏已满");
                  }
               }
            }
            else if(param1.id == 2)
            {
               trace("放弃");
               if(NpcListData.getStata(_loc3_) == 1 || NpcListData.getStata(_loc3_) == 2)
               {
                  _loc2_.clearKong();
                  clearGoods(_loc2_);
                  NpcListData.setStata(_loc3_,0);
                  PlayerTaskData.clearTask(_loc3_);
                  this.initText();
                  this.renwuInit();
                  this.taskingNum = 0;
               }
            }
            else if(param1.id == 3)
            {
               if(NpcListData.getStata(_loc3_) == 2)
               {
                  if(this.textData.bagNum(this.slot,this.taskingNum))
                  {
                     this.textData.overAward(this.slot,this.taskingNum);
                     this.textData.overGoldAncExp(this.slot,this.taskingNum);
                     this.textData.overPlayerStata(this.slot,this.taskingNum);
                     clearGoods(_loc2_);
                     clearGold(_loc2_);
                     if(_loc2_.isAgin())
                     {
                        if(_loc2_.isRc())
                        {
                           NpcListData.setStata(_loc3_,3);
                           _loc2_.setOverTimer(Main.serverTime.getValue());
                           NpcListData.setOldTask(_loc2_);
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
                        NpcListData.setOldTask(_loc2_);
                     }
                     PlayerTaskData.clearTask(_loc3_);
                     this.initNpcList(npcNum);
                     this.initNpcTask(npcNum);
                     this.initSlot();
                     this.initSlotVisble();
                     this.initText();
                     this.renwuInit();
                     this.getUrlTask();
                     this.taskingNum = 0;
                  }
                  else
                  {
                     ShortTip.open(3);
                  }
               }
            }
            else if(param1.id == 6)
            {
               _loc4_ = _loc2_.getUrl();
               _loc5_ = new URLRequest(_loc4_);
               navigateToURL(_loc5_,"_blank");
            }
            if(param1.id != 6)
            {
               _loc2_.clearKong();
               this.initStataRenwu();
               this.btnStata();
            }
         }
         else
         {
            trace("没有选择的任务");
         }
      }
   }
}

