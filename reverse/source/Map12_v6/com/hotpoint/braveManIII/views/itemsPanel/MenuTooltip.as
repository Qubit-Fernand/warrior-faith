package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.repository.elves.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.pet.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.repository.title.*;
   import com.hotpoint.braveManIII.views.makePanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class MenuTooltip extends MovieClip
   {
      
      public static var selectType:uint;
      
      public static var oldNum:uint;
      
      public static var whichDo:uint;
      
      public static var moneyOK:Boolean = false;
      
      public static var moneyOK2:Boolean = false;
      
      private static var menuTooltip:MovieClip = new MenuShow();
      
      private static var timetemp:int = 0;
      
      private var su:Supplies;
      
      private var amount:VT = VT.createVT(1);
      
      private var equipSlot:EquipSlot = new EquipSlot();
      
      private var equipSlot2P:EquipSlot = new EquipSlot();
      
      private var skillSlot:EquipSkillSlot = new EquipSkillSlot();
      
      private var skillSlot2P:EquipSkillSlot = new EquipSkillSlot();
      
      public function MenuTooltip()
      {
         super();
         equipSlot = Main.player1.getEquipSlot();
         skillSlot = Main.player1.getEquipSkillSlot();
         if(Main.P1P2)
         {
            equipSlot2P = Main.player2.getEquipSlot();
            skillSlot2P = Main.player2.getEquipSkillSlot();
         }
         this.addChild(menuTooltip);
         this.visible = false;
      }
      
      public static function lijifuhua() : *
      {
         var id:int = 0;
         if(moneyOK)
         {
            if(whichDo == 1)
            {
               id = int(Main.player1.getBag().delOtherobj(oldNum).getValue_1());
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(PetFactory.creatPet(id).getLink()));
               BagItemsShow.otherobjShow();
            }
            else
            {
               id = int(Main.player2.getBag().delOtherobj(oldNum).getValue_1());
               Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(PetFactory.creatPet(id).getLink()));
               BagItemsShow.otherobjShow2P();
            }
            Main.Save();
            menuTooltip["menu_9"]["fuhuaNow"].visible = true;
            moneyOK = false;
         }
      }
      
      public static function isFJ(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            if(Main.player1.getBag().getEquipFromBag(oldNum).getDressLevel() >= 50)
            {
               if(selectType == 1)
               {
                  if(Main.player1.getBag().getEquipFromBag(oldNum).getColor() <= 3)
                  {
                     doFenJie();
                     Main.player1.getBag().delEquip(oldNum);
                  }
                  else
                  {
                     ItemsPanel.itemsPanel["isFenJie"].visible = true;
                     ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isFenJie"]);
                     ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["mouseFJ"]);
                  }
                  BagItemsShow.equipShow();
                  BagItemsShow.informationShow();
               }
            }
         }
         else if(Main.player2.getBag().getEquipFromBag(oldNum).getDressLevel() >= 50)
         {
            if(selectType == 1)
            {
               if(Main.player2.getBag().getEquipFromBag(oldNum).getColor() <= 3)
               {
                  doFenJie();
                  Main.player2.getBag().delEquip(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isFenJie"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isFenJie"]);
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["mouseFJ"]);
               }
               BagItemsShow.equipShow2P();
               BagItemsShow.informationShow2P();
            }
         }
      }
      
      private static function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      private static function jianbian(e:*) : *
      {
         ++timetemp;
         ItemsPanel.itemsPanel["getFJ"].alpha -= 0.02;
         if(timetemp > 50)
         {
            ItemsPanel.itemsPanel["getFJ"].visible = false;
            ItemsPanel.itemsPanel.removeEventListener(Event.ENTER_FRAME,jianbian);
         }
      }
      
      private static function showPicAndNum(other:Otherobj, num:int) : *
      {
         timetemp = 0;
         ItemsPanel.itemsPanel["getFJ"].alpha = 1;
         ItemsPanel.itemsPanel["getFJ"].visible = true;
         ItemsPanel.itemsPanel.addEventListener(Event.ENTER_FRAME,jianbian);
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["getFJ"]);
         ItemsPanel.itemsPanel["getFJ"]["showPic"].gotoAndStop(other.getFrame());
         ItemsPanel.itemsPanel["getFJ"]["showPic"]["t_txt"].text = num;
      }
      
      private static function getColor1() : *
      {
         var i:int = 0;
         var rdm:int = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 3; i++)
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),3);
                  break;
               case 1:
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63133));
                  showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 2:
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63134));
                  showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 3:
                  for(i = 0; i < 3; i++)
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),3);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 3; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),3);
                  break;
               case 1:
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63133));
                  showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 2:
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63134));
                  showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 3:
                  for(i = 0; i < 3; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),3);
            }
         }
      }
      
      private static function getColor2() : *
      {
         var i:int = 0;
         var rdm:int = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 6; i++)
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),6);
                  break;
               case 1:
                  for(i = 0; i < 2; i++)
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63133));
                  }
                  showPicAndNum(OtherFactory.creatOther(63133),2);
                  break;
               case 2:
                  for(i = 0; i < 2; i++)
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63134));
                  }
                  showPicAndNum(OtherFactory.creatOther(63134),2);
                  break;
               case 3:
                  for(i = 0; i < 6; i++)
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),6);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 6; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),6);
                  break;
               case 1:
                  for(i = 0; i < 2; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63133));
                  }
                  showPicAndNum(OtherFactory.creatOther(63133),2);
                  break;
               case 2:
                  for(i = 0; i < 2; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63134));
                  }
                  showPicAndNum(OtherFactory.creatOther(63134),2);
                  break;
               case 3:
                  for(i = 0; i < 6; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),6);
            }
         }
      }
      
      private static function getColor3() : *
      {
         var rdm:int = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63133));
                  showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 1:
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63134));
                  showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 2:
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63136));
                  showPicAndNum(OtherFactory.creatOther(63136),1);
                  break;
               case 3:
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63137));
                  showPicAndNum(OtherFactory.creatOther(63137),1);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63133));
                  showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 1:
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63134));
                  showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 2:
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63136));
                  showPicAndNum(OtherFactory.creatOther(63136),1);
                  break;
               case 3:
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63137));
                  showPicAndNum(OtherFactory.creatOther(63137),1);
            }
         }
      }
      
      private static function getColor4() : *
      {
         var rdm:int = Math.random() * 3;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 15; ++i)
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63136));
                  }
                  showPicAndNum(OtherFactory.creatOther(63136),15);
                  break;
               case 1:
                  for(i = 0; i < 15; ++i)
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63137));
                  }
                  showPicAndNum(OtherFactory.creatOther(63137),15);
                  break;
               case 2:
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63138));
                  showPicAndNum(OtherFactory.creatOther(63138),1);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 15; ++i)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63136));
                  }
                  showPicAndNum(OtherFactory.creatOther(63136),15);
                  break;
               case 1:
                  for(i = 0; i < 15; ++i)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63137));
                  }
                  showPicAndNum(OtherFactory.creatOther(63137),15);
                  break;
               case 2:
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63138));
                  showPicAndNum(OtherFactory.creatOther(63138),1);
            }
         }
      }
      
      public static function doFenJie() : *
      {
         if(whichDo == 1)
         {
            switch(Main.player1.getBag().getEquipFromBag(oldNum).getColor())
            {
               case 1:
                  getColor1();
                  break;
               case 2:
                  getColor2();
                  break;
               case 3:
                  getColor3();
                  break;
               case 4:
                  getColor4();
                  break;
               case 5:
                  getColor4();
            }
         }
         else
         {
            switch(Main.player2.getBag().getEquipFromBag(oldNum).getColor())
            {
               case 1:
                  getColor1();
                  break;
               case 2:
                  getColor2();
                  break;
               case 3:
                  getColor3();
                  break;
               case 4:
                  getColor4();
                  break;
               case 5:
                  getColor4();
            }
         }
      }
      
      public static function xufeiRMB() : *
      {
         if(moneyOK2)
         {
            if(whichDo == 1)
            {
               Main.player1.getEquipSlot().getEquipFromSlot(oldNum).setRemainingTimeNow();
               Main.player1.getEquipSlot().getEquipFromSlot(oldNum).setSysTime(Main.serverTime);
            }
            else
            {
               Main.player2.getEquipSlot().getEquipFromSlot(oldNum).setRemainingTimeNow();
               Main.player2.getEquipSlot().getEquipFromSlot(oldNum).setSysTime(Main.serverTime);
            }
            moneyOK2 = false;
            Main.Save();
         }
      }
      
      public function addListener() : *
      {
         ItemsPanel.itemsPanel["fhRMB"].visible = false;
         ItemsPanel.itemsPanel["xfRMB"].visible = false;
         ItemsPanel.itemsPanel["xfRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesXF);
         ItemsPanel.itemsPanel["xfRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,noXF);
         ItemsPanel.itemsPanel["fhRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesFH);
         ItemsPanel.itemsPanel["fhRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,noFH);
         ItemsPanel.itemsPanel["txtTop"]["close"].addEventListener(MouseEvent.CLICK,closeTXT);
         ItemsPanel.itemsPanel["txtTop2"]["close"].addEventListener(MouseEvent.CLICK,closeTXT2);
         ItemsPanel.itemsPanel["isFenJie"]["yesFJ"].addEventListener(MouseEvent.CLICK,yesFJ);
         ItemsPanel.itemsPanel["isFenJie"]["noFJ"].addEventListener(MouseEvent.CLICK,noFJ);
         ItemsPanel.itemsPanel.addEventListener(BtnEvent.DO_CLICK,btnListen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].addEventListener(MouseEvent.MOUSE_OVER,tipOpen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].addEventListener(MouseEvent.MOUSE_OUT,tipClose);
         menuTooltip["menu_1"]["off_btn"].addEventListener(MouseEvent.CLICK,takeOff);
         menuTooltip["menu_2"]["wear_btn"].addEventListener(MouseEvent.CLICK,wear);
         menuTooltip["menu_2"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_2"]["all_Sell"].addEventListener(MouseEvent.CLICK,allSell);
         menuTooltip["menu_2"]["fenJie"].addEventListener(MouseEvent.CLICK,isFJ);
         menuTooltip["menu_3"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_3"]["key_btn1"].addEventListener(MouseEvent.CLICK,setKey_1);
         menuTooltip["menu_3"]["key_btn2"].addEventListener(MouseEvent.CLICK,setKey_2);
         menuTooltip["menu_3"]["key_btn3"].addEventListener(MouseEvent.CLICK,setKey_3);
         menuTooltip["menu_4"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_5"]["left_btn"].addEventListener(MouseEvent.CLICK,leftInto);
         menuTooltip["menu_5"]["right_btn"].addEventListener(MouseEvent.CLICK,rightInto);
         menuTooltip["menu_5"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_6"]["free_btn"].addEventListener(MouseEvent.CLICK,setFree);
         menuTooltip["menu_7"]["use_btn"].addEventListener(MouseEvent.CLICK,useOther);
         menuTooltip["menu_7"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_8"]["use_btn"].addEventListener(MouseEvent.CLICK,useOther);
         menuTooltip["menu_8"]["alluse_btn"].addEventListener(MouseEvent.CLICK,alluseOther);
         menuTooltip["menu_8"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_9"]["fuhua"].addEventListener(MouseEvent.CLICK,fuhua);
         menuTooltip["menu_9"]["fuhuaNow"].addEventListener(MouseEvent.CLICK,fuhuaNow);
         menuTooltip["menu_10"]["xf_btn"].addEventListener(MouseEvent.CLICK,xufei);
         menuTooltip["menu_10"]["yc_btn"].addEventListener(MouseEvent.CLICK,yincang);
         menuTooltip["menu_10"]["xs_btn"].addEventListener(MouseEvent.CLICK,xianshi);
         menuTooltip["menu_10"]["off_btn"].addEventListener(MouseEvent.CLICK,takeOff);
      }
      
      public function removeListener() : *
      {
         ItemsPanel.itemsPanel["xfRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesXF);
         ItemsPanel.itemsPanel["xfRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,noXF);
         ItemsPanel.itemsPanel["fhRMB"]["yes_btn"].removeEventListener(MouseEvent.CLICK,yesFH);
         ItemsPanel.itemsPanel["fhRMB"]["no_btn"].removeEventListener(MouseEvent.CLICK,noFH);
         ItemsPanel.itemsPanel["txtTop"]["close"].removeEventListener(MouseEvent.CLICK,closeTXT);
         ItemsPanel.itemsPanel["txtTop2"]["close"].removeEventListener(MouseEvent.CLICK,closeTXT2);
         ItemsPanel.itemsPanel["isFenJie"]["yesFJ"].removeEventListener(MouseEvent.CLICK,yesFJ);
         ItemsPanel.itemsPanel["isFenJie"]["noFJ"].removeEventListener(MouseEvent.CLICK,noFJ);
         ItemsPanel.itemsPanel.removeEventListener(BtnEvent.DO_CLICK,btnListen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].removeEventListener(MouseEvent.MOUSE_OVER,tipOpen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].removeEventListener(MouseEvent.MOUSE_OUT,tipClose);
         menuTooltip["menu_1"]["off_btn"].removeEventListener(MouseEvent.CLICK,takeOff);
         menuTooltip["menu_2"]["wear_btn"].removeEventListener(MouseEvent.CLICK,wear);
         menuTooltip["menu_2"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_2"]["fenJie"].removeEventListener(MouseEvent.CLICK,isFJ);
         menuTooltip["menu_2"]["wear_btn"].removeEventListener(MouseEvent.CLICK,wear);
         menuTooltip["menu_3"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_3"]["key_btn1"].removeEventListener(MouseEvent.CLICK,setKey_1);
         menuTooltip["menu_3"]["key_btn2"].removeEventListener(MouseEvent.CLICK,setKey_2);
         menuTooltip["menu_3"]["key_btn3"].removeEventListener(MouseEvent.CLICK,setKey_3);
         menuTooltip["menu_4"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_5"]["left_btn"].removeEventListener(MouseEvent.CLICK,leftInto);
         menuTooltip["menu_5"]["right_btn"].removeEventListener(MouseEvent.CLICK,rightInto);
         menuTooltip["menu_5"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_6"]["free_btn"].removeEventListener(MouseEvent.CLICK,setFree);
         menuTooltip["menu_7"]["use_btn"].removeEventListener(MouseEvent.CLICK,useOther);
         menuTooltip["menu_7"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_8"]["use_btn"].removeEventListener(MouseEvent.CLICK,useOther);
         menuTooltip["menu_8"]["alluse_btn"].removeEventListener(MouseEvent.CLICK,alluseOther);
         menuTooltip["menu_8"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_9"]["fuhua"].removeEventListener(MouseEvent.CLICK,fuhua);
         menuTooltip["menu_9"]["fuhuaNow"].removeEventListener(MouseEvent.CLICK,fuhuaNow);
         menuTooltip["menu_10"]["xf_btn"].removeEventListener(MouseEvent.CLICK,xufei);
         menuTooltip["menu_10"]["yc_btn"].removeEventListener(MouseEvent.CLICK,yincang);
         menuTooltip["menu_10"]["xs_btn"].removeEventListener(MouseEvent.CLICK,xianshi);
         menuTooltip["menu_10"]["off_btn"].removeEventListener(MouseEvent.CLICK,takeOff);
      }
      
      public function setItemsMenu(type:uint, num:uint, whichPlayerData:uint) : *
      {
         whichDo = whichPlayerData;
         selectType = type;
         oldNum = num;
         menuTooltip["menu_1"].visible = false;
         menuTooltip["menu_2"].visible = false;
         menuTooltip["menu_3"].visible = false;
         menuTooltip["menu_4"].visible = false;
         menuTooltip["menu_5"].visible = false;
         menuTooltip["menu_6"].visible = false;
         menuTooltip["menu_7"].visible = false;
         menuTooltip["menu_8"].visible = false;
         menuTooltip["menu_9"].visible = false;
         menuTooltip["menu_10"].visible = false;
         switch(selectType)
         {
            case 1:
               if(whichDo == 1)
               {
                  if(Main.player1.getBag().getEquipFromBag(oldNum).getDressLevel() < 50)
                  {
                     menuTooltip["menu_2"]["fenJie"].visible = false;
                  }
                  else
                  {
                     menuTooltip["menu_2"]["fenJie"].visible = true;
                  }
               }
               else if(Main.player2.getBag().getEquipFromBag(oldNum).getDressLevel() < 50)
               {
                  menuTooltip["menu_2"]["fenJie"].visible = false;
               }
               else
               {
                  menuTooltip["menu_2"]["fenJie"].visible = true;
               }
               menuTooltip["menu_2"].visible = true;
               break;
            case 2:
               menuTooltip["menu_3"].visible = true;
               break;
            case 3:
               if(whichDo == 1)
               {
                  if(Main.player1.getBag().getGemFromBag(oldNum).getType() == 4)
                  {
                     menuTooltip["menu_5"].visible = true;
                  }
                  else if(Main.player1.getBag().getGemFromBag(oldNum).getType() == 5 || Main.player1.getBag().getGemFromBag(oldNum).getType() == 6)
                  {
                     menuTooltip["menu_7"].visible = true;
                  }
                  else
                  {
                     menuTooltip["menu_4"].visible = true;
                  }
               }
               else if(Main.player2.getBag().getGemFromBag(oldNum).getType() == 4)
               {
                  menuTooltip["menu_5"].visible = true;
               }
               else if(Main.player2.getBag().getGemFromBag(oldNum).getType() == 5 || Main.player2.getBag().getGemFromBag(oldNum).getType() == 6)
               {
                  menuTooltip["menu_7"].visible = true;
               }
               else
               {
                  menuTooltip["menu_4"].visible = true;
               }
               break;
            case 4:
               if(whichDo == 1)
               {
                  if(Main.player1.getBag().getOtherobjFromBag(oldNum).getIsUse() == 1)
                  {
                     menuTooltip["menu_7"].visible = true;
                  }
                  else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getIsUse() == 0)
                  {
                     menuTooltip["menu_4"].visible = true;
                  }
                  else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getIsUse() == 3)
                  {
                     menuTooltip["menu_8"].visible = true;
                  }
                  else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getIsUse() == 4)
                  {
                     menuTooltip["menu_9"].visible = true;
                  }
               }
               else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getIsUse() == 1)
               {
                  menuTooltip["menu_7"].visible = true;
               }
               else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getIsUse() == 0)
               {
                  menuTooltip["menu_4"].visible = true;
               }
               else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getIsUse() == 3)
               {
                  menuTooltip["menu_8"].visible = true;
               }
               else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getIsUse() == 4)
               {
                  menuTooltip["menu_9"].visible = true;
               }
               break;
            case 5:
               menuTooltip["menu_4"].visible = true;
         }
      }
      
      private function tipOpen(e:MouseEvent) : void
      {
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsTooltip);
         ItemsPanel.itemsTooltip.x = ItemsPanel.itemsPanel.mouseX;
         ItemsPanel.itemsTooltip.y = ItemsPanel.itemsPanel.mouseY;
         if(whichDo == 1)
         {
            ItemsPanel.itemsTooltip.gemTooltip(Main.player1.getBag().getGemFromBag(oldNum));
         }
         else
         {
            ItemsPanel.itemsTooltip.gemTooltip(Main.player2.getBag().getGemFromBag(oldNum));
         }
         ItemsPanel.itemsTooltip.visible = true;
      }
      
      private function tipClose(e:MouseEvent) : void
      {
         ItemsPanel.itemsTooltip.visible = false;
      }
      
      private function getPart(num:Number) : uint
      {
         switch(num)
         {
            case 1:
               return 0;
            case 2:
               return 1;
            case 3:
               return 3;
            case 4:
               return 4;
            case 5:
               return 2;
            case 6:
               return 2;
            case 7:
               return 2;
            case 8:
               return 6;
            case 9:
               return 7;
            default:
               return null;
         }
      }
      
      public function setSlotMenu(num:uint, whichPlayerData:uint) : *
      {
         oldNum = num;
         whichDo = whichPlayerData;
         if(oldNum < 6)
         {
            menuTooltip["menu_1"].visible = true;
            menuTooltip["menu_10"].visible = false;
         }
         else
         {
            menuTooltip["menu_1"].visible = false;
            menuTooltip["menu_10"].visible = true;
            if(oldNum == 6)
            {
               if(Main["player_" + whichDo].skin_Z2_V)
               {
                  menuTooltip["menu_10"]["yc_btn"].visible = true;
               }
               else
               {
                  menuTooltip["menu_10"]["yc_btn"].visible = false;
               }
            }
            else if(oldNum == 7)
            {
               if(Main["player_" + whichDo].skin_Z3_V)
               {
                  menuTooltip["menu_10"]["yc_btn"].visible = true;
               }
               else
               {
                  menuTooltip["menu_10"]["yc_btn"].visible = false;
               }
            }
            if(Main["player" + whichDo].getEquipSlot().getEquipFromSlot(oldNum).getColor() >= 4)
            {
               menuTooltip["menu_10"]["xf_btn"].visible = false;
            }
            else
            {
               menuTooltip["menu_10"]["xf_btn"].visible = true;
            }
         }
         menuTooltip["menu_2"].visible = false;
         menuTooltip["menu_3"].visible = false;
         menuTooltip["menu_4"].visible = false;
         menuTooltip["menu_5"].visible = false;
         menuTooltip["menu_6"].visible = false;
         menuTooltip["menu_7"].visible = false;
         menuTooltip["menu_8"].visible = false;
         menuTooltip["menu_9"].visible = false;
      }
      
      public function setSkillSlotMenu(num:uint, whichPlayerData:uint) : *
      {
         oldNum = num;
         whichDo = whichPlayerData;
         menuTooltip["menu_1"].visible = false;
         menuTooltip["menu_2"].visible = false;
         menuTooltip["menu_3"].visible = false;
         menuTooltip["menu_4"].visible = false;
         menuTooltip["menu_5"].visible = false;
         menuTooltip["menu_6"].visible = true;
         menuTooltip["menu_7"].visible = false;
         menuTooltip["menu_8"].visible = false;
         menuTooltip["menu_9"].visible = false;
         menuTooltip["menu_10"].visible = false;
      }
      
      private function bagNoBug() : *
      {
         if(whichDo == 1)
         {
            ItemsPanel.isPOne = true;
            ItemsPanel.itemsPanel["bagOne"].isClick = true;
         }
         else
         {
            ItemsPanel.isPOne = false;
            ItemsPanel.itemsPanel["bagTwo"].isClick = true;
         }
      }
      
      public function fuhua(e:*) : *
      {
         var id:int = 0;
         if(whichDo == 1)
         {
            if(Main.player1.getPetSlot().backPetSlotNum() > 0)
            {
               id = int(Main.player1.getBag().delOtherobj(oldNum).getValue_1());
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(id));
            }
            else
            {
               ShortTip.open(37);
            }
            BagItemsShow.otherobjShow();
         }
         else
         {
            if(Main.player2.getPetSlot().backPetSlotNum() > 0)
            {
               id = int(Main.player2.getBag().delOtherobj(oldNum).getValue_1());
               Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(id));
            }
            else
            {
               ShortTip.open(37);
            }
            BagItemsShow.otherobjShow2P();
         }
      }
      
      public function fuhuaNow(e:*) : *
      {
         ItemsPanel.itemsPanel["fhRMB"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["fhRMB"]);
      }
      
      public function yesFH(e:*) : *
      {
         if(whichDo == 1)
         {
            if(Main.player1.getPetSlot().backPetSlotNum() <= 0)
            {
               ShortTip.open(37);
               return;
            }
         }
         else if(Main.player2.getPetSlot().backPetSlotNum() <= 0)
         {
            ShortTip.open(37);
            return;
         }
         Api_4399_All.Money_down(InitData.fuHua.getValue());
         menuTooltip["menu_9"]["fuhuaNow"].visible = false;
         moneyOK = true;
         ItemsPanel.itemsPanel["fhRMB"].visible = false;
      }
      
      public function noFH(e:*) : *
      {
         ItemsPanel.itemsPanel["fhRMB"].visible = false;
      }
      
      public function wear(e:MouseEvent) : *
      {
         var equip:Equip = null;
         var part:uint = 0;
         if(whichDo == 1)
         {
            if(selectType == 1)
            {
               part = uint(getPart(Main.player1.getBag().getEquipFromBag(oldNum).getPosition()));
               if(Main.player1.getBag().getEquipFromBag(oldNum).getDressLevel() <= Main.player1.getLevel() || Main.player1.getBag().getEquipFromBag(oldNum).getDressLevel() == 100)
               {
                  if(equipSlot.getEquipFromSlot(part) == null)
                  {
                     equipSlot.addToSlot(Main.player1.getBag().getEquipFromBag(oldNum),part);
                     Main.player1.getBag().delEquip(oldNum);
                  }
                  else
                  {
                     equip = equipSlot.delSlot(part);
                     equipSlot.addToSlot(Main.player1.getBag().getEquipFromBag(oldNum),part);
                     Main.player1.getBag().delEquip(oldNum);
                     Main.player1.getBag().addToEquipBag(equip,oldNum);
                  }
               }
               else
               {
                  ShortTip.open(25);
               }
            }
            Main.player_1.LoadPlayerLvData();
            Player.getEquipDataXX();
            BagItemsShow.informationShow();
            BagItemsShow.equipShow();
            BagItemsShow.slotShow();
            ItemsPanel.changeModel(Main.player1);
         }
         else
         {
            if(selectType == 1)
            {
               part = uint(getPart(Main.player2.getBag().getEquipFromBag(oldNum).getPosition()));
               if(Main.player2.getBag().getEquipFromBag(oldNum).getDressLevel() <= Main.player2.getLevel() || Main.player2.getBag().getEquipFromBag(oldNum).getDressLevel() == 100)
               {
                  if(equipSlot2P.getEquipFromSlot(part) == null)
                  {
                     equipSlot2P.addToSlot(Main.player2.getBag().getEquipFromBag(oldNum),part);
                     Main.player2.getBag().delEquip(oldNum);
                  }
                  else
                  {
                     equip = equipSlot2P.delSlot(part);
                     equipSlot2P.addToSlot(Main.player2.getBag().getEquipFromBag(oldNum),part);
                     Main.player2.getBag().delEquip(oldNum);
                     Main.player2.getBag().addToEquipBag(equip,oldNum);
                  }
               }
               else
               {
                  ShortTip.open(25);
               }
            }
            Main.player_2.LoadPlayerLvData();
            Player.getEquipDataXX();
            BagItemsShow.informationShow2P();
            BagItemsShow.equipShow2P();
            BagItemsShow.slotShow2P();
            ItemsPanel.changeModel(Main.player2);
         }
      }
      
      public function takeOff(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            if(Main.player1.getBag().backequipBagNum() > 0)
            {
               Main.player1.getBag().addEquipBag(equipSlot.getEquipFromSlot(oldNum));
               equipSlot.delSlot(oldNum);
            }
            else
            {
               ShortTip.open(3);
            }
            Player.getEquipDataXX();
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_1"].isClick = true;
            ItemsPanel.itemsType = 1;
            BagItemsShow.equipShow();
            BagItemsShow.slotShow();
            BagItemsShow.informationShow();
            ItemsPanel.changeModel(Main.player1);
         }
         else
         {
            if(Main.player2.getBag().backequipBagNum() > 0)
            {
               Main.player2.getBag().addEquipBag(equipSlot2P.getEquipFromSlot(oldNum));
               equipSlot2P.delSlot(oldNum);
            }
            else
            {
               ShortTip.open(3);
            }
            Player.getEquipDataXX();
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_1"].isClick = true;
            ItemsPanel.itemsType2P = 1;
            BagItemsShow.equipShow2P();
            BagItemsShow.slotShow2P();
            BagItemsShow.informationShow2P();
            ItemsPanel.changeModel(Main.player2);
         }
      }
      
      public function leftInto(e:MouseEvent) : *
      {
         var gem:Gem = null;
         if(whichDo == 1)
         {
            if(Main.player1.getBag().getGemFromBag(oldNum).getUseLevel() <= Main.player1.getLevel())
            {
               if(skillSlot.getGemFromSkillSlot(0) == null)
               {
                  skillSlot.addToSkillSlot(Main.player1.getBag().getGemFromBag(oldNum),0);
                  Main.player1.getBag().delGem(oldNum,1);
               }
               else
               {
                  gem = skillSlot.delSkillSlot(0);
                  skillSlot.addToSkillSlot(Main.player1.getBag().getGemFromBag(oldNum),0);
                  Main.player1.getBag().delGem(oldNum,1);
                  Main.player1.getBag().addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_1.energySlot.energyLeftNum.setValue(0);
            Main.player_1.energySlot.energyLeftMax.setValue(SkillFactory.getSkillById(skillSlot.getGemFromSkillSlot(0).getGemSkill()).getEp());
            BagItemsShow.skillSlotShow();
            BagItemsShow.gemShow();
         }
         else
         {
            if(Main.player2.getBag().getGemFromBag(oldNum).getUseLevel() <= Main.player2.getLevel())
            {
               if(skillSlot2P.getGemFromSkillSlot(0) == null)
               {
                  skillSlot2P.addToSkillSlot(Main.player2.getBag().getGemFromBag(oldNum),0);
                  Main.player2.getBag().delGem(oldNum,1);
               }
               else
               {
                  gem = skillSlot2P.delSkillSlot(0);
                  skillSlot2P.addToSkillSlot(Main.player2.getBag().getGemFromBag(oldNum),0);
                  Main.player2.getBag().delGem(oldNum,1);
                  Main.player2.getBag().addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_2.energySlot.energyLeftNum.setValue(0);
            Main.player_2.energySlot.energyLeftMax.setValue(SkillFactory.getSkillById(skillSlot2P.getGemFromSkillSlot(0).getGemSkill()).getEp());
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
         }
      }
      
      public function rightInto(e:MouseEvent) : *
      {
         var gem:Gem = null;
         if(whichDo == 1)
         {
            if(Main.player1.getBag().getGemFromBag(oldNum).getUseLevel() <= Main.player1.getLevel())
            {
               if(skillSlot.getGemFromSkillSlot(1) == null)
               {
                  skillSlot.addToSkillSlot(Main.player1.getBag().getGemFromBag(oldNum),1);
                  Main.player1.getBag().delGem(oldNum,1);
               }
               else
               {
                  gem = skillSlot.delSkillSlot(1);
                  skillSlot.addToSkillSlot(Main.player1.getBag().getGemFromBag(oldNum),1);
                  Main.player1.getBag().delGem(oldNum,1);
                  Main.player1.getBag().addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_1.energySlot.energyRightMax.setValue(SkillFactory.getSkillById(skillSlot.getGemFromSkillSlot(1).getGemSkill()).getEp());
            Main.player_1.energySlot.energyRightNum.setValue(0);
            BagItemsShow.skillSlotShow();
            BagItemsShow.gemShow();
         }
         else
         {
            if(Main.player2.getBag().getGemFromBag(oldNum).getUseLevel() <= Main.player2.getLevel())
            {
               if(skillSlot2P.getGemFromSkillSlot(1) == null)
               {
                  skillSlot2P.addToSkillSlot(Main.player2.getBag().getGemFromBag(oldNum),1);
                  Main.player2.getBag().delGem(oldNum,1);
               }
               else
               {
                  gem = skillSlot2P.delSkillSlot(1);
                  skillSlot2P.addToSkillSlot(Main.player2.getBag().getGemFromBag(oldNum),1);
                  Main.player2.getBag().delGem(oldNum,1);
                  Main.player2.getBag().addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_2.energySlot.energyRightMax.setValue(SkillFactory.getSkillById(skillSlot2P.getGemFromSkillSlot(1).getGemSkill()).getEp());
            Main.player_2.energySlot.energyRightNum.setValue(0);
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
         }
      }
      
      public function setFree(e:MouseEvent) : *
      {
         var gem:Gem = null;
         if(whichDo == 1)
         {
            if(Main.player1.getBag().backGemBagNum() > 0)
            {
               Main.player1.getBag().addGemBag(skillSlot.delSkillSlot(oldNum));
               if(oldNum == 0)
               {
                  Main.player_1.energySlot.energyLeftMax.setValue(0);
                  Main.player_1.energySlot.energyLeftNum.setValue(0);
               }
               else
               {
                  Main.player_1.energySlot.energyRightMax.setValue(0);
                  Main.player_1.energySlot.energyRightNum.setValue(0);
               }
            }
            else
            {
               ShortTip.open(3);
            }
            BagItemsShow.skillSlotShow();
            BagItemsShow.gemShow();
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_3"].isClick = true;
            ItemsPanel.itemsType = 3;
         }
         else
         {
            if(Main.player2.getBag().backGemBagNum() > 0)
            {
               Main.player2.getBag().addGemBag(skillSlot2P.delSkillSlot(oldNum));
               if(oldNum == 0)
               {
                  Main.player_2.energySlot.energyLeftMax.setValue(0);
                  Main.player_2.energySlot.energyLeftNum.setValue(0);
               }
               else
               {
                  Main.player_2.energySlot.energyRightMax.setValue(0);
                  Main.player_2.energySlot.energyRightNum.setValue(0);
               }
            }
            else
            {
               ShortTip.open(3);
            }
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_3"].isClick = true;
            ItemsPanel.itemsType2P = 3;
         }
      }
      
      public function allSell(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["isAllSell"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isAllSell"]);
      }
      
      public function sell(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            if(selectType == 1)
            {
               if(Main.player1.getBag().getEquipFromBag(oldNum).getColor() <= 2)
               {
                  Main.player1.addGold(Main.player1.getBag().getEquipFromBag(oldNum).getPrice());
                  Main.player1.getBag().delEquip(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.equipShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 2)
            {
               if(Main.player1.getBag().getSuppliesFromBag(oldNum).getColor() <= 2)
               {
                  Main.player1.addGold(Main.player1.getBag().getSuppliesFromBag(oldNum).getPrice());
                  Main.player1.getBag().delSupplies(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.suppliesShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 3)
            {
               if(Main.player1.getBag().getGemFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(Main.player1.getBag().getGemFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else if(Main.player1.getBag().getGemFromBag(oldNum).getColor() <= 2)
               {
                  Main.player1.addGold(Main.player1.getBag().getGemFromBag(oldNum).getPrice());
                  Main.player1.getBag().delGem(oldNum,1);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 4)
            {
               if(Main.player1.getBag().getOtherobjFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(Main.player1.getBag().getOtherobjFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
            }
            if(selectType == 5)
            {
               ItemsPanel.itemsPanel["isSell"].visible = true;
               ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
            }
         }
         else
         {
            if(selectType == 1)
            {
               if(Main.player2.getBag().getEquipFromBag(oldNum).getColor() <= 2)
               {
                  Main.player2.addGold(Main.player2.getBag().getEquipFromBag(oldNum).getPrice());
                  Main.player2.getBag().delEquip(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.equipShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 2)
            {
               if(Main.player2.getBag().getSuppliesFromBag(oldNum).getColor() <= 2)
               {
                  Main.player2.addGold(Main.player2.getBag().getSuppliesFromBag(oldNum).getPrice());
                  Main.player2.getBag().delSupplies(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.suppliesShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 3)
            {
               if(Main.player2.getBag().getGemFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(Main.player2.getBag().getGemFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else if(Main.player2.getBag().getGemFromBag(oldNum).getColor() <= 2)
               {
                  Main.player2.addGold(Main.player2.getBag().getGemFromBag(oldNum).getPrice());
                  Main.player2.getBag().delGem(oldNum,1);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.gemShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 4)
            {
               if(Main.player2.getBag().getOtherobjFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(Main.player2.getBag().getOtherobjFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
            }
            if(selectType == 5)
            {
               ItemsPanel.itemsPanel["isSell"].visible = true;
               ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
            }
         }
      }
      
      private function noAllSell() : *
      {
         bagNoBug();
         ItemsPanel.itemsPanel["isAllSell"].visible = false;
      }
      
      private function yesAllSell() : *
      {
         var i:* = undefined;
         bagNoBug();
         if(whichDo == 1)
         {
            for(i = 0; i < 24; i++)
            {
               if(Main.player1.getBag().getEquipFromBag(i) != null)
               {
                  if(Main.player1.getBag().getEquipFromBag(i).getColor() <= 2 && Main.player1.getBag().getEquipFromBag(i).getPosition() <= 7)
                  {
                     Main.player1.addGold(Main.player1.getBag().getEquipFromBag(i).getPrice());
                     Main.player1.getBag().delEquip(i);
                  }
               }
            }
            BagItemsShow.equipShow();
            BagItemsShow.informationShow();
         }
         else
         {
            for(i = 0; i < 24; i++)
            {
               if(Main.player2.getBag().getEquipFromBag(i) != null)
               {
                  if(Main.player2.getBag().getEquipFromBag(i).getColor() <= 2 && Main.player2.getBag().getEquipFromBag(i).getPosition() <= 7)
                  {
                     Main.player2.addGold(Main.player2.getBag().getEquipFromBag(i).getPrice());
                     Main.player2.getBag().delEquip(i);
                  }
               }
            }
            BagItemsShow.equipShow2P();
            BagItemsShow.informationShow2P();
         }
         ItemsPanel.itemsPanel["isAllSell"].visible = false;
      }
      
      private function yesHandle() : *
      {
         bagNoBug();
         if(whichDo == 1)
         {
            if(selectType == 1)
            {
               Main.player1.addGold(Main.player1.getBag().getEquipFromBag(oldNum).getPrice());
               Main.player1.getBag().delEquip(oldNum);
               BagItemsShow.equipShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 2)
            {
               Main.player1.addGold(Main.player1.getBag().getSuppliesFromBag(oldNum).getPrice());
               Main.player1.getBag().delSupplies(oldNum);
               BagItemsShow.suppliesShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 3)
            {
               Main.player1.addGold(Main.player1.getBag().getGemFromBag(oldNum).getPrice());
               Main.player1.getBag().delGem(oldNum,1);
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 4)
            {
               Main.player1.addGold(Main.player1.getBag().getOtherobjFromBag(oldNum).getGold());
               Main.player1.getBag().delOtherobj(oldNum,1);
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 5)
            {
               Main.player1.addGold(Main.player1.getBag().getQuestFromBag(oldNum).getGold());
               Main.player1.getBag().delQuset(oldNum);
               BagItemsShow.questShow();
               BagItemsShow.informationShow();
            }
         }
         else
         {
            if(selectType == 1)
            {
               Main.player2.addGold(Main.player2.getBag().getEquipFromBag(oldNum).getPrice());
               Main.player2.getBag().delEquip(oldNum);
               BagItemsShow.equipShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 2)
            {
               Main.player2.addGold(Main.player2.getBag().getSuppliesFromBag(oldNum).getPrice());
               Main.player2.getBag().delSupplies(oldNum);
               BagItemsShow.suppliesShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 3)
            {
               Main.player2.addGold(Main.player2.getBag().getGemFromBag(oldNum).getPrice());
               Main.player2.getBag().delGem(oldNum,1);
               BagItemsShow.gemShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 4)
            {
               Main.player2.addGold(Main.player2.getBag().getOtherobjFromBag(oldNum).getGold());
               Main.player2.getBag().delOtherobj(oldNum,1);
               BagItemsShow.otherobjShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 5)
            {
               Main.player2.addGold(Main.player2.getBag().getQuestFromBag(oldNum).getGold());
               Main.player2.getBag().delQuset(oldNum);
               BagItemsShow.questShow2P();
               BagItemsShow.informationShow2P();
            }
         }
         ItemsPanel.itemsPanel["isSell"].visible = false;
      }
      
      public function btnListen(e:BtnEvent) : *
      {
         var btn:MovieClip = e.target as MovieClip;
         switch(btn.name)
         {
            case "yesBtn_All":
               yesAllSell();
               break;
            case "noBtn_All":
               noAllSell();
               break;
            case "yesBtn":
               yesHandle();
               break;
            case "noBtn":
               bagNoBug();
               ItemsPanel.itemsPanel["isSell"].visible = false;
               break;
            case "sellUp":
               setUp();
               break;
            case "sellDown":
               setDown();
               break;
            case "sellBtn":
               sellBatch();
               bagNoBug();
               break;
            case "closeSellMenu":
               bagNoBug();
               ItemsPanel.itemsPanel["sellMenu"].visible = false;
         }
      }
      
      private function sellBatch() : void
      {
         if(whichDo == 1)
         {
            if(selectType == 3)
            {
               Main.player1.addGold(Main.player1.getBag().getGemFromBag(oldNum).getPrice() * amount.getValue());
               Main.player1.getBag().delGem(oldNum,amount.getValue());
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            else if(selectType == 4)
            {
               Main.player1.addGold(Main.player1.getBag().getOtherobjFromBag(oldNum).getGold() * amount.getValue());
               Main.player1.getBag().delOtherobj(oldNum,amount.getValue());
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
         }
         else if(selectType == 3)
         {
            Main.player2.addGold(Main.player2.getBag().getGemFromBag(oldNum).getPrice() * amount.getValue());
            Main.player2.getBag().delGem(oldNum,amount.getValue());
            BagItemsShow.gemShow2P();
            BagItemsShow.informationShow2P();
         }
         else if(selectType == 4)
         {
            Main.player2.addGold(Main.player2.getBag().getOtherobjFromBag(oldNum).getGold() * amount.getValue());
            Main.player2.getBag().delOtherobj(oldNum,amount.getValue());
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
         ItemsPanel.itemsPanel["sellMenu"].visible = false;
      }
      
      private function setUp() : void
      {
         if(whichDo == 1)
         {
            if(selectType == 3)
            {
               if(amount.getValue() == Main.player1.getBag().getGemFromBag(oldNum).getTimes())
               {
                  amount.setValue(1);
               }
               else
               {
                  amount.setValue(amount.getValue() + 1);
               }
            }
            else if(selectType == 4)
            {
               if(amount.getValue() == Main.player1.getBag().getOtherobjFromBag(oldNum).getTimes())
               {
                  amount.setValue(1);
               }
               else
               {
                  amount.setValue(amount.getValue() + 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
         }
         else
         {
            if(selectType == 3)
            {
               if(amount.getValue() == Main.player2.getBag().getGemFromBag(oldNum).getTimes())
               {
                  amount.setValue(1);
               }
               else
               {
                  amount.setValue(amount.getValue() + 1);
               }
            }
            else if(selectType == 4)
            {
               if(amount.getValue() == Main.player2.getBag().getOtherobjFromBag(oldNum).getTimes())
               {
                  amount.setValue(1);
               }
               else
               {
                  amount.setValue(amount.getValue() + 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
         }
      }
      
      private function setDown() : void
      {
         if(whichDo == 1)
         {
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
            if(selectType == 3)
            {
               if(amount.getValue() == 1)
               {
                  amount.setValue(Main.player1.getBag().getGemFromBag(oldNum).getTimes());
               }
               else
               {
                  amount.setValue(amount.getValue() - 1);
               }
            }
            else if(selectType == 4)
            {
               if(amount.getValue() == 1)
               {
                  amount.setValue(Main.player1.getBag().getOtherobjFromBag(oldNum).getTimes());
               }
               else
               {
                  amount.setValue(amount.getValue() - 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
         }
         else
         {
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
            if(selectType == 3)
            {
               if(amount.getValue() == 1)
               {
                  amount.setValue(Main.player2.getBag().getGemFromBag(oldNum).getTimes());
               }
               else
               {
                  amount.setValue(amount.getValue() - 1);
               }
            }
            else if(selectType == 4)
            {
               if(amount.getValue() == 1)
               {
                  amount.setValue(Main.player2.getBag().getOtherobjFromBag(oldNum).getTimes());
               }
               else
               {
                  amount.setValue(amount.getValue() - 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
         }
      }
      
      public function alluseOther(e:*) : *
      {
         if(whichDo == 1)
         {
            if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 11)
            {
               while(Boolean(Main.player1.getBag().getOtherobjFromBag(oldNum)) && Main.player1.getBag().getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  if(Main.player1.getLevel() > Player.maxLevel)
                  {
                     break;
                  }
                  Main.player_1.ExpUP(InitData.EXP_num.getValue(),2);
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 31)
            {
               while(Boolean(Main.player1.getBag().getOtherobjFromBag(oldNum)) && Main.player1.getBag().getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  if(Main.player1.getLevel() > Player.maxLevel)
                  {
                     break;
                  }
                  Main.player_1.ExpUP(InitData.EXP_big_num.getValue(),2);
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 9)
            {
               while(Boolean(Main.player1.getBag().getOtherobjFromBag(oldNum)) && Main.player1.getBag().getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() + InitData.BuyNum_300.getValue());
                  Main.player1.addGold(InitData.BuyNum_80000.getValue());
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  Main.Save();
               }
            }
            BagItemsShow.otherobjShow();
            BagItemsShow.informationShow();
         }
         else
         {
            if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 11)
            {
               while(Boolean(Main.player2.getBag().getOtherobjFromBag(oldNum)) && Main.player2.getBag().getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  if(Main.player2.getLevel() > Player.maxLevel)
                  {
                     break;
                  }
                  Main.player_2.ExpUP(InitData.EXP_big_num.getValue(),2);
                  Main.player2.getBag().delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 31)
            {
               while(Boolean(Main.player2.getBag().getOtherobjFromBag(oldNum)) && Main.player2.getBag().getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  if(Main.player2.getLevel() > Player.maxLevel)
                  {
                     break;
                  }
                  Main.player_2.ExpUP(InitData.EXP_num.getValue(),2);
                  Main.player2.getBag().delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 9)
            {
               while(Boolean(Main.player2.getBag().getOtherobjFromBag(oldNum)) && Main.player2.getBag().getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() + InitData.BuyNum_300.getValue());
                  Main.player2.addGold(InitData.BuyNum_80000.getValue());
                  Main.player2.getBag().delOtherobj(oldNum,1);
                  Main.Save();
               }
            }
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
      }
      
      public function useOther(e:MouseEvent) : *
      {
         var i:int = 0;
         var skn:uint = 0;
         var skstr:String = null;
         var star:int = 0;
         var usstr:String = null;
         if(whichDo == 1)
         {
            if(selectType == 4)
            {
               if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 4)
               {
                  InitData.EXPxTimeUp(Main.player1.getBag().getOtherobjFromBag(oldNum).getRemaining());
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  Main.Save();
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 5)
               {
                  InitData.DOWNxTimeUp(Main.player1.getBag().getOtherobjFromBag(oldNum).getRemaining());
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  Main.Save();
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 7)
               {
                  MakeData.open(Main.player1.getBag().getOtherobjFromBag(oldNum).getId());
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  ShortTip.open(31);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 9)
               {
                  Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() + InitData.BuyNum_300.getValue());
                  Main.player1.addGold(InitData.BuyNum_80000.getValue());
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  Main.Save();
                  ItemsPanel.itemsPanel["txtTop"].visible = true;
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 10)
               {
                  TaskData.otherUpdataTask();
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  ShortTip.open(34);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 11)
               {
                  if(Main.player1.getLevel() <= Player.maxLevel)
                  {
                     Main.player_1.ExpUP(InitData.EXP_num.getValue(),2);
                     Main.player1.getBag().delOtherobj(oldNum,1);
                     ShortTip.open(35);
                  }
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 31)
               {
                  if(Main.player1.getLevel() <= Player.maxLevel)
                  {
                     Main.player_1.ExpUP(InitData.EXP_big_num.getValue(),2);
                     Main.player1.getBag().delOtherobj(oldNum,1);
                     ShortTip.open(35);
                  }
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 17)
               {
                  QiangHuaPanel.open(true,oldNum);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 18)
               {
                  Main.player1.getBadgeSlot().addToSlot(Main.player1.getBag().getOtherobjFromBag(oldNum),0);
                  Main.player1.getBag().delOtherobj(oldNum,1);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 19)
               {
                  Main.player1.getBadgeSlot().addToSlot(Main.player1.getBag().getOtherobjFromBag(oldNum),1);
                  Main.player1.getBag().delOtherobj(oldNum,1);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 20)
               {
                  Main.player1.getBadgeSlot().addToSlot(Main.player1.getBag().getOtherobjFromBag(oldNum),2);
                  Main.player1.getBag().delOtherobj(oldNum,1);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 21)
               {
                  Main.player1.getBadgeSlot().addToSlot(Main.player1.getBag().getOtherobjFromBag(oldNum),3);
                  Main.player1.getBag().delOtherobj(oldNum,1);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 22)
               {
                  Main.player1.getBadgeSlot().addToSlot(Main.player1.getBag().getOtherobjFromBag(oldNum),4);
                  Main.player1.getBag().delOtherobj(oldNum,1);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 23)
               {
                  Main.player1.getBadgeSlot().addToSlot(Main.player1.getBag().getOtherobjFromBag(oldNum),5);
                  Main.player1.getBag().delOtherobj(oldNum,1);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 24)
               {
                  Main.player1.getTitleSlot().addToSlot(TitleFactory.creatTitle(Main.player1.getBag().getOtherobjFromBag(oldNum).getValue_1()));
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  Main.player_1.cengHao_mc.Show(1);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 25)
               {
                  Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() + InitData.BuyNum_50.getValue());
                  Main.player1.addGold(InitData.BuyNum_18000.getValue());
                  Main.player1.getBag().delOtherobj(oldNum,1);
                  ItemsPanel.itemsPanel["txtTop2"].visible = true;
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 27)
               {
                  Main.player1.getElvesSlot().addElvesSlot(ElvesFactory.creatElves(Main.player1.getBag().getOtherobjFromBag(oldNum).getValue_1()));
                  Main.player1.getBag().delOtherobj(oldNum,1);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 29)
               {
                  upgradePanel.open(Main.player1);
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 26)
               {
                  if(Main.player1.getBag().backOtherBagNum() >= 4)
                  {
                     for(i = 0; i < 5; i++)
                     {
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63138));
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63155));
                     }
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                     Main.player1.getBag().delOtherobj(oldNum,1);
                  }
                  else
                  {
                     ShortTip.open(3);
                  }
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 28)
               {
                  if(Main.player1.getBag().backOtherBagNum() >= 3)
                  {
                     for(i = 0; i < 5; i++)
                     {
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                     }
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63195));
                     Main.player1.getBag().delOtherobj(oldNum,1);
                  }
                  else
                  {
                     ShortTip.open(3);
                  }
               }
               else if(Main.player1.getBag().getOtherobjFromBag(oldNum).getType() == 32)
               {
                  if(Main.player1.getBag().backOtherBagNum() >= 1 && Main.player1.getBag().backequipBagNum() >= 9)
                  {
                     for(i = 0; i < 10; i++)
                     {
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63147));
                     }
                     Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(13524));
                     Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(13424));
                     Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(13724));
                     Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(13624));
                     Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(14311));
                     Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(14211));
                     Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(14111));
                     Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(14450));
                     Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(14433));
                     Main.player1.getBag().delOtherobj(oldNum,1);
                  }
                  else
                  {
                     ShortTip.open(3);
                  }
               }
               BagItemsShow.badgeSlotShow();
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
            else if(selectType == 3)
            {
               if(Main.player1.getBag().getGemFromBag(oldNum).getType() == 5)
               {
                  skn = uint(Main.player1.getBag().getGemFromBag(oldNum).getGemSkill());
                  skstr = Main.player1.getBag().getGemFromBag(oldNum).getDescript();
                  zengfuPanel.open(true,skstr,skn,oldNum);
               }
               else if(Main.player1.getBag().getGemFromBag(oldNum).getType() == 6)
               {
                  star = int(Main.player1.getBag().getGemFromBag(oldNum).getStrengthenLevel());
                  usstr = Main.player1.getBag().getGemFromBag(oldNum).getDescript();
                  upstarPanel.open(true,usstr,star,oldNum);
               }
            }
         }
         else if(selectType == 4)
         {
            if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 4)
            {
               InitData.EXPxTimeUp(Main.player2.getBag().getOtherobjFromBag(oldNum).getRemaining());
               Main.player2.getBag().delOtherobj(oldNum,1);
               Main.Save();
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 5)
            {
               InitData.DOWNxTimeUp(Main.player2.getBag().getOtherobjFromBag(oldNum).getRemaining());
               Main.player2.getBag().delOtherobj(oldNum,1);
               Main.Save();
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 7)
            {
               MakeData.open(Main.player2.getBag().getOtherobjFromBag(oldNum).getId());
               Main.player2.getBag().delOtherobj(oldNum,1);
               ShortTip.open(31);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 9)
            {
               Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() + InitData.BuyNum_300.getValue());
               Main.player2.addGold(InitData.BuyNum_80000.getValue());
               Main.player2.getBag().delOtherobj(oldNum,1);
               Main.Save();
               ItemsPanel.itemsPanel["txtTop"].visible = true;
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 10)
            {
               TaskData.otherUpdataTask();
               Main.player2.getBag().delOtherobj(oldNum,1);
               ShortTip.open(34);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 11)
            {
               if(Main.player2.getLevel() <= Player.maxLevel)
               {
                  Main.player_2.ExpUP(InitData.EXP_num.getValue(),2);
                  Main.player2.getBag().delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 31)
            {
               if(Main.player2.getLevel() <= Player.maxLevel)
               {
                  Main.player_2.ExpUP(InitData.EXP_big_num.getValue(),2);
                  Main.player2.getBag().delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 17)
            {
               QiangHuaPanel.open(false,oldNum);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 18)
            {
               Main.player2.getBadgeSlot().addToSlot(Main.player2.getBag().getOtherobjFromBag(oldNum),0);
               Main.player2.getBag().delOtherobj(oldNum,1);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 19)
            {
               Main.player2.getBadgeSlot().addToSlot(Main.player2.getBag().getOtherobjFromBag(oldNum),1);
               Main.player2.getBag().delOtherobj(oldNum,1);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 20)
            {
               Main.player2.getBadgeSlot().addToSlot(Main.player2.getBag().getOtherobjFromBag(oldNum),2);
               Main.player2.getBag().delOtherobj(oldNum,1);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 21)
            {
               Main.player2.getBadgeSlot().addToSlot(Main.player2.getBag().getOtherobjFromBag(oldNum),3);
               Main.player2.getBag().delOtherobj(oldNum,1);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 22)
            {
               Main.player2.getBadgeSlot().addToSlot(Main.player2.getBag().getOtherobjFromBag(oldNum),4);
               Main.player2.getBag().delOtherobj(oldNum,1);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 23)
            {
               Main.player2.getBadgeSlot().addToSlot(Main.player2.getBag().getOtherobjFromBag(oldNum),5);
               Main.player2.getBag().delOtherobj(oldNum,1);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 24)
            {
               Main.player2.getTitleSlot().addToSlot(TitleFactory.creatTitle(Main.player2.getBag().getOtherobjFromBag(oldNum).getValue_1()));
               Main.player2.getBag().delOtherobj(oldNum,1);
               Main.player_2.cengHao_mc.Show(2);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 27)
            {
               Main.player2.getElvesSlot().addElvesSlot(ElvesFactory.creatElves(Main.player2.getBag().getOtherobjFromBag(oldNum).getValue_1()));
               Main.player2.getBag().delOtherobj(oldNum,1);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 29)
            {
               upgradePanel.open(Main.player2);
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 25)
            {
               Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() + InitData.BuyNum_50.getValue());
               Main.player2.addGold(InitData.BuyNum_18000.getValue());
               Main.player2.getBag().delOtherobj(oldNum,1);
               ItemsPanel.itemsPanel["txtTop2"].visible = true;
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 26)
            {
               if(Main.player2.getBag().backOtherBagNum() >= 4)
               {
                  for(i = 0; i < 5; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63138));
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63155));
                  }
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                  Main.player2.getBag().delOtherobj(oldNum,1);
               }
               else
               {
                  ShortTip.open(3);
               }
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 28)
            {
               if(Main.player2.getBag().backOtherBagNum() >= 3)
               {
                  for(i = 0; i < 5; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                  }
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63195));
                  Main.player2.getBag().delOtherobj(oldNum,1);
               }
               else
               {
                  ShortTip.open(3);
               }
            }
            else if(Main.player2.getBag().getOtherobjFromBag(oldNum).getType() == 32)
            {
               if(Main.player2.getBag().backOtherBagNum() >= 1 && Main.player2.getBag().backequipBagNum() >= 9)
               {
                  for(i = 0; i < 10; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63147));
                  }
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(13524));
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(13424));
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(13724));
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(13624));
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(14311));
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(14211));
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(14111));
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(14450));
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(14433));
                  Main.player2.getBag().delOtherobj(oldNum,1);
               }
               else
               {
                  ShortTip.open(3);
               }
            }
            BagItemsShow.badgeSlotShow2P();
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
         else if(selectType == 3)
         {
            if(Main.player2.getBag().getGemFromBag(oldNum).getType() == 5)
            {
               skn = uint(Main.player2.getBag().getGemFromBag(oldNum).getGemSkill());
               skstr = Main.player2.getBag().getGemFromBag(oldNum).getDescript();
               zengfuPanel.open(false,skstr,skn,oldNum);
            }
            else if(Main.player2.getBag().getGemFromBag(oldNum).getType() == 6)
            {
               star = int(Main.player2.getBag().getGemFromBag(oldNum).getStrengthenLevel());
               usstr = Main.player2.getBag().getGemFromBag(oldNum).getDescript();
               upstarPanel.open(false,usstr,star,oldNum);
            }
         }
      }
      
      public function yesFJ(e:*) : *
      {
         ItemsPanel.itemsPanel["isFenJie"].visible = false;
         if(whichDo == 1)
         {
            doFenJie();
            Main.player1.getBag().delEquip(oldNum);
            BagItemsShow.equipShow();
            BagItemsShow.informationShow();
         }
         else
         {
            doFenJie();
            Main.player2.getBag().delEquip(oldNum);
            BagItemsShow.equipShow2P();
            BagItemsShow.informationShow2P();
         }
      }
      
      public function noFJ(e:*) : *
      {
         ItemsPanel.itemsPanel["isFenJie"].visible = false;
      }
      
      private function closeTXT(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["txtTop"].visible = false;
      }
      
      private function closeTXT2(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["txtTop2"].visible = false;
      }
      
      public function setKey_1(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            su = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(su,0);
         }
         else
         {
            su = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(su,0);
         }
      }
      
      public function setKey_2(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            su = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(su,1);
         }
         else
         {
            su = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(su,1);
         }
      }
      
      public function setKey_3(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            su = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(su,2);
         }
         else
         {
            su = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(su,2);
         }
      }
      
      public function yesXF(e:*) : *
      {
         Api_4399_All.Money_down(InitData.fuHua.getValue());
         moneyOK2 = true;
         ItemsPanel.itemsPanel["xfRMB"].visible = false;
      }
      
      public function noXF(e:*) : *
      {
         ItemsPanel.itemsPanel["xfRMB"].visible = false;
      }
      
      public function xufei(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["xfRMB"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["xfRMB"]);
      }
      
      public function xianshi(e:MouseEvent) : *
      {
         if(oldNum == 6 && Main["player_" + whichDo].skin_Z2_V == false)
         {
            Main["player_" + whichDo].skin_Z2_V = true;
         }
         else if(oldNum == 7 && Main["player_" + whichDo].skin_Z3_V == false)
         {
            Main["player_" + whichDo].skin_Z3_V = true;
         }
         (Main["player_" + whichDo] as Player).noHead = false;
         Main["player_" + whichDo].newSkin();
      }
      
      public function yincang(e:MouseEvent) : *
      {
         if(oldNum == 6 && Main["player_" + whichDo].skin_Z2_V == true)
         {
            Main["player_" + whichDo].skin_Z2_V = false;
         }
         else if(oldNum == 7 && Main["player_" + whichDo].skin_Z3_V == true)
         {
            Main["player_" + whichDo].skin_Z3_V = false;
         }
         Main["player_" + whichDo].newSkin();
      }
   }
}

