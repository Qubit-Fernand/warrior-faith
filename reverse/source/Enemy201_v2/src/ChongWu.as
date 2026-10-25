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
         this.who = param2;
         this.who.data.playerCW_Data = this.data = param1;
         this.who.playerCW = this;
         this.addSkin();
         Main.world.moveChild_ChongWu.addChild(this);
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         this.SearchPlayer();
         mouseChildren = mouseEnabled = false;
      }
      
      public static function get_XML_data() : *
      {
         dataXml = XMLAsset.createXML(Data2.petHit_data);
      }
      
      public function Close() : *
      {
         this.parent.removeChild(this);
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         this.who.playerCW = null;
         this.who.data.playerCW_Data = null;
      }
      
      private function addSkin() : *
      {
         var _loc1_:String = PetFactory.getClassName(this.data._id.getValue());
         var _loc2_:Class = ChongWu.loadData.getClass(_loc1_) as Class;
         this.skin = new _loc2_();
         addChild(this.skin);
         this.y = 500;
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         this.GongJi();
         if(!this.noMove)
         {
            this.WhereAreYou();
         }
         this.GoToPlay();
      }
      
      private function WhereAreYou() : *
      {
         this.distance_X = this.x - this.who.x;
         distance_Y = this.y - this.who.y;
         if(Math.abs(this.distance_X) > this.distanceMax)
         {
            this.SearchPlayer();
         }
         this.MoveRun();
      }
      
      private function SearchPlayer() : *
      {
         this.x = this.who.x + Math.random() * 200 - 100;
         this.y = this.who.y - 100;
      }
      
      private function MoveRun() : *
      {
         var _loc3_:* = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc1_:* = int(this.x + Main.world.x);
         var _loc2_:int = this.y;
         _loc3_ = int(this.gravity);
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
         _loc3_ = int(Math.abs(this.walk_power.getValue()));
         while(_loc3_ > 0)
         {
            _loc6_ = Boolean(Main.world.MapData1.hitTestPoint(_loc1_,_loc2_ - 30,true));
            if(!_loc6_)
            {
               if(this.distance_X > 200)
               {
                  _loc1_--;
                  this.getRL(false);
                  this.GoTo("移动",true);
               }
               else if(this.distance_X < -200)
               {
                  _loc1_++;
                  this.getRL(true);
                  this.GoTo("移动",true);
               }
               else
               {
                  this.GoTo("站立");
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
            --this.timeNum;
            if(this.timeNum <= 0)
            {
               this.GoTo("攻击",true);
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
         if(this.isRunOver())
         {
            if(this.runType2 != "攻击")
            {
               this.skin.gotoAndPlay(this.runType);
            }
            else
            {
               this.GoTo("站立");
            }
         }
      }
      
      public function isRunOver() : Boolean
      {
         if(this.skin.currentLabel != this.runType)
         {
            this.noMove = false;
            return true;
         }
         return false;
      }
      
      public function GoTo(param1:String, param2:Boolean = false) : *
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         if(this.noMove)
         {
            return;
         }
         var _loc3_:uint = 3;
         if(this.data._id.getValue() == 73105)
         {
            _loc3_ = 5;
         }
         var _loc4_:String = param1;
         if(param1 == "站立")
         {
            _loc4_ = "站立" + int(Math.random() * _loc3_ + 1);
         }
         else if(param1 == "攻击")
         {
            _loc5_ = this.data.getPetSkillType();
            _loc6_ = int(Math.random() * 4);
            if(!(_loc5_[_loc6_] > 0))
            {
               gongJiYn1 = gongJiYn2 = false;
               return;
            }
            _loc4_ = "攻击" + _loc5_[_loc6_];
         }
         if(this.runType != _loc4_ && (this.isRunOver() || param2))
         {
            this.runType = _loc4_;
            this.runType2 = param1;
            trace("GoToGoToGoTo ==== " + this.runType);
            if(param1 == "攻击")
            {
               this.noMove = true;
               this.timeNum = 27 * 10;
               gongJiYn1 = gongJiYn2 = false;
            }
            this.skin.gotoAndPlay(this.runType);
         }
      }
   }
}

