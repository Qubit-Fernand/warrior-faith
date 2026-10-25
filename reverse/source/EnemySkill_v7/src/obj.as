package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.quest.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.tool.*;
   
   public class obj extends MovieClip
   {
      
      internal var objX:*;
      
      public function obj(param1:*, param2:int, param3:int)
      {
         super();
         if(param1 is Equip)
         {
            objX = param1;
         }
         else if(param1 is Gem)
         {
            objX = param1;
         }
         else if(param1 is Quest)
         {
            objX = param1;
         }
         else if(param1 is Otherobj)
         {
            objX = param1;
         }
         else
         {
            if(!(param1 is Supplies))
            {
               return;
            }
            objX = param1;
         }
         var _loc4_:int = int(param1.getFrame());
         this.x = param2;
         this.y = param3;
         Main.world.moveChild_Other.addChild(this);
         this.gotoAndStop(_loc4_);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
         mouseChildren = mouseEnabled = false;
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         var _loc3_:Quest = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:* = int(Player.All.length - 1);
         while(_loc2_ >= 0)
         {
            if(Boolean(objX is Equip && (Player.All[_loc2_] as Player).hit) && Boolean(this.hitTestObject((Player.All[_loc2_] as Player).hit)) && Boolean((Player.All[_loc2_] as Player).getKeyStatus("下",1)))
            {
               if((Player.All[_loc2_] as Player).data.getBag().backequipBagNum() > 0)
               {
                  Player.All[_loc2_].data.getBag().addEquipBag(objX);
                  this.parent.removeChild(this);
                  removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                  return;
               }
               NewMC.Open("背包已满",Main._this,0,0,15,0,true);
            }
            else if(Boolean(objX is Gem && (Player.All[_loc2_] as Player).hit) && Boolean(this.hitTestObject((Player.All[_loc2_] as Player).hit)) && Boolean((Player.All[_loc2_] as Player).getKeyStatus("下",1)))
            {
               if((Player.All[_loc2_] as Player).data.getBag().backGemBagNum() > 0)
               {
                  Player.All[_loc2_].data.getBag().addGemBag(objX);
                  this.parent.removeChild(this);
                  removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                  return;
               }
               NewMC.Open("背包已满",Main._this,0,0,15,0,true);
            }
            else if(Boolean(objX is Otherobj && (Player.All[_loc2_] as Player).hit) && Boolean(this.hitTestObject((Player.All[_loc2_] as Player).hit)) && Boolean((Player.All[_loc2_] as Player).getKeyStatus("下",1)))
            {
               if((Player.All[_loc2_] as Player).data.getBag().backOtherBagNum() > 0)
               {
                  Player.All[_loc2_].data.getBag().addOtherobjBag(objX);
                  this.parent.removeChild(this);
                  removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                  return;
               }
               NewMC.Open("背包已满",Main._this,0,0,15,0,true);
            }
            else if(Boolean(objX is Supplies && (Player.All[_loc2_] as Player).hit) && Boolean(this.hitTestObject((Player.All[_loc2_] as Player).hit)) && Boolean((Player.All[_loc2_] as Player).getKeyStatus("下",1)))
            {
               if((Player.All[_loc2_] as Player).data.getBag().backSuppliesBagNum() > 0)
               {
                  (Player.All[_loc2_].data.getBag() as Bag).addSuppliesBag(objX);
                  this.parent.removeChild(this);
                  removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                  return;
               }
               NewMC.Open("背包已满",Main._this,0,0,15,0,true);
            }
            else if(Boolean(objX is Quest && (Player.All[_loc2_] as Player).data.getBag().backQuestBagNum() > 0 && (Player.All[_loc2_] as Player).hit) && Boolean(this.hitTestObject((Player.All[_loc2_] as Player).hit)) && Boolean((Player.All[_loc2_] as Player).getKeyStatus("下",1)))
            {
               _loc3_ = objX as Quest;
               _loc4_ = _loc3_.getFallLevel();
               if(_loc3_.getType() != 2)
               {
                  _loc5_ = 0;
                  if(_loc3_.getType() == 0)
                  {
                     _loc5_ = _loc3_.getGoodMaxNum();
                  }
                  else if(_loc3_.getType() == 1)
                  {
                     _loc5_ = _loc3_.getFallMax();
                  }
                  if(Player.All[_loc2_].data.getBag().fallQusetBag(_loc4_) < _loc5_)
                  {
                     Player.All[_loc2_].data.getBag().addQuestBag(objX);
                     this.parent.removeChild(this);
                     removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                     TaskData.addGoods(objX.getId());
                     TaskData.isOk();
                     return;
                  }
               }
               else if(Player.All[_loc2_].data.isTransferOk() == false)
               {
                  if(Player.All[_loc2_].data.getBag().fallQusetBag(_loc4_) < _loc3_.getFallMax())
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
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         stop();
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         removeEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
   }
}

