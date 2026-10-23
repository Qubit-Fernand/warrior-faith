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
         var i:uint = 0;
         for(i = 0; i < 6; i++)
         {
            ItemsPanel.itemsPanel["z2_" + i].t_txt.text = "";
            if(ItemsPanel.player2.getEquipSlot().getEquipFromSlot(i) != null)
            {
               ItemsPanel.itemsPanel["z2_" + i].gotoAndStop(ItemsPanel.player2.getEquipSlot().getEquipFromSlot(i).getFrame());
               ItemsPanel.itemsPanel["z2_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["z2_" + i].visible = false;
            }
         }
      }
      
      public static function allHide() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            ItemsPanel.itemsPanel["s2_" + i].t_txt.text = "";
            ItemsPanel.itemsPanel["s1_" + i].t_txt.visible = true;
            ItemsPanel.itemsPanel["s2_" + i].t_txt.visible = true;
            ItemsPanel.itemsPanel["s1_" + i].visible = false;
            ItemsPanel.itemsPanel["s2_" + i].visible = false;
         }
         for(i = 0; i < 6; i++)
         {
            ItemsPanel.itemsPanel["z1_" + i].t_txt.text = "";
            ItemsPanel.itemsPanel["z2_" + i].t_txt.text = "";
            ItemsPanel.itemsPanel["z1_" + i].visible = false;
            ItemsPanel.itemsPanel["z2_" + i].visible = false;
         }
         ItemsPanel.itemsPanel["g1_0"].visible = false;
         ItemsPanel.itemsPanel["g1_1"].visible = false;
         ItemsPanel.itemsPanel["g2_0"].visible = false;
         ItemsPanel.itemsPanel["g2_1"].visible = false;
      }
      
      public static function questShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s2_" + i].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getQuestFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s2_" + i].gotoAndStop(ItemsPanel.player2.getBag().getQuestFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s2_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + i].visible = false;
            }
         }
      }
      
      public static function otherobjShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getOtherobjFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(ItemsPanel.player1.getBag().getOtherobjFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function informationShow2P() : void
      {
         timeOut = setTimeout(show2P,100);
      }
      
      public static function suppliesShow2P() : void
      {
         var i:uint = 0;
         if(ItemsPanel.boolFlag == false)
         {
            return;
         }
         ItemsPanel.menuTooltip.visible = false;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s2_" + i].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getSuppliesFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s2_" + i].gotoAndStop(ItemsPanel.player2.getBag().getSuppliesFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s2_" + i].visible = true;
               if(ItemsPanel.player2.getBag().getSuppliesFromBag(i).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s2_" + i].t_txt.text = ItemsPanel.player2.getBag().getSuppliesFromBag(i).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + i].visible = false;
            }
         }
      }
      
      public static function informationShow() : void
      {
         timeOut = setTimeout(show1P,100);
      }
      
      public static function skillSlotShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 2; i++)
         {
            if(ItemsPanel.player2.getEquipSkillSlot().getGemFromSkillSlot(i) != null)
            {
               ItemsPanel.itemsPanel["g2_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["g2_" + i].visible = false;
            }
         }
      }
      
      public static function equipShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s2_" + i].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getEquipFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s2_" + i].gotoAndStop(ItemsPanel.player2.getBag().getEquipFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s2_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + i].visible = false;
            }
         }
      }
      
      public static function skillSlotShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 2; i++)
         {
            if(ItemsPanel.player1.getEquipSkillSlot().getGemFromSkillSlot(i) != null)
            {
               ItemsPanel.itemsPanel["g1_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["g1_" + i].visible = false;
            }
         }
      }
      
      public static function equipShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getEquipFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(ItemsPanel.player1.getBag().getEquipFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function gemShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s2_" + i].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getGemFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s2_" + i].gotoAndStop(ItemsPanel.player2.getBag().getGemFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s2_" + i].visible = true;
               if(ItemsPanel.player2.getBag().getGemFromBag(i).getIsPile() == true)
               {
                  ItemsPanel.itemsPanel["s2_" + i].t_txt.text = ItemsPanel.player2.getBag().getGemFromBag(i).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + i].visible = false;
            }
         }
      }
      
      public static function gemShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getGemFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(ItemsPanel.player1.getBag().getGemFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(ItemsPanel.player1.getBag().getGemFromBag(i).getIsPile() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = ItemsPanel.player1.getBag().getGemFromBag(i).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
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
         var i:uint = 0;
         if(ItemsPanel.boolFlag == false)
         {
            return;
         }
         ItemsPanel.menuTooltip.visible = false;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getSuppliesFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(ItemsPanel.player1.getBag().getSuppliesFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(ItemsPanel.player1.getBag().getSuppliesFromBag(i).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = ItemsPanel.player1.getBag().getSuppliesFromBag(i).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function otherobjShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s2_" + i].t_txt.text = "";
            if(ItemsPanel.player2.getBag().getOtherobjFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s2_" + i].gotoAndStop(ItemsPanel.player2.getBag().getOtherobjFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s2_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s2_" + i].visible = false;
            }
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
         var i:uint = 0;
         for(i = 0; i < 6; i++)
         {
            ItemsPanel.itemsPanel["z1_" + i].t_txt.text = "";
            if(ItemsPanel.player1.getEquipSlot().getEquipFromSlot(i) != null)
            {
               ItemsPanel.itemsPanel["z1_" + i].gotoAndStop(ItemsPanel.player1.getEquipSlot().getEquipFromSlot(i).getFrame());
               ItemsPanel.itemsPanel["z1_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["z1_" + i].visible = false;
            }
         }
      }
      
      public static function questShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(ItemsPanel.player1.getBag().getQuestFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(ItemsPanel.player1.getBag().getQuestFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
   }
}

