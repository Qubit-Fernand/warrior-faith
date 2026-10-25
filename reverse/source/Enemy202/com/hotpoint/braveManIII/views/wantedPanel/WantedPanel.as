package com.hotpoint.braveManIII.views.wantedPanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class WantedPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var xsrw:WantedPanel;
      
      public static var CZXSOK:Boolean = false;
      
      public static var xsrwPanel:MovieClip = new XSRWShow();
      
      public static var clickNum:Number = 0;
      
      public static var czNum:Number = 0;
      
      public function WantedPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(xsrwPanel);
      }
      
      public static function open() : void
      {
         if(Main.wts.getAccess() > -1)
         {
            clickNum = Main.wts.getAccess();
         }
         Main.allClosePanel();
         if(xsrw == null)
         {
            if(!Main.wts)
            {
               Main.wts = WantedTaskSlot.creatWantedTaskSlot();
            }
            xsrw = new WantedPanel();
         }
         Main.stopXX = true;
         xsrw.x = 0;
         xsrw.y = 0;
         addListener();
         Main._stage.addChild(xsrw);
         xsrw.visible = true;
      }
      
      public static function close() : void
      {
         if(xsrw == null)
         {
            if(!Main.wts)
            {
               Main.wts = WantedTaskSlot.creatWantedTaskSlot();
            }
            xsrw = new WantedPanel();
         }
         Main.stopXX = false;
         removeListener();
         xsrw.visible = false;
      }
      
      public static function addListener() : *
      {
         xsrwPanel["NoMoney_mc"].visible = false;
         xsrwPanel["xsRMB"].visible = false;
         xsrwPanel["xsRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yes_btn);
         xsrwPanel["xsRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,no_btn);
         xsrwPanel["NoMoney_mc"]["yes_btn"].addEventListener(MouseEvent.CLICK,closeNORMB);
         xsrwPanel["NoMoney_mc"]["addMoney_btn"].addEventListener(MouseEvent.CLICK,addMoney_btn);
         xsrwPanel["close"].addEventListener(MouseEvent.CLICK,closeXS);
         xsrwPanel["rwOK"].addEventListener(MouseEvent.CLICK,rwOK);
         xsrwPanel["rwFQ"].addEventListener(MouseEvent.CLICK,rwFQ);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            xsrwPanel["lq" + _loc1_]["lq_btn"].addEventListener(MouseEvent.CLICK,lqReset);
            xsrwPanel["jq" + _loc1_].addEventListener(MouseEvent.CLICK,jiequ);
            xsrwPanel["tq" + _loc1_].addEventListener(MouseEvent.CLICK,choseOne);
            xsrwPanel["tq" + _loc1_].mouseChildren = false;
            xsrwPanel["tq" + _loc1_].mouseEnabled = true;
            _loc1_++;
         }
         panelShow();
      }
      
      private static function closeNORMB(param1:*) : void
      {
         petPanel["NoMoney_mc"].visible = false;
      }
      
      private static function addMoney_btn(param1:*) : void
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      public static function yes_btn(param1:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 20)
         {
            Api_4399_All.Money_down(InitData.chongzhirenwu.getValue());
            CZXSOK = true;
            xsrwPanel["xsRMB"].visible = false;
         }
         else
         {
            xsrwPanel["NoMoney_mc"].visible = true;
         }
      }
      
      public static function no_btn(param1:*) : *
      {
         xsrwPanel["xsRMB"].visible = false;
      }
      
      public static function lqczOK() : *
      {
         if(CZXSOK)
         {
            Main.wts.delCD(czNum);
            Main.Save();
            CZXSOK = false;
         }
      }
      
      public static function lqReset(param1:*) : *
      {
         xsrwPanel["xsRMB"].visible = true;
         czNum = param1.target.parent.name.substr(2,1);
      }
      
      public static function removeListener() : *
      {
         xsrwPanel["close"].removeEventListener(MouseEvent.CLICK,closeXS);
      }
      
      public static function rwOK(param1:*) : *
      {
         if(Main.P1P2)
         {
            if(Main.player1.getBag().backSuppliesBagNum() > 1 && Main.player2.getBag().backSuppliesBagNum() > 1)
            {
               Main.player1.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_1()));
               Main.player1.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_2()));
               Main.player2.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_1()));
               Main.player2.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_2()));
               Main.wts.getWantedTaskFromSlot(clickNum).setState(3);
            }
            else
            {
               ShortTip.open(3);
            }
         }
         else if(Main.player1.getBag().backSuppliesBagNum() > 1)
         {
            Main.player1.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_1()));
            Main.player1.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_2()));
            Main.wts.getWantedTaskFromSlot(clickNum).setState(3);
         }
         else
         {
            ShortTip.open(3);
         }
         panelShow();
      }
      
      public static function rwFQ(param1:*) : *
      {
         Main.wts.getWantedTaskFromSlot(clickNum).setState(0);
         panelShow();
      }
      
      public static function closeXS(param1:*) : *
      {
         close();
      }
      
      public static function choseOne(param1:*) : *
      {
         clickNum = uint((param1.target as MovieClip).name.substr(2,1));
         panelShow();
      }
      
      public static function jiequ(param1:*) : *
      {
         var _loc2_:uint = uint(param1.target.name.substr(2,1));
         if(Main.P1P2)
         {
            if(Main.player1.getGold() > 80000 && Main.player2.getGold() > 80000)
            {
               if(Main.player1.getKillPoint() > 80 && Main.player2.getKillPoint() > 80)
               {
                  Main.player2.AddKillPoint(-80);
                  Main.player1.payGold(80000);
                  Main.player1.AddKillPoint(-80);
                  Main.player2.payGold(80000);
                  Main.wts.setWantedTaskSlot(_loc2_);
               }
               else
               {
                  ShortTip.open(32);
               }
            }
            else
            {
               ShortTip.open(16);
            }
         }
         else if(Main.player1.getGold() > 80000)
         {
            if(Main.player1.getKillPoint() > 80)
            {
               Main.player1.payGold(80000);
               Main.player1.AddKillPoint(-80);
               Main.wts.setWantedTaskSlot(_loc2_);
            }
            else
            {
               ShortTip.open(32);
            }
         }
         else
         {
            ShortTip.open(16);
         }
         panelShow();
      }
      
      private static function panelShow() : *
      {
         var _loc1_:int = 0;
         if(Main.wts.getWantedTaskFromSlot(clickNum).getState() == 2)
         {
            xsrwPanel["rwOK"].visible = true;
         }
         else
         {
            xsrwPanel["rwOK"].visible = false;
         }
         if(Main.wts.getWantedTaskFromSlot(clickNum).getState() == 1)
         {
            xsrwPanel["rwFQ"].visible = true;
         }
         else
         {
            xsrwPanel["rwFQ"].visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            xsrwPanel["lq" + _loc1_].stop();
            xsrwPanel["lq" + _loc1_].visible = false;
            xsrwPanel["xz" + _loc1_].visible = false;
            xsrwPanel["yjq" + _loc1_].visible = false;
            xsrwPanel["bjq" + _loc1_].visible = true;
            xsrwPanel["jq" + _loc1_].visible = true;
            xsrwPanel["tq" + _loc1_].gotoAndStop(Main.wts.getWantedTaskFromSlot(_loc1_).getFrame());
            _loc1_++;
         }
         xsrwPanel["msg"].gotoAndStop(clickNum + 1);
         xsrwPanel["nowTimes"].text = Main.wts.getWantedTaskFromSlot(clickNum).nowTimes();
         xsrwPanel["allTimes"].text = Main.wts.getWantedTaskFromSlot(clickNum).getTimes();
         xsrwPanel["jl1"].gotoAndStop(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_1()).getFrame());
         xsrwPanel["jl2"].gotoAndStop(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_2()).getFrame());
         xsrwPanel["jl1"]["t_txt"].text = SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_1()).getTimes();
         xsrwPanel["jl2"]["t_txt"].text = SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_2()).getTimes();
         xsrwPanel["xz" + clickNum].visible = true;
         if(Main.wts.getAccess() > -1)
         {
            xsrwPanel["yjq" + Main.wts.getAccess()].visible = true;
            xsrwPanel["bjq" + Main.wts.getAccess()].visible = false;
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               xsrwPanel["jq" + _loc1_].visible = false;
               _loc1_++;
            }
         }
         if(Main.wts.getISCD() == -1)
         {
            xsrwPanel.removeEventListener(Event.ENTER_FRAME,cdTime);
         }
         else
         {
            xsrwPanel.addEventListener(Event.ENTER_FRAME,cdTime);
         }
      }
      
      public static function cdTime(param1:*) : *
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            if(Main.wts.getWantedTaskFromSlot(_loc2_).getState() == 3)
            {
               if(Main.wts.getWantedTaskFromSlot(_loc2_).nowCD() <= 0)
               {
                  panelShow();
               }
               else
               {
                  xsrwPanel["yjq" + _loc2_].visible = false;
                  xsrwPanel["bjq" + _loc2_].visible = false;
                  xsrwPanel["lq" + _loc2_].visible = true;
                  _loc3_ = (Main.wts.getWantedTaskFromSlot(_loc2_).nowCD() / Main.wts.getWantedTaskFromSlot(_loc2_).getCooldown()).toFixed(2) * 100;
                  xsrwPanel["lq" + _loc2_].gotoAndStop(_loc3_);
                  xsrwPanel["lq" + _loc2_]["time"].text = "冷却时间" + int(Main.wts.getWantedTaskFromSlot(_loc2_).nowCD() / 60) + "分" + Main.wts.getWantedTaskFromSlot(_loc2_).nowCD() % 60 + "秒";
               }
            }
            else
            {
               xsrwPanel["lq" + _loc2_].stop();
               xsrwPanel["lq" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         if(Main.wts.getISCD() == -1)
         {
            xsrwPanel.removeEventListener(Event.ENTER_FRAME,cdTime);
            panelShow();
         }
      }
   }
}

