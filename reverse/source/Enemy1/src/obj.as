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
      
      public function obj(ob:*, xx:int, yy:int)
      {
         var frame:int = 0;
         super();
         if(ob is Equip)
         {
            objX = ob;
         }
         else if(ob is Gem)
         {
            objX = ob;
         }
         else
         {
            if(!(ob is Quest))
            {
               return;
            }
            objX = ob;
         }
         frame = int(ob.getFrame());
         this.x = xx;
         this.y = yy;
         Main.world.moveChild_Other.addChild(this);
         this.gotoAndStop(frame);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         stop();
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         removeEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         var i:* = 0;
         var mc:Quest = null;
         var fallLevel:Number = NaN;
         var fallMax:Number = NaN;
         for(i = int(Player.All.length - 1); i >= 0; i--)
         {
            if(Boolean(objX is Equip && (Player.All[i] as Player).data.getBag().backequipBagNum() > 0 && (Player.All[i] as Player).hit) && Boolean(this.hitTestObject((Player.All[i] as Player).hit)) && Boolean((Player.All[i] as Player).getKeyStatus("下",2)))
            {
               Player.All[i].data.getBag().addEquipBag(objX);
               this.parent.removeChild(this);
               removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
               return;
            }
            if(Boolean(objX is Gem && (Player.All[i] as Player).data.getBag().backGemBagNum() > 0 && (Player.All[i] as Player).hit) && Boolean(this.hitTestObject((Player.All[i] as Player).hit)) && Boolean((Player.All[i] as Player).getKeyStatus("下",2)))
            {
               Player.All[i].data.getBag().addGemBag(objX);
               this.parent.removeChild(this);
               removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
               return;
            }
            if(Boolean(objX is Quest && (Player.All[i] as Player).data.getBag().backQuestBagNum() > 0 && (Player.All[i] as Player).hit) && Boolean(this.hitTestObject((Player.All[i] as Player).hit)) && Boolean((Player.All[i] as Player).getKeyStatus("下",2)))
            {
               mc = objX as Quest;
               fallLevel = mc.getFallLevel();
               fallMax = mc.getFallMax();
               if(mc.getType() != 2)
               {
                  if(Player.All[i].data.getBag().fallQusetBag(fallLevel) < fallMax)
                  {
                     Player.All[i].data.getBag().addQuestBag(objX);
                     this.parent.removeChild(this);
                     removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                     return;
                  }
               }
               else if(Player.All[i].data.isTransferOk() == false)
               {
                  if(Player.All[i].data.getBag().fallQusetBag(fallLevel) < fallMax)
                  {
                     Player.All[i].data.getBag().addQuestBag(objX);
                     this.parent.removeChild(this);
                     removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                     return;
                  }
               }
            }
         }
         if(this.parent == Main.world.moveChild_Other && !JhitTestPoint.hitTestPoint(this,Main.world.MapData))
         {
            this.y += 10;
         }
      }
   }
}

