package src
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.pet.Pet;
   import com.hotpoint.braveManIII.repository.pet.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class YongShi61 extends MovieClip
   {
      
      public static var booltemp:Boolean = false;
      
      public var who:Player;
      
      public var data:Pet;
      
      public var food:VT = VT.createVT(100);
      
      public var RL:Boolean = true;
      
      private var distance_X:int = 0;
      
      private var distanceMax:int = 1800;
      
      private var walk_power:VT = VT.createVT(6);
      
      private var gravity:int = 20;
      
      public var skin:MovieClip;
      
      public var runType:String = "站立";
      
      public var runType2:String = "站立";
      
      public var continuous:Boolean;
      
      public var timeNum:int = 270;
      
      public function YongShi61(param1:Player)
      {
         super();
         who = param1;
         who.playerYS = this;
         addSkin();
         Main.world.moveChild_Enemy.addChild(this);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         SearchPlayer();
         mouseChildren = mouseEnabled = false;
      }
      
      public static function get_XML_data() : *
      {
         dataXml = XMLAsset.createXML(Data2.petHit_data);
      }
      
      public function close() : *
      {
         this.parent.removeChild(this);
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         who.playerYS = null;
      }
      
      private function addSkin() : *
      {
         var _loc1_:Class = SixOne_Interface.loadData.getClass("YS61") as Class;
         this.skin = new _loc1_();
         addChild(skin);
         Main.world.moveChild_Enemy.addChild(this);
         this.y = 500;
         booltemp = true;
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         WhereAreYou();
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
         MoveRun();
      }
      
      private function SearchPlayer() : *
      {
         this.x = who.x + Math.random() * 200 - 100;
         this.y = who.y - 100;
      }
      
      private function MoveRun() : *
      {
         var _loc3_:* = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc1_:* = int(this.x + Main.world.x);
         var _loc2_:int = this.y;
         _loc3_ = int(gravity);
         while(_loc3_ > 0)
         {
            _loc5_ = Boolean(Main.world.MapData.hitTestPoint(_loc1_,_loc2_ - 3,true));
            _loc6_ = Boolean(Main.world.MapData.hitTestPoint(_loc1_,_loc2_ - 1,true));
            _loc7_ = Boolean(Main.world.MapData.hitTestPoint(_loc1_,_loc2_ + 6,true));
            if(_loc5_)
            {
               _loc2_ -= 2;
            }
            else if(_loc6_)
            {
               runY = 0;
            }
            else if(_loc7_)
            {
               _loc2_ += 3;
            }
            else
            {
               _loc2_++;
            }
            _loc3_--;
         }
         this.y = _loc2_;
         _loc3_ = int(Math.abs(walk_power.getValue()));
         while(_loc3_ > 0)
         {
            _loc6_ = Boolean(Main.world.MapData1.hitTestPoint(_loc1_,_loc2_ - 30,true));
            if(!_loc6_)
            {
               if(distance_X > 200)
               {
                  _loc1_--;
                  getRL(false);
                  GoTo("移动",true);
               }
               else if(distance_X < -200)
               {
                  _loc1_++;
                  getRL(true);
                  GoTo("移动",true);
               }
               else
               {
                  GoTo("站立");
               }
            }
            _loc3_--;
         }
         var _loc4_:int = _loc1_ - Main.world.x;
         if(_loc4_ > Main.world._width + 100)
         {
            this.x = Main.world._width + 100;
         }
         else if(_loc4_ < -100)
         {
            this.x = -100;
         }
         else
         {
            this.x = _loc4_;
         }
      }
      
      public function getRL(param1:Boolean) : *
      {
         this.RL = param1;
         if(param1)
         {
            scaleX = -1;
         }
         else if(!param1)
         {
            scaleX = 1;
         }
      }
      
      private function GoToPlay() : *
      {
         if(isRunOver())
         {
            GoTo("站立");
         }
      }
      
      public function isRunOver() : Boolean
      {
         if(skin.currentLabel != runType)
         {
            return true;
         }
         return false;
      }
      
      public function GoTo(param1:String, param2:Boolean = false) : *
      {
         var _loc3_:uint = 2;
         var _loc4_:String = param1;
         if(param1 == "站立")
         {
            _loc4_ = "站立" + int(Math.random() * _loc3_ + 1);
         }
         if(runType != _loc4_ && (isRunOver() || param2))
         {
            runType = _loc4_;
            runType2 = param1;
            skin.gotoAndPlay(runType);
         }
      }
   }
}

