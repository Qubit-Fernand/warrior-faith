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
         var _loc1_:int = 0;
         if(petp == null)
         {
            petp = new PetPanel();
         }
         addFoodTime();
         isPOne = true;
         if(Main.player1.playerCW_Data)
         {
            _loc1_ = 0;
            while(_loc1_ < Main.player1.getPetSlot().getPetSlotNum())
            {
               if(Boolean(Main.player1.getPetSlot().getPetFromSlot(_loc1_)) && Main.player1.playerCW_Data == Main.player1.getPetSlot().getPetFromSlot(_loc1_))
               {
                  clickNum = _loc1_;
                  break;
               }
               _loc1_++;
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
         var _loc1_:uint = 0;
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
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            petPanel["jn" + _loc1_].buttonMode = true;
            petPanel["lw" + _loc1_].addEventListener(MouseEvent.CLICK,lingwu);
            petPanel["jn" + _loc1_].addEventListener(MouseEvent.CLICK,shuaJN);
            petPanel["jn" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,openTip);
            petPanel["jn" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,closeTip);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            petPanel["e" + _loc1_].mouseChildren = false;
            petPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            petPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            petPanel["e" + _loc1_].addEventListener(MouseEvent.CLICK,choseFH);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            petPanel["p" + _loc1_].mouseChildren = false;
            petPanel["p" + _loc1_].addEventListener(MouseEvent.CLICK,chosePet);
            _loc1_++;
         }
         oneShow();
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
      
      private static function openTip(param1:*) : void
      {
         petPanel["jntip"].visible = true;
         petPanel["jntip"].x = petPanel.mouseX + 10;
         petPanel["jntip"].y = petPanel.mouseY;
         var _loc2_:int = int(param1.target.name.substr(2,1));
         if(isPOne)
         {
            petPanel["jntip"]["str_name"].text = Main.player1.getPetSlot().getPetFromSlot(clickNum).getPetSkillNum(_loc2_).getSkillName();
            petPanel["jntip"]["str_text"].text = Main.player1.getPetSlot().getPetFromSlot(clickNum).getPetSkillNum(_loc2_).getIntroduction();
         }
         else
         {
            petPanel["jntip"]["str_name"].text = Main.player2.getPetSlot().getPetFromSlot(clickNum).getPetSkillNum(_loc2_).getSkillName();
            petPanel["jntip"]["str_text"].text = Main.player2.getPetSlot().getPetFromSlot(clickNum).getPetSkillNum(_loc2_).getIntroduction();
         }
      }
      
      private static function closeTip(param1:*) : void
      {
         petPanel["jntip"].visible = false;
      }
      
      private static function timeFunction(param1:*) : void
      {
         var _loc2_:uint = 0;
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
         _loc2_ = 0;
         while(_loc2_ < Main.player1.getPetSlot().getPetSlotNum())
         {
            if(Main.player1.getPetSlot().getPetFromSlot(_loc2_) != null)
            {
               if(Main.player1.getPetSlot().getPetFromSlot(_loc2_).getType() == 2)
               {
                  ++temp;
                  if(temp >= 27)
                  {
                     --time_1[_loc2_];
                     temp = 0;
                     if(time_1[_loc2_] <= 0)
                     {
                        Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(Main.player1.getPetSlot().delPetSlot(_loc2_).getLink()));
                        time_1[_loc2_] = 2400;
                        showPetAll(Main.player1.getPetSlot().getPetFromSlot(_loc2_));
                        oneShow();
                     }
                  }
               }
            }
            _loc2_++;
         }
         if(!Main.P1P2)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < Main.player2.getPetSlot().getPetSlotNum())
         {
            if(Main.player2.getPetSlot().getPetFromSlot(_loc2_) != null)
            {
               if(Main.player2.getPetSlot().getPetFromSlot(_loc2_).getType() == 2)
               {
                  ++temp2;
                  if(temp2 >= 27)
                  {
                     --time_2[_loc2_];
                     temp2 = 0;
                     if(time_2[_loc2_] <= 0)
                     {
                        Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(Main.player2.getPetSlot().delPetSlot(_loc2_).getLink()));
                        time_2[_loc2_] = 2400;
                        showPetAll(Main.player2.getPetSlot().getPetFromSlot(_loc2_));
                        twoShow();
                     }
                  }
               }
            }
            _loc2_++;
         }
      }
      
      private static function foodTime(param1:*) : void
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
      
      private static function jinhua(param1:*) : void
      {
         var _loc2_:Pet = null;
         if(isPOne)
         {
            if(Main.player1.getBag().getOtherobjNum(63160) > 1)
            {
               Main.player1.getBag().delOtherById(63160,2);
               _loc2_ = Main.player1.getPetSlot().delPetSlot(clickNum);
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(_loc2_.getEvolution()));
               if(_loc2_ == Main.player1.playerCW_Data)
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
            _loc2_ = Main.player2.getPetSlot().delPetSlot(clickNum);
            Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(_loc2_.getEvolution()));
            if(_loc2_ == Main.player2.playerCW_Data)
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
      
      private static function petDo(param1:*) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         switch(_loc2_.name)
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
      
      private static function yesSJ(param1:*) : *
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
      
      private static function noSJ(param1:*) : *
      {
         petPanel["rmbSJ"].visible = false;
      }
      
      private static function yesJN(param1:*) : *
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
      
      private static function noJN(param1:*) : *
      {
         petPanel["rmbJN"].visible = false;
      }
      
      private static function yesWX(param1:*) : *
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
      
      private static function noWX(param1:*) : *
      {
         petPanel["rmbWX"].visible = false;
      }
      
      private static function yesLW(param1:*) : *
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
      
      private static function noLW(param1:*) : *
      {
         petPanel["isLW"].visible = false;
      }
      
      private static function lingwu(param1:*) : *
      {
         lwNum = int(param1.target.name.substr(2,2));
         petPanel["isLW"].visible = true;
      }
      
      private static function yesFS(param1:*) : *
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
      
      private static function noFS(param1:*) : *
      {
         petPanel["isFS"].visible = false;
      }
      
      private static function fangsheng() : *
      {
         petPanel["isFS"].visible = true;
      }
      
      private static function kssj(param1:*) : *
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
      
      private static function shuaWX(param1:*) : *
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
      
      private static function shuaJN(param1:*) : *
      {
         petPanel["rmbJN"].visible = true;
         jnNum = int(param1.target.name.substr(2,2));
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
      
      private static function bagListen(param1:*) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         switch(_loc2_.name)
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
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            petPanel["e" + _loc1_].t_txt.text = "";
            if(Main.player1.getBag().getOtherobjFromBag(_loc1_) != null)
            {
               petPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getOtherobjFromBag(_loc1_).getFrame());
               petPanel["e" + _loc1_].visible = true;
               if(Main.player1.getBag().getOtherobjFromBag(_loc1_).getTimes() > 1)
               {
                  petPanel["e" + _loc1_].t_txt.text = Main.player1.getBag().getOtherobjFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               petPanel["e" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function showOtherBagP2() : *
      {
         isPOne = false;
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            petPanel["e" + _loc1_].t_txt.text = "";
            if(Main.player2.getBag().getOtherobjFromBag(_loc1_) != null)
            {
               petPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getOtherobjFromBag(_loc1_).getFrame());
               petPanel["e" + _loc1_].visible = true;
               if(Main.player2.getBag().getOtherobjFromBag(_loc1_).getTimes() > 1)
               {
                  petPanel["e" + _loc1_].t_txt.text = Main.player2.getBag().getOtherobjFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               petPanel["e" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function showPetP1() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            if(Main.player1.getPetSlot().getPetFromSlot(_loc1_) != null)
            {
               petPanel["p" + _loc1_].gotoAndStop(Main.player1.getPetSlot().getPetFromSlot(_loc1_).getFrame());
               petPanel["p" + _loc1_].visible = true;
            }
            else
            {
               petPanel["p" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 3;
         while(_loc1_ < 10)
         {
            if(Main.player1.getPetSlot().getPetSlotNum() > _loc1_)
            {
               petPanel["lock_" + _loc1_].visible = false;
            }
            else
            {
               petPanel["lock_" + _loc1_].visible = true;
            }
            _loc1_++;
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
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            if(Main.player2.getPetSlot().getPetFromSlot(_loc1_) != null)
            {
               petPanel["p" + _loc1_].gotoAndStop(Main.player2.getPetSlot().getPetFromSlot(_loc1_).getFrame());
               petPanel["p" + _loc1_].visible = true;
            }
            else
            {
               petPanel["p" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 3;
         while(_loc1_ < 10)
         {
            if(Main.player2.getPetSlot().getPetSlotNum() > _loc1_)
            {
               petPanel["lock_" + _loc1_].visible = false;
            }
            else
            {
               petPanel["lock_" + _loc1_].visible = true;
            }
            _loc1_++;
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
      
      public static function showPetAll(param1:Pet) : *
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(param1.getType() == 1)
         {
            petPanel["setFood"].visible = true;
            petPanel["time_txt"].visible = false;
            petPanel["chuzhan"].visible = true;
            petPanel["zhaohui"].visible = true;
            if(param1.getLv() < param1.getLvLimit())
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
               if(param1 == Main.player1.playerCW_Data || param1 == Main.player2.playerCW_Data)
               {
                  petPanel["chuzhan"].visible = false;
               }
               else
               {
                  petPanel["chuzhan"].visible = true;
               }
            }
            else if(param1 == Main.player1.playerCW_Data)
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
         if(param1.getEvolutionLV() != -1 && param1.getLv() >= param1.getEvolutionLV())
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
         if(param1.getPetSkill().length > 0)
         {
            _loc2_ = param1.getPetSkill();
            for(_loc3_ in _loc2_)
            {
               if(_loc2_[_loc3_] == 0)
               {
                  petPanel["lw" + _loc3_].visible = true;
               }
               else
               {
                  petPanel["lw" + _loc3_].visible = false;
               }
               if(_loc2_[_loc3_] > 0)
               {
                  petPanel["jn" + _loc3_].visible = true;
                  petPanel["jn" + _loc3_].gotoAndStop(SkillFactory.getSkillById(_loc2_[_loc3_]).getFrame());
               }
               else
               {
                  petPanel["jn" + _loc3_].visible = false;
               }
            }
         }
         if(param1.getWX() > 0 && param1.getWX() < 4)
         {
            petPanel["sxwx"].visible = true;
         }
         else
         {
            petPanel["sxwx"].visible = false;
         }
         showLV(param1.getLv());
         petPanel["explain"].text = param1.getIntroduction();
         petPanel["food"].text = param1.getFood();
         petPanel["wx_txt"].text = param1.getWX();
         petPanel["lv_txt"].text = param1.getLvLimit() + "(可升至" + param1.getLvLimit() + "级)";
         petPanel["exp"].text = param1.getExp() + "/" + PetFactory.all_LVData_vt[param1.getLv()].getValue();
         petPanel["txt_att"].text = "为玩家增加攻击力" + (param1.getAtt() * 100).toFixed(2) + "%";
         petPanel["txt_def"].text = "为玩家增加防御力" + (param1.getDef() * 100).toFixed(2) + "%";
         petPanel["txt_crit"].text = "为玩家增加暴击率" + (param1.getCrit() * 100).toFixed(2) + "%";
         petPanel["txt_life"].text = "为玩家增加血量" + (param1.getLife() * 100).toFixed(2) + "%";
         if(param1.getAtt() == 0)
         {
            ColorX(petPanel["txt_att"],"0x999999");
         }
         if(param1.getDef() == 0)
         {
            ColorX(petPanel["txt_def"],"0x999999");
         }
         if(param1.getCrit() == 0)
         {
            ColorX(petPanel["txt_crit"],"0x999999");
         }
         if(param1.getLife() == 0)
         {
            ColorX(petPanel["txt_life"],"0x999999");
         }
      }
      
      private static function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      public static function chosePet(param1:*) : *
      {
         clickObj = param1.target as MovieClip;
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
         var _loc1_:uint = 0;
         petPanel["isFS"]["yes_btn"].removeEventListener(MouseEvent.CLICK,yesFS);
         petPanel["isFS"]["no_btn"].removeEventListener(MouseEvent.CLICK,noFS);
         petPanel.removeEventListener(BtnEvent.DO_CLICK,petDo);
         petPanel.removeEventListener(BtnEvent.DO_CHANGE,bagListen);
         petPanel["close1"].removeEventListener(MouseEvent.CLICK,closePet);
         petPanel["close2"].removeEventListener(MouseEvent.CLICK,closePet);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            petPanel["e" + _loc1_].mouseChildren = false;
            petPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            petPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            petPanel["p" + _loc1_].removeEventListener(MouseEvent.CLICK,chosePet);
            _loc1_++;
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
      
      private static function showLV(param1:Number) : *
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 < 10)
         {
            petPanel["shiwei"].gotoAndStop(param1);
            petPanel["gewei"].visible = false;
         }
         else
         {
            petPanel["gewei"].visible = true;
            _loc2_ = param1.toString();
            _loc3_ = int(_loc2_.substring(0,1));
            _loc4_ = int(_loc2_.substring(1,2));
            petPanel["shiwei"].gotoAndStop(_loc3_);
            if(_loc4_ == 0)
            {
               petPanel["gewei"].gotoAndStop(10);
            }
            else
            {
               petPanel["gewei"].gotoAndStop(_loc4_);
            }
         }
      }
      
      public static function closePet(param1:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         petPanel.addChild(itemsTooltip);
         var _loc3_:uint = uint(_loc2_.name.substr(1,2));
         var _loc4_:String = _loc2_.name.substr(0,1);
         if(isPOne)
         {
            if(_loc4_ == "e")
            {
               if(Main.player1.getBag().getOtherobjFromBag(_loc3_) != null)
               {
                  itemsTooltip.otherTooltip(Main.player1.getBag().getOtherobjFromBag(_loc3_));
               }
            }
         }
         else if(_loc4_ == "e")
         {
            if(Main.player2.getBag().getOtherobjFromBag(_loc3_) != null)
            {
               itemsTooltip.otherTooltip(Main.player2.getBag().getOtherobjFromBag(_loc3_));
            }
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = petPanel.mouseX + 10;
         itemsTooltip.y = petPanel.mouseY;
         itemsTooltip.setTooltipPoint();
         petPanel["menu"].visible = false;
      }
      
      private static function tooltipClose(param1:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      public static function choseFH(param1:*) : *
      {
         choseNum = uint((param1.target as MovieClip).name.substr(1,2));
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
      
      public static function fuhua(param1:*) : *
      {
         var _loc2_:int = 0;
         if(isPOne)
         {
            if(Main.player1.getPetSlot().backPetSlotNum() > 0)
            {
               _loc2_ = int(Main.player1.getBag().delOtherobj(choseNum).getValue_1());
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(_loc2_));
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
               _loc2_ = int(Main.player2.getBag().delOtherobj(choseNum).getValue_1());
               Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(_loc2_));
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

