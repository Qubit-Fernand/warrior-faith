package com.hotpoint.braveManIII.views.suppliesShopPanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   
   public class AllSuppliesShopHandle
   {
      
      private var bag2P:Bag = new Bag();
      
      private var bag:Bag = new Bag();
      
      public function AllSuppliesShopHandle()
      {
         super();
         bag = SuppliesShopPanel.player1.getBag();
         if(SuppliesShopPanel.player2)
         {
            bag2P = SuppliesShopPanel.player2.getBag();
         }
      }
      
      public function suppliesHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         if(param1.name.substr(0,2) == "s1")
         {
            bag.suppliesBagMove(param2,param3);
            ShopItemsShow.suppliesShow();
            return true;
         }
         return false;
      }
      
      public function suppliesHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         if(param1.name.substr(0,2) == "s2")
         {
            bag2P.suppliesBagMove(param2,param3);
            ShopItemsShow.suppliesShow2P();
            return true;
         }
         return false;
      }
   }
}

