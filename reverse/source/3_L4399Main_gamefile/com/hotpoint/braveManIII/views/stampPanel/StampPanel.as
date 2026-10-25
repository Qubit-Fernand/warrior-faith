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
      
      public static function open(param1:Boolean = true) : void
      {
         Main.DuoKai_Fun();
         Main.allClosePanel();
         if(sp == null)
         {
            sp = new StampPanel();
         }
         Main.stopXX = true;
         sp.x = 0;
         sp.y = 0;
         yeNum = 1;
         isPOne = param1;
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
         qnPanel["djPoint"].visible = true;
         qnPanel["qnRMB"].visible = false;
         qnPanel["qnRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yes_btn);
         qnPanel["qnRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,no_btn);
         qnPanel["NoMoney_mc"].visible = false;
         qnPanel["NoMoney_mc"]["yes_btn"].addEventListener(MouseEvent.CLICK,closeNORMB);
         qnPanel["NoMoney_mc"]["addMoney_btn"].addEventListener(MouseEvent.CLICK,addMoney_btn);
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            qnPanel["yz" + _loc1_].buttonMode = true;
            qnPanel["zy" + _loc1_].buttonMode = true;
            qnPanel["yz" + _loc1_].addEventListener(MouseEvent.CLICK,upDo);
            qnPanel["zy" + _loc1_].addEventListener(MouseEvent.CLICK,downDo);
            qnPanel["zd" + _loc1_].addEventListener(MouseEvent.CLICK,rmbDo);
            qnPanel["ty" + _loc1_].addEventListener(MouseEvent.CLICK,tongyongDo);
            qnPanel["s1_" + _loc1_].mouseChildren = qnPanel["s1_" + _loc1_].mouseEnabled = false;
            qnPanel["s2_" + _loc1_].mouseChildren = qnPanel["s2_" + _loc1_].mouseEnabled = false;
            qnPanel["s3_" + _loc1_].mouseChildren = qnPanel["s3_" + _loc1_].mouseEnabled = false;
            _loc1_++;
         }
         qnPanel["shang_btn"].addEventListener(MouseEvent.CLICK,shangDo);
         qnPanel["xia_btn"].addEventListener(MouseEvent.CLICK,xiaDo);
         qnPanel["closePanel"].addEventListener(MouseEvent.CLICK,closePanel);
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            qnPanel["e" + _loc2_].mouseChildren = false;
            qnPanel["e" + _loc2_].stop();
            qnPanel["e" + _loc2_].addEventListener(MouseEvent.CLICK,choseDo);
            qnPanel["e" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,tipOpen);
            qnPanel["e" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,tipClose);
            _loc2_++;
         }
         showRMB();
         showPanel();
         showGem();
      }
      
      private static function tipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         qnPanel.addChild(itemsTooltip);
         var _loc3_:uint = uint(_loc2_.name.substr(1,2));
         if(isPOne)
         {
            if(Main.player1.getBag().getGemFromBag(_loc3_) != null)
            {
               itemsTooltip.gemTooltip(Main.player1.getBag().getGemFromBag(_loc3_),1);
            }
         }
         else if(Main.player2.getBag().getGemFromBag(_loc3_) != null)
         {
            itemsTooltip.gemTooltip(Main.player2.getBag().getGemFromBag(_loc3_),2);
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = qnPanel.mouseX + 10;
         itemsTooltip.y = qnPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function tipClose(param1:MouseEvent) : void
      {
         itemsTooltip.visible = false;
      }
      
      public static function closePanel(param1:*) : *
      {
         close();
      }
      
      public static function tongyongDo(param1:*) : *
      {
         clickNum = param1.target.name.substr(2,1);
         if(isPOne)
         {
            if(Main.player1.getBag().backGemBagNum() > 0)
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
         }
         else if(Main.player2.getBag().backGemBagNum() > 0)
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
      
      public static function yes_btn(param1:*) : *
      {
         TYOK = true;
         tyKeyOK();
         qnPanel["qnRMB"].visible = false;
      }
      
      public static function no_btn(param1:*) : *
      {
         qnPanel["qnRMB"].visible = false;
      }
      
      private static function closeNORMB(param1:*) : void
      {
         qnPanel["NoMoney_mc"].visible = false;
      }
      
      private static function addMoney_btn(param1:*) : void
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      public static function rmbDo(param1:*) : *
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
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            qnPanel["s3_" + _loc1_].visible = false;
            qnPanel["k3_" + _loc1_].visible = false;
            _loc1_++;
         }
         if(isPOne)
         {
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               if(Main.player1.getStampSlot().getSlot11_key(_loc1_) == 1)
               {
                  qnPanel["zd" + _loc1_].visible = false;
                  if(Main.player1.getStampSlot().getSlot11(_loc1_))
                  {
                     qnPanel["s3_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot11(_loc1_).getFrame());
                     qnPanel["s3_" + _loc1_].visible = true;
                  }
               }
               else
               {
                  qnPanel["zd" + _loc1_].visible = true;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               if(Main.player2.getStampSlot().getSlot11_key(_loc1_) == 1)
               {
                  qnPanel["zd" + _loc1_].visible = false;
                  if(Main.player2.getStampSlot().getSlot11(_loc1_))
                  {
                     qnPanel["s3_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot11(_loc1_).getFrame());
                     qnPanel["s3_" + _loc1_].visible = true;
                  }
               }
               else
               {
                  qnPanel["zd" + _loc1_].visible = true;
               }
               _loc1_++;
            }
         }
         qnPanel["djPoint"].text = Shop4399.moneyAll.getValue();
      }
      
      public static function showAllGem() : *
      {
         var _loc1_:uint = 0;
         if(isPOne)
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               qnPanel["e" + _loc1_].visible = false;
               if(Main.player1.getBag().getGemFromBag(_loc1_) && Main.player1.getBag().getGemFromBag(_loc1_).getType() >= 7 && Main.player1.getBag().getGemFromBag(_loc1_).getType() <= 16)
               {
                  qnPanel["e" + _loc1_].visible = true;
                  qnPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getGemFromBag(_loc1_).getFrame());
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               qnPanel["e" + _loc1_].visible = false;
               if(Main.player2.getBag().getGemFromBag(_loc1_) && Main.player2.getBag().getGemFromBag(_loc1_).getType() >= 7 && Main.player2.getBag().getGemFromBag(_loc1_).getType() <= 16)
               {
                  qnPanel["e" + _loc1_].visible = true;
                  qnPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getGemFromBag(_loc1_).getFrame());
               }
               _loc1_++;
            }
         }
      }
      
      public static function showGem(param1:int = -1) : *
      {
         var _loc2_:uint = 0;
         if(isPOne)
         {
            _loc2_ = 0;
            while(_loc2_ < 24)
            {
               qnPanel["e" + _loc2_].visible = false;
               if(Boolean(Main.player1.getBag().getGemFromBag(_loc2_)) && Main.player1.getBag().getGemFromBag(_loc2_).getType() == param1)
               {
                  qnPanel["e" + _loc2_].visible = true;
                  qnPanel["e" + _loc2_].gotoAndStop(Main.player1.getBag().getGemFromBag(_loc2_).getFrame());
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 24)
            {
               qnPanel["e" + _loc2_].visible = false;
               if(Boolean(Main.player2.getBag().getGemFromBag(_loc2_)) && Main.player2.getBag().getGemFromBag(_loc2_).getType() == param1)
               {
                  qnPanel["e" + _loc2_].visible = true;
                  qnPanel["e" + _loc2_].gotoAndStop(Main.player2.getBag().getGemFromBag(_loc2_).getFrame());
               }
               _loc2_++;
            }
         }
      }
      
      public static function showPanel() : *
      {
         var _loc1_:uint = 0;
         qnPanel["yeshu"].text = yeNum + "/5";
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            qnPanel["yz" + _loc1_].gotoAndStop(yeNum * 2 - 1);
            qnPanel["zy" + _loc1_].gotoAndStop(yeNum * 2);
            qnPanel["k1_" + _loc1_].visible = false;
            qnPanel["k2_" + _loc1_].visible = false;
            qnPanel["s1_" + _loc1_].visible = false;
            qnPanel["s2_" + _loc1_].visible = false;
            _loc1_++;
         }
         if(isPOne)
         {
            if(yeNum == 1)
            {
               qnPanel["txt_1"].text = "魔力印章(使用魔法药效果提高+" + Math.round(Main.player1.getStampSlot().getValueSlot1() * 100) + "%)";
               qnPanel["txt_2"].text = "体力印章(使用体力药效果提高+" + Math.round(Main.player1.getStampSlot().getValueSlot2() * 100) + "%)";
            }
            else if(yeNum == 2)
            {
               qnPanel["txt_1"].text = "攻击印章(攻击力提高+" + Number(Main.player1.getStampSlot().getValueSlot3() * 100).toFixed(1) + "%)";
               qnPanel["txt_2"].text = "防御印章(防御力提高+" + Number(Main.player1.getStampSlot().getValueSlot4() * 100).toFixed(1) + "%)";
            }
            else if(yeNum == 3)
            {
               qnPanel["txt_1"].text = "生命印章(提高固定生命值+" + Math.round(Main.player1.getStampSlot().getValueSlot5()) + ")";
               qnPanel["txt_2"].text = "力量印章(提高固定攻击力+" + Math.round(Main.player1.getStampSlot().getValueSlot6()) + ")";
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
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               if(yeNum == 1 && Boolean(Main.player1.getStampSlot().getSlot1(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot1(_loc1_).getFrame());
               }
               if(yeNum == 1 && Boolean(Main.player1.getStampSlot().getSlot2(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot2(_loc1_).getFrame());
               }
               if(yeNum == 2 && Boolean(Main.player1.getStampSlot().getSlot3(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot3(_loc1_).getFrame());
               }
               if(yeNum == 2 && Boolean(Main.player1.getStampSlot().getSlot4(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot4(_loc1_).getFrame());
               }
               if(yeNum == 3 && Boolean(Main.player1.getStampSlot().getSlot5(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot5(_loc1_).getFrame());
               }
               if(yeNum == 3 && Boolean(Main.player1.getStampSlot().getSlot6(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot6(_loc1_).getFrame());
               }
               if(yeNum == 4 && Boolean(Main.player1.getStampSlot().getSlot7(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot7(_loc1_).getFrame());
               }
               if(yeNum == 4 && Boolean(Main.player1.getStampSlot().getSlot8(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot8(_loc1_).getFrame());
               }
               if(yeNum == 5 && Boolean(Main.player1.getStampSlot().getSlot9(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot9(_loc1_).getFrame());
               }
               if(yeNum == 5 && Boolean(Main.player1.getStampSlot().getSlot10(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player1.getStampSlot().getSlot10(_loc1_).getFrame());
               }
               _loc1_++;
            }
         }
         else
         {
            if(yeNum == 1)
            {
               qnPanel["txt_1"].text = "魔力印章(使用魔法药效果提高+" + Math.round(Main.player2.getStampSlot().getValueSlot1() * 100) + "%)";
               qnPanel["txt_2"].text = "体力印章(使用体力药效果提高+" + Math.round(Main.player2.getStampSlot().getValueSlot2() * 100) + "%)";
            }
            else if(yeNum == 2)
            {
               qnPanel["txt_1"].text = "攻击印章(攻击力提高+" + Number(Main.player2.getStampSlot().getValueSlot3() * 100).toFixed(1) + "%)";
               qnPanel["txt_2"].text = "防御印章(防御力提高+" + Number(Main.player2.getStampSlot().getValueSlot4() * 100).toFixed(1) + "%)";
            }
            else if(yeNum == 3)
            {
               qnPanel["txt_1"].text = "生命印章(提高固定生命值+" + Math.round(Main.player2.getStampSlot().getValueSlot5()) + ")";
               qnPanel["txt_2"].text = "力量印章(提高固定攻击力+" + Math.round(Main.player2.getStampSlot().getValueSlot6()) + ")";
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
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               if(yeNum == 1 && Boolean(Main.player2.getStampSlot().getSlot1(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot1(_loc1_).getFrame());
               }
               if(yeNum == 1 && Boolean(Main.player2.getStampSlot().getSlot2(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot2(_loc1_).getFrame());
               }
               if(yeNum == 2 && Boolean(Main.player2.getStampSlot().getSlot3(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot3(_loc1_).getFrame());
               }
               if(yeNum == 2 && Boolean(Main.player2.getStampSlot().getSlot4(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot4(_loc1_).getFrame());
               }
               if(yeNum == 3 && Boolean(Main.player2.getStampSlot().getSlot5(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot5(_loc1_).getFrame());
               }
               if(yeNum == 3 && Boolean(Main.player2.getStampSlot().getSlot6(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot6(_loc1_).getFrame());
               }
               if(yeNum == 4 && Boolean(Main.player2.getStampSlot().getSlot7(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot7(_loc1_).getFrame());
               }
               if(yeNum == 4 && Boolean(Main.player2.getStampSlot().getSlot8(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot8(_loc1_).getFrame());
               }
               if(yeNum == 5 && Boolean(Main.player2.getStampSlot().getSlot9(_loc1_)))
               {
                  qnPanel["s1_" + _loc1_].visible = true;
                  qnPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot9(_loc1_).getFrame());
               }
               if(yeNum == 5 && Boolean(Main.player2.getStampSlot().getSlot10(_loc1_)))
               {
                  qnPanel["s2_" + _loc1_].visible = true;
                  qnPanel["s2_" + _loc1_].gotoAndStop(Main.player2.getStampSlot().getSlot10(_loc1_).getFrame());
               }
               _loc1_++;
            }
         }
      }
      
      public static function removeListenerP1() : *
      {
         qnPanel["qnRMB"]["yes_btn"].removeEventListener(MouseEvent.CLICK,yes_btn);
         qnPanel["qnRMB"]["no_btn"].removeEventListener(MouseEvent.CLICK,no_btn);
         qnPanel["NoMoney_mc"]["yes_btn"].removeEventListener(MouseEvent.CLICK,closeNORMB);
         qnPanel["NoMoney_mc"]["addMoney_btn"].removeEventListener(MouseEvent.CLICK,addMoney_btn);
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            qnPanel["yz" + _loc1_].removeEventListener(MouseEvent.CLICK,upDo);
            qnPanel["zy" + _loc1_].removeEventListener(MouseEvent.CLICK,downDo);
            qnPanel["zd" + _loc1_].removeEventListener(MouseEvent.CLICK,rmbDo);
            qnPanel["ty" + _loc1_].removeEventListener(MouseEvent.CLICK,tongyongDo);
            _loc1_++;
         }
         qnPanel["shang_btn"].addEventListener(MouseEvent.CLICK,shangDo);
         qnPanel["xia_btn"].addEventListener(MouseEvent.CLICK,xiaDo);
         qnPanel["closePanel"].addEventListener(MouseEvent.CLICK,closePanel);
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            qnPanel["e" + _loc2_].removeEventListener(MouseEvent.CLICK,choseDo);
            qnPanel["e" + _loc2_].removeEventListener(MouseEvent.MOUSE_MOVE,tipOpen);
            qnPanel["e" + _loc2_].removeEventListener(MouseEvent.MOUSE_OUT,tipClose);
            _loc2_++;
         }
      }
      
      public static function choseDo(param1:*) : *
      {
         var _loc2_:int = int(uint(param1.target.name.substr(1,2)));
         if(isPOne)
         {
            if(slotNum == 1)
            {
               Main.player1.getStampSlot().setSlot1(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 2)
            {
               Main.player1.getStampSlot().setSlot2(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 3)
            {
               Main.player1.getStampSlot().setSlot3(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 4)
            {
               Main.player1.getStampSlot().setSlot4(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 5)
            {
               Main.player1.getStampSlot().setSlot5(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 6)
            {
               Main.player1.getStampSlot().setSlot6(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 7)
            {
               Main.player1.getStampSlot().setSlot7(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 8)
            {
               Main.player1.getStampSlot().setSlot8(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 9)
            {
               Main.player1.getStampSlot().setSlot9(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 10)
            {
               Main.player1.getStampSlot().setSlot10(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
            else if(slotNum == 11)
            {
               Main.player1.getStampSlot().setSlot11(Main.player1.getBag().delGem(_loc2_,1),clickNum);
            }
         }
         else if(slotNum == 1)
         {
            Main.player2.getStampSlot().setSlot1(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 2)
         {
            Main.player2.getStampSlot().setSlot2(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 3)
         {
            Main.player2.getStampSlot().setSlot3(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 4)
         {
            Main.player2.getStampSlot().setSlot4(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 5)
         {
            Main.player2.getStampSlot().setSlot5(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 6)
         {
            Main.player2.getStampSlot().setSlot6(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 7)
         {
            Main.player2.getStampSlot().setSlot7(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 8)
         {
            Main.player2.getStampSlot().setSlot8(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 9)
         {
            Main.player2.getStampSlot().setSlot9(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 10)
         {
            Main.player2.getStampSlot().setSlot10(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         else if(slotNum == 11)
         {
            Main.player2.getStampSlot().setSlot11(Main.player2.getBag().delGem(_loc2_,1),clickNum);
         }
         showGem();
         showPanel();
         showRMB();
      }
      
      public static function xiaDo(param1:*) : *
      {
         if(yeNum < 5)
         {
            ++yeNum;
         }
         showGem();
         showPanel();
      }
      
      public static function shangDo(param1:*) : *
      {
         if(yeNum > 1)
         {
            --yeNum;
         }
         showGem();
         showPanel();
      }
      
      public static function upDo(param1:*) : *
      {
         clickNum = param1.target.name.substr(2,1);
         if(isPOne)
         {
            if(Main.player1.getBag().backGemBagNum() > 0)
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
         }
         else if(Main.player2.getBag().backGemBagNum() > 0)
         {
            if(yeNum == 1)
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
         }
         showPanel();
         showRMB();
         qnPanel["k1_" + clickNum].visible = true;
         slotNum = yeNum * 2 - 1;
         showGem(slotNum + 6);
      }
      
      public static function downDo(param1:*) : *
      {
         clickNum = param1.target.name.substr(2,1);
         if(isPOne)
         {
            if(Main.player1.getBag().backGemBagNum() > 0)
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
         }
         else if(Main.player2.getBag().backGemBagNum() > 0)
         {
            if(yeNum == 1)
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
         }
         showPanel();
         showRMB();
         qnPanel["k2_" + clickNum].visible = true;
         slotNum = yeNum * 2;
         showGem(slotNum + 6);
      }
   }
}

