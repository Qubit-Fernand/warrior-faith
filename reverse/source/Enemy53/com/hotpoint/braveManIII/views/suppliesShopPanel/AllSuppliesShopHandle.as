package com.hotpoint.braveManIII.views.suppliesShopPanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   import src.*;
   
   public class AllSuppliesShopHandle
   {
      
      private var bag:Bag = new Bag();
      
      private var bag2P:Bag = new Bag();
      
      public function AllSuppliesShopHandle()
      {
         super();
         this.bag = Main.player1.getBag();
         if(Main.player2)
         {
            this.bag2P = Main.player2.getBag();
         }
      }
      
      public function suppliesHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         if(dragObj.name.substr(0,2) == "s1")
         {
            this.bag.suppliesBagMove(begin,end);
            ShopItemsShow.suppliesShow();
            return true;
         }
         return false;
      }
      
      public function suppliesHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         if(dragObj.name.substr(0,2) == "s2")
         {
            this.bag2P.suppliesBagMove(begin,end);
            ShopItemsShow.suppliesShow2P();
            return true;
         }
         return false;
      }
   }
}

