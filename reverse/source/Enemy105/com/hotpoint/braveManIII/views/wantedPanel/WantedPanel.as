package com.hotpoint.braveManIII.views.wantedPanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.repository.other.*;
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
      
      public static var click:Number = 0;
      
      public static var yeshu:Number = 1;
      
      public static var overNum:Number = 0;
      
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
         xsrwPanel["lingqu_btn"].visible = false;
         xsrwPanel["NoMoney_mc"].visible = false;
         xsrwPanel["xsRMB"].visible = false;
         xsrwPanel["shang_btn"].addEventListener(MouseEvent.CLICK,shang_btn);
         xsrwPanel["xia_btn"].addEventListener(MouseEvent.CLICK,xia_btn);
         xsrwPanel["lingqu_btn"].addEventListener(MouseEvent.CLICK,lingqu);
         xsrwPanel["xsRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yes_btn);
         xsrwPanel["xsRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,no_btn);
         xsrwPanel["NoMoney_mc"]["yes_btn"].addEventListener(MouseEvent.CLICK,closeNORMB);
         xsrwPanel["NoMoney_mc"]["addMoney_btn"].addEventListener(MouseEvent.CLICK,addMoney_btn);
         xsrwPanel["close"].addEventListener(MouseEvent.CLICK,closeXS);
         xsrwPanel["rwOK"].addEventListener(MouseEvent.CLICK,rwOK);
         xsrwPanel["rwFQ"].addEventListener(MouseEvent.CLICK,rwFQ);
         for(var i:int = 0; i < 3; i++)
         {
            xsrwPanel["lq" + i]["lq_btn"].addEventListener(MouseEvent.CLICK,lqReset);
            xsrwPanel["jq" + i].addEventListener(MouseEvent.CLICK,jiequ);
            xsrwPanel["tq" + i].addEventListener(MouseEvent.CLICK,choseOne);
            xsrwPanel["tq" + i].mouseChildren = false;
            xsrwPanel["tq" + i].mouseEnabled = true;
         }
         panelShow();
      }
      
      private static function closeNORMB(e:*) : void
      {
         xsrwPanel["NoMoney_mc"].visible = false;
      }
      
      private static function addMoney_btn(e:*) : void
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      public static function yes_btn(e:*) : *
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
      
      public static function no_btn(e:*) : *
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
      
      public static function lqReset(e:*) : *
      {
         xsrwPanel["xsRMB"].visible = true;
         czNum = e.target.parent.name.substr(2,1);
         czNum += (yeshu - 1) * 3;
      }
      
      public static function removeListener() : *
      {
         xsrwPanel["close"].removeEventListener(MouseEvent.CLICK,closeXS);
      }
      
      public static function rwOK(e:*) : *
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
      
      public static function shang_btn(e:*) : *
      {
         if(yeshu > 1)
         {
            --yeshu;
            panelShow();
         }
      }
      
      public static function xia_btn(e:*) : *
      {
         if(yeshu < 4 && Main.wts.wantedTaskTimesLV1() >= 50)
         {
            ++yeshu;
            panelShow();
         }
      }
      
      public static function lingqu(e:*) : *
      {
         if(Main.wts.getJLTimes() < 1 && yeshu == 1)
         {
            if(Main.P1P2)
            {
               if(Main.player1.getBag().backOtherBagNum() >= 1 && Main.player2.getBag().backOtherBagNum() >= 1)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63176));
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63176));
                  Main.wts.addJLTimes();
               }
               else
               {
                  ShortTip.open(3);
               }
            }
            else if(Main.player1.getBag().backOtherBagNum() >= 1)
            {
               Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63176));
               Main.wts.addJLTimes();
            }
            else
            {
               ShortTip.open(3);
            }
            panelShow();
         }
         if(Main.wts.getJLTimes2() < 1 && yeshu == 2)
         {
            if(Main.P1P2)
            {
               if(Main.player1.getBag().backOtherBagNum() >= 1 && Main.player2.getBag().backOtherBagNum() >= 1)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63201));
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63201));
                  Main.wts.addJLTimes2();
               }
               else
               {
                  ShortTip.open(3);
               }
            }
            else if(Main.player1.getBag().backOtherBagNum() >= 1)
            {
               Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63201));
               Main.wts.addJLTimes2();
            }
            else
            {
               ShortTip.open(3);
            }
            panelShow();
         }
         if(Main.wts.getJLTimes3() < 1 && yeshu == 3)
         {
            if(Main.P1P2)
            {
               if(Main.player1.getBag().backOtherBagNum() >= 1 && Main.player2.getBag().backOtherBagNum() >= 1)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63213));
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63213));
                  Main.wts.addJLTimes3();
               }
               else
               {
                  ShortTip.open(3);
               }
            }
            else if(Main.player1.getBag().backOtherBagNum() >= 1)
            {
               Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63213));
               Main.wts.addJLTimes3();
            }
            else
            {
               ShortTip.open(3);
            }
            panelShow();
         }
         if(Main.wts.getJLTimes4() < 1 && yeshu == 4)
         {
            if(Main.P1P2)
            {
               if(Main.player1.getBag().backOtherBagNum() >= 1 && Main.player2.getBag().backOtherBagNum() >= 1)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63217));
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63217));
                  Main.wts.addJLTimes4();
               }
               else
               {
                  ShortTip.open(3);
               }
            }
            else if(Main.player1.getBag().backOtherBagNum() >= 1)
            {
               Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63217));
               Main.wts.addJLTimes4();
            }
            else
            {
               ShortTip.open(3);
            }
            panelShow();
         }
      }
      
      public static function rwFQ(e:*) : *
      {
         Main.wts.getWantedTaskFromSlot(clickNum).setState(0);
         panelShow();
      }
      
      public static function closeXS(e:*) : *
      {
         close();
      }
      
      public static function choseOne(e:*) : *
      {
         click = uint((e.target as MovieClip).name.substr(2,1));
         clickNum = 3 * (yeshu - 1) + click;
         panelShow();
      }
      
      public static function jiequ(e:*) : *
      {
         overNum = e.target.name.substr(2,1);
         overNum += 3 * (yeshu - 1);
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
                  Main.wts.setWantedTaskSlot(overNum);
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
               Main.wts.setWantedTaskSlot(overNum);
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
         var i:int = 0;
         xsrwPanel["yeshu_txt"].text = yeshu + "/4";
         xsrwPanel["lingqu_btn"].visible = false;
         WantedPanel.xsrwPanel._money_txt.text = Main.player1.getGold();
         WantedPanel.xsrwPanel._kill_txt.text = Main.player1.getKillPoint();
         if(WantedPanel.xsrwPanel._moneyP_txt.text == "")
         {
            Api_4399_All.Money_sel();
         }
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
         for(i = 0; i < 3; i++)
         {
            xsrwPanel["lq" + i].stop();
            xsrwPanel["lq" + i].visible = false;
            xsrwPanel["xz" + i].visible = false;
            xsrwPanel["yjq" + i].visible = false;
            xsrwPanel["bjq" + i].visible = true;
            xsrwPanel["jq" + i].visible = true;
            xsrwPanel["tq" + i].gotoAndStop(Main.wts.getWantedTaskFromSlot(i + 3 * (yeshu - 1)).getFrame());
         }
         xsrwPanel["msg"].gotoAndStop(clickNum + 1);
         if(yeshu == 1)
         {
            xsrwPanel["nowTimes"].text = Main.wts.wantedTaskTimesLV1();
         }
         else if(yeshu == 2)
         {
            xsrwPanel["nowTimes"].text = Main.wts.wantedTaskTimesLV2();
         }
         else if(yeshu == 3)
         {
            xsrwPanel["nowTimes"].text = Main.wts.wantedTaskTimesLV3();
         }
         else if(yeshu == 4)
         {
            xsrwPanel["nowTimes"].text = Main.wts.wantedTaskTimesLV4();
         }
         xsrwPanel["allTimes"].text = Main.wts.getWantedTaskFromSlot(clickNum).getTimes();
         if(yeshu == 4 && Main.wts.wantedTaskTimesLV4() >= 50 && Main.wts.getJLTimes4() < 1)
         {
            xsrwPanel["lingqu_btn"].visible = true;
         }
         if(yeshu == 3 && Main.wts.wantedTaskTimesLV3() >= 50 && Main.wts.getJLTimes3() < 1)
         {
            xsrwPanel["lingqu_btn"].visible = true;
         }
         if(yeshu == 2 && Main.wts.wantedTaskTimesLV2() >= 50 && Main.wts.getJLTimes2() < 1)
         {
            xsrwPanel["lingqu_btn"].visible = true;
         }
         if(yeshu == 1 && Main.wts.wantedTaskTimesLV1() >= 50 && Main.wts.getJLTimes() < 1)
         {
            xsrwPanel["lingqu_btn"].visible = true;
         }
         xsrwPanel["jl1"].gotoAndStop(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_1()).getFrame());
         xsrwPanel["jl2"].gotoAndStop(SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_2()).getFrame());
         xsrwPanel["jl1"]["t_txt"].text = SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_1()).getTimes();
         xsrwPanel["jl2"]["t_txt"].text = SuppliesFactory.getSuppliesById(Main.wts.getWantedTaskFromSlot(clickNum).getReward_2()).getTimes();
         xsrwPanel["xz" + click].visible = true;
         if(Main.wts.getAccess() > -1)
         {
            if(yeshu * 3 - Main.wts.getAccess() > 0 && yeshu * 3 - Main.wts.getAccess() < 4)
            {
               xsrwPanel["yjq" + (Main.wts.getAccess() - 3 * (yeshu - 1))].visible = true;
               xsrwPanel["bjq" + (Main.wts.getAccess() - 3 * (yeshu - 1))].visible = false;
            }
            for(i = 0; i < 3; i++)
            {
               xsrwPanel["jq" + i].visible = false;
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
      
      public static function cdTime(e:*) : *
      {
         var per:int = 0;
         for(var i:int = 0; i < 3; i++)
         {
            if(Main.wts.getWantedTaskFromSlot(i + 3 * (yeshu - 1)).getState() == 3)
            {
               if(Main.wts.getWantedTaskFromSlot(i + 3 * (yeshu - 1)).nowCD() <= 0)
               {
                  panelShow();
               }
               else
               {
                  xsrwPanel["yjq" + i].visible = false;
                  xsrwPanel["bjq" + i].visible = false;
                  xsrwPanel["lq" + i].visible = true;
                  per = (Main.wts.getWantedTaskFromSlot(i + 3 * (yeshu - 1)).nowCD() / Main.wts.getWantedTaskFromSlot(i + 3 * (yeshu - 1)).getCooldown()).toFixed(2) * 100;
                  xsrwPanel["lq" + i].gotoAndStop(per);
                  xsrwPanel["lq" + i]["time"].text = "冷却时间" + int(Main.wts.getWantedTaskFromSlot(i + 3 * (yeshu - 1)).nowCD() / 60) + "分" + Main.wts.getWantedTaskFromSlot(i + 3 * (yeshu - 1)).nowCD() % 60 + "秒";
               }
            }
            else
            {
               xsrwPanel["lq" + i].stop();
               xsrwPanel["lq" + i].visible = false;
            }
         }
         if(Main.wts.getISCD() == -1)
         {
            xsrwPanel.removeEventListener(Event.ENTER_FRAME,cdTime);
            panelShow();
         }
      }
   }
}

