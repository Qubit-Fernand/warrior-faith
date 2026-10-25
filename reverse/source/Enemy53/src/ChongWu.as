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
      
      public function ChongWu(_data:Pet, p:Player)
      {
         super();
         this.who = p;
         this.who.data.playerCW_Data = this.data = _data;
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
         var classStr:String = PetFactory.getClassName(this.data._id.getValue());
         var classRef:Class = ChongWu.loadData.getClass(classStr) as Class;
         this.skin = new classRef();
         addChild(this.skin);
         this.y = 500;
      }
      
      private function onENTER_FRAME(e:*) : *
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
         var i:* = 0;
         var BB:Boolean = false;
         var AA:Boolean = false;
         var CC:Boolean = false;
         var forecast_x:* = int(this.x + Main.world.x);
         var forecast_y:int = this.y;
         for(i = int(this.gravity); i > 0; i--)
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
         for(i = int(Math.abs(this.walk_power.getValue())); i > 0; i--)
         {
            AA = Boolean(Main.world.MapData1.hitTestPoint(forecast_x,forecast_y - 30,true));
            if(!AA)
            {
               if(this.distance_X > 200)
               {
                  forecast_x--;
                  this.getRL(false);
                  this.GoTo("移动",true);
               }
               else if(this.distance_X < -200)
               {
                  forecast_x++;
                  this.getRL(true);
                  this.GoTo("移动",true);
               }
               else
               {
                  this.GoTo("站立");
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
      
      public function GoTo(str:String, YN:Boolean = false) : *
      {
         var arr:Array = null;
         var xx:int = 0;
         if(this.noMove)
         {
            return;
         }
         var num:uint = 3;
         if(this.data._id.getValue() == 73105)
         {
            num = 5;
         }
         var str2:String = str;
         if(str == "站立")
         {
            str2 = "站立" + int(Math.random() * num + 1);
         }
         else if(str == "攻击")
         {
            arr = this.data.getPetSkillType();
            xx = int(Math.random() * 4);
            if(!(arr[xx] > 0))
            {
               gongJiYn1 = gongJiYn2 = false;
               return;
            }
            str2 = "攻击" + arr[xx];
         }
         if(this.runType != str2 && (this.isRunOver() || YN))
         {
            this.runType = str2;
            this.runType2 = str;
            if(str == "攻击")
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

