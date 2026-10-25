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
   
   public class ChongWu extends MovieClip
   {
      
      public static var dataXml:XML;
      
      public static var loadData:ClassLoader;
      
      public static var gongJiYn1:Boolean = false;
      
      public static var gongJiYn2:Boolean = false;
      
      public var who:Player;
      
      public var data:Pet;
      
      public var food:VT = VT.createVT(100);
      
      public var RL:Boolean = true;
      
      private var distance_X:int = 0;
      
      private var distanceMax:int = 2000;
      
      private var walk_power:VT = VT.createVT(7);
      
      private var gravity:int = 20;
      
      public var skin:MovieClip;
      
      public var runType:String = "站立";
      
      public var runType2:String = "站立";
      
      public var continuous:Boolean;
      
      public var noMove:Boolean = false;
      
      public var timeNum:int = 270;
      
      public function ChongWu(param1:Pet, param2:Player)
      {
         super();
         who = param2;
         who.data.playerCW_Data = data = param1;
         who.playerCW = this;
         addSkin();
         Main.world.moveChild_ChongWu.addChild(this);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         SearchPlayer();
         mouseChildren = mouseEnabled = false;
      }
      
      public static function get_XML_data() : *
      {
         dataXml = XMLAsset.createXML(Data2.petHit_data);
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
         var _loc1_:String = PetFactory.getClassName(data._id.getValue());
         var _loc2_:Class = ChongWu.loadData.getClass(_loc1_) as Class;
         skin = new _loc2_();
         addChild(skin);
         this.y = 500;
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         GongJi();
         if(!noMove)
         {
            WhereAreYou();
         }
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
      
      private function GongJi() : *
      {
         if(gongJiYn1 || gongJiYn2)
         {
            --timeNum;
            if(timeNum <= 0)
            {
               GoTo("攻击",true);
            }
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
            if(runType2 != "攻击")
            {
               skin.gotoAndPlay(runType);
            }
            else
            {
               GoTo("站立");
            }
         }
      }
      
      public function isRunOver() : Boolean
      {
         if(skin.currentLabel != runType)
         {
            noMove = false;
            return true;
         }
         return false;
      }
      
      public function GoTo(param1:String, param2:Boolean = false) : *
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(noMove)
         {
            return;
         }
         var _loc3_:String = param1;
         if(param1 == "站立")
         {
            _loc3_ = "站立" + int(Math.random() * 3 + 1);
         }
         else if(param1 == "攻击")
         {
            _loc4_ = data.getPetSkillType();
            _loc5_ = int(Math.random() * 4);
            if(!(_loc4_[_loc5_] > 0))
            {
               gongJiYn1 = gongJiYn2 = false;
               return;
            }
            _loc3_ = "攻击" + _loc4_[_loc5_];
         }
         if(runType != _loc3_ && (isRunOver() || param2))
         {
            runType = _loc3_;
            runType2 = param1;
            trace("GoToGoToGoTo ==== " + runType);
            if(param1 == "攻击")
            {
               noMove = true;
               timeNum = 27 * 10;
               gongJiYn1 = gongJiYn2 = false;
            }
            skin.gotoAndPlay(runType);
         }
      }
   }
}

