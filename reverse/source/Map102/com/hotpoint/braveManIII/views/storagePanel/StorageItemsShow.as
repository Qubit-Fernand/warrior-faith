package com.hotpoint.braveManIII.views.storagePanel
{
   public class StorageItemsShow
   {
      
      public function StorageItemsShow()
      {
         super();
      }
      
      public static function allHide() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            StoragePanel.storagePanel["s1_" + _loc1_].visible = false;
            StoragePanel.storagePanel["s2_" + _loc1_].visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 35)
         {
            StoragePanel.storagePanel["kc_" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      public static function otherobjShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            StoragePanel.storagePanel["s1_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.player1.getBag().getOtherobjFromBag(_loc1_) != null)
            {
               StoragePanel.storagePanel["s1_" + _loc1_].gotoAndStop(StoragePanel.player1.getBag().getOtherobjFromBag(_loc1_).getFrame());
               StoragePanel.storagePanel["s1_" + _loc1_].visible = true;
            }
            else
            {
               StoragePanel.storagePanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function informationShow2P() : void
      {
         StoragePanel.storagePanel["gold2"].text = StoragePanel.player2.getGold();
      }
      
      public static function equipStorageShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 35)
         {
            StoragePanel.storagePanel["kc_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.storage.getEquipFromStorage(_loc1_) != null)
            {
               StoragePanel.storagePanel["kc_" + _loc1_].gotoAndStop(StoragePanel.storage.getEquipFromStorage(_loc1_).getFrame());
               StoragePanel.storagePanel["kc_" + _loc1_].visible = true;
            }
            else
            {
               StoragePanel.storagePanel["kc_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function gemStorageShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 35)
         {
            StoragePanel.storagePanel["kc_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.storage.getGemFromStorage(_loc1_) != null)
            {
               StoragePanel.storagePanel["kc_" + _loc1_].gotoAndStop(StoragePanel.storage.getGemFromStorage(_loc1_).getFrame());
               StoragePanel.storagePanel["kc_" + _loc1_].visible = true;
               if(StoragePanel.storage.getGemFromStorage(_loc1_).getIsPile() == true)
               {
                  StoragePanel.storagePanel["kc_" + _loc1_]["t_txt"].text = StoragePanel.storage.getGemFromStorage(_loc1_).getTimes();
                  StoragePanel.storagePanel["kc_" + _loc1_]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["kc_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function suppliesShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            StoragePanel.storagePanel["s1_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.player1.getBag().getSuppliesFromBag(_loc1_) != null)
            {
               StoragePanel.storagePanel["s1_" + _loc1_].gotoAndStop(StoragePanel.player1.getBag().getSuppliesFromBag(_loc1_).getFrame());
               StoragePanel.storagePanel["s1_" + _loc1_].visible = true;
               if(StoragePanel.player1.getBag().getSuppliesFromBag(_loc1_).getTimes() > 1)
               {
                  StoragePanel.storagePanel["s1_" + _loc1_]["t_txt"].text = StoragePanel.player1.getBag().getSuppliesFromBag(_loc1_).getTimes();
                  StoragePanel.storagePanel["s1_" + _loc1_]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s1_" + _loc1_].visible = false;
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
            StoragePanel.storagePanel["s2_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.player2.getBag().getEquipFromBag(_loc1_) != null)
            {
               StoragePanel.storagePanel["s2_" + _loc1_].gotoAndStop(StoragePanel.player2.getBag().getEquipFromBag(_loc1_).getFrame());
               StoragePanel.storagePanel["s2_" + _loc1_].visible = true;
            }
            else
            {
               StoragePanel.storagePanel["s2_" + _loc1_].visible = false;
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
            StoragePanel.storagePanel["s1_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.player1.getBag().getGemFromBag(_loc1_) != null)
            {
               StoragePanel.storagePanel["s1_" + _loc1_].gotoAndStop(StoragePanel.player1.getBag().getGemFromBag(_loc1_).getFrame());
               StoragePanel.storagePanel["s1_" + _loc1_].visible = true;
               if(StoragePanel.player1.getBag().getGemFromBag(_loc1_).getIsPile() == true)
               {
                  StoragePanel.storagePanel["s1_" + _loc1_]["t_txt"].text = StoragePanel.player1.getBag().getGemFromBag(_loc1_).getTimes();
                  StoragePanel.storagePanel["s1_" + _loc1_]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s1_" + _loc1_].visible = false;
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
            StoragePanel.storagePanel["s1_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.player1.getBag().getEquipFromBag(_loc1_) != null)
            {
               StoragePanel.storagePanel["s1_" + _loc1_].gotoAndStop(StoragePanel.player1.getBag().getEquipFromBag(_loc1_).getFrame());
               StoragePanel.storagePanel["s1_" + _loc1_].visible = true;
            }
            else
            {
               StoragePanel.storagePanel["s1_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function suppliesShow2P() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            StoragePanel.storagePanel["s2_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.player2.getBag().getSuppliesFromBag(_loc1_) != null)
            {
               StoragePanel.storagePanel["s2_" + _loc1_].gotoAndStop(StoragePanel.player2.getBag().getSuppliesFromBag(_loc1_).getFrame());
               StoragePanel.storagePanel["s2_" + _loc1_].visible = true;
               if(StoragePanel.player2.getBag().getSuppliesFromBag(_loc1_).getTimes() > 1)
               {
                  StoragePanel.storagePanel["s2_" + _loc1_]["t_txt"].text = StoragePanel.player2.getBag().getSuppliesFromBag(_loc1_).getTimes();
                  StoragePanel.storagePanel["s2_" + _loc1_]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function informationShow() : void
      {
         StoragePanel.storagePanel["gold1"].text = StoragePanel.player1.getGold();
      }
      
      public static function gemShow2P() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            StoragePanel.storagePanel["s2_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.player2.getBag().getGemFromBag(_loc1_) != null)
            {
               StoragePanel.storagePanel["s2_" + _loc1_].gotoAndStop(StoragePanel.player2.getBag().getGemFromBag(_loc1_).getFrame());
               StoragePanel.storagePanel["s2_" + _loc1_].visible = true;
               if(StoragePanel.player2.getBag().getGemFromBag(_loc1_).getIsPile() == true)
               {
                  StoragePanel.storagePanel["s2_" + _loc1_]["t_txt"].text = StoragePanel.player2.getBag().getGemFromBag(_loc1_).getTimes();
                  StoragePanel.storagePanel["s2_" + _loc1_]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function suppliesStorageShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 35)
         {
            StoragePanel.storagePanel["kc_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.storage.getSuppliesFromStorage(_loc1_) != null)
            {
               StoragePanel.storagePanel["kc_" + _loc1_].gotoAndStop(StoragePanel.storage.getSuppliesFromStorage(_loc1_).getFrame());
               StoragePanel.storagePanel["kc_" + _loc1_].visible = true;
               if(StoragePanel.storage.getSuppliesFromStorage(_loc1_).getTimes() > 1)
               {
                  StoragePanel.storagePanel["kc_" + _loc1_]["t_txt"].text = StoragePanel.storage.getSuppliesFromStorage(_loc1_).getTimes();
                  StoragePanel.storagePanel["kc_" + _loc1_]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["kc_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function otherobjStorageShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 35)
         {
            StoragePanel.storagePanel["kc_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.storage.getOtherobjFromStorage(_loc1_) != null)
            {
               StoragePanel.storagePanel["kc_" + _loc1_].gotoAndStop(StoragePanel.storage.getOtherobjFromStorage(_loc1_).getFrame());
               StoragePanel.storagePanel["kc_" + _loc1_].visible = true;
            }
            else
            {
               StoragePanel.storagePanel["kc_" + _loc1_].visible = false;
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
            StoragePanel.storagePanel["s2_" + _loc1_]["t_txt"].visible = false;
            if(StoragePanel.player2.getBag().getOtherobjFromBag(_loc1_) != null)
            {
               StoragePanel.storagePanel["s2_" + _loc1_].gotoAndStop(StoragePanel.player2.getBag().getOtherobjFromBag(_loc1_).getFrame());
               StoragePanel.storagePanel["s2_" + _loc1_].visible = true;
            }
            else
            {
               StoragePanel.storagePanel["s2_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
   }
}

