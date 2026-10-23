package com.hotpoint.braveManIII.views.chestPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.chest.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol296")]
   public class ChestPanel extends MovieClip
   {
      
      public var btn:宝箱按钮;
      
      public var xx_mc:MovieClip;
      
      private var data:PlayerData;
      
      private var keyId:Number = 63203;
      
      private var ob:obj;
      
      private var id:Number;
      
      private var type:Number;
      
      private var xx:Number;
      
      private var yy:Number;
      
      private var ranNum:Number;
      
      private var okBo:Boolean = false;
      
      private var saveBo:Boolean;
      
      public function ChestPanel()
      {
         super();
         xx_mc.visible = false;
         this.addEventListener(BtnEvent.DO_CLICK,doClick);
      }
      
      private function doClick(param1:Event) : void
      {
         var _loc2_:Number = 0;
         if(Main.player1.getBag().getOtherobjNum(keyId) > 0)
         {
            _loc2_ = 1;
         }
         if(Boolean(Main.P1P2) && _loc2_ == 0)
         {
            if(Main.player2.getBag().getOtherobjNum(keyId) > 0)
            {
               _loc2_ = 2;
            }
         }
         if(_loc2_ != 0)
         {
            data = Main["player" + _loc2_];
            xx_mc.visible = true;
            xx_mc.gotoAndPlay(2);
            this.btn.visible = false;
            ranNum = int(Math.random() * 100);
            id = ChestFactory.getRewardId(ranNum);
            type = ChestFactory.getType(ranNum);
            xx = this.x;
            yy = this.y - 150;
            data.getBag().delOtherById(keyId,1);
            Main.Save(true,1);
            addEventListener(Event.ENTER_FRAME,onHandle);
            this.removeEventListener(BtnEvent.DO_CLICK,doClick);
         }
         else
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"缺少“封印星灵财宝”道具");
         }
      }
      
      private function onHandle(param1:Event) : void
      {
         if(xx_mc.currentFrame > 37 && Main.saveID.getValue() == 1)
         {
            xx_mc.stop();
         }
         if(Main.saveID.getValue() == 2)
         {
            Main.saveID.setValue(0);
            xx_mc.play();
         }
         if(xx_mc.currentLabel == "go" && okBo == false)
         {
            switch(type)
            {
               case 0:
                  ob = new obj(EquipFactory.createEquipByID(id),xx,yy);
                  break;
               case 1:
                  ob = new obj(SuppliesFactory.getSuppliesById(id),xx,yy);
                  break;
               case 2:
                  ob = new obj(GemFactory.creatGemById(id),xx,yy);
                  break;
               case 3:
                  ob = new obj(OtherFactory.creatOther(id),xx,yy);
            }
            okBo = true;
         }
         else if(xx_mc.currentFrame == xx_mc.totalFrames)
         {
            removeEventListener(Event.ENTER_FRAME,onHandle);
            okBo = false;
            this.btn.visible = true;
            xx_mc.gotoAndStop(1);
            xx_mc.visible = false;
            this.addEventListener(BtnEvent.DO_CLICK,doClick);
         }
      }
   }
}

