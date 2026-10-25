package com.hotpoint.braveManIII.views.suppliesShopPanel
{
   public class ShopItemsShow
   {
      
      public function ShopItemsShow()
      {
         super();
      }
      
      public static function shopSuppliesShow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc1_ = 6;
         _loc2_ = SuppliesShopPanel.shopSuppliesList;
         _loc3_ = Math.ceil(_loc2_.length / 6);
         SuppliesShopPanel.suppliesShowPanel["pageNumR"].text = _loc3_;
         _loc4_ = int(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            _loc6_ = _loc5_ + (_loc4_ - 1) * 6;
            if(_loc2_[_loc6_] != null)
            {
               SuppliesShopPanel.suppliesShowPanel["se_" + _loc5_].visible = true;
               SuppliesShopPanel.suppliesShowPanel["se_" + _loc5_]["sells"].visible = true;
               SuppliesShopPanel.suppliesShowPanel["se_" + _loc5_]["sells"].gotoAndStop(_loc2_[_loc6_].getFrame());
               SuppliesShopPanel.suppliesShowPanel["name_" + _loc5_].text = _loc2_[_loc6_].getName();
               SuppliesShopPanel.suppliesShowPanel["price_" + _loc5_].text = "价格：" + _loc2_[_loc6_].getPrice() * 2;
            }
            else
            {
               SuppliesShopPanel.suppliesShowPanel["se_" + _loc5_].visible = false;
               SuppliesShopPanel.suppliesShowPanel["name_" + _loc5_].text = "";
               SuppliesShopPanel.suppliesShowPanel["price_" + _loc5_].text = "";
            }
            _loc5_++;
         }
      }
      
      public static function allHide() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            SuppliesShopPanel.suppliesShowPanel["s1_" + _loc1_].visible = false;
            SuppliesShopPanel.suppliesShowPanel["s2_" + _loc1_].visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            SuppliesShopPanel.suppliesShowPanel["se_" + _loc1_]["sells"].visible = false;
            SuppliesShopPanel.suppliesShowPanel["se_" + _loc1_]["sells"]["t_txt"].visible = false;
            _loc1_++;
         }
      }
      
      public static function informationShow2P() : void
      {
         SuppliesShopPanel.suppliesShowPanel["gold2"].text = SuppliesShopPanel.player2.getGold();
      }
      
      public static function suppliesShow2P() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            SuppliesShopPanel.suppliesShowPanel["s2_" + _loc1_]["t_txt"].visible = false;
            if(SuppliesShopPanel.player2.getBag().getSuppliesFromBag(_loc1_) != null)
            {
               SuppliesShopPanel.suppliesShowPanel["s2_" + _loc1_].gotoAndStop(SuppliesShopPanel.player2.getBag().getSuppliesFromBag(_loc1_).getFrame());
               SuppliesShopPanel.suppliesShowPanel["s2_" + _loc1_].visible = true;
               if(SuppliesShopPanel.player2.getBag().getSuppliesFromBag(_loc1_).getTimes() > 1)
               {
                  SuppliesShopPanel.suppliesShowPanel["s2_" + _loc1_]["t_txt"].text = SuppliesShopPanel.player2.getBag().getSuppliesFromBag(_loc1_).getTimes();
                  SuppliesShopPanel.suppliesShowPanel["s2_" + _loc1_]["t_txt"].visible = true;
               }
            }
            else
            {
               SuppliesShopPanel.suppliesShowPanel["s2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         SuppliesShopPanel.suppliesShowPanel["mySell"].visible = false;
      }
      
      public static function informationShow() : void
      {
         SuppliesShopPanel.suppliesShowPanel["gold1"].text = SuppliesShopPanel.player1.getGold();
      }
      
      public static function suppliesShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            SuppliesShopPanel.suppliesShowPanel["s1_" + _loc1_]["t_txt"].visible = false;
            if(SuppliesShopPanel.player1.getBag().getSuppliesFromBag(_loc1_) != null)
            {
               SuppliesShopPanel.suppliesShowPanel["s1_" + _loc1_].gotoAndStop(SuppliesShopPanel.player1.getBag().getSuppliesFromBag(_loc1_).getFrame());
               SuppliesShopPanel.suppliesShowPanel["s1_" + _loc1_].visible = true;
               if(SuppliesShopPanel.player1.getBag().getSuppliesFromBag(_loc1_).getTimes() > 1)
               {
                  SuppliesShopPanel.suppliesShowPanel["s1_" + _loc1_]["t_txt"].text = SuppliesShopPanel.player1.getBag().getSuppliesFromBag(_loc1_).getTimes();
                  SuppliesShopPanel.suppliesShowPanel["s1_" + _loc1_]["t_txt"].visible = true;
               }
            }
            else
            {
               SuppliesShopPanel.suppliesShowPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         SuppliesShopPanel.suppliesShowPanel["mySell"].visible = false;
      }
   }
}

