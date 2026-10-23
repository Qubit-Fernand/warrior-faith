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
      
      public static var yeshu:int = 1;
      
      public static var yeshu_max:int = 1;
      
      public static var clickNum:int = 0;
      
      public function CardPanel()
      {
         super();
         var classRef:Class = ccc.getClass("CardShow") as Class;
         cardPanel = new classRef();
         this.addChild(cardPanel);
      }
      
      public static function open() : void
      {
         Main.DuoKai_Fun();
         Main.allClosePanel();
         if(cp == null)
         {
            if(!monsterSlot)
            {
               monsterSlot = MonsterSlot.creatMonsterSlot();
            }
            cp = new CardPanel();
         }
         Main.stopXX = true;
         cp.x = 0;
         cp.y = 0;
         addListenerP1();
         Main._stage.addChild(cp);
         cp.visible = true;
         monsterSlot.testMonsterSlot();
      }
      
      public static function close() : void
      {
         if(cp == null)
         {
            if(!monsterSlot)
            {
               monsterSlot = MonsterSlot.creatMonsterSlot();
            }
            cp = new CardPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         cp.visible = false;
         monsterSlot.testMonsterSlot();
      }
      
      public static function closeCP(e:*) : *
      {
         close();
      }
      
      public static function upPage(e:*) : *
      {
         if(yeshu > 1)
         {
            --yeshu;
         }
         showInit();
         showCard();
      }
      
      public static function downPage(e:*) : *
      {
         if(yeshu < yeshu_max)
         {
            ++yeshu;
         }
         showInit();
         showCard();
      }
      
      public static function chosed(e:*) : *
      {
         clickNum = int((e.target as MovieClip).name.substr(1,2));
         showInit();
         showCard();
      }
      
      public static function lingqu(e:*) : *
      {
         var i:int = 0;
         if(monsterSlot.getLqTimes() == 0)
         {
            if(Main.player1.getBag().backOtherBagNum() >= 2)
            {
               for(i = 0; i < 2; i++)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63210));
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63203));
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
               for(i = 0; i < 3; i++)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63210));
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63203));
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
               for(i = 0; i < 4; i++)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63210));
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63203));
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
               for(i = 0; i < 5; i++)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63210));
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63203));
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
      
      private static function changeListen(e:BtnEvent) : void
      {
         var btn:MovieClip = e.target as MovieClip;
         switch(btn.name)
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
      
      private static function tipOpen(e:*) : void
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
      
      private static function tipClose(e:*) : void
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
         for(var i:uint = 0; i < 9; i++)
         {
            cardPanel["c" + i].addEventListener(MouseEvent.CLICK,chosed);
            cardPanel["c" + i].buttonMode = true;
            cardPanel["c" + i].mouseChildren = false;
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
         for(var i:uint = 0; i < 9; i++)
         {
            cardPanel["c" + i].removeEventListener(MouseEvent.CLICK,chosed);
         }
      }
      
      public static function showInit() : *
      {
         for(var i:uint = 0; i < 9; i++)
         {
            if(MonsterFactory.allData[i + (yeshu - 1) * 9])
            {
               cardPanel["c" + i].gotoAndStop(MonsterFactory.allData[i + (yeshu - 1) * 9].getFrame());
            }
            else
            {
               cardPanel["c" + i].gotoAndStop(1);
            }
            cardPanel["s" + i]["t0"].visible = false;
            cardPanel["s" + i]["t1"].visible = false;
            cardPanel["s" + i]["t2"].visible = false;
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
         var pass:Number = Math.floor(monsterSlot.getAllStarNum() / 30);
         trace("a =  = " + pass);
         trace(" monsterSlot.getLqTimes() =  = " + monsterSlot.getLqTimes());
         if(pass > monsterSlot.getLqTimes())
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
         var i:uint = 0;
         for(var j:* = 0; j < monsterSlot.getMonsterSlotLength(); j++)
         {
            for(i = 0; i < 9; i++)
            {
               if(MonsterFactory.allData[i + (yeshu - 1) * 9])
               {
                  if(Boolean(monsterSlot.getMonsterSlotNum(j)) && monsterSlot.getMonsterSlotNum(j).getType() == MonsterFactory.allData[i + (yeshu - 1) * 9].getType())
                  {
                     cardPanel["s" + i].visible = true;
                     if(monsterSlot.getMonsterSlotNum(j).getTimes() == 1)
                     {
                        cardPanel["s" + i]["t0"].visible = true;
                        cardPanel["s" + i]["t1"].visible = false;
                        cardPanel["s" + i]["t2"].visible = false;
                     }
                     else if(monsterSlot.getMonsterSlotNum(j).getTimes() == 2)
                     {
                        cardPanel["s" + i]["t0"].visible = true;
                        cardPanel["s" + i]["t1"].visible = true;
                        cardPanel["s" + i]["t2"].visible = false;
                     }
                     else if(monsterSlot.getMonsterSlotNum(j).getTimes() == 3)
                     {
                        cardPanel["s" + i]["t0"].visible = true;
                        cardPanel["s" + i]["t1"].visible = true;
                        cardPanel["s" + i]["t2"].visible = true;
                     }
                  }
               }
            }
         }
      }
   }
}

