package com.hotpoint.braveManIII.views.suppliesShopPanel
{
   import src.*;
   
   public class ShopItemsShow
   {
      
      public function ShopItemsShow()
      {
         super();
      }
      
      public static function shopSuppliesShow() : void
      {
         var showNum:int = 0;
         var arr:Array = null;
         var pageNumR:int = 0;
         var pageNumL:int = 0;
         var i:uint = 0;
         var temp:int = 0;
         showNum = 6;
         arr = SuppliesShopPanel.shopSuppliesList;
         pageNumR = Math.ceil(arr.length / 6);
         SuppliesShopPanel.suppliesShowPanel["pageNumR"].text = pageNumR;
         pageNumL = int(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
         for(i = 0; i < 6; i++)
         {
            temp = i + (pageNumL - 1) * 6;
            if(arr[temp] != null)
            {
               SuppliesShopPanel.suppliesShowPanel["se_" + i].visible = true;
               SuppliesShopPanel.suppliesShowPanel["se_" + i]["sells"].visible = true;
               SuppliesShopPanel.suppliesShowPanel["se_" + i]["sells"].gotoAndStop(arr[temp].getFrame());
               SuppliesShopPanel.suppliesShowPanel["name_" + i].text = arr[temp].getName();
               SuppliesShopPanel.suppliesShowPanel["price_" + i].text = "价格：" + arr[temp].getPrice() * 2;
            }
            else
            {
               SuppliesShopPanel.suppliesShowPanel["se_" + i].visible = false;
               SuppliesShopPanel.suppliesShowPanel["name_" + i].text = "";
               SuppliesShopPanel.suppliesShowPanel["price_" + i].text = "";
            }
         }
      }
      
      public static function allHide() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            SuppliesShopPanel.suppliesShowPanel["s1_" + i].visible = false;
            SuppliesShopPanel.suppliesShowPanel["s2_" + i].visible = false;
         }
         for(i = 0; i < 6; i++)
         {
            SuppliesShopPanel.suppliesShowPanel["se_" + i]["sells"].visible = false;
            SuppliesShopPanel.suppliesShowPanel["se_" + i]["sells"]["t_txt"].visible = false;
         }
      }
      
      public static function informationShow2P() : void
      {
         SuppliesShopPanel.suppliesShowPanel["gold2"].text = Main.player2.getGold();
      }
      
      public static function suppliesShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            SuppliesShopPanel.suppliesShowPanel["s2_" + i]["t_txt"].visible = false;
            if(Main.player2.getBag().getSuppliesFromBag(i) != null)
            {
               SuppliesShopPanel.suppliesShowPanel["s2_" + i].gotoAndStop(Main.player2.getBag().getSuppliesFromBag(i).getFrame());
               SuppliesShopPanel.suppliesShowPanel["s2_" + i].visible = true;
               if(Main.player2.getBag().getSuppliesFromBag(i).getTimes() > 1)
               {
                  SuppliesShopPanel.suppliesShowPanel["s2_" + i]["t_txt"].text = Main.player2.getBag().getSuppliesFromBag(i).getTimes();
                  SuppliesShopPanel.suppliesShowPanel["s2_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               SuppliesShopPanel.suppliesShowPanel["s2_" + i].visible = false;
            }
         }
         SuppliesShopPanel.suppliesShowPanel["mySell"].visible = false;
      }
      
      public static function informationShow() : void
      {
         SuppliesShopPanel.suppliesShowPanel["gold1"].text = Main.player1.getGold();
      }
      
      public static function suppliesShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            SuppliesShopPanel.suppliesShowPanel["s1_" + i]["t_txt"].visible = false;
            if(Main.player1.getBag().getSuppliesFromBag(i) != null)
            {
               SuppliesShopPanel.suppliesShowPanel["s1_" + i].gotoAndStop(Main.player1.getBag().getSuppliesFromBag(i).getFrame());
               SuppliesShopPanel.suppliesShowPanel["s1_" + i].visible = true;
               if(Main.player1.getBag().getSuppliesFromBag(i).getTimes() > 1)
               {
                  SuppliesShopPanel.suppliesShowPanel["s1_" + i]["t_txt"].text = Main.player1.getBag().getSuppliesFromBag(i).getTimes();
                  SuppliesShopPanel.suppliesShowPanel["s1_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               SuppliesShopPanel.suppliesShowPanel["s1_" + i].visible = false;
            }
         }
         SuppliesShopPanel.suppliesShowPanel["mySell"].visible = false;
      }
   }
}

