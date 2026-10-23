package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.quest.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.views.playerTaskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class obj extends MovieClip
   {
      
      internal var objX:*;
      
      public function obj(ob:*, xx:int, yy:int)
      {
         super();
         if(ob is Equip)
         {
            this.objX = ob;
         }
         else if(ob is Gem)
         {
            this.objX = ob;
         }
         else if(ob is Quest)
         {
            this.objX = ob;
         }
         else
         {
            if(!(ob is Otherobj))
            {
               return;
            }
            this.objX = ob;
         }
         var frame:int = int(ob.getFrame());
         this.x = xx;
         this.y = yy;
         Main.world.moveChild_Other.addChild(this);
         this.gotoAndStop(frame);
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onREMOVED_FROM_STAGE);
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         var mc:Quest = null;
         var fallLevel:Number = NaN;
         var num:Number = NaN;
         for(var i:* = int(Player.All.length - 1); i >= 0; i--)
         {
            if(Boolean(this.objX is Equip && (Player.All[i] as Player).data.getBag().backequipBagNum() > 0 && (Player.All[i] as Player).hit) && Boolean(this.hitTestObject((Player.All[i] as Player).hit)) && Boolean((Player.All[i] as Player).getKeyStatus("下",2)))
            {
               Player.All[i].data.getBag().addEquipBag(this.objX);
               this.parent.removeChild(this);
               removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
               return;
            }
            if(Boolean(this.objX is Gem && (Player.All[i] as Player).data.getBag().backGemBagNum() > 0 && (Player.All[i] as Player).hit) && Boolean(this.hitTestObject((Player.All[i] as Player).hit)) && Boolean((Player.All[i] as Player).getKeyStatus("下",2)))
            {
               Player.All[i].data.getBag().addGemBag(this.objX);
               this.parent.removeChild(this);
               removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
               return;
            }
            if(Boolean(this.objX is Otherobj && (Player.All[i] as Player).data.getBag().backOtherBagNum() > 0 && (Player.All[i] as Player).hit) && Boolean(this.hitTestObject((Player.All[i] as Player).hit)) && Boolean((Player.All[i] as Player).getKeyStatus("下",2)))
            {
               Player.All[i].data.getBag().addOtherobjBag(this.objX);
               this.parent.removeChild(this);
               removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
               return;
            }
            if(Boolean(this.objX is Quest && (Player.All[i] as Player).data.getBag().backQuestBagNum() > 0 && (Player.All[i] as Player).hit) && Boolean(this.hitTestObject((Player.All[i] as Player).hit)) && Boolean((Player.All[i] as Player).getKeyStatus("下",2)))
            {
               mc = this.objX as Quest;
               fallLevel = mc.getFallLevel();
               if(mc.getType() != 2)
               {
                  num = 0;
                  if(mc.getType() == 0)
                  {
                     num = mc.getGoodMaxNum();
                  }
                  else if(mc.getType() == 1)
                  {
                     num = mc.getFallMax();
                  }
                  if(Player.All[i].data.getBag().fallQusetBag(fallLevel) < num)
                  {
                     Player.All[i].data.getBag().addQuestBag(this.objX);
                     this.parent.removeChild(this);
                     removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
                     return;
                  }
               }
               else if(Player.All[i].data.isTransferOk() == false)
               {
                  if(Player.All[i].data.getBag().fallQusetBag(fallLevel) < mc.getFallMax())
                  {
                     Player.All[i].data.getBag().addQuestBag(this.objX);
                     this.parent.removeChild(this);
                     removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
                     return;
                  }
               }
               PlayerTaskData.addGoodsNum();
            }
         }
         if(this.parent == Main.world.moveChild_Other && !JhitTestPoint.hitTestPoint(this,Main.world.MapData))
         {
            this.y += 10;
         }
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         stop();
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onREMOVED_FROM_STAGE);
      }
   }
}

