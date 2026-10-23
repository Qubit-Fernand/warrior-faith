package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.pet.Pet;
   import com.hotpoint.braveManIII.repository.pet.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class ChongWu extends MovieClip
   {
      
      public static var loadData:ClassLoader;
      
      public var who:Player;
      
      public var data:Pet;
      
      public var food:VT = VT.createVT(100);
      
      public var RL:Boolean = true;
      
      private var distance_X:int = 0;
      
      private var distanceMax:int = 600;
      
      private var walk_power:VT = VT.createVT(5);
      
      private var gravity:int = 4;
      
      public var skin:MovieClip;
      
      public var runType:String = "站立";
      
      public var runFrame:int = 0;
      
      public var continuous:Boolean;
      
      public function ChongWu(_data:Pet, p:Player)
      {
         super();
         who = p;
         who.data.playerCW_Data = data = _data;
         who.playerCW = this;
         addSkin();
         addStage();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function addStage() : *
      {
         Main.world.moveChild_Player.addChild(this);
      }
      
      public function Close() : *
      {
         this.parent.removeChild(this);
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         who.playerCW = null;
         who.data.playerCW_Data = null;
      }
      
      private function addSkin() : *
      {
         var classStr:String = PetFactory.getClassName(data._id.getValue());
         var classRef:Class = ChongWu.loadData.getClass(classStr) as Class;
         skin = new classRef();
         addChild(skin);
         this.y = 500;
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         WhereAreYou();
         MoveRun();
         GoToPlay();
      }
      
      private function WhereAreYou() : *
      {
         distance_X = this.x - who.x;
         distance_Y = this.y - who.y;
         if(Math.abs(distance_X) > distanceMax)
         {
            SearchPlayer();
         }
      }
      
      private function SearchPlayer() : *
      {
         this.x = who.x + Math.random() * 100 - 50;
         this.y = who.y - 50;
      }
      
      private function MoveRun() : *
      {
         var i:* = 0;
         var BB:Boolean = false;
         var AA:Boolean = false;
         var CC:Boolean = false;
         var forecast_x:* = int(this.x + Main.world.x);
         var forecast_y:int = this.y;
         for(i = 5; i > 0; i--)
         {
            BB = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y - 3,true));
            AA = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y - 1,true));
            CC = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y + 6,true));
            if(BB)
            {
               forecast_y -= 2;
            }
            else if(AA)
            {
               runY = 0;
            }
            else if(CC)
            {
               forecast_y += 3;
            }
            else
            {
               forecast_y++;
            }
         }
         this.y = forecast_y;
         for(i = int(Math.abs(walk_power.getValue())); i > 0; i--)
         {
            AA = Boolean(Main.world.MapData1.hitTestPoint(forecast_x,forecast_y - 30,true));
            if(!AA)
            {
               if(distance_X > 100)
               {
                  forecast_x--;
                  getRL(true);
                  GoTo("移动",true);
               }
               else if(distance_X < -100)
               {
                  forecast_x++;
                  getRL(false);
                  GoTo("移动",true);
               }
               else
               {
                  GoTo("站立");
               }
            }
         }
         var xxx:int = forecast_x - Main.world.x;
         if(xxx > Main.world._width + 100)
         {
            this.x = Main.world._width + 100;
         }
         else if(xxx < -100)
         {
            this.x = -100;
         }
         else
         {
            this.x = xxx;
         }
      }
      
      public function getRL(_RL:Boolean) : *
      {
         this.RL = _RL;
         if(_RL)
         {
            scaleX = -1;
         }
         else if(!_RL)
         {
            scaleX = 1;
         }
      }
      
      private function GoToPlay() : *
      {
         if(isRunOver())
         {
            skin.gotoAndPlay(runType);
         }
         ++runFrame;
      }
      
      public function isRunOver() : Boolean
      {
         if(skin.currentLabel != runType)
         {
            runFrame = 0;
            return true;
         }
         return false;
      }
      
      public function GoTo(str:String, YN:Boolean = false) : *
      {
         if(str == "站立")
         {
            str = "站立" + int(Math.random() * 3 + 1);
         }
         if(runType != str && (isRunOver() || YN))
         {
            runType = str;
            skin.gotoAndPlay(str);
         }
      }
   }
}

