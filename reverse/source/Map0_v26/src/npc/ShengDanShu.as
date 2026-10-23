package src.npc
{
   import com.hotpoint.braveManIII.repository.equip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol217")]
   public class ShengDanShu extends MovieClip
   {
      
      public var lingqu:SimpleButton;
      
      public var g0:MovieClip;
      
      public var g1:MovieClip;
      
      public var g2:MovieClip;
      
      public var g3:MovieClip;
      
      public var g4:MovieClip;
      
      public var g5:MovieClip;
      
      public var g6:MovieClip;
      
      public var g7:MovieClip;
      
      public var g8:MovieClip;
      
      public function ShengDanShu()
      {
         super();
         lingqu.addEventListener(MouseEvent.CLICK,shengdanlingqu);
         showGuaJian();
      }
      
      public function shengdanlingqu(param1:*) : *
      {
         var _loc2_:int = 0;
         if(Main.shengdanTimes.getValue() <= 8)
         {
            if(Main.P1P2)
            {
               if(Main.player1.getBag().backequipBagNum() > 0 && Main.player2.getBag().backequipBagNum() > 0)
               {
                  Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(14610));
                  Main.player2.getBag().addEquipBag(EquipFactory.createEquipByID(14610));
                  Main.shengdanTimes.setValue(Main.shengdanTimes.getValue() + 1);
                  _loc2_ = 0;
                  while(_loc2_ < 9)
                  {
                     Main.shengdan[_loc2_].setValue(0);
                     _loc2_++;
                  }
                  allFalse();
               }
               else
               {
                  NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包空间不足");
               }
            }
            else if(Main.player1.getBag().backequipBagNum() > 0)
            {
               Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(14610));
               Main.shengdanTimes.setValue(Main.shengdanTimes.getValue() + 1);
               _loc2_ = 0;
               while(_loc2_ < 9)
               {
                  Main.shengdan[_loc2_].setValue(0);
                  _loc2_++;
               }
               allFalse();
            }
            else
            {
               NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包空间不足");
            }
         }
         else
         {
            NewMC.Open("圣诞挂件",Main._this,480,290,30,0,true,2,"已无法再领取");
         }
      }
      
      public function allFalse() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            this["g" + _loc1_].visible = false;
            _loc1_++;
         }
         lingqu.visible = false;
      }
      
      public function showGuaJian() : *
      {
         var _loc1_:int = 0;
         allFalse();
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            if(Main.shengdan[_loc2_].getValue() == 1)
            {
               this["g" + _loc2_].visible = true;
               _loc1_++;
            }
            _loc2_++;
         }
         if(_loc1_ == 9)
         {
            lingqu.visible = true;
         }
      }
   }
}

