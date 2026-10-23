package com.hotpoint.braveManIII.views.cardPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.repository.monsterCard.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class CardPanel extends MovieClip
   {
      
      public static var monsterSlot:MonsterSlot;
      
      public static var cp:CardPanel;
      
      public static var ccc:ClassLoader;
      
      public static var cardPanel:MovieClip;
      
      private static var loadData:ClassLoader;
      
      public static var yeshu:int = 1;
      
      public static var yeshu_max:int = 1;
      
      public static var clickNum:int = 0;
      
      private static var loadName:String = "Card_v16.swf";
      
      private static var OpenYN:Boolean = false;
      
      public function CardPanel()
      {
         super();
      }
      
      private static function LoadSkin() : *
      {
         if(!cardPanel && !loadData)
         {
            loadData = new ClassLoader(loadName);
            loadData.addEventListener(Event.COMPLETE,onLoadingOK);
            Play_Interface.interfaceX["load_mc"].visible = true;
         }
      }
      
      private static function onLoadingOK(param1:*) : *
      {
         var _loc2_:Class = loadData.getClass("CardShow") as Class;
         cardPanel = new _loc2_();
         cp.addChild(cardPanel);
         Play_Interface.interfaceX["load_mc"].visible = false;
         if(OpenYN)
         {
            open();
         }
         else
         {
            close();
         }
      }
      
      private static function InitOpen() : *
      {
         if(!monsterSlot)
         {
            monsterSlot = MonsterSlot.creatMonsterSlot();
         }
         cp = new CardPanel();
         LoadSkin();
         Main._stage.addChild(cp);
         OpenYN = true;
      }
      
      private static function InitClose() : *
      {
         if(!monsterSlot)
         {
            monsterSlot = MonsterSlot.creatMonsterSlot();
         }
         cp = new CardPanel();
         Main._stage.addChild(cp);
         OpenYN = false;
      }
      
      public static function open() : void
      {
         Main.DuoKai_Fun();
         Main.allClosePanel();
         if(cardPanel)
         {
            Main.stopXX = true;
            cp.x = 0;
            cp.y = 0;
            addListenerP1();
            cp.visible = true;
            monsterSlot.testMonsterSlot();
         }
         else
         {
            InitOpen();
         }
      }
      
      public static function close() : void
      {
         if(cardPanel)
         {
            cp.visible = false;
            Main.stopXX = false;
            removeListenerP1();
            monsterSlot.testMonsterSlot();
         }
         else
         {
            InitClose();
         }
      }
      
      public static function closeCP(param1:*) : *
      {
         close();
      }
      
      public static function upPage(param1:*) : *
      {
         if(yeshu > 1)
         {
            --yeshu;
         }
         showInit();
         showCard();
      }
      
      public static function downPage(param1:*) : *
      {
         if(yeshu < yeshu_max)
         {
            ++yeshu;
         }
         showInit();
         showCard();
      }
      
      public static function chosed(param1:*) : *
      {
         clickNum = int((param1.target as MovieClip).name.substr(1,2));
         showInit();
         showCard();
      }
      
      public static function lingqu(param1:*) : *
      {
         var _loc2_:int = 0;
         if(monsterSlot.getLqTimes() == 0)
         {
            if(Main.player1.getBag().backOtherBagNum() >= 2)
            {
               _loc2_ = 0;
               while(_loc2_ < 2)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63210));
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63203));
                  _loc2_++;
               }
               monsterSlot.addLqTimes();
               ShortTip.open(29);
            }
            else
            {
               ShortTip.open(3);
            }
         }
         else if(monsterSlot.getLqTimes() == 1)
         {
            if(Main.player1.getBag().backOtherBagNum() >= 2)
            {
               _loc2_ = 0;
               while(_loc2_ < 3)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63210));
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63203));
                  _loc2_++;
               }
               monsterSlot.addLqTimes();
               ShortTip.open(29);
            }
            else
            {
               ShortTip.open(3);
            }
         }
         else if(monsterSlot.getLqTimes() == 2)
         {
            if(Main.player1.getBag().backOtherBagNum() >= 2)
            {
               _loc2_ = 0;
               while(_loc2_ < 4)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63210));
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63203));
                  _loc2_++;
               }
               monsterSlot.addLqTimes();
               ShortTip.open(29);
            }
            else
            {
               ShortTip.open(3);
            }
         }
         else if(monsterSlot.getLqTimes() >= 3)
         {
            if(Main.player1.getBag().backOtherBagNum() >= 3)
            {
               _loc2_ = 0;
               while(_loc2_ < 5)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63210));
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63203));
                  _loc2_++;
               }
               Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
               monsterSlot.addLqTimes();
               ShortTip.open(29);
            }
            else
            {
               ShortTip.open(3);
            }
         }
         showInit();
         showCard();
      }
      
      private static function changeListen(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         switch(_loc2_.name)
         {
            case "b1":
               allFalse();
               cardPanel["b1"].isClick = true;
               break;
            case "b2":
               allFalse();
               cardPanel["b2"].isClick = true;
               break;
            case "b3":
               allFalse();
               cardPanel["b3"].isClick = true;
               break;
            case "b4":
               allFalse();
               cardPanel["b4"].isClick = true;
               break;
            case "b5":
               allFalse();
               cardPanel["b5"].isClick = true;
         }
      }
      
      public static function allFalse() : void
      {
         cardPanel["b1"].isClick = false;
         cardPanel["b2"].isClick = false;
         cardPanel["b3"].isClick = false;
         cardPanel["b4"].isClick = false;
         cardPanel["b5"].isClick = false;
      }
      
      private static function tipOpen(param1:*) : void
      {
         if(monsterSlot.getLqTimes() == 0)
         {
            cardPanel["tishi"]["msg_txt"].text = "获得封印的星灵财宝2个、洗练券2个";
         }
         else if(monsterSlot.getLqTimes() == 1)
         {
            cardPanel["tishi"]["msg_txt"].text = "获得封印的星灵财宝3个、洗练券3个";
         }
         else if(monsterSlot.getLqTimes() == 2)
         {
            cardPanel["tishi"]["msg_txt"].text = "获得封印的星灵财宝4个、洗练券4个";
         }
         else if(monsterSlot.getLqTimes() >= 3)
         {
            cardPanel["tishi"]["msg_txt"].text = "获得封印的星灵财宝5个、洗练券5个、击杀点礼包1个";
         }
         cardPanel["tishi"].visible = true;
      }
      
      private static function tipClose(param1:*) : void
      {
         cardPanel["tishi"].visible = false;
      }
      
      public static function addListenerP1() : *
      {
         cardPanel["tishi"].visible = false;
         cardPanel["lingqu_back"].addEventListener(MouseEvent.MOUSE_OVER,tipOpen);
         cardPanel["lingqu_back"].addEventListener(MouseEvent.MOUSE_OUT,tipClose);
         cardPanel.addEventListener(BtnEvent.DO_CHANGE,changeListen);
         cardPanel["lingqu"].addEventListener(MouseEvent.CLICK,lingqu);
         cardPanel["close"].addEventListener(MouseEvent.CLICK,closeCP);
         cardPanel["up"].addEventListener(MouseEvent.CLICK,upPage);
         cardPanel["down"].addEventListener(MouseEvent.CLICK,downPage);
         var _loc1_:uint = 0;
         while(_loc1_ < 9)
         {
            cardPanel["c" + _loc1_].addEventListener(MouseEvent.CLICK,chosed);
            cardPanel["c" + _loc1_].buttonMode = true;
            cardPanel["c" + _loc1_].mouseChildren = false;
            _loc1_++;
         }
         showInit();
         showCard();
      }
      
      public static function removeListenerP1() : *
      {
         cardPanel["lingqu_back"].removeEventListener(MouseEvent.MOUSE_OVER,tipOpen);
         cardPanel["lingqu_back"].removeEventListener(MouseEvent.MOUSE_OUT,tipClose);
         cardPanel.removeEventListener(BtnEvent.DO_CHANGE,changeListen);
         cardPanel["lingqu"].removeEventListener(MouseEvent.CLICK,lingqu);
         cardPanel["close"].removeEventListener(MouseEvent.CLICK,closeCP);
         cardPanel["up"].removeEventListener(MouseEvent.CLICK,upPage);
         cardPanel["down"].removeEventListener(MouseEvent.CLICK,downPage);
         var _loc1_:uint = 0;
         while(_loc1_ < 9)
         {
            cardPanel["c" + _loc1_].removeEventListener(MouseEvent.CLICK,chosed);
            _loc1_++;
         }
      }
      
      public static function showInit() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 9)
         {
            if(MonsterFactory.allData[_loc1_ + (yeshu - 1) * 9])
            {
               cardPanel["c" + _loc1_].gotoAndStop(MonsterFactory.allData[_loc1_ + (yeshu - 1) * 9].getFrame());
            }
            else
            {
               cardPanel["c" + _loc1_].gotoAndStop(1);
            }
            cardPanel["s" + _loc1_]["t0"].visible = false;
            cardPanel["s" + _loc1_]["t1"].visible = false;
            cardPanel["s" + _loc1_]["t2"].visible = false;
            _loc1_++;
         }
         if(MonsterFactory.allData[clickNum + (yeshu - 1) * 9])
         {
            cardPanel["chose"].gotoAndStop(MonsterFactory.allData[clickNum + (yeshu - 1) * 9].getFrame2());
         }
         yeshu_max = Math.ceil(MonsterFactory.allData.length / 9);
         cardPanel["count"].text = monsterSlot.getAllStarNum() + "/" + 30 * (monsterSlot.getLqTimes() + 1);
         cardPanel["ye_num"].text = yeshu + "/" + yeshu_max;
         cardPanel["att"].text = monsterSlot.getAllAttup();
         cardPanel["def"].text = monsterSlot.getAllDefup();
         cardPanel["hp"].text = monsterSlot.getAllHpup();
         cardPanel["mp"].text = monsterSlot.getAllMpup();
         cardPanel["crit"].text = monsterSlot.getAllCritup();
         cardPanel["select"].x = cardPanel["c" + clickNum].x;
         cardPanel["select"].y = cardPanel["c" + clickNum].y;
         var _loc2_:Number = Math.floor(monsterSlot.getAllStarNum() / 30);
         if(_loc2_ > monsterSlot.getLqTimes())
         {
            cardPanel["lingqu"].visible = true;
         }
         else
         {
            cardPanel["lingqu"].visible = false;
         }
      }
      
      public static function showCard() : *
      {
         var _loc2_:uint = 0;
         var _loc1_:* = 0;
         while(_loc1_ < monsterSlot.getMonsterSlotLength())
         {
            _loc2_ = 0;
            while(_loc2_ < 9)
            {
               if(MonsterFactory.allData[_loc2_ + (yeshu - 1) * 9])
               {
                  if(Boolean(monsterSlot.getMonsterSlotNum(_loc1_)) && monsterSlot.getMonsterSlotNum(_loc1_).getType() == MonsterFactory.allData[_loc2_ + (yeshu - 1) * 9].getType())
                  {
                     cardPanel["s" + _loc2_].visible = true;
                     if(monsterSlot.getMonsterSlotNum(_loc1_).getTimes() == 1)
                     {
                        cardPanel["s" + _loc2_]["t0"].visible = true;
                        cardPanel["s" + _loc2_]["t1"].visible = false;
                        cardPanel["s" + _loc2_]["t2"].visible = false;
                     }
                     else if(monsterSlot.getMonsterSlotNum(_loc1_).getTimes() == 2)
                     {
                        cardPanel["s" + _loc2_]["t0"].visible = true;
                        cardPanel["s" + _loc2_]["t1"].visible = true;
                        cardPanel["s" + _loc2_]["t2"].visible = false;
                     }
                     else if(monsterSlot.getMonsterSlotNum(_loc1_).getTimes() == 3)
                     {
                        cardPanel["s" + _loc2_]["t0"].visible = true;
                        cardPanel["s" + _loc2_]["t1"].visible = true;
                        cardPanel["s" + _loc2_]["t2"].visible = true;
                     }
                  }
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
   }
}

