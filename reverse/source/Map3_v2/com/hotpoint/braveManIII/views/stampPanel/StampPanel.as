package com.hotpoint.braveManIII.views.stampPanel
{
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class StampPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var sp:StampPanel;
      
      public static var isPOne:Boolean;
      
      public static var clickNum:Number;
      
      public static var TYOK:Boolean = false;
      
      public static var qnPanel:MovieClip = new QNShow();
      
      public static var yeNum:Number = 1;
      
      public static var slotNum:Number = 1;
      
      public function StampPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(qnPanel);
      }
      
      public static function open(pp:Boolean = true) : void
      {
         Main.allClosePanel();
         Main.player1.getBag().cheatGem();
         if(sp == null)
         {
            sp = new StampPanel();
         }
         Main.stopXX = true;
         sp.x = 0;
         sp.y = 0;
         yeNum = 1;
         isPOne = pp;
         addListenerP1();
         Main._stage.addChild(sp);
         sp.visible = true;
      }
      
      public static function close() : void
      {
         if(sp == null)
         {
            sp = new StampPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         sp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         qnPanel["qnRMB"].visible = false;
         qnPanel["qnRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yes_btn);
         qnPanel["qnRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,no_btn);
         qnPanel["NoMoney_mc"].visible = false;
         qnPanel["NoMoney_mc"]["yes_btn"].addEventListener(MouseEvent.CLICK,closeNORMB);
         qnPanel["NoMoney_mc"]["addMoney_btn"].addEventListener(MouseEvent.CLICK,addMoney_btn);
         for(var i:uint = 0; i < 4; i++)
         {
            qnPanel["yz" + i].buttonMode = true;
            qnPanel["zy" + i].buttonMode = true;
            qnPanel["yz" + i].addEventListener(MouseEvent.CLICK,upDo);
            qnPanel["zy" + i].addEventListener(MouseEvent.CLICK,downDo);
            qnPanel["zd" + i].addEventListener(MouseEvent.CLICK,rmbDo);
            qnPanel["ty" + i].addEventListener(MouseEvent.CLICK,tongyongDo);
            qnPanel["s1_" + i].mouseChildren = qnPanel["s1_" + i].mouseEnabled = false;
            qnPanel["s2_" + i].mouseChildren = qnPanel["s2_" + i].mouseEnabled = false;
            qnPanel["s3_" + i].mouseChildren = qnPanel["s3_" + i].mouseEnabled = false;
         }
         qnPanel["shang_btn"].addEventListener(MouseEvent.CLICK,shangDo);
         qnPanel["xia_btn"].addEventListener(MouseEvent.CLICK,xiaDo);
         qnPanel["closePanel"].addEventListener(MouseEvent.CLICK,closePanel);
         for(var j:uint = 0; j < 24; j++)
         {
            qnPanel["e" + j].mouseChildren = false;
            qnPanel["e" + j].stop();
            qnPanel["e" + j].addEventListener(MouseEvent.CLICK,choseDo);
            qnPanel["e" + j].addEventListener(MouseEvent.MOUSE_MOVE,tipOpen);
            qnPanel["e" + j].addEventListener(MouseEvent.MOUSE_OUT,tipClose);
         }
         showRMB();
         showPanel();
         showGem();
      }
      
      private static function tipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         qnPanel.addChild(itemsTooltip);
         var overNum:uint = uint(overobj.name.substr(1,2));
         if(isPOne)
         {
            if(Main.player1.getBag().getGemFromBag(overNum) != null)
            {
               itemsTooltip.gemTooltip(Main.player1.getBag().getGemFromBag(overNum),1);
            }
         }
         else if(Main.player2.getBag().getGemFromBag(overNum) != null)
         {
            itemsTooltip.gemTooltip(Main.player2.getBag().getGemFromBag(overNum),2);
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = qnPanel.mouseX + 10;
         itemsTooltip.y = qnPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function tipClose(e:MouseEvent) : void
      {
         itemsTooltip.visible = false;
      }
      
      public static function closePanel(e:*) : *
      {
         close();
      }
      
      public static function tongyongDo(e:*) : *
      {
         clickNum = e.target.name.substr(2,1);
         if(isPOne)
         {
            if(Main.player1.getStampSlot().getSlot11(clickNum))
            {
               Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot11(clickNum));
            }
            showRMB();
            showPanel();
            qnPanel["k3_" + clickNum].visible = true;
            slotNum = 11;
         }
         else
         {
            if(Main.player2.getStampSlot().getSlot11(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot11(clickNum));
            }
            showRMB();
            showPanel();
            qnPanel["k3_" + clickNum].visible = true;
            slotNum = 11;
         }
         showAllGem();
      }
      
      public static function yes_btn(e:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 20)
         {
            Api_4399_All.Money_down(InitData.tongyongjiesuo.getValue());
            TYOK = true;
            qnPanel["qnRMB"].visible = false;
         }
         else
         {
            qnPanel["NoMoney_mc"].visible = true;
         }
      }
      
      public static function no_btn(e:*) : *
      {
         qnPanel["qnRMB"].visible = false;
      }
      
      private static function closeNORMB(e:*) : void
      {
         qnPanel["NoMoney_mc"].visible = false;
      }
      
      private static function addMoney_btn(e:*) : void
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      public static function rmbDo(e:*) : *
      {
         qnPanel["qnRMB"].visible = true;
      }
      
      public static function tyKeyOK() : *
      {
         if(TYOK)
         {
            if(isPOne)
            {
               Main.player1.getStampSlot().setKeySlot11();
            }
            else
            {
               Main.player2.getStampSlot().setKeySlot11();
            }
            showRMB();
            Main.Save();
            TYOK = false;
         }
      }
      
      public static function showRMB() : *
      {
         var i:uint = 0;
         for(i = 0; i < 4; i++)
         {
            qnPanel["s3_" + i].visible = false;
            qnPanel["k3_" + i].visible = false;
         }
         if(isPOne)
         {
            for(i = 0; i < 4; i++)
            {
               if(Main.player1.getStampSlot().getSlot11_key(i) == 1)
               {
                  qnPanel["zd" + i].visible = false;
                  if(Main.player1.getStampSlot().getSlot11(i))
                  {
                     qnPanel["s3_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot11(i).getFrame());
                     qnPanel["s3_" + i].visible = true;
                  }
               }
               else
               {
                  qnPanel["zd" + i].visible = true;
               }
            }
         }
         else
         {
            for(i = 0; i < 4; i++)
            {
               if(Main.player2.getStampSlot().getSlot11_key(i) == 1)
               {
                  qnPanel["zd" + i].visible = false;
                  if(Main.player2.getStampSlot().getSlot11(i))
                  {
                     qnPanel["s3_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot11(i).getFrame());
                     qnPanel["s3_" + i].visible = true;
                  }
               }
               else
               {
                  qnPanel["zd" + i].visible = true;
               }
            }
         }
      }
      
      public static function showAllGem() : *
      {
         var i:uint = 0;
         if(isPOne)
         {
            for(i = 0; i < 24; i++)
            {
               qnPanel["e" + i].visible = false;
               if(Boolean(Main.player1.getBag().getGemFromBag(i)) && Boolean(Main.player1.getBag().getGemFromBag(i).getType() >= 7) && Main.player1.getBag().getGemFromBag(i).getType() <= 16)
               {
                  qnPanel["e" + i].visible = true;
                  qnPanel["e" + i].gotoAndStop(Main.player1.getBag().getGemFromBag(i).getFrame());
               }
            }
         }
         else
         {
            for(i = 0; i < 24; i++)
            {
               qnPanel["e" + i].visible = false;
               if(Boolean(Main.player2.getBag().getGemFromBag(i)) && Boolean(Main.player2.getBag().getGemFromBag(i).getType() >= 7) && Main.player2.getBag().getGemFromBag(i).getType() <= 16)
               {
                  qnPanel["e" + i].visible = true;
                  qnPanel["e" + i].gotoAndStop(Main.player2.getBag().getGemFromBag(i).getFrame());
               }
            }
         }
      }
      
      public static function showGem(type:int = -1) : *
      {
         var i:uint = 0;
         if(isPOne)
         {
            for(i = 0; i < 24; i++)
            {
               qnPanel["e" + i].visible = false;
               if(Boolean(Main.player1.getBag().getGemFromBag(i)) && Main.player1.getBag().getGemFromBag(i).getType() == type)
               {
                  qnPanel["e" + i].visible = true;
                  qnPanel["e" + i].gotoAndStop(Main.player1.getBag().getGemFromBag(i).getFrame());
               }
            }
         }
         else
         {
            for(i = 0; i < 24; i++)
            {
               qnPanel["e" + i].visible = false;
               if(Boolean(Main.player2.getBag().getGemFromBag(i)) && Main.player2.getBag().getGemFromBag(i).getType() == type)
               {
                  qnPanel["e" + i].visible = true;
                  qnPanel["e" + i].gotoAndStop(Main.player2.getBag().getGemFromBag(i).getFrame());
               }
            }
         }
      }
      
      public static function showPanel() : *
      {
         var i:uint = 0;
         qnPanel["yeshu"].text = yeNum + "/5";
         for(i = 0; i < 4; i++)
         {
            qnPanel["yz" + i].gotoAndStop(yeNum * 2 - 1);
            qnPanel["zy" + i].gotoAndStop(yeNum * 2);
            qnPanel["k1_" + i].visible = false;
            qnPanel["k2_" + i].visible = false;
            qnPanel["s1_" + i].visible = false;
            qnPanel["s2_" + i].visible = false;
         }
         if(isPOne)
         {
            if(yeNum == 1)
            {
               qnPanel["txt_1"].text = "魔力印章(使用魔法药效果提高+" + int(Main.player1.getStampSlot().getValueSlot1() * 100) + "%)";
               qnPanel["txt_2"].text = "体力印章(使用体力药效果提高+" + int(Main.player1.getStampSlot().getValueSlot2() * 100) + "%)";
            }
            else if(yeNum == 2)
            {
               qnPanel["txt_1"].text = "未开启";
               qnPanel["txt_2"].text = "未开启";
            }
            else if(yeNum == 3)
            {
               qnPanel["txt_1"].text = "未开启";
               qnPanel["txt_2"].text = "未开启";
            }
            else if(yeNum == 4)
            {
               qnPanel["txt_1"].text = "未开启";
               qnPanel["txt_2"].text = "未开启";
            }
            else if(yeNum == 5)
            {
               qnPanel["txt_1"].text = "未开启";
               qnPanel["txt_2"].text = "未开启";
            }
            for(i = 0; i < 4; i++)
            {
               if(yeNum == 1 && Boolean(Main.player1.getStampSlot().getSlot1(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot1(i).getFrame());
               }
               if(yeNum == 1 && Boolean(Main.player1.getStampSlot().getSlot2(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot2(i).getFrame());
               }
               if(yeNum == 2 && Boolean(Main.player1.getStampSlot().getSlot3(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot3(i).getFrame());
               }
               if(yeNum == 2 && Boolean(Main.player1.getStampSlot().getSlot4(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot4(i).getFrame());
               }
               if(yeNum == 3 && Boolean(Main.player1.getStampSlot().getSlot5(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot5(i).getFrame());
               }
               if(yeNum == 3 && Boolean(Main.player1.getStampSlot().getSlot6(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot6(i).getFrame());
               }
               if(yeNum == 4 && Boolean(Main.player1.getStampSlot().getSlot7(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot7(i).getFrame());
               }
               if(yeNum == 4 && Boolean(Main.player1.getStampSlot().getSlot8(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot8(i).getFrame());
               }
               if(yeNum == 5 && Boolean(Main.player1.getStampSlot().getSlot9(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot9(i).getFrame());
               }
               if(yeNum == 5 && Boolean(Main.player1.getStampSlot().getSlot10(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player1.getStampSlot().getSlot10(i).getFrame());
               }
            }
         }
         else
         {
            if(yeNum == 1)
            {
               qnPanel["txt_1"].text = "魔力印章(使用魔法药效果提高+" + int(Main.player2.getStampSlot().getValueSlot1()) * 100 + "%)";
               qnPanel["txt_2"].text = "体力印章(使用体力药效果提高+" + int(Main.player2.getStampSlot().getValueSlot2()) * 100 + "%)";
            }
            else if(yeNum == 2)
            {
               qnPanel["txt_1"].text = "未开启";
               qnPanel["txt_2"].text = "未开启";
            }
            else if(yeNum == 3)
            {
               qnPanel["txt_1"].text = "未开启";
               qnPanel["txt_2"].text = "未开启";
            }
            else if(yeNum == 4)
            {
               qnPanel["txt_1"].text = "未开启";
               qnPanel["txt_2"].text = "未开启";
            }
            else if(yeNum == 5)
            {
               qnPanel["txt_1"].text = "未开启";
               qnPanel["txt_2"].text = "未开启";
            }
            for(i = 0; i < 4; i++)
            {
               if(yeNum == 1 && Boolean(Main.player2.getStampSlot().getSlot1(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot1(i).getFrame());
               }
               if(yeNum == 1 && Boolean(Main.player2.getStampSlot().getSlot2(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot2(i).getFrame());
               }
               if(yeNum == 2 && Boolean(Main.player2.getStampSlot().getSlot3(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot3(i).getFrame());
               }
               if(yeNum == 2 && Boolean(Main.player2.getStampSlot().getSlot4(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot4(i).getFrame());
               }
               if(yeNum == 3 && Boolean(Main.player2.getStampSlot().getSlot5(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot5(i).getFrame());
               }
               if(yeNum == 3 && Boolean(Main.player2.getStampSlot().getSlot6(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot6(i).getFrame());
               }
               if(yeNum == 4 && Boolean(Main.player2.getStampSlot().getSlot7(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot7(i).getFrame());
               }
               if(yeNum == 4 && Boolean(Main.player2.getStampSlot().getSlot8(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot8(i).getFrame());
               }
               if(yeNum == 5 && Boolean(Main.player2.getStampSlot().getSlot9(i)))
               {
                  qnPanel["s1_" + i].visible = true;
                  qnPanel["s1_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot9(i).getFrame());
               }
               if(yeNum == 5 && Boolean(Main.player2.getStampSlot().getSlot10(i)))
               {
                  qnPanel["s2_" + i].visible = true;
                  qnPanel["s2_" + i].gotoAndStop(Main.player2.getStampSlot().getSlot10(i).getFrame());
               }
            }
         }
      }
      
      public static function removeListenerP1() : *
      {
         qnPanel["qnRMB"]["yes_btn"].removeEventListener(MouseEvent.CLICK,yes_btn);
         qnPanel["qnRMB"]["no_btn"].removeEventListener(MouseEvent.CLICK,no_btn);
         qnPanel["NoMoney_mc"]["yes_btn"].removeEventListener(MouseEvent.CLICK,closeNORMB);
         qnPanel["NoMoney_mc"]["addMoney_btn"].removeEventListener(MouseEvent.CLICK,addMoney_btn);
         for(var i:uint = 0; i < 4; i++)
         {
            qnPanel["yz" + i].removeEventListener(MouseEvent.CLICK,upDo);
            qnPanel["zy" + i].removeEventListener(MouseEvent.CLICK,downDo);
            qnPanel["zd" + i].removeEventListener(MouseEvent.CLICK,rmbDo);
            qnPanel["ty" + i].removeEventListener(MouseEvent.CLICK,tongyongDo);
         }
         qnPanel["shang_btn"].addEventListener(MouseEvent.CLICK,shangDo);
         qnPanel["xia_btn"].addEventListener(MouseEvent.CLICK,xiaDo);
         qnPanel["closePanel"].addEventListener(MouseEvent.CLICK,closePanel);
         for(var j:uint = 0; j < 24; j++)
         {
            qnPanel["e" + j].removeEventListener(MouseEvent.CLICK,choseDo);
            qnPanel["e" + j].removeEventListener(MouseEvent.MOUSE_MOVE,tipOpen);
            qnPanel["e" + j].removeEventListener(MouseEvent.MOUSE_OUT,tipClose);
         }
      }
      
      public static function choseDo(e:*) : *
      {
         var choseNum:int = int(uint(e.target.name.substr(1,2)));
         if(isPOne)
         {
            if(slotNum == 1)
            {
               Main.player1.getStampSlot().setSlot1(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 2)
            {
               Main.player1.getStampSlot().setSlot2(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 3)
            {
               Main.player1.getStampSlot().setSlot3(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 4)
            {
               Main.player1.getStampSlot().setSlot4(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 5)
            {
               Main.player1.getStampSlot().setSlot5(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 6)
            {
               Main.player1.getStampSlot().setSlot6(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 7)
            {
               Main.player1.getStampSlot().setSlot7(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 8)
            {
               Main.player1.getStampSlot().setSlot8(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 9)
            {
               Main.player1.getStampSlot().setSlot9(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 10)
            {
               Main.player1.getStampSlot().setSlot10(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
            else if(slotNum == 11)
            {
               Main.player1.getStampSlot().setSlot11(Main.player1.getBag().delGem(choseNum,1),clickNum);
            }
         }
         else if(slotNum == 1)
         {
            Main.player2.getStampSlot().setSlot1(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 2)
         {
            Main.player2.getStampSlot().setSlot2(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 3)
         {
            Main.player2.getStampSlot().setSlot3(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 4)
         {
            Main.player2.getStampSlot().setSlot4(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 5)
         {
            Main.player2.getStampSlot().setSlot5(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 6)
         {
            Main.player2.getStampSlot().setSlot6(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 7)
         {
            Main.player2.getStampSlot().setSlot7(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 8)
         {
            Main.player2.getStampSlot().setSlot8(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 9)
         {
            Main.player2.getStampSlot().setSlot9(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 10)
         {
            Main.player2.getStampSlot().setSlot10(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         else if(slotNum == 11)
         {
            Main.player2.getStampSlot().setSlot11(Main.player2.getBag().delGem(choseNum,1),clickNum);
         }
         showGem();
         showPanel();
         showRMB();
      }
      
      public static function xiaDo(e:*) : *
      {
         if(yeNum < 5)
         {
            ++yeNum;
         }
         showGem();
         showPanel();
      }
      
      public static function shangDo(e:*) : *
      {
         if(yeNum > 1)
         {
            --yeNum;
         }
         showGem();
         showPanel();
      }
      
      public static function upDo(e:*) : *
      {
         clickNum = e.target.name.substr(2,1);
         if(isPOne)
         {
            if(yeNum == 1)
            {
               if(Main.player1.getStampSlot().getSlot1(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot1(clickNum));
               }
            }
            else if(yeNum == 2)
            {
               if(Main.player1.getStampSlot().getSlot3(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot3(clickNum));
               }
            }
            else if(yeNum == 3)
            {
               if(Main.player1.getStampSlot().getSlot5(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot5(clickNum));
               }
            }
            else if(yeNum == 4)
            {
               if(Main.player1.getStampSlot().getSlot7(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot7(clickNum));
               }
            }
            else if(yeNum == 5)
            {
               if(Main.player1.getStampSlot().getSlot9(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot9(clickNum));
               }
            }
         }
         else if(yeNum == 1)
         {
            if(Main.player2.getStampSlot().getSlot1(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot1(clickNum));
            }
         }
         else if(yeNum == 2)
         {
            if(Main.player2.getStampSlot().getSlot3(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot3(clickNum));
            }
         }
         else if(yeNum == 3)
         {
            if(Main.player2.getStampSlot().getSlot5(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot5(clickNum));
            }
         }
         else if(yeNum == 4)
         {
            if(Main.player2.getStampSlot().getSlot7(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot7(clickNum));
            }
         }
         else if(yeNum == 5)
         {
            if(Main.player2.getStampSlot().getSlot9(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot9(clickNum));
            }
         }
         showPanel();
         showRMB();
         qnPanel["k1_" + clickNum].visible = true;
         slotNum = yeNum * 2 - 1;
         showGem(slotNum + 6);
      }
      
      public static function downDo(e:*) : *
      {
         clickNum = e.target.name.substr(2,1);
         if(isPOne)
         {
            if(yeNum == 1)
            {
               if(Main.player1.getStampSlot().getSlot2(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot2(clickNum));
               }
            }
            else if(yeNum == 2)
            {
               if(Main.player1.getStampSlot().getSlot4(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot4(clickNum));
               }
            }
            else if(yeNum == 3)
            {
               if(Main.player1.getStampSlot().getSlot6(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot6(clickNum));
               }
            }
            else if(yeNum == 4)
            {
               if(Main.player1.getStampSlot().getSlot8(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot8(clickNum));
               }
            }
            else if(yeNum == 5)
            {
               if(Main.player1.getStampSlot().getSlot10(clickNum))
               {
                  Main.player1.getBag().addGemBag(Main.player1.getStampSlot().delSlot10(clickNum));
               }
            }
         }
         else if(yeNum == 1)
         {
            if(Main.player2.getStampSlot().getSlot2(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot2(clickNum));
            }
         }
         else if(yeNum == 2)
         {
            if(Main.player2.getStampSlot().getSlot4(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot4(clickNum));
            }
         }
         else if(yeNum == 3)
         {
            if(Main.player2.getStampSlot().getSlot6(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot6(clickNum));
            }
         }
         else if(yeNum == 4)
         {
            if(Main.player2.getStampSlot().getSlot8(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot8(clickNum));
            }
         }
         else if(yeNum == 5)
         {
            if(Main.player2.getStampSlot().getSlot10(clickNum))
            {
               Main.player2.getBag().addGemBag(Main.player2.getStampSlot().delSlot10(clickNum));
            }
         }
         showPanel();
         showRMB();
         qnPanel["k2_" + clickNum].visible = true;
         slotNum = yeNum * 2;
         showGem(slotNum + 6);
      }
   }
}

