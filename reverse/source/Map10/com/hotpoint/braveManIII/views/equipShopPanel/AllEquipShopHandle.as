package com.hotpoint.braveManIII.views.equipShopPanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   
   public class AllEquipShopHandle
   {
      
      private var bag2P:Bag = new Bag();
      
      private var bag:Bag = new Bag();
      
      public function AllEquipShopHandle()
      {
         super();
         bag = EquipShopPanel.player1.getBag();
         if(EquipShopPanel.player2)
         {
            bag2P = EquipShopPanel.player2.getBag();
         }
      }
      
      public function equipHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         if(dragObj.name.substr(0,2) == "s1")
         {
            bag.equipBagMove(begin,end);
            ShopItemsShow.equipShow();
            return true;
         }
         return false;
      }
      
      public function equipHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         if(dragObj.name.substr(0,2) == "s2")
         {
            bag2P.equipBagMove(begin,end);
            ShopItemsShow.equipShow2P();
            return true;
         }
         return false;
      }
   }
}

