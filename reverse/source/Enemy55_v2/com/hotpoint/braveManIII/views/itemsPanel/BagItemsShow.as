package com.hotpoint.braveManIII.views.itemsPanel
{
   import flash.utils.*;
   import src.*;
   
   public class BagItemsShow
   {
      
      internal var timeOut:int;
      
      public function BagItemsShow()
      {
         super();
      }
      
      public static function allHide() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.visible = true;
            ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            ItemsPanel.itemsPanel["s1_" + _loc1_]["diKuang"].visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            ItemsPanel.itemsPanel["z1_" + _loc1_].t_txt.text = "";
            ItemsPanel.itemsPanel["z1_" + _loc1_].visible = false;
            ItemsPanel.itemsPanel["k1_" + _loc1_].visible = false;
            ItemsPanel.itemsPanel["z1_" + _loc1_]["diKuang"].visible = false;
            _loc1_++;
         }
         ItemsPanel.itemsPanel["g1_0"].visible = false;
         ItemsPanel.itemsPanel["g1_1"].visible = false;
      }
      
      public static function skillSlotShow() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 2)
         {
            if(Main.player1.getEquipSkillSlot().getGemFromSkillSlot(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["g1_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["g1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function skillSlotShow2P() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 2)
         {
            if(Main.player2.getEquipSkillSlot().getGemFromSkillSlot(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["g1_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["g1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function clearTimeout() : void
      {
         if(timeOut > 0)
         {
            clearTimeout(timeOut);
         }
      }
      
      public static function informationShow() : void
      {
         timeOut = setTimeout(show1P,100);
      }
      
      private static function showLV(param1:Number) : *
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 < 10)
         {
            ItemsPanel.itemsPanel["shiwei"].gotoAndStop(param1);
            ItemsPanel.itemsPanel["gewei"].visible = false;
         }
         else
         {
            ItemsPanel.itemsPanel["gewei"].visible = true;
            _loc2_ = param1.toString();
            _loc3_ = int(_loc2_.substring(0,1));
            _loc4_ = int(_loc2_.substring(1,2));
            ItemsPanel.itemsPanel["shiwei"].gotoAndStop(_loc3_);
            if(_loc4_ == 0)
            {
               ItemsPanel.itemsPanel["gewei"].gotoAndStop(10);
            }
            else
            {
               ItemsPanel.itemsPanel["gewei"].gotoAndStop(_loc4_);
            }
         }
      }
      
      public static function zyShow(param1:int) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            if(_loc2_ == 3)
            {
               ItemsPanel.itemsPanel["ZY_txt"].text = "新手";
            }
            else if(Main["player" + param1]._transferArr[_loc2_])
            {
               if(_loc2_ == 0)
               {
                  ItemsPanel.itemsPanel["ZY_txt"].text = "杀戮战神";
               }
               else if(_loc2_ == 1)
               {
                  ItemsPanel.itemsPanel["ZY_txt"].text = "汲魂术士";
               }
               else
               {
                  ItemsPanel.itemsPanel["ZY_txt"].text = "毁灭拳神";
               }
               break;
            }
            _loc2_++;
         }
      }
      
      public static function QiangHuaJiaChengP1() : *
      {
         var _loc1_:int = int(Main.player1.getEquipSlot().getSuitStrength());
         if(_loc1_ < 4)
         {
            ItemsPanel.itemsPanel["strengthen"].gotoAndStop(1);
            return;
         }
         ItemsPanel.itemsPanel["strengthen"].gotoAndStop(_loc1_ - 2);
      }
      
      public static function QiangHuaJiaChengP2() : *
      {
         var _loc1_:int = int(Main.player2.getEquipSlot().getSuitStrength());
         if(_loc1_ < 4)
         {
            ItemsPanel.itemsPanel["strengthen"].gotoAndStop(1);
            return;
         }
         ItemsPanel.itemsPanel["strengthen"].gotoAndStop(_loc1_ - 2);
      }
      
      public static function show1P() : *
      {
         zyShow(1);
         ItemsPanel.itemsPanel["name_txt"].text = Main.logName;
         ItemsPanel.itemsPanel["mkPoint"].text = int(Main.player_1.use_fangyu2.getValue());
         ItemsPanel.itemsPanel["pmPoint"].text = int(Main.player_1.use_gongji2.getValue());
         ItemsPanel.itemsPanel["hpPoint"].text = int(Main.player_1.use_hp_Max.getValue());
         ItemsPanel.itemsPanel["mpPoint"].text = int(Main.player_1.use_mp_Max.getValue());
         ItemsPanel.itemsPanel["attackPoint"].text = int(Main.player_1.use_gongji.getValue());
         ItemsPanel.itemsPanel["defensePoint"].text = int(Main.player_1.use_fangyu.getValue());
         ItemsPanel.itemsPanel["critPoint"].text = Math.pow(Number(Main.player_1.use_baoji.getValue() / 70),0.8).toFixed(1) + "%";
         ItemsPanel.itemsPanel["duckPoint"].text = Math.pow(Number(Main.player_1.use_sanbi.getValue() / 100),0.8).toFixed(1) + "%";
         ItemsPanel.itemsPanel["gold1"].text = Main.player1.getGold();
         ItemsPanel.itemsPanel["kill_txt"].text = Main.player1.killPoint.getValue();
         ItemsPanel.itemsPanel["expPoint"].text = Main.player1.getEXP() + " / " + Main.player_1.nextExp.getValue();
         ItemsPanel.itemsPanel["jyt"]["zd"].scaleX = Main.player1.getEXP() / Main.player_1.nextExp.getValue();
         if(Main.player1.getTitleSlot().getTitleView())
         {
            ItemsPanel.itemsPanel["chenghao"].gotoAndStop(Main.player1.getTitleSlot().getTitleView().getFrame());
         }
         else
         {
            ItemsPanel.itemsPanel["chenghao"].gotoAndStop(1);
         }
         if(Main.player1.playerJL_Data)
         {
            ItemsPanel.itemsPanel["jingling"].gotoAndStop(Main.player1.playerJL_Data.getFrame() + 1);
         }
         else
         {
            ItemsPanel.itemsPanel["jingling"].gotoAndStop(1);
         }
         if(Main.player1.getElvesSlot().backElvesNum() == 0)
         {
            ItemsPanel.itemsPanel["jingling_btn"].visible = false;
         }
         else
         {
            ItemsPanel.itemsPanel["jingling_btn"].visible = true;
         }
         showLV(Main.player1.getLevel());
         QiangHuaJiaChengP1();
      }
      
      public static function informationShow2P() : void
      {
         timeOut = setTimeout(show2P,100);
      }
      
      public static function show2P() : *
      {
         zyShow(2);
         ItemsPanel.itemsPanel["mkPoint"].text = int(Main.player_2.use_fangyu2.getValue());
         ItemsPanel.itemsPanel["pmPoint"].text = int(Main.player_2.use_gongji2.getValue());
         ItemsPanel.itemsPanel["hpPoint"].text = int(Main.player_2.use_hp_Max.getValue());
         ItemsPanel.itemsPanel["mpPoint"].text = int(Main.player_2.use_mp_Max.getValue());
         ItemsPanel.itemsPanel["attackPoint"].text = int(Main.player_2.use_gongji.getValue());
         ItemsPanel.itemsPanel["defensePoint"].text = int(Main.player_2.use_fangyu.getValue());
         ItemsPanel.itemsPanel["critPoint"].text = Math.pow(Number(Main.player_2.use_baoji.getValue() / 70),0.8).toFixed(1) + "%";
         ItemsPanel.itemsPanel["duckPoint"].text = Math.pow(Number(Main.player_2.use_sanbi.getValue() / 100),0.8).toFixed(1) + "%";
         ItemsPanel.itemsPanel["gold1"].text = Main.player2.getGold();
         ItemsPanel.itemsPanel["kill_txt"].text = Main.player2.killPoint.getValue();
         ItemsPanel.itemsPanel["expPoint"].text = Main.player2.getEXP() + " / " + Main.player_2.nextExp.getValue();
         ItemsPanel.itemsPanel["jyt"]["zd"].scaleX = Main.player2.getEXP() / Main.player_2.nextExp.getValue();
         if(Main.player2.getTitleSlot().getTitleView())
         {
            ItemsPanel.itemsPanel["chenghao"].gotoAndStop(Main.player2.getTitleSlot().getTitleView().getFrame());
         }
         else
         {
            ItemsPanel.itemsPanel["chenghao"].gotoAndStop(1);
         }
         if(Main.player2.playerJL_Data)
         {
            ItemsPanel.itemsPanel["jingling"].gotoAndStop(Main.player2.playerJL_Data.getFrame() + 1);
         }
         else
         {
            ItemsPanel.itemsPanel["jingling"].gotoAndStop(1);
         }
         if(Main.player2.getElvesSlot().backElvesNum() == 0)
         {
            ItemsPanel.itemsPanel["jingling_btn"].visible = false;
         }
         else
         {
            ItemsPanel.itemsPanel["jingling_btn"].visible = true;
         }
         showLV(Main.player2.getLevel());
         QiangHuaJiaChengP2();
      }
      
      public static function equipShow() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player1.getBag().getEquipFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getBag().getEquipFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function equipShow2P() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player2.getBag().getEquipFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getBag().getEquipFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function gemShow() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player1.getBag().getGemFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getBag().getGemFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(Main.player1.getBag().getGemFromBag(_loc1_).getIsPile() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = Main.player1.getBag().getGemFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function gemShow2P() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player2.getBag().getGemFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getBag().getGemFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(Main.player2.getBag().getGemFromBag(_loc1_).getIsPile() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = Main.player2.getBag().getGemFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function suppliesShow() : void
      {
         if(ItemsPanel.boolFlag == false)
         {
            return;
         }
         ItemsPanel.menuTooltip.visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player1.getBag().getSuppliesFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getBag().getSuppliesFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(Main.player1.getBag().getSuppliesFromBag(_loc1_).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = Main.player1.getBag().getSuppliesFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function suppliesShow2P() : void
      {
         if(ItemsPanel.boolFlag == false)
         {
            return;
         }
         ItemsPanel.menuTooltip.visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player2.getBag().getSuppliesFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getBag().getSuppliesFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(Main.player2.getBag().getSuppliesFromBag(_loc1_).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = Main.player2.getBag().getSuppliesFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function slotShow() : void
      {
         var _loc2_:int = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = int(_loc1_);
            if(Main.water.getValue() != 1 && (_loc1_ == 0 || _loc1_ == 1 || _loc1_ == 3 || _loc1_ == 4))
            {
               _loc2_ += 8;
            }
            ItemsPanel.itemsPanel["z1_" + _loc1_].t_txt.text = "";
            if(Main.player1.getEquipSlot().getEquipFromSlot(_loc2_) != null)
            {
               ItemsPanel.itemsPanel["z1_" + _loc1_].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(_loc2_).getFrame());
               ItemsPanel.itemsPanel["z1_" + _loc1_].visible = true;
               ItemsPanel.itemsPanel["z1_" + _loc1_]["diKuang"].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["z1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function slotShow2P() : void
      {
         var _loc2_:int = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = int(_loc1_);
            if(Main.water.getValue() != 1 && (_loc1_ == 0 || _loc1_ == 1 || _loc1_ == 3 || _loc1_ == 4))
            {
               _loc2_ += 8;
            }
            ItemsPanel.itemsPanel["z1_" + _loc1_].t_txt.text = "";
            if(Main.player2.getEquipSlot().getEquipFromSlot(_loc2_) != null)
            {
               ItemsPanel.itemsPanel["z1_" + _loc1_].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(_loc2_).getFrame());
               ItemsPanel.itemsPanel["z1_" + _loc1_].visible = true;
               ItemsPanel.itemsPanel["z1_" + _loc1_]["diKuang"].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["z1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function badgeSlotShow() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            if(Main.player1.getBadgeSlot().getBadgeFromSlot(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["hz" + _loc1_].gotoAndStop(Main.player1.getBadgeSlot().getBadgeFromSlot(_loc1_).getFrame());
               ItemsPanel.itemsPanel["hz" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["hz" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function badgeSlotShow2P() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            if(Main.player2.getBadgeSlot().getBadgeFromSlot(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["hz" + _loc1_].gotoAndStop(Main.player2.getBadgeSlot().getBadgeFromSlot(_loc1_).getFrame());
               ItemsPanel.itemsPanel["hz" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["hz" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function questShow() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player1.getBag().getQuestFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getBag().getQuestFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(Main.player1.getBag().getQuestFromBag(_loc1_).isMany() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = Main.player1.getBag().getQuestFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function questShow2P() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player2.getBag().getQuestFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getBag().getQuestFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(Main.player2.getBag().getQuestFromBag(_loc1_).isMany() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = Main.player2.getBag().getQuestFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function otherobjShow() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player1.getBag().getOtherobjFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player1.getBag().getOtherobjFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(Main.player1.getBag().getOtherobjFromBag(_loc1_).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = Main.player1.getBag().getOtherobjFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function otherobjShow2P() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(Main.player2.getBag().getOtherobjFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(Main.player2.getBag().getOtherobjFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(Main.player2.getBag().getOtherobjFromBag(_loc1_).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = Main.player2.getBag().getOtherobjFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
   }
}

