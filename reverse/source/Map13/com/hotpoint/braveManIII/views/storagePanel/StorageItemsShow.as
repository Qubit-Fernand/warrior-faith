package com.hotpoint.braveManIII.views.storagePanel
{
   import src.*;
   
   public class StorageItemsShow
   {
      
      public function StorageItemsShow()
      {
         super();
      }
      
      public static function allHide() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            StoragePanel.storagePanel["s1_" + i].visible = false;
            StoragePanel.storagePanel["s2_" + i].visible = false;
         }
         for(i = 0; i < 35; i++)
         {
            StoragePanel.storagePanel["kc_" + i].visible = false;
         }
      }
      
      public static function otherobjShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            StoragePanel.storagePanel["s1_" + i]["t_txt"].visible = false;
            if(Main.player1.getBag().getOtherobjFromBag(i) != null)
            {
               StoragePanel.storagePanel["s1_" + i].gotoAndStop(Main.player1.getBag().getOtherobjFromBag(i).getFrame());
               StoragePanel.storagePanel["s1_" + i].visible = true;
               if(Main.player1.getBag().getOtherobjFromBag(i).getTimes() > 1)
               {
                  StoragePanel.storagePanel["s1_" + i]["t_txt"].text = Main.player1.getBag().getOtherobjFromBag(i).getTimes();
                  StoragePanel.storagePanel["s1_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function informationShow2P() : void
      {
         StoragePanel.storagePanel["gold2"].text = Main.player2.getGold();
         StoragePanel.storagePanel["kill_txt2"].text = Main.player2.killPoint.getValue();
      }
      
      public static function equipStorageShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 35; i++)
         {
            StoragePanel.storagePanel["kc_" + i]["t_txt"].visible = false;
            if(StoragePanel.storage.getEquipFromStorage(i) != null)
            {
               StoragePanel.storagePanel["kc_" + i].gotoAndStop(StoragePanel.storage.getEquipFromStorage(i).getFrame());
               StoragePanel.storagePanel["kc_" + i].visible = true;
            }
            else
            {
               StoragePanel.storagePanel["kc_" + i].visible = false;
            }
         }
      }
      
      public static function gemStorageShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 35; i++)
         {
            StoragePanel.storagePanel["kc_" + i]["t_txt"].visible = false;
            if(StoragePanel.storage.getGemFromStorage(i) != null)
            {
               StoragePanel.storagePanel["kc_" + i].gotoAndStop(StoragePanel.storage.getGemFromStorage(i).getFrame());
               StoragePanel.storagePanel["kc_" + i].visible = true;
               if(StoragePanel.storage.getGemFromStorage(i).getIsPile() == true)
               {
                  StoragePanel.storagePanel["kc_" + i]["t_txt"].text = StoragePanel.storage.getGemFromStorage(i).getTimes();
                  StoragePanel.storagePanel["kc_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["kc_" + i].visible = false;
            }
         }
      }
      
      public static function suppliesShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            StoragePanel.storagePanel["s1_" + i]["t_txt"].visible = false;
            if(Main.player1.getBag().getSuppliesFromBag(i) != null)
            {
               StoragePanel.storagePanel["s1_" + i].gotoAndStop(Main.player1.getBag().getSuppliesFromBag(i).getFrame());
               StoragePanel.storagePanel["s1_" + i].visible = true;
               if(Main.player1.getBag().getSuppliesFromBag(i).getTimes() > 1)
               {
                  StoragePanel.storagePanel["s1_" + i]["t_txt"].text = Main.player1.getBag().getSuppliesFromBag(i).getTimes();
                  StoragePanel.storagePanel["s1_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function equipShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            StoragePanel.storagePanel["s2_" + i]["t_txt"].visible = false;
            if(Main.player2.getBag().getEquipFromBag(i) != null)
            {
               StoragePanel.storagePanel["s2_" + i].gotoAndStop(Main.player2.getBag().getEquipFromBag(i).getFrame());
               StoragePanel.storagePanel["s2_" + i].visible = true;
            }
            else
            {
               StoragePanel.storagePanel["s2_" + i].visible = false;
            }
         }
      }
      
      public static function gemShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            StoragePanel.storagePanel["s1_" + i]["t_txt"].visible = false;
            if(Main.player1.getBag().getGemFromBag(i) != null)
            {
               StoragePanel.storagePanel["s1_" + i].gotoAndStop(Main.player1.getBag().getGemFromBag(i).getFrame());
               StoragePanel.storagePanel["s1_" + i].visible = true;
               if(Main.player1.getBag().getGemFromBag(i).getIsPile() == true)
               {
                  StoragePanel.storagePanel["s1_" + i]["t_txt"].text = Main.player1.getBag().getGemFromBag(i).getTimes();
                  StoragePanel.storagePanel["s1_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function equipShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            StoragePanel.storagePanel["s1_" + i]["t_txt"].visible = false;
            if(Main.player1.getBag().getEquipFromBag(i) != null)
            {
               StoragePanel.storagePanel["s1_" + i].gotoAndStop(Main.player1.getBag().getEquipFromBag(i).getFrame());
               StoragePanel.storagePanel["s1_" + i].visible = true;
            }
            else
            {
               StoragePanel.storagePanel["s1_" + i].visible = false;
            }
         }
      }
      
      public static function suppliesShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            StoragePanel.storagePanel["s2_" + i]["t_txt"].visible = false;
            if(Main.player2.getBag().getSuppliesFromBag(i) != null)
            {
               StoragePanel.storagePanel["s2_" + i].gotoAndStop(Main.player2.getBag().getSuppliesFromBag(i).getFrame());
               StoragePanel.storagePanel["s2_" + i].visible = true;
               if(Main.player2.getBag().getSuppliesFromBag(i).getTimes() > 1)
               {
                  StoragePanel.storagePanel["s2_" + i]["t_txt"].text = Main.player2.getBag().getSuppliesFromBag(i).getTimes();
                  StoragePanel.storagePanel["s2_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s2_" + i].visible = false;
            }
         }
      }
      
      public static function informationShow() : void
      {
         StoragePanel.storagePanel["gold1"].text = Main.player1.getGold();
         StoragePanel.storagePanel["kill_txt"].text = Main.player1.killPoint.getValue();
      }
      
      public static function gemShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            StoragePanel.storagePanel["s2_" + i]["t_txt"].visible = false;
            if(Main.player2.getBag().getGemFromBag(i) != null)
            {
               StoragePanel.storagePanel["s2_" + i].gotoAndStop(Main.player2.getBag().getGemFromBag(i).getFrame());
               StoragePanel.storagePanel["s2_" + i].visible = true;
               if(Main.player2.getBag().getGemFromBag(i).getIsPile() == true)
               {
                  StoragePanel.storagePanel["s2_" + i]["t_txt"].text = Main.player2.getBag().getGemFromBag(i).getTimes();
                  StoragePanel.storagePanel["s2_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s2_" + i].visible = false;
            }
         }
      }
      
      public static function suppliesStorageShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 35; i++)
         {
            StoragePanel.storagePanel["kc_" + i]["t_txt"].visible = false;
            if(StoragePanel.storage.getSuppliesFromStorage(i) != null)
            {
               StoragePanel.storagePanel["kc_" + i].gotoAndStop(StoragePanel.storage.getSuppliesFromStorage(i).getFrame());
               StoragePanel.storagePanel["kc_" + i].visible = true;
               if(StoragePanel.storage.getSuppliesFromStorage(i).getTimes() > 1)
               {
                  StoragePanel.storagePanel["kc_" + i]["t_txt"].text = StoragePanel.storage.getSuppliesFromStorage(i).getTimes();
                  StoragePanel.storagePanel["kc_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["kc_" + i].visible = false;
            }
         }
      }
      
      public static function otherobjStorageShow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 35; i++)
         {
            StoragePanel.storagePanel["kc_" + i]["t_txt"].visible = false;
            if(StoragePanel.storage.getOtherobjFromStorage(i) != null)
            {
               StoragePanel.storagePanel["kc_" + i].gotoAndStop(StoragePanel.storage.getOtherobjFromStorage(i).getFrame());
               StoragePanel.storagePanel["kc_" + i].visible = true;
               if(StoragePanel.storage.getOtherobjFromStorage(i).getTimes() > 1)
               {
                  StoragePanel.storagePanel["kc_" + i]["t_txt"].text = StoragePanel.storage.getOtherobjFromStorage(i).getTimes();
                  StoragePanel.storagePanel["kc_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["kc_" + i].visible = false;
            }
         }
      }
      
      public static function otherobjShow2P() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            StoragePanel.storagePanel["s2_" + i]["t_txt"].visible = false;
            if(Main.player2.getBag().getOtherobjFromBag(i) != null)
            {
               StoragePanel.storagePanel["s2_" + i].gotoAndStop(Main.player2.getBag().getOtherobjFromBag(i).getFrame());
               StoragePanel.storagePanel["s2_" + i].visible = true;
               if(Main.player2.getBag().getOtherobjFromBag(i).getTimes() > 1)
               {
                  StoragePanel.storagePanel["s2_" + i]["t_txt"].text = Main.player2.getBag().getOtherobjFromBag(i).getTimes();
                  StoragePanel.storagePanel["s2_" + i]["t_txt"].visible = true;
               }
            }
            else
            {
               StoragePanel.storagePanel["s2_" + i].visible = false;
            }
         }
      }
   }
}

