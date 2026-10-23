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
      
      public static function slotShow2P() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            ItemsPanel.itemsPanel["z2_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player2.getEquipSlot().getEquipFromSlot(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["z2_" + _loc1_].gotoAndStop(ItemsPanel.player2.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
               ItemsPanel.itemsPanel["z2_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["z2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function allHide() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            ItemsPanel.itemsPanel["s2_" + _loc1_].t_txt.text = "";
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.visible = true;
            ItemsPanel.itemsPanel["s2_" + _loc1_].t_txt.visible = true;
            ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            ItemsPanel.itemsPanel["s2_" + _loc1_].visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            ItemsPanel.itemsPanel["z1_" + _loc1_].t_txt.text = "";
            ItemsPanel.itemsPanel["z2_" + _loc1_].t_txt.text = "";
            ItemsPanel.itemsPanel["z1_" + _loc1_].visible = false;
            ItemsPanel.itemsPanel["z2_" + _loc1_].visible = false;
            _loc1_++;
         }
         ItemsPanel.itemsPanel["g1_0"].visible = false;
         ItemsPanel.itemsPanel["g1_1"].visible = false;
         ItemsPanel.itemsPanel["g2_0"].visible = false;
         ItemsPanel.itemsPanel["g2_1"].visible = false;
      }
      
      public static function questShow2P() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s2_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getQuestFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].gotoAndStop(ItemsPanel.player2.getBag().getQuestFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function otherobjShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getOtherobjFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(ItemsPanel.player1.getBag().getOtherobjFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function informationShow2P() : void
      {
         timeOut = setTimeout(show2P,100);
      }
      
      public static function suppliesShow2P() : void
      {
         var _loc1_:uint = 0;
         if(ItemsPanel.boolFlag == false)
         {
            return;
         }
         ItemsPanel.menuTooltip.visible = false;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s2_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getSuppliesFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].gotoAndStop(ItemsPanel.player2.getBag().getSuppliesFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = true;
               if(ItemsPanel.player2.getBag().getSuppliesFromBag(_loc1_).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s2_" + _loc1_].t_txt.text = ItemsPanel.player2.getBag().getSuppliesFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function informationShow() : void
      {
         timeOut = setTimeout(show1P,100);
      }
      
      public static function skillSlotShow2P() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            if(ItemsPanel.player2.getEquipSkillSlot().getGemFromSkillSlot(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["g2_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["g2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function equipShow2P() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s2_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getEquipFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].gotoAndStop(ItemsPanel.player2.getBag().getEquipFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function skillSlotShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            if(ItemsPanel.player1.getEquipSkillSlot().getGemFromSkillSlot(_loc1_) != null)
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
      
      public static function equipShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getEquipFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(ItemsPanel.player1.getBag().getEquipFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
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
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s2_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getGemFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].gotoAndStop(ItemsPanel.player2.getBag().getGemFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = true;
               if(ItemsPanel.player2.getBag().getGemFromBag(_loc1_).getIsPile() == true)
               {
                  ItemsPanel.itemsPanel["s2_" + _loc1_].t_txt.text = ItemsPanel.player2.getBag().getGemFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function gemShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getGemFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(ItemsPanel.player1.getBag().getGemFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(ItemsPanel.player1.getBag().getGemFromBag(_loc1_).getIsPile() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = ItemsPanel.player1.getBag().getGemFromBag(_loc1_).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = false;
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
      
      public static function suppliesShow() : void
      {
         var _loc1_:uint = 0;
         if(ItemsPanel.boolFlag == false)
         {
            return;
         }
         ItemsPanel.menuTooltip.visible = false;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getSuppliesFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(ItemsPanel.player1.getBag().getSuppliesFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
               if(ItemsPanel.player1.getBag().getSuppliesFromBag(_loc1_).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = ItemsPanel.player1.getBag().getSuppliesFromBag(_loc1_).getTimes();
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
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s2_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getOtherobjFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].gotoAndStop(ItemsPanel.player2.getBag().getOtherobjFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function show2P() : *
      {
         ItemsPanel.itemsPanel["attackPoint2P"].text = int(Main.player_2.use_gongji.getValue());
         ItemsPanel.itemsPanel["defensePoint2P"].text = int(Main.player_2.use_fangyu.getValue());
         ItemsPanel.itemsPanel["speedPoint2P"].text = int(Main.player_2.walk_power.getValue());
         ItemsPanel.itemsPanel["critPoint2P"].text = int(Main.player_2.use_baoji.getValue());
         ItemsPanel.itemsPanel["duckPoint2P"].text = int(Main.player_2.use_sanbi.getValue());
         ItemsPanel.itemsPanel["gold2"].text = ItemsPanel.player2.getGold();
         ItemsPanel.itemsPanel["level_2"].text = "LV:" + ItemsPanel.player2.getLevel();
      }
      
      public static function show1P() : *
      {
         ItemsPanel.itemsPanel["attackPoint"].text = int(Main.player_1.use_gongji.getValue());
         ItemsPanel.itemsPanel["defensePoint"].text = int(Main.player_1.use_fangyu.getValue());
         ItemsPanel.itemsPanel["speedPoint"].text = int(Main.player_1.walk_power.getValue());
         ItemsPanel.itemsPanel["critPoint"].text = int(Main.player_1.use_baoji.getValue());
         ItemsPanel.itemsPanel["duckPoint"].text = int(Main.player_1.use_sanbi.getValue());
         ItemsPanel.itemsPanel["gold1"].text = ItemsPanel.player1.getGold();
         ItemsPanel.itemsPanel["level_1"].text = "LV:" + ItemsPanel.player1.getLevel();
      }
      
      public static function slotShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            ItemsPanel.itemsPanel["z1_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player1.getEquipSlot().getEquipFromSlot(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["z1_" + _loc1_].gotoAndStop(ItemsPanel.player1.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
               ItemsPanel.itemsPanel["z1_" + _loc1_].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["z1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function questShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ItemsPanel.itemsPanel["s1_" + _loc1_].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getQuestFromBag(_loc1_) != null)
            {
               ItemsPanel.itemsPanel["s1_" + _loc1_].gotoAndStop(ItemsPanel.player1.getBag().getQuestFromBag(_loc1_).getFrame());
               ItemsPanel.itemsPanel["s1_" + _loc1_].visible = true;
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

