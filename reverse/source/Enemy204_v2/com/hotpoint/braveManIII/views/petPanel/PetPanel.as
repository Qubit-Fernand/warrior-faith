package com.hotpoint.braveManIII.views.petPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.pet.Pet;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.pet.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class PetPanel extends MovieClip
   {
      
      public static var choseNum:int;
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var petp:PetPanel;
      
      public static var clickObj:MovieClip;
      
      public static var WXOK:Boolean = false;
      
      public static var JNOK:Boolean = false;
      
      public static var SJOK:Boolean = false;
      
      public static var lwNum:int = 0;
      
      public static var jnNum:int = 0;
      
      public static var time_1:Array = [2400,2400,2400,2400,2400,2400,2400,2400,2400,2400];
      
      public static var time_2:Array = [2400,2400,2400,2400,2400,2400,2400,2400,2400,2400];
      
      public static var temp:int = 0;
      
      public static var temp2:int = 0;
      
      public static var tempFood:int = 0;
      
      public static var tempFood2:int = 0;
      
      public static var petPanel:MovieClip = new PetShow();
      
      public static var isPOne:Boolean = true;
      
      public static var clickNum:Number = 0;
      
      public function PetPanel()
      {
         super();
         petPanel["sxcz"].visible = false;
         petPanel["sxwx"].visible = false;
         petPanel["kssj"].visible = false;
         petPanel["sxatt"].visible = false;
         petPanel["sxdef"].visible = false;
         petPanel["sxcrit"].visible = false;
         petPanel["sxlife"].visible = false;
         petPanel["lw0"].visible = false;
         petPanel["lw1"].visible = false;
         petPanel["lw2"].visible = false;
         petPanel["lw3"].visible = false;
         petPanel["jn0"].visible = false;
         petPanel["jn1"].visible = false;
         petPanel["jn2"].visible = false;
         petPanel["jn3"].visible = false;
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(petPanel);
         petPanel["bagOne"].visible = false;
         petPanel["bagTwo"].visible = false;
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         if(petp == null)
         {
            petp = new PetPanel();
         }
         Main.stopXX = true;
         petp.x = 0;
         petp.y = 0;
         addListenerP1();
         petPanel["bagOne"].visible = false;
         petPanel["bagTwo"].visible = false;
         if(Main.P1P2)
         {
            petPanel["bagOne"].visible = true;
            petPanel["bagTwo"].visible = true;
            oneShow();
         }
         Main._stage.addChild(petp);
         petp.visible = true;
      }
      
      public static function close() : void
      {
         var i:int = 0;
         if(petp == null)
         {
            petp = new PetPanel();
         }
         addFoodTime();
         isPOne = true;
         if(Main.player1.playerCW_Data)
         {
            for(i = 0; i < Main.player1.getPetSlot().getPetSlotNum(); i++)
            {
               if(Boolean(Main.player1.getPetSlot().getPetFromSlot(i)) && Main.player1.playerCW_Data == Main.player1.getPetSlot().getPetFromSlot(i))
               {
                  clickNum = i;
                  break;
               }
            }
         }
         else
         {
            clickNum = 0;
         }
         Main.stopXX = false;
         removeListenerP1();
         petp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var i:uint = 0;
         petPanel["jntip"].visible = false;
         petPanel["isLW"].visible = false;
         petPanel["isFS"].visible = false;
         petPanel["menu"].visible = false;
         petPanel["rmbWX"].visible = false;
         petPanel["rmbJN"].visible = false;
         petPanel["rmbSJ"].visible = false;
         petPanel["touming"].visible = false;
         petPanel["NoMoney_mc"].visible = false;
         petPanel["kssj"].addEventListener(MouseEvent.CLICK,kssj);
         petPanel["sxwx"].addEventListener(MouseEvent.CLICK,shuaWX);
         petPanel["jinhua"].addEventListener(MouseEvent.CLICK,jinhua);
         petPanel["menu"]["fuhua"].addEventListener(MouseEvent.CLICK,fuhua);
         petPanel["NoMoney_mc"]["yes_btn"].addEventListener(MouseEvent.CLICK,closeNORMB);
         petPanel["NoMoney_mc"]["addMoney_btn"].addEventListener(MouseEvent.CLICK,addMoney_btn);
         petPanel["isLW"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesLW);
         petPanel["isLW"]["no_btn"].addEventListener(MouseEvent.CLICK,noLW);
         petPanel["isFS"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesFS);
         petPanel["isFS"]["no_btn"].addEventListener(MouseEvent.CLICK,noFS);
         petPanel["rmbWX"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesWX);
         petPanel["rmbWX"]["no_btn"].addEventListener(MouseEvent.CLICK,noWX);
         petPanel["rmbJN"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesJN);
         petPanel["rmbJN"]["no_btn"].addEventListener(MouseEvent.CLICK,noJN);
         petPanel["rmbSJ"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesSJ);
         petPanel["rmbSJ"]["no_btn"].addEventListener(MouseEvent.CLICK,noSJ);
         petPanel.addEventListener(Event.ENTER_FRAME,timeFunction);
         petPanel.addEventListener(BtnEvent.DO_CLICK,petDo);
         petPanel.addEventListener(BtnEvent.DO_CHANGE,bagListen);
         petPanel["close1"].addEventListener(MouseEvent.CLICK,closePet);
         petPanel["close2"].addEventListener(MouseEvent.CLICK,closePet);
         for(i = 0; i < 4; i++)
         {
            petPanel["jn" + i].buttonMode = true;
            petPanel["lw" + i].addEventListener(MouseEvent.CLICK,lingwu);
            petPanel["jn" + i].addEventListener(MouseEvent.CLICK,shuaJN);
            petPanel["jn" + i].addEventListener(MouseEvent.MOUSE_OVER,openTip);
            petPanel["jn" + i].addEventListener(MouseEvent.MOUSE_OUT,closeTip);
         }
         for(i = 0; i < 24; i++)
         {
            petPanel["e" + i].mouseChildren = false;
            petPanel["e" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            petPanel["e" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            petPanel["e" + i].addEventListener(MouseEvent.CLICK,choseFH);
         }
         for(i = 0; i < 10; i++)
         {
            petPanel["p" + i].mouseChildren = false;
            petPanel["p" + i].addEventListener(MouseEvent.CLICK,chosePet);
         }
         oneShow();
      }
      
      private static function closeNORMB(e:*) : void
      {
         petPanel["NoMoney_mc"].visible = false;
      }
      
      private static function addMoney_btn(e:*) : void
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      private static function openTip(e:*) : void
      {
         petPanel["jntip"].visible = true;
         petPanel["jntip"].x = petPanel.mouseX + 10;
         petPanel["jntip"].y = petPanel.mouseY;
         var overNum:int = int(e.target.name.substr(2,1));
         if(isPOne)
         {
            petPanel["jntip"]["str_name"].text = Main.player1.getPetSlot().getPetFromSlot(clickNum).getPetSkillNum(overNum).getSkillName();
            petPanel["jntip"]["str_text"].text = Main.player1.getPetSlot().getPetFromSlot(clickNum).getPetSkillNum(overNum).getIntroduction();
         }
         else
         {
            petPanel["jntip"]["str_name"].text = Main.player2.getPetSlot().getPetFromSlot(clickNum).getPetSkillNum(overNum).getSkillName();
            petPanel["jntip"]["str_text"].text = Main.player2.getPetSlot().getPetFromSlot(clickNum).getPetSkillNum(overNum).getIntroduction();
         }
      }
      
      private static function closeTip(e:*) : void
      {
         petPanel["jntip"].visible = false;
      }
      
      private static function timeFunction(e:*) : void
      {
         var i:uint = 0;
         if(isPOne)
         {
            petPanel["time_txt"].text = "孵化剩余时间:" + int(time_1[clickNum] / 60) + "分" + time_1[clickNum] % 60 + "秒";
         }
         else
         {
            petPanel["time_txt"].text = "孵化剩余时间:" + int(time_2[clickNum] / 60) + "分" + time_2[clickNum] % 60 + "秒";
         }
         if(Main.player1.getPetSlot().getPetFromSlot(0) == null)
         {
            return;
         }
         for(i = 0; i < Main.player1.getPetSlot().getPetSlotNum(); i++)
         {
            if(Main.player1.getPetSlot().getPetFromSlot(i) != null)
            {
               if(Main.player1.getPetSlot().getPetFromSlot(i).getType() == 2)
               {
                  ++temp;
                  if(temp >= 27)
                  {
                     --time_1[i];
                     temp = 0;
                     if(time_1[i] <= 0)
                     {
                        Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(Main.player1.getPetSlot().delPetSlot(i).getLink()));
                        time_1[i] = 2400;
                        showPetAll(Main.player1.getPetSlot().getPetFromSlot(i));
                        oneShow();
                     }
                  }
               }
            }
         }
         if(!Main.P1P2)
         {
            return;
         }
         for(i = 0; i < Main.player2.getPetSlot().getPetSlotNum(); i++)
         {
            if(Main.player2.getPetSlot().getPetFromSlot(i) != null)
            {
               if(Main.player2.getPetSlot().getPetFromSlot(i).getType() == 2)
               {
                  ++temp2;
                  if(temp2 >= 27)
                  {
                     --time_2[i];
                     temp2 = 0;
                     if(time_2[i] <= 0)
                     {
                        Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(Main.player2.getPetSlot().delPetSlot(i).getLink()));
                        time_2[i] = 2400;
                        showPetAll(Main.player2.getPetSlot().getPetFromSlot(i));
                        twoShow();
                     }
                  }
               }
            }
         }
      }
      
      private static function foodTime(e:*) : void
      {
         ++tempFood;
         if(tempFood % 1134 == 0)
         {
            if(Main.player1.playerCW_Data)
            {
               Main.player1.playerCW_Data.setFood(-1);
               if(Main.player1.playerCW_Data.getFood() <= 0)
               {
                  Main.player_1.playerCW.Close();
               }
            }
            if(Boolean(Main.P1P2) && Boolean(Main.player2.playerCW_Data))
            {
               Main.player2.playerCW_Data.setFood(-1);
               if(Main.player2.playerCW_Data.getFood() <= 0)
               {
                  Main.player_2.playerCW.Close();
               }
            }
            if(isPOne)
            {
               if(Main.player1.getPetSlot().getPetFromSlot(clickNum))
               {
                  petPanel["food"].text = Main.player1.getPetSlot().getPetFromSlot(clickNum).getFood();
               }
            }
            else if(Main.player2.getPetSlot().getPetFromSlot(clickNum))
            {
               petPanel["food"].text = Main.player2.getPetSlot().getPetFromSlot(clickNum).getFood();
            }
         }
      }
      
      private static function jinhua(e:*) : void
      {
         var pet:Pet = null;
         if(isPOne)
         {
            if(Main.player1.getBag().getOtherobjNum(63160) > 1)
            {
               Main.player1.getBag().delOtherById(63160,2);
               pet = Main.player1.getPetSlot().delPetSlot(clickNum);
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(pet.getEvolution()));
               if(pet == Main.player1.playerCW_Data)
               {
                  Main.player_1.playerCW.Close();
                  Main.player_1.NewCW(Main.player1.getPetSlot().getPetFromSlot(clickNum));
               }
               oneShow();
            }
            else
            {
               ShortTip.open(41);
            }
         }
         else if(Main.player2.getBag().getOtherobjNum(63160) > 1)
         {
            Main.player2.getBag().delOtherById(63160,2);
            pet = Main.player2.getPetSlot().delPetSlot(clickNum);
            Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(pet.getEvolution()));
            if(pet == Main.player2.playerCW_Data)
            {
               Main.player_2.playerCW.Close();
               Main.player_2.NewCW(Main.player2.getPetSlot().getPetFromSlot(clickNum));
            }
            twoShow();
         }
         else
         {
            ShortTip.open(41);
         }
      }
      
      private static function petDo(e:*) : void
      {
         var btn:MovieClip = e.target as MovieClip;
         switch(btn.name)
         {
            case "setFood":
               setFood();
               break;
            case "chuzhan":
               chuzhan();
               break;
            case "zhaohui":
               zhaohui();
               break;
            case "fangsheng":
               fangsheng();
         }
      }
      
      private static function zhaohui() : *
      {
         if(isPOne)
         {
            Main.player_1.playerCW.Close();
            petPanel["chuzhan"].visible = true;
         }
         else
         {
            Main.player_2.playerCW.Close();
            petPanel["chuzhan"].visible = true;
         }
      }
      
      private static function chuzhan() : *
      {
         if(isPOne)
         {
            if(Main.player1.getPetSlot().getPetFromSlot(clickNum).getFood() > 0)
            {
               Main.player_1.NewCW(Main.player1.getPetSlot().getPetFromSlot(clickNum));
               petPanel["chuzhan"].visible = false;
               petPanel["zhaohui"].visible = true;
            }
         }
         else if(Main.player2.getPetSlot().getPetFromSlot(clickNum).getFood() > 0)
         {
            Main.player_2.NewCW(Main.player2.getPetSlot().getPetFromSlot(clickNum));
            petPanel["chuzhan"].visible = false;
            petPanel["zhaohui"].visible = true;
         }
      }
      
      public static function addFoodTime() : *
      {
         petPanel.addEventListener(Event.ENTER_FRAME,foodTime);
      }
      
      private static function yesSJ(e:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 20)
         {
            Api_4399_All.Money_down(InitData.wuXingJiNeng.getValue());
            SJOK = true;
            petPanel["rmbSJ"].visible = false;
            petPanel["touming"].visible = true;
         }
         else
         {
            petPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function noSJ(e:*) : *
      {
         petPanel["rmbSJ"].visible = false;
      }
      
      private static function yesJN(e:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 20)
         {
            Api_4399_All.Money_down(InitData.wuXingJiNeng.getValue());
            JNOK = true;
            petPanel["rmbJN"].visible = false;
            petPanel["touming"].visible = true;
         }
         else
         {
            petPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function noJN(e:*) : *
      {
         petPanel["rmbJN"].visible = false;
      }
      
      private static function yesWX(e:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 20)
         {
            Api_4399_All.Money_down(InitData.wuXingJiNeng.getValue());
            WXOK = true;
            petPanel["touming"].visible = true;
            petPanel["rmbWX"].visible = false;
         }
         else
         {
            petPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function noWX(e:*) : *
      {
         petPanel["rmbWX"].visible = false;
      }
      
      private static function yesLW(e:*) : *
      {
         if(isPOne)
         {
            if(Main.player1.getGold() >= 100000)
            {
               Main.player1.getPetSlot().getPetFromSlot(clickNum).setSkill(lwNum);
               Main.player1.payGold(100000);
               oneShow();
               Main.Save();
            }
            else
            {
               ShortTip.open(16);
            }
         }
         else if(Main.player2.getGold() >= 100000)
         {
            Main.player2.getPetSlot().getPetFromSlot(clickNum).setSkill(lwNum);
            Main.player2.payGold(100000);
            twoShow();
            Main.Save();
         }
         else
         {
            ShortTip.open(16);
         }
         petPanel["isLW"].visible = false;
      }
      
      private static function noLW(e:*) : *
      {
         petPanel["isLW"].visible = false;
      }
      
      private static function lingwu(e:*) : *
      {
         lwNum = int(e.target.name.substr(2,2));
         petPanel["isLW"].visible = true;
      }
      
      private static function yesFS(e:*) : *
      {
         if(isPOne)
         {
            if(Main.player1.getPetSlot().getPetFromSlot(clickNum) == Main.player1.playerCW_Data)
            {
               Main.player_1.playerCW.Close();
            }
            Main.player1.getPetSlot().delPetSlot(clickNum);
            time_1[clickNum] = 2400;
            oneShow();
         }
         else
         {
            if(Main.player2.getPetSlot().getPetFromSlot(clickNum) == Main.player2.playerCW_Data)
            {
               Main.player_2.playerCW.Close();
            }
            Main.player2.getPetSlot().delPetSlot(clickNum);
            time_2[clickNum] = 2400;
            twoShow();
         }
         petPanel["isFS"].visible = false;
      }
      
      private static function noFS(e:*) : *
      {
         petPanel["isFS"].visible = false;
      }
      
      private static function fangsheng() : *
      {
         petPanel["isFS"].visible = true;
      }
      
      private static function kssj(e:*) : *
      {
         petPanel["rmbSJ"].visible = true;
      }
      
      public static function sjrmbOK() : *
      {
         if(SJOK)
         {
            if(isPOne)
            {
               Main.player1.getPetSlot().getPetFromSlot(clickNum).addExp(9999);
               oneShow();
            }
            else
            {
               Main.player2.getPetSlot().getPetFromSlot(clickNum).addExp(9999);
               twoShow();
            }
            petPanel["touming"].visible = false;
            Main.Save();
            ShortTip.open(35);
            SJOK = false;
         }
      }
      
      private static function shuaWX(e:*) : *
      {
         petPanel["rmbWX"].visible = true;
      }
      
      public static function wxrmbOK() : *
      {
         if(WXOK)
         {
            if(isPOne)
            {
               Main.player1.getPetSlot().getPetFromSlot(clickNum).setWX();
               oneShow();
            }
            else
            {
               Main.player2.getPetSlot().getPetFromSlot(clickNum).setWX();
               twoShow();
            }
            petPanel["touming"].visible = false;
            Main.Save();
            ShortTip.open(35);
            WXOK = false;
         }
      }
      
      private static function shuaJN(e:*) : *
      {
         petPanel["rmbJN"].visible = true;
         jnNum = int(e.target.name.substr(2,2));
      }
      
      public static function jnrmbOK() : *
      {
         if(JNOK)
         {
            if(isPOne)
            {
               Main.player1.getPetSlot().getPetFromSlot(clickNum).setSkill(jnNum);
               oneShow();
            }
            else
            {
               Main.player2.getPetSlot().getPetFromSlot(clickNum).setSkill(jnNum);
               twoShow();
            }
            petPanel["touming"].visible = false;
            ShortTip.open(35);
            Main.Save();
            JNOK = false;
         }
      }
      
      private static function setFood() : *
      {
         if(isPOne)
         {
            if(Main.player1.getBag().getOtherobjNum(63148) > 0)
            {
               if(Main.player1.getPetSlot().getPetFromSlot(clickNum).getFood() < 100)
               {
                  Main.player1.getPetSlot().getPetFromSlot(clickNum).setFood(OtherFactory.creatOther(63148).getValue_1());
                  Main.player1.getBag().delOtherById(63148,1);
               }
            }
            else
            {
               ShortTip.open(36);
            }
            oneShow();
            showPetAll(Main.player1.getPetSlot().getPetFromSlot(clickNum));
         }
         else
         {
            if(Main.player2.getBag().getOtherobjNum(63148) > 0)
            {
               if(Main.player2.getPetSlot().getPetFromSlot(clickNum).getFood() < 100)
               {
                  Main.player2.getPetSlot().getPetFromSlot(clickNum).setFood(OtherFactory.creatOther(63148).getValue_1());
                  Main.player2.getBag().delOtherById(63148,1);
               }
            }
            else
            {
               ShortTip.open(36);
            }
            twoShow();
            showPetAll(Main.player2.getPetSlot().getPetFromSlot(clickNum));
         }
      }
      
      private static function bagListen(e:*) : void
      {
         var btn:MovieClip = e.target as MovieClip;
         switch(btn.name)
         {
            case "bagOne":
               isPOne = true;
               clickNum = 0;
               oneShow();
               break;
            case "bagTwo":
               isPOne = false;
               clickNum = 0;
               twoShow();
         }
      }
      
      public static function showOtherBagP1() : *
      {
         isPOne = true;
         for(var i:int = 0; i < 24; i++)
         {
            petPanel["e" + i].t_txt.text = "";
            if(Main.player1.getBag().getOtherobjFromBag(i) != null)
            {
               petPanel["e" + i].gotoAndStop(Main.player1.getBag().getOtherobjFromBag(i).getFrame());
               petPanel["e" + i].visible = true;
               if(Main.player1.getBag().getOtherobjFromBag(i).getTimes() > 1)
               {
                  petPanel["e" + i].t_txt.text = Main.player1.getBag().getOtherobjFromBag(i).getTimes();
               }
            }
            else
            {
               petPanel["e" + i].visible = false;
            }
         }
      }
      
      public static function showOtherBagP2() : *
      {
         isPOne = false;
         for(var i:int = 0; i < 24; i++)
         {
            petPanel["e" + i].t_txt.text = "";
            if(Main.player2.getBag().getOtherobjFromBag(i) != null)
            {
               petPanel["e" + i].gotoAndStop(Main.player2.getBag().getOtherobjFromBag(i).getFrame());
               petPanel["e" + i].visible = true;
               if(Main.player2.getBag().getOtherobjFromBag(i).getTimes() > 1)
               {
                  petPanel["e" + i].t_txt.text = Main.player2.getBag().getOtherobjFromBag(i).getTimes();
               }
            }
            else
            {
               petPanel["e" + i].visible = false;
            }
         }
      }
      
      public static function showPetP1() : *
      {
         for(var i:int = 0; i < 10; i++)
         {
            if(Main.player1.getPetSlot().getPetFromSlot(i) != null)
            {
               petPanel["p" + i].gotoAndStop(Main.player1.getPetSlot().getPetFromSlot(i).getFrame());
               petPanel["p" + i].visible = true;
            }
            else
            {
               petPanel["p" + i].visible = false;
            }
         }
         for(i = 3; i < 10; i++)
         {
            if(Main.player1.getPetSlot().getPetSlotNum() > i)
            {
               petPanel["lock_" + i].visible = false;
            }
            else
            {
               petPanel["lock_" + i].visible = true;
            }
         }
         if(Main.player1.getPetSlot().backPetNum() > 0)
         {
            petPanel["select"].visible = true;
            petPanel["chose"].visible = true;
            while(1)
            {
               if(Main.player1.getPetSlot().getPetFromSlot(clickNum))
               {
                  petPanel["chose"].x = petPanel["p" + clickNum].x - 8;
                  petPanel["chose"].y = petPanel["p" + clickNum].y - 4;
                  petPanel["select"].gotoAndStop(Main.player1.getPetSlot().getPetFromSlot(clickNum).getFrame());
                  showPetAll(Main.player1.getPetSlot().getPetFromSlot(clickNum));
                  break;
               }
               ++clickNum;
               if(clickNum > Main.player1.getPetSlot().getPetSlotNum())
               {
                  clickNum = 0;
               }
            }
         }
         else
         {
            AllPetFalse();
            petPanel["chose"].visible = false;
            petPanel["select"].visible = false;
         }
      }
      
      public static function showPetP2() : *
      {
         for(var i:int = 0; i < 10; i++)
         {
            if(Main.player2.getPetSlot().getPetFromSlot(i) != null)
            {
               petPanel["p" + i].gotoAndStop(Main.player2.getPetSlot().getPetFromSlot(i).getFrame());
               petPanel["p" + i].visible = true;
            }
            else
            {
               petPanel["p" + i].visible = false;
            }
         }
         for(i = 3; i < 10; i++)
         {
            if(Main.player2.getPetSlot().getPetSlotNum() > i)
            {
               petPanel["lock_" + i].visible = false;
            }
            else
            {
               petPanel["lock_" + i].visible = true;
            }
         }
         if(Main.player2.getPetSlot().backPetNum() > 0)
         {
            petPanel["select"].visible = true;
            petPanel["chose"].visible = true;
            while(1)
            {
               if(Main.player2.getPetSlot().getPetFromSlot(clickNum))
               {
                  petPanel["chose"].x = petPanel["p" + clickNum].x - 8;
                  petPanel["chose"].y = petPanel["p" + clickNum].y - 4;
                  petPanel["select"].gotoAndStop(Main.player2.getPetSlot().getPetFromSlot(clickNum).getFrame());
                  showPetAll(Main.player2.getPetSlot().getPetFromSlot(clickNum));
                  break;
               }
               ++clickNum;
               if(clickNum > Main.player2.getPetSlot().getPetSlotNum())
               {
                  clickNum = 0;
               }
            }
         }
         else
         {
            AllPetFalse();
            petPanel["chose"].visible = false;
            petPanel["select"].visible = false;
         }
      }
      
      public static function AllPetFalse() : *
      {
         showLV(0);
         petPanel["explain"].text = "未知";
         petPanel["food"].text = "未知";
         petPanel["lv_txt"].text = "未知";
         petPanel["wx_txt"].text = "未知";
         petPanel["exp"].text = "未知";
         petPanel["txt_att"].text = "未知";
         petPanel["txt_def"].text = "未知";
         petPanel["txt_crit"].text = "未知";
         petPanel["txt_life"].text = "未知";
         petPanel["setFood"].visible = false;
         petPanel["kssj"].visible = false;
         petPanel["time_txt"].visible = false;
         petPanel["chuzhan"].visible = false;
         petPanel["zhaohui"].visible = false;
         petPanel["fangsheng"].visible = false;
         petPanel["jinhua"].visible = false;
         petPanel["sxwx"].visible = false;
         petPanel["lw0"].visible = false;
         petPanel["lw1"].visible = false;
         petPanel["lw2"].visible = false;
         petPanel["lw3"].visible = false;
         petPanel["jn0"].visible = false;
         petPanel["jn1"].visible = false;
         petPanel["jn2"].visible = false;
         petPanel["jn3"].visible = false;
      }
      
      public static function showPetAll(pet:Pet) : *
      {
         var arr:Array = null;
         var i:int = 0;
         if(pet.getType() == 1)
         {
            petPanel["setFood"].visible = true;
            petPanel["time_txt"].visible = false;
            petPanel["chuzhan"].visible = true;
            petPanel["zhaohui"].visible = true;
            if(pet.getLv() < pet.getLvLimit())
            {
               petPanel["kssj"].visible = true;
            }
            else
            {
               petPanel["kssj"].visible = false;
            }
            petPanel["fangsheng"].visible = true;
            if(Main.P1P2)
            {
               if(pet == Main.player1.playerCW_Data || pet == Main.player2.playerCW_Data)
               {
                  petPanel["chuzhan"].visible = false;
               }
               else
               {
                  petPanel["chuzhan"].visible = true;
               }
            }
            else if(pet == Main.player1.playerCW_Data)
            {
               petPanel["chuzhan"].visible = false;
            }
            else
            {
               petPanel["chuzhan"].visible = true;
            }
         }
         else
         {
            petPanel["setFood"].visible = false;
            petPanel["time_txt"].visible = true;
            petPanel["chuzhan"].visible = false;
            petPanel["zhaohui"].visible = false;
            petPanel["kssj"].visible = false;
            petPanel["fangsheng"].visible = true;
         }
         if(pet.getEvolutionLV() != -1 && pet.getLv() >= pet.getEvolutionLV())
         {
            petPanel["jinhua"].visible = true;
         }
         else
         {
            petPanel["jinhua"].visible = false;
         }
         petPanel["lw0"].visible = false;
         petPanel["lw1"].visible = false;
         petPanel["lw2"].visible = false;
         petPanel["lw3"].visible = false;
         petPanel["jn0"].visible = false;
         petPanel["jn1"].visible = false;
         petPanel["jn2"].visible = false;
         petPanel["jn3"].visible = false;
         if(pet.getPetSkill().length > 0)
         {
            arr = pet.getPetSkill();
            for(i in arr)
            {
               if(arr[i] == 0)
               {
                  petPanel["lw" + i].visible = true;
               }
               else
               {
                  petPanel["lw" + i].visible = false;
               }
               if(arr[i] > 0)
               {
                  petPanel["jn" + i].visible = true;
                  petPanel["jn" + i].gotoAndStop(SkillFactory.getSkillById(arr[i]).getFrame());
               }
               else
               {
                  petPanel["jn" + i].visible = false;
               }
            }
         }
         if(pet.getWX() > 0 && pet.getWX() < 4)
         {
            petPanel["sxwx"].visible = true;
         }
         else
         {
            petPanel["sxwx"].visible = false;
         }
         showLV(pet.getLv());
         petPanel["explain"].text = pet.getIntroduction();
         petPanel["food"].text = pet.getFood();
         petPanel["wx_txt"].text = pet.getWX();
         petPanel["lv_txt"].text = pet.getLvLimit() + "(可升至" + pet.getLvLimit() + "级)";
         petPanel["exp"].text = pet.getExp() + "/" + PetFactory.all_LVData_vt[pet.getLv()].getValue();
         petPanel["txt_att"].text = "为玩家增加攻击力" + (pet.getAtt() * 100).toFixed(2) + "%";
         petPanel["txt_def"].text = "为玩家增加防御力" + (pet.getDef() * 100).toFixed(2) + "%";
         petPanel["txt_crit"].text = "为玩家增加暴击率" + (pet.getCrit() * 100).toFixed(2) + "%";
         petPanel["txt_life"].text = "为玩家增加血量" + (pet.getLife() * 100).toFixed(2) + "%";
         if(pet.getAtt() == 0)
         {
            ColorX(petPanel["txt_att"],"0x999999");
         }
         if(pet.getDef() == 0)
         {
            ColorX(petPanel["txt_def"],"0x999999");
         }
         if(pet.getCrit() == 0)
         {
            ColorX(petPanel["txt_crit"],"0x999999");
         }
         if(pet.getLife() == 0)
         {
            ColorX(petPanel["txt_life"],"0x999999");
         }
      }
      
      private static function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      public static function chosePet(e:*) : *
      {
         clickObj = e.target as MovieClip;
         petPanel["chose"].visible = true;
         petPanel["chose"].x = clickObj.x - 8;
         petPanel["chose"].y = clickObj.y - 4;
         clickNum = uint(clickObj.name.substr(1,2));
         petPanel["select"].gotoAndStop(clickObj.currentFrame);
         petPanel["select"].visible = true;
         if(isPOne)
         {
            if(Main.player1.getPetSlot().getPetFromSlot(clickNum))
            {
               showPetAll(Main.player1.getPetSlot().getPetFromSlot(clickNum));
            }
         }
         else if(Main.player2.getPetSlot().getPetFromSlot(clickNum))
         {
            showPetAll(Main.player2.getPetSlot().getPetFromSlot(clickNum));
         }
      }
      
      public static function removeListenerP1() : *
      {
         var i:uint = 0;
         petPanel["isFS"]["yes_btn"].removeEventListener(MouseEvent.CLICK,yesFS);
         petPanel["isFS"]["no_btn"].removeEventListener(MouseEvent.CLICK,noFS);
         petPanel.removeEventListener(BtnEvent.DO_CLICK,petDo);
         petPanel.removeEventListener(BtnEvent.DO_CHANGE,bagListen);
         petPanel["close1"].removeEventListener(MouseEvent.CLICK,closePet);
         petPanel["close2"].removeEventListener(MouseEvent.CLICK,closePet);
         for(i = 0; i < 24; i++)
         {
            petPanel["e" + i].mouseChildren = false;
            petPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            petPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         }
         for(i = 0; i < 10; i++)
         {
            petPanel["p" + i].removeEventListener(MouseEvent.CLICK,chosePet);
         }
      }
      
      public static function oneShow() : void
      {
         petPanel["bagTwo"].isClick = false;
         petPanel["bagOne"].isClick = true;
         showPetP1();
         showOtherBagP1();
         petPanel["gold"].text = Main.player1.getGold();
         petPanel["jsd"].text = Main.player1.killPoint.getValue();
      }
      
      public static function twoShow() : void
      {
         petPanel["bagTwo"].isClick = true;
         petPanel["bagOne"].isClick = false;
         showPetP2();
         showOtherBagP2();
         petPanel["gold"].text = Main.player2.getGold();
         petPanel["jsd"].text = Main.player2.killPoint.getValue();
      }
      
      private static function showLV(level:Number) : *
      {
         var str:String = null;
         var left:int = 0;
         var right:int = 0;
         if(level < 10)
         {
            petPanel["shiwei"].gotoAndStop(level);
            petPanel["gewei"].visible = false;
         }
         else
         {
            petPanel["gewei"].visible = true;
            str = level.toString();
            left = int(str.substring(0,1));
            right = int(str.substring(1,2));
            petPanel["shiwei"].gotoAndStop(left);
            if(right == 0)
            {
               petPanel["gewei"].gotoAndStop(10);
            }
            else
            {
               petPanel["gewei"].gotoAndStop(right);
            }
         }
      }
      
      public static function closePet(e:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         petPanel.addChild(itemsTooltip);
         var overNum:uint = uint(overobj.name.substr(1,2));
         var str:String = overobj.name.substr(0,1);
         if(isPOne)
         {
            if(str == "e")
            {
               if(Main.player1.getBag().getOtherobjFromBag(overNum) != null)
               {
                  itemsTooltip.otherTooltip(Main.player1.getBag().getOtherobjFromBag(overNum));
               }
            }
         }
         else if(str == "e")
         {
            if(Main.player2.getBag().getOtherobjFromBag(overNum) != null)
            {
               itemsTooltip.otherTooltip(Main.player2.getBag().getOtherobjFromBag(overNum));
            }
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = petPanel.mouseX + 10;
         itemsTooltip.y = petPanel.mouseY;
         itemsTooltip.setTooltipPoint();
         petPanel["menu"].visible = false;
      }
      
      private static function tooltipClose(e:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      public static function choseFH(e:*) : *
      {
         choseNum = uint((e.target as MovieClip).name.substr(1,2));
         if(isPOne)
         {
            if(Main.player1.getBag().getOtherobjFromBag(choseNum).getIsUse() == 4)
            {
               petPanel["menu"].visible = true;
               petPanel["menu"].x = petPanel.mouseX + 5;
               petPanel["menu"].y = petPanel.mouseY + 5;
            }
         }
         else if(Main.player2.getBag().getOtherobjFromBag(choseNum).getIsUse() == 4)
         {
            petPanel["menu"].visible = true;
            petPanel["menu"].x = petPanel.mouseX + 5;
            petPanel["menu"].y = petPanel.mouseY + 5;
         }
      }
      
      public static function fuhua(e:*) : *
      {
         var id:int = 0;
         if(isPOne)
         {
            if(Main.player1.getPetSlot().backPetSlotNum() > 0)
            {
               id = int(Main.player1.getBag().delOtherobj(choseNum).getValue_1());
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(id));
            }
            else
            {
               ShortTip.open(37);
            }
            oneShow();
         }
         else
         {
            if(Main.player2.getPetSlot().backPetSlotNum() > 0)
            {
               id = int(Main.player2.getBag().delOtherobj(choseNum).getValue_1());
               Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(id));
            }
            else
            {
               ShortTip.open(37);
            }
            twoShow();
         }
         petPanel["menu"].visible = false;
      }
   }
}

