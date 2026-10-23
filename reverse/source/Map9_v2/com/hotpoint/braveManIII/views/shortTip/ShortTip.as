package com.hotpoint.braveManIII.views.shortTip
{
   import flash.display.*;
   import src.*;
   
   public class ShortTip extends MovieClip
   {
      
      public static var st:ShortTip;
      
      private static var shortTip:MovieClip = new ShortTipShow();
      
      public function ShortTip()
      {
         super();
         this.addChild(shortTip);
         shortTip.visible = false;
      }
      
      public static function open(frame:int) : void
      {
         if(st == null)
         {
            st = new ShortTip();
         }
         Main._stage.addChild(st);
         st.x = 450;
         st.y = 300;
         st.visible = true;
         switch(frame)
         {
            case 1:
               taskMax();
               break;
            case 2:
               noHollowed();
               break;
            case 3:
               noSpace();
               break;
            case 4:
               itemsTypeWrong();
               break;
            case 5:
               strengthenMax();
               break;
            case 6:
               setItemsFrist();
               break;
            case 7:
               noSlot();
               break;
            case 8:
               alreadySet();
               break;
            case 9:
               composeMax();
               break;
            case 10:
               noCompose();
               break;
            case 11:
               weaponLevelOver();
               break;
            case 12:
               setSkillKeyOk();
               break;
            case 13:
               noReSet();
               break;
            case 14:
               noSetAfterPay();
               break;
            case 15:
               reSetOk();
               break;
            case 16:
               noGold();
               break;
            case 17:
               upSkillOk();
               break;
            case 18:
               setKeyOk();
               break;
            case 19:
               noSetKey();
               break;
            case 20:
               noSkillPoint();
               break;
            case 21:
               noTakeoffWeapon();
               break;
            case 22:
               belowWeaponLV();
               break;
            case 23:
               sameGemLV();
               break;
            case 24:
               belowEquipLV();
               break;
            case 25:
               noWearLV();
               break;
            case 26:
               noTransfer();
               break;
            case 27:
               AAA27();
               break;
            case 28:
               AAA28();
               break;
            case 29:
               makeOk();
               break;
            case 31:
               allowMake();
               break;
            case 32:
               killpoint();
               break;
            case 33:
               zfOK();
               break;
            case 34:
               renwuOK();
               break;
            case 35:
               useOK();
               break;
            case 36:
               noFood();
               break;
            case 37:
               noPetSlot();
               break;
            case 38:
               qhOK();
               break;
            case 39:
               hcOK();
               break;
            case 40:
               qhshibai();
               break;
            case 41:
               petjinhua();
               break;
            case 42:
               chengjiuPoint();
               break;
            case 43:
               zhufuOK();
               break;
            case 44:
               fangRuOK();
               break;
            case 45:
               xishouNO();
               break;
            case 46:
               fun46();
         }
      }
      
      public static function close() : void
      {
         if(st == null)
         {
            st = new ShortTip();
         }
         st.visible = false;
      }
      
      public static function taskMax() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(1);
         if(shortTip.mc_1)
         {
            shortTip.mc_1.gotoAndPlay(1);
         }
      }
      
      public static function noHollowed() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(2);
         if(shortTip.mc_2)
         {
            shortTip.mc_2.gotoAndPlay(1);
         }
      }
      
      public static function noSpace() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(3);
         if(shortTip.mc_3)
         {
            shortTip.mc_3.gotoAndPlay(1);
         }
      }
      
      public static function itemsTypeWrong() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(4);
         if(shortTip.mc_4)
         {
            shortTip.mc_4.gotoAndPlay(1);
         }
      }
      
      public static function strengthenMax() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(5);
         if(shortTip.mc_5)
         {
            shortTip.mc_5.gotoAndPlay(1);
         }
      }
      
      public static function setItemsFrist() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(6);
         if(shortTip.mc_6)
         {
            shortTip.mc_6.gotoAndPlay(1);
         }
      }
      
      public static function noSlot() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(7);
         if(shortTip.mc_7)
         {
            shortTip.mc_7.gotoAndPlay(1);
         }
      }
      
      public static function alreadySet() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(8);
         if(shortTip.mc_8)
         {
            shortTip.mc_8.gotoAndPlay(1);
         }
      }
      
      public static function composeMax() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(9);
         if(shortTip.mc_9)
         {
            shortTip.mc_9.gotoAndPlay(1);
         }
      }
      
      public static function noCompose() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(10);
         if(shortTip.mc_10)
         {
            shortTip.mc_10.gotoAndPlay(1);
         }
      }
      
      public static function weaponLevelOver() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(11);
         if(shortTip.mc_11)
         {
            shortTip.mc_11.gotoAndPlay(1);
         }
      }
      
      public static function setSkillKeyOk() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(12);
         if(shortTip.mc_12)
         {
            shortTip.mc_12.gotoAndPlay(1);
         }
      }
      
      public static function noReSet() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(13);
         if(shortTip.mc_13)
         {
            shortTip.mc_13.gotoAndPlay(1);
         }
      }
      
      public static function noSetAfterPay() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(14);
         if(shortTip.mc_14)
         {
            shortTip.mc_14.gotoAndPlay(1);
         }
      }
      
      public static function reSetOk() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(15);
         if(shortTip.mc_15)
         {
            shortTip.mc_15.gotoAndPlay(1);
         }
      }
      
      public static function noGold() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(16);
         if(shortTip.mc_16)
         {
            shortTip.mc_16.gotoAndPlay(1);
         }
      }
      
      public static function upSkillOk() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(17);
         if(shortTip.mc_17)
         {
            shortTip.mc_17.gotoAndPlay(1);
         }
      }
      
      public static function setKeyOk() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(18);
         if(shortTip.mc_18)
         {
            shortTip.mc_18.gotoAndPlay(1);
         }
      }
      
      public static function noSetKey() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(19);
         if(shortTip.mc_19)
         {
            shortTip.mc_19.gotoAndPlay(1);
         }
      }
      
      public static function noSkillPoint() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(20);
         if(shortTip.mc_20)
         {
            shortTip.mc_20.gotoAndPlay(1);
         }
      }
      
      public static function noTakeoffWeapon() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(21);
         if(shortTip.mc_21)
         {
            shortTip.mc_21.gotoAndPlay(1);
         }
      }
      
      public static function belowWeaponLV() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(22);
         if(shortTip.mc_22)
         {
            shortTip.mc_22.gotoAndPlay(1);
         }
      }
      
      public static function sameGemLV() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(23);
         if(shortTip.mc_23)
         {
            shortTip.mc_23.gotoAndPlay(1);
         }
      }
      
      public static function belowEquipLV() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(24);
         if(shortTip.mc_24)
         {
            shortTip.mc_24.gotoAndPlay(1);
         }
      }
      
      public static function noWearLV() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(25);
         if(shortTip.mc_25)
         {
            shortTip.mc_25.gotoAndPlay(1);
         }
      }
      
      public static function noTransfer() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(26);
         if(shortTip.mc_26)
         {
            shortTip.mc_26.gotoAndPlay(1);
         }
      }
      
      public static function AAA27() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(27);
         if(shortTip.mc_27)
         {
            shortTip.mc_27.gotoAndPlay(1);
         }
      }
      
      public static function AAA28() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(28);
         if(shortTip.mc_28)
         {
            shortTip.mc_28.gotoAndPlay(1);
         }
      }
      
      public static function makeOk() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(29);
         if(shortTip.mc_29)
         {
            shortTip.mc_29.gotoAndPlay(1);
         }
      }
      
      public static function allowMake() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(31);
         if(shortTip.mc_31)
         {
            shortTip.mc_31.gotoAndPlay(1);
         }
      }
      
      public static function zfOK() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(33);
         if(shortTip.mc_33)
         {
            shortTip.mc_33.gotoAndPlay(1);
         }
      }
      
      public static function renwuOK() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(34);
         if(shortTip.mc_34)
         {
            shortTip.mc_34.gotoAndPlay(1);
         }
      }
      
      public static function useOK() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(35);
         if(shortTip.mc_35)
         {
            shortTip.mc_35.gotoAndPlay(1);
         }
      }
      
      public static function noFood() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(36);
         if(shortTip.mc_36)
         {
            shortTip.mc_36.gotoAndPlay(1);
         }
      }
      
      public static function noPetSlot() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(37);
         if(shortTip.mc_37)
         {
            shortTip.mc_37.gotoAndPlay(1);
         }
      }
      
      public static function qhOK() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(38);
         if(shortTip.mc_38)
         {
            shortTip.mc_38.gotoAndPlay(1);
         }
      }
      
      public static function hcOK() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(39);
         if(shortTip.mc_39)
         {
            shortTip.mc_39.gotoAndPlay(1);
         }
      }
      
      public static function qhshibai() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(40);
         if(shortTip.mc_40)
         {
            shortTip.mc_40.gotoAndPlay(1);
         }
      }
      
      public static function petjinhua() : void
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(41);
         if(shortTip.mc_41)
         {
            shortTip.mc_41.gotoAndPlay(1);
         }
      }
      
      private static function chengjiuPoint() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(42);
         if(shortTip.mc_42)
         {
            shortTip.mc_42.gotoAndPlay(1);
         }
      }
      
      private static function zhufuOK() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(43);
         if(shortTip.mc_43)
         {
            shortTip.mc_43.gotoAndPlay(1);
         }
      }
      
      private static function fangRuOK() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(44);
         if(shortTip.mc_44)
         {
            shortTip.mc_44.gotoAndPlay(1);
         }
      }
      
      private static function xishouNO() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(45);
         if(shortTip.mc_45)
         {
            shortTip.mc_45.gotoAndPlay(1);
         }
      }
      
      private static function fun46() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(46);
         if(shortTip.mc_46)
         {
            shortTip.mc_46.gotoAndPlay(1);
         }
      }
      
      private static function killpoint() : *
      {
         shortTip.visible = true;
         shortTip.gotoAndStop(32);
         if(shortTip.mc_32)
         {
            shortTip.mc_32.gotoAndPlay(1);
         }
      }
   }
}

