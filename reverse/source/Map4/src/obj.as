package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.quest.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class obj extends MovieClip
   {
      
      internal var objX:*;
      
      public function obj(param1:*, param2:int, param3:int)
      {
         var _loc4_:int = 0;
         super();
         if(param1 is Equip)
         {
            objX = param1;
         }
         else if(param1 is Gem)
         {
            objX = param1;
         }
         else
         {
            if(!(param1 is Quest))
            {
               return;
            }
            objX = param1;
         }
         _loc4_ = int(param1.getFrame());
         this.x = param2;
         this.y = param3;
         Main.world.moveChild_Other.addChild(this);
         this.gotoAndStop(_loc4_);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         stop();
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         removeEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         var _loc2_:* = 0;
         var _loc3_:Quest = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc2_ = int(Player.All.length - 1);
         while(_loc2_ >= 0)
         {
            if(Boolean(objX is Equip && (Player.All[_loc2_] as Player).data.getBag().backequipBagNum() > 0 && (Player.All[_loc2_] as Player).hit) && Boolean(this.hitTestObject((Player.All[_loc2_] as Player).hit)) && Boolean((Player.All[_loc2_] as Player).getKeyStatus("下",2)))
            {
               Player.All[_loc2_].data.getBag().addEquipBag(objX);
               this.parent.removeChild(this);
               removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
               return;
            }
            if(Boolean(objX is Gem && (Player.All[_loc2_] as Player).data.getBag().backGemBagNum() > 0 && (Player.All[_loc2_] as Player).hit) && Boolean(this.hitTestObject((Player.All[_loc2_] as Player).hit)) && Boolean((Player.All[_loc2_] as Player).getKeyStatus("下",2)))
            {
               Player.All[_loc2_].data.getBag().addGemBag(objX);
               this.parent.removeChild(this);
               removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
               return;
            }
            if(Boolean(objX is Quest && (Player.All[_loc2_] as Player).data.getBag().backQuestBagNum() > 0 && (Player.All[_loc2_] as Player).hit) && Boolean(this.hitTestObject((Player.All[_loc2_] as Player).hit)) && Boolean((Player.All[_loc2_] as Player).getKeyStatus("下",2)))
            {
               _loc3_ = objX as Quest;
               _loc4_ = _loc3_.getFallLevel();
               _loc5_ = _loc3_.getFallMax();
               if(_loc3_.getType() != 2)
               {
                  if(Player.All[_loc2_].data.getBag().fallQusetBag(_loc4_) < _loc5_)
                  {
                     Player.All[_loc2_].data.getBag().addQuestBag(objX);
                     this.parent.removeChild(this);
                     removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                     return;
                  }
               }
               else if(Player.All[_loc2_].data.isTransferOk() == false)
               {
                  if(Player.All[_loc2_].data.getBag().fallQusetBag(_loc4_) < _loc5_)
                  {
                     Player.All[_loc2_].data.getBag().addQuestBag(objX);
                     this.parent.removeChild(this);
                     removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                     return;
                  }
               }
            }
            _loc2_--;
         }
         if(this.parent == Main.world.moveChild_Other && !JhitTestPoint.hitTestPoint(this,Main.world.MapData))
         {
            this.y += 10;
         }
      }
   }
}

