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
         who = p;
         who.data.playerCW_Data = data = _data;
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
         var classStr:String = PetFactory.getClassName(data._id.getValue());
         var classRef:Class = ChongWu.loadData.getClass(classStr) as Class;
         skin = new classRef();
         addChild(skin);
         this.y = 500;
      }
      
      private function onENTER_FRAME(e:*) : *
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
         var i:* = 0;
         var BB:Boolean = false;
         var AA:Boolean = false;
         var CC:Boolean = false;
         var forecast_x:* = int(this.x + Main.world.x);
         var forecast_y:int = this.y;
         for(i = int(gravity); i > 0; i--)
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
               if(distance_X > 200)
               {
                  forecast_x--;
                  getRL(false);
                  GoTo("移动",true);
               }
               else if(distance_X < -200)
               {
                  forecast_x++;
                  getRL(true);
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
      
      public function GoTo(str:String, YN:Boolean = false) : *
      {
         var arr:Array = null;
         var xx:int = 0;
         if(noMove)
         {
            return;
         }
         var str2:String = str;
         if(str == "站立")
         {
            str2 = "站立" + int(Math.random() * 3 + 1);
         }
         else if(str == "攻击")
         {
            arr = data.getPetSkillType();
            xx = int(Math.random() * 4);
            if(arr[xx] <= 0)
            {
               gongJiYn1 = gongJiYn2 = false;
               return;
            }
            str2 = "攻击" + arr[xx];
         }
         if(runType != str2 && (isRunOver() || YN))
         {
            runType = str2;
            runType2 = str;
            trace("GoToGoToGoTo ==== " + runType);
            if(str == "攻击")
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

