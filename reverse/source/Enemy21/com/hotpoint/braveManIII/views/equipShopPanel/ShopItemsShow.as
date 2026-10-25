package com.hotpoint.braveManIII.views.equipShopPanel
{
   import src.*;
   
   public class ShopItemsShow
   {
      
      public function ShopItemsShow()
      {
         super();
      }
      
      public static function allHide() : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            EquipShopPanel.equipShowPanel["s1_" + i].visible = false;
            EquipShopPanel.equipShowPanel["s2_" + i].visible = false;
         }
         for(i = 0; i < 6; i++)
         {
            EquipShopPanel.equipShowPanel["se_" + i]["sells"].visible = false;
            EquipShopPanel.equipShowPanel["se_" + i]["sells"]["t_txt"].visible = false;
         }
      }
      
      public static function informationShow() : void
      {
         EquipShopPanel.equipShowPanel["gold1"].text = Main.player1.getGold();
         EquipShopPanel.equipShowPanel["kill_txt"].text = Main.player1.killPoint.getValue();
      }
      
      public static function informationShow2P() : void
      {
         EquipShopPanel.equipShowPanel["gold2"].text = Main.player2.getGold();
         EquipShopPanel.equipShowPanel["kill_txt2"].text = Main.player2.killPoint.getValue();
      }
      
      public static function equipShow() : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            EquipShopPanel.equipShowPanel["s1_" + i]["t_txt"].visible = false;
            if(Main.player1.getBag().getEquipFromBag(i) != null)
            {
               EquipShopPanel.equipShowPanel["s1_" + i].gotoAndStop(Main.player1.getBag().getEquipFromBag(i).getFrame());
               EquipShopPanel.equipShowPanel["s1_" + i].visible = true;
            }
            else
            {
               EquipShopPanel.equipShowPanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function equipShow2P() : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            EquipShopPanel.equipShowPanel["s2_" + i]["t_txt"].visible = false;
            if(Main.player2.getBag().getEquipFromBag(i) != null)
            {
               EquipShopPanel.equipShowPanel["s2_" + i].gotoAndStop(Main.player2.getBag().getEquipFromBag(i).getFrame());
               EquipShopPanel.equipShowPanel["s2_" + i].visible = true;
            }
            else
            {
               EquipShopPanel.equipShowPanel["s2_" + i].visible = false;
            }
         }
      }
      
      public static function shopEquipShow() : void
      {
         var temp:int = 0;
         var showNum:int = 6;
         var arr:Array = EquipShopPanel.shopEquipList;
         var pageNumR:int = Math.ceil(arr.length / 6);
         EquipShopPanel.equipShowPanel["pageNumR"].text = pageNumR;
         var pageNumL:int = int(EquipShopPanel.equipShowPanel["pageNumL"].text);
         for(var i:uint = 0; i < 6; i++)
         {
            temp = i + (pageNumL - 1) * 6;
            if(arr[temp] != null)
            {
               EquipShopPanel.equipShowPanel["se_" + i].visible = true;
               EquipShopPanel.equipShowPanel["se_" + i]["sells"].visible = true;
               EquipShopPanel.equipShowPanel["se_" + i]["sells"].gotoAndStop(arr[temp].getFrame());
               EquipShopPanel.equipShowPanel["name_" + i].text = arr[temp].getName();
               EquipShopPanel.equipShowPanel["price_" + i].text = "价格：" + arr[temp].getPrice() * 9;
            }
            else
            {
               EquipShopPanel.equipShowPanel["se_" + i].visible = false;
               EquipShopPanel.equipShowPanel["name_" + i].text = "";
               EquipShopPanel.equipShowPanel["price_" + i].text = "";
            }
         }
      }
   }
}

