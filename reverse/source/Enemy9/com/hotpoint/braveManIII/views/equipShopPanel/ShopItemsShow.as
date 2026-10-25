package com.hotpoint.braveManIII.views.equipShopPanel
{
   public class ShopItemsShow
   {
      
      public function ShopItemsShow()
      {
         super();
      }
      
      public static function allHide() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            EquipShopPanel.equipShowPanel["s1_" + _loc1_].visible = false;
            EquipShopPanel.equipShowPanel["s2_" + _loc1_].visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            EquipShopPanel.equipShowPanel["se_" + _loc1_]["sells"].visible = false;
            EquipShopPanel.equipShowPanel["se_" + _loc1_]["sells"]["t_txt"].visible = false;
            _loc1_++;
         }
      }
      
      public static function informationShow2P() : void
      {
         EquipShopPanel.equipShowPanel["gold2"].text = EquipShopPanel.player2.getGold();
      }
      
      public static function informationShow() : void
      {
         EquipShopPanel.equipShowPanel["gold1"].text = EquipShopPanel.player1.getGold();
      }
      
      public static function equipShow2P() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            EquipShopPanel.equipShowPanel["s2_" + _loc1_]["t_txt"].visible = false;
            if(EquipShopPanel.player2.getBag().getEquipFromBag(_loc1_) != null)
            {
               EquipShopPanel.equipShowPanel["s2_" + _loc1_].gotoAndStop(EquipShopPanel.player2.getBag().getEquipFromBag(_loc1_).getFrame());
               EquipShopPanel.equipShowPanel["s2_" + _loc1_].visible = true;
            }
            else
            {
               EquipShopPanel.equipShowPanel["s2_" + _loc1_].visible = false;
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
            EquipShopPanel.equipShowPanel["s1_" + _loc1_]["t_txt"].visible = false;
            if(EquipShopPanel.player1.getBag().getEquipFromBag(_loc1_) != null)
            {
               EquipShopPanel.equipShowPanel["s1_" + _loc1_].gotoAndStop(EquipShopPanel.player1.getBag().getEquipFromBag(_loc1_).getFrame());
               EquipShopPanel.equipShowPanel["s1_" + _loc1_].visible = true;
            }
            else
            {
               EquipShopPanel.equipShowPanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function shopEquipShow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc1_ = 6;
         _loc2_ = EquipShopPanel.shopEquipList;
         _loc3_ = Math.ceil(_loc2_.length / 6);
         EquipShopPanel.equipShowPanel["pageNumR"].text = _loc3_;
         _loc4_ = int(EquipShopPanel.equipShowPanel["pageNumL"].text);
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            _loc6_ = _loc5_ + (_loc4_ - 1) * 6;
            if(_loc2_[_loc6_] != null)
            {
               EquipShopPanel.equipShowPanel["se_" + _loc5_].visible = true;
               EquipShopPanel.equipShowPanel["se_" + _loc5_]["sells"].visible = true;
               EquipShopPanel.equipShowPanel["se_" + _loc5_]["sells"].gotoAndStop(_loc2_[_loc6_].getFrame());
               EquipShopPanel.equipShowPanel["name_" + _loc5_].text = _loc2_[_loc6_].getName();
               EquipShopPanel.equipShowPanel["price_" + _loc5_].text = "价格：" + _loc2_[_loc6_].getPrice() * 9;
            }
            else
            {
               EquipShopPanel.equipShowPanel["se_" + _loc5_].visible = false;
               EquipShopPanel.equipShowPanel["name_" + _loc5_].text = "";
               EquipShopPanel.equipShowPanel["price_" + _loc5_].text = "";
            }
            _loc5_++;
         }
      }
   }
}

