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
            ItemsPanel.itemsPanel["z1_" + i].t_txt.text = "";
            if(Main.player2.getEquipSlot().getEquipFromSlot(i) != null)
            {
               ItemsPanel.itemsPanel["z1_" + i].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(i).getFrame());
               ItemsPanel.itemsPanel["z1_" + i].visible = true;
               ItemsPanel.itemsPanel["z1_" + i]["diKuang"].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["z1_" + i].visible = false;
            }
         }
      }
      
      public static function allHide() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            ItemsPanel.itemsPanel["s1_" + i].t_txt.visible = true;
            ItemsPanel.itemsPanel["s1_" + i].visible = false;
            ItemsPanel.itemsPanel["s1_" + i]["diKuang"].visible = false;
         }
         for(i = 0; i < 8; i++)
         {
            ItemsPanel.itemsPanel["z1_" + i].t_txt.text = "";
            ItemsPanel.itemsPanel["z1_" + i].visible = false;
            ItemsPanel.itemsPanel["k1_" + i].visible = false;
            ItemsPanel.itemsPanel["z1_" + i]["diKuang"].visible = false;
         }
         ItemsPanel.itemsPanel["g1_0"].visible = false;
         ItemsPanel.itemsPanel["g1_1"].visible = false;
      }
      
      public static function questShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(Main.player2.getBag().getQuestFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player2.getBag().getQuestFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(Main.player2.getBag().getQuestFromBag(i).isMany() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = Main.player2.getBag().getQuestFromBag(i).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function otherobjShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(Main.player1.getBag().getOtherobjFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player1.getBag().getOtherobjFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(Main.player1.getBag().getOtherobjFromBag(i).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = Main.player1.getBag().getOtherobjFromBag(i).getTimes();
               }
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
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(Main.player2.getBag().getSuppliesFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player2.getBag().getSuppliesFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(Main.player2.getBag().getSuppliesFromBag(i).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = Main.player2.getBag().getSuppliesFromBag(i).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
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
            if(Main.player2.getEquipSkillSlot().getGemFromSkillSlot(i) != null)
            {
               ItemsPanel.itemsPanel["g1_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["g1_" + i].visible = false;
            }
         }
      }
      
      public static function show1P() : *
      {
         zyShow(1);
         ItemsPanel.itemsPanel["name_txt"].text = Main.logName;
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
         showLV(Main.player1.getLevel());
      }
      
      public static function skillSlotShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 2; i++)
         {
            if(Main.player1.getEquipSkillSlot().getGemFromSkillSlot(i) != null)
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
            if(Main.player1.getBag().getEquipFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player1.getBag().getEquipFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
      
      private static function showLV(level:Number) : *
      {
         var str:String = null;
         var left:int = 0;
         var right:int = 0;
         if(level < 10)
         {
            ItemsPanel.itemsPanel["shiwei"].gotoAndStop(level);
            ItemsPanel.itemsPanel["gewei"].visible = false;
         }
         else
         {
            str = level.toString();
            left = int(str.substring(0,1));
            right = int(str.substring(1,2));
            ItemsPanel.itemsPanel["shiwei"].gotoAndStop(left);
            if(right == 0)
            {
               ItemsPanel.itemsPanel["gewei"].gotoAndStop(10);
            }
            else
            {
               ItemsPanel.itemsPanel["gewei"].gotoAndStop(right);
            }
         }
      }
      
      public static function gemShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(Main.player2.getBag().getGemFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player2.getBag().getGemFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(Main.player2.getBag().getGemFromBag(i).getIsPile() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = Main.player2.getBag().getGemFromBag(i).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function equipShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(Main.player2.getBag().getEquipFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player2.getBag().getEquipFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function gemShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(Main.player1.getBag().getGemFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player1.getBag().getGemFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(Main.player1.getBag().getGemFromBag(i).getIsPile() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = Main.player1.getBag().getGemFromBag(i).getTimes();
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
            if(Main.player1.getBag().getSuppliesFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player1.getBag().getSuppliesFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(Main.player1.getBag().getSuppliesFromBag(i).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = Main.player1.getBag().getSuppliesFromBag(i).getTimes();
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
            ItemsPanel.itemsPanel["s1_" + i].t_txt.text = "";
            if(Main.player2.getBag().getOtherobjFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player2.getBag().getOtherobjFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(Main.player2.getBag().getOtherobjFromBag(i).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = Main.player2.getBag().getOtherobjFromBag(i).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function show2P() : *
      {
         zyShow(2);
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
         showLV(Main.player2.getLevel());
      }
      
      public static function zyShow(p1p2:int) : *
      {
         var i:int = 0;
         for(i = 0; i < 4; i++)
         {
            if(i == 3)
            {
               ItemsPanel.itemsPanel["ZY_txt"].text = "新手";
            }
            else if(Main["player" + p1p2]._transferArr[i])
            {
               if(i == 0)
               {
                  ItemsPanel.itemsPanel["ZY_txt"].text = "杀戮战神";
               }
               else if(i == 1)
               {
                  ItemsPanel.itemsPanel["ZY_txt"].text = "汲魂术士";
               }
               else
               {
                  ItemsPanel.itemsPanel["ZY_txt"].text = "毁灭拳神";
               }
               break;
            }
         }
      }
      
      public static function slotShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 6; i++)
         {
            ItemsPanel.itemsPanel["z1_" + i].t_txt.text = "";
            if(Main.player1.getEquipSlot().getEquipFromSlot(i) != null)
            {
               ItemsPanel.itemsPanel["z1_" + i].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(i).getFrame());
               ItemsPanel.itemsPanel["z1_" + i].visible = true;
               ItemsPanel.itemsPanel["z1_" + i]["diKuang"].visible = true;
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
            if(Main.player1.getBag().getQuestFromBag(i) != null)
            {
               ItemsPanel.itemsPanel["s1_" + i].gotoAndStop(Main.player1.getBag().getQuestFromBag(i).getFrame());
               ItemsPanel.itemsPanel["s1_" + i].visible = true;
               if(Main.player1.getBag().getQuestFromBag(i).isMany() == true)
               {
                  ItemsPanel.itemsPanel["s1_" + i].t_txt.text = Main.player1.getBag().getQuestFromBag(i).getTimes();
               }
            }
            else
            {
               ItemsPanel.itemsPanel["s1_" + i].visible = false;
            }
         }
      }
   }
}

