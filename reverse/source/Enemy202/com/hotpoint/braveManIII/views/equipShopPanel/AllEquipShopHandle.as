package com.hotpoint.braveManIII.views.equipShopPanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   import src.*;
   
   public class AllEquipShopHandle
   {
      
      private var bag:Bag = new Bag();
      
      private var bag2P:Bag = new Bag();
      
      public function AllEquipShopHandle()
      {
         super();
         this.bag = Main.player1.getBag();
         if(Main.player2)
         {
            this.bag2P = Main.player2.getBag();
         }
      }
      
      public function equipHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         if(param1.name.substr(0,2) == "s1")
         {
            this.bag.equipBagMove(param2,param3);
            ShopItemsShow.equipShow();
            return true;
         }
         return false;
      }
      
      public function equipHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         if(param1.name.substr(0,2) == "s2")
         {
            this.bag2P.equipBagMove(param2,param3);
            ShopItemsShow.equipShow2P();
            return true;
         }
         return false;
      }
   }
}

