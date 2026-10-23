package src
{
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import flash.display.*;
   import flash.events.*;
   import src.tool.*;
   
   public class Map extends MovieClip
   {
      
      public static var MapLoaded:Boolean;
      
      public static var MapArr:Array = new Array();
      
      public var speed:int = 0;
      
      public var paths:Array = [];
      
      public var nextNode:int = 1;
      
      public var _width:int;
      
      public var runX:int = 0;
      
      public var runY:int = 0;
      
      public var MapData:MovieClip = new MovieClip();
      
      public var MapData1:MovieClip = new MovieClip();
      
      public var MapData2:MovieClip = new MovieClip();
      
      public var moveChild_Player:MovieClip = new MovieClip();
      
      public var moveChild_Enemy:MovieClip = new MovieClip();
      
      public var moveChild_ChongWu:MovieClip = new MovieClip();
      
      public var moveChild_Other:MovieClip = new MovieClip();
      
      public var moveChild_Back:MovieClip = new MovieClip();
      
      public var stopYn:Boolean = false;
      
      public var stopX_1:uint = 0;
      
      public var stopX_2:uint = 1600;
      
      public var stopNumArr:Array = [0,1200,2400,3600,4800,5980];
      
      private var quakeNum:int = 10;
      
      private var quakeTime:int = 0;
      
      public function Map()
      {
         super();
         if(this["_Data"])
         {
            MapData = this["_Data"];
            if(MapData["Data1"])
            {
               MapData1 = MapData["Data1"];
            }
            else
            {
               trace("Data1未定义");
            }
            if(MapData["Data2"])
            {
               MapData2 = MapData["Data2"];
            }
            else
            {
               trace("Data2未定义");
            }
            stopX_1 = 0;
            if(this["moveChild"])
            {
               _width = stopX_2 = this["moveChild"].width;
            }
            else
            {
               _width = stopX_2 = 1600;
            }
            addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            addEventListener(Event.REMOVED_FROM_STAGE,onOver);
         }
         if(this["moveChild"])
         {
            this["moveChild"].addChild(moveChild_Back);
            this["moveChild"].addChild(moveChild_ChongWu);
            this["moveChild"].addChild(moveChild_Enemy);
            this["moveChild"].addChild(moveChild_Player);
            this["moveChild"].addChild(moveChild_Other);
            if(this["map_3"])
            {
               this["moveChild"].addChild(this["map_3"]);
               this["map_3"].mouseChildren = this["map_3"].mouseEnabled = false;
            }
         }
         else
         {
            addChild(moveChild_Back);
            addChild(moveChild_ChongWu);
            addChild(moveChild_Enemy);
            addChild(moveChild_Player);
            addChild(moveChild_Other);
            if(this["map_3"])
            {
               addChild(this["map_3"]);
               this["map_3"].mouseChildren = this["map_3"].mouseEnabled = false;
            }
         }
         moveChild_Other.mouseChildren = moveChild_Other.mouseEnabled = false;
         moveChild_Player.mouseChildren = moveChild_Player.mouseEnabled = false;
         moveChild_ChongWu.mouseChildren = moveChild_ChongWu.mouseEnabled = false;
         if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 0)
         {
            CaoNiMa0();
         }
         else if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 1)
         {
            CaoNiMa1();
         }
         else if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 2)
         {
            CaoNiMa2();
         }
         Main._stage.stageFocusRect = false;
         Main._stage.focus = this;
      }
      
      public function NoStop() : *
      {
         Main.world.stopYn = false;
         stopX_1 = 0;
         if(this["moveChild"])
         {
            stopX_2 = this["moveChild"].width;
         }
         else
         {
            stopX_2 = 1600;
         }
      }
      
      private function onENTER_FRAME(param1:Event) : *
      {
         if(!stopYn && Main.gameNum.getValue() > 50 && Main.gameNum.getValue() < 81)
         {
            if(Main.world.x <= -stopNumArr[Main.gameNum2.getValue()] + 940)
            {
               stopYn = true;
               stopX_1 = stopNumArr[Main.gameNum2.getValue() - 1];
               stopX_2 = -Main.world.x + 940;
               if(stopX_2 - stopX_1 < 940)
               {
                  stopX_1 = stopX_2 - 938;
               }
            }
         }
         if(this != Main.world)
         {
            removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            return;
         }
         背景移动();
         地震();
      }
      
      private function Run() : *
      {
         this.runX = this.runY = 0;
         if(paths.length > 1)
         {
            if(this.x > paths[nextNode][0])
            {
               if(this.x - speed < paths[nextNode][0])
               {
                  this.x = paths[nextNode][0];
               }
               else
               {
                  this.x -= speed;
                  this.runX = -speed;
               }
            }
            else if(this.x < paths[nextNode][0])
            {
               if(this.x + speed > paths[nextNode][0])
               {
                  this.x = paths[nextNode][0];
               }
               else
               {
                  this.x += speed;
                  this.runX = speed;
               }
            }
            if(this.y > paths[nextNode][1])
            {
               if(this.y - speed < paths[nextNode][1])
               {
                  this.y = paths[nextNode][1];
               }
               else
               {
                  this.y -= speed;
               }
            }
            else if(this.y < paths[nextNode][1])
            {
               if(this.y + speed > paths[nextNode][1])
               {
                  this.y = paths[nextNode][1];
               }
               else
               {
                  this.y += speed;
               }
            }
            if(this.x == paths[nextNode][0] && this.y == paths[nextNode][1])
            {
               if(nextNode + 1 == paths.length)
               {
                  nextNode = 0;
               }
               else
               {
                  ++nextNode;
               }
            }
         }
      }
      
      public function 背景移动() : *
      {
         if(this["_move"])
         {
            this["_move"].x = this.x * 0.5 - this.x;
         }
      }
      
      public function onOver(param1:*) : *
      {
         Map.MapLoaded = false;
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         removeEventListener(Event.REMOVED_FROM_STAGE,onOver);
      }
      
      public function GetPathsAndSpeed(param1:Array, param2:int = 5) : *
      {
         this.paths = param1;
         this.speed = param2;
      }
      
      public function Quake(param1:int = 4) : *
      {
         if(quakeTime < param1)
         {
            quakeTime = param1;
         }
      }
      
      private function 地震() : *
      {
         if(quakeTime <= 0)
         {
            this.y = 0;
            return;
         }
         if(quakeTime % 2 == 0)
         {
            this.y = -quakeNum;
         }
         else
         {
            this.y = 0;
         }
         --quakeTime;
      }
      
      public function CaoNiMa0() : *
      {
         addEventListener(Event.ADDED_TO_STAGE,onCaoNiMa0);
      }
      
      private function XueHua() : *
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 200)
         {
            _loc2_ = Math.random() * 1600;
            _loc3_ = Math.random() * 600;
            NewMC.Open("雪",this.moveChild_Other,_loc2_,_loc3_);
            _loc1_++;
         }
      }
      
      public function onCaoNiMa0(param1:*) : *
      {
         开启Show0();
         removeEventListener(Event.ADDED_TO_STAGE,onCaoNiMa0);
      }
      
      public function 开启Show0() : *
      {
         if(!this["转职"])
         {
            return;
         }
         this["转职"].visible = false;
         this["转职"].addEventListener(MouseEvent.CLICK,转职面板);
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(Main.P1P2)
         {
            if(!SetTransferPanel.tbo1() || !SetTransferPanel.tbo2())
            {
               _loc2_ = true;
            }
         }
         else if(!SetTransferPanel.tbo1())
         {
            _loc2_ = true;
         }
         if(Main.P1P2)
         {
            if(_loc2_)
            {
               if(Boolean(Main.player_1) && Boolean(Main.player_2))
               {
                  if(!SetTransferPanel.tbo1() && !SetTransferPanel.tbo2())
                  {
                     if(Main.player1.getLevel() >= 25 || Main.player2.getLevel() >= 25)
                     {
                        _loc1_ = true;
                     }
                  }
                  else if(Boolean(SetTransferPanel.tbo1()) && !SetTransferPanel.tbo2())
                  {
                     if(Main.player2.getLevel() >= 25)
                     {
                        _loc1_ = true;
                     }
                  }
                  else if(Boolean(SetTransferPanel.tbo2()) && !SetTransferPanel.tbo1())
                  {
                     if(Main.player1.getLevel() >= 25)
                     {
                        _loc1_ = true;
                     }
                  }
               }
            }
         }
         else if(_loc2_)
         {
            if(Main.player_1)
            {
               if(Main.player1.getLevel() >= 25)
               {
                  _loc1_ = true;
               }
            }
         }
         if(_loc1_)
         {
            this["转职"].visible = true;
         }
      }
      
      private function 转职面板(param1:*) : *
      {
         SetTransferPanel.open();
      }
      
      public function CaoNiMa1() : *
      {
         addEventListener(Event.ADDED_TO_STAGE,onCaoNiMa1);
      }
      
      public function onCaoNiMa1(param1:*) : *
      {
         开启Show();
         var _loc2_:int = 0;
         while(_loc2_ <= 4)
         {
            this["X_btn_8411" + _loc2_].addEventListener(MouseEvent.CLICK,Cangjingkong);
            _loc2_++;
         }
         removeEventListener(Event.ADDED_TO_STAGE,onCaoNiMa1);
      }
      
      public function 开启(param1:String) : *
      {
         this["X_btn_8411" + param1].gotoAndPlay(2);
         NewMC.Open("文字提示",Main._stage,400,350,60,0,true,2,"好像有某个神秘地带的入口被开启了");
      }
      
      public function 开启Show() : *
      {
         var _loc1_:int = 0;
         for(_loc1_ in Main.questArr)
         {
            if(Main.questArr[_loc1_][0])
            {
               this["X_btn_8411" + _loc1_].gotoAndStop(this["X_btn_8411" + _loc1_].totalFrames);
            }
         }
      }
      
      public function Cangjingkong(param1:MouseEvent) : *
      {
         trace("开启" + param1.target.name);
         var _loc2_:Number = Number((param1.target.name as String).substr(6,5));
         var _loc3_:Number = Number((param1.target.name as String).substr(10,1));
         var _loc4_:Boolean = Boolean(Main.getQuest(_loc2_));
         if(_loc4_)
         {
            return;
         }
         CangjingkongGoto(_loc2_,_loc3_);
      }
      
      public function CangjingkongGoto(param1:String, param2:String) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 1;
         while(_loc4_ <= 2)
         {
            if(Boolean(Main["player" + _loc4_]) && Boolean(Main["player" + _loc4_].getBag().fallQusetBag(param1)))
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            开启(param2);
            Main.setQuest(param1);
            _loc4_ = 1;
            while(_loc4_ <= 2)
            {
               if(Boolean(Main["player" + _loc4_]) && Boolean(Main["player" + _loc4_].getBag().fallQusetBag(param1)))
               {
                  Main["player" + _loc4_] && Main["player" + _loc4_].getBag().clearQuest(param1);
               }
               _loc4_++;
            }
         }
      }
      
      public function CaoNiMa2() : *
      {
         var _loc1_:* = undefined;
         for(_loc1_ in Main.questArr)
         {
            if(!Main.questArr[_loc1_][0])
            {
               trace("Ying_" + (_loc1_ + 1));
               this["Ying_" + (_loc1_ + 1)].visible = false;
            }
         }
         addEventListener(Event.ENTER_FRAME,OtherGame);
      }
      
      private function OtherGame(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:MovieClip = null;
         var _loc4_:Player = null;
         if(this != Main.world)
         {
            removeEventListener(Event.ENTER_FRAME,OtherGame);
            return;
         }
         for(_loc2_ in Main.questArr)
         {
            _loc3_ = this["Ying_" + (_loc2_ + 1)];
            if(_loc3_.visible)
            {
               i2 = 0;
               while(i2 < Player.All.length)
               {
                  _loc4_ = Player.All[i2];
                  if(Boolean(_loc4_.hit) && Boolean(_loc3_.hitTestObject(_loc4_.hit)) && _loc4_.getKeyStatus("上",2))
                  {
                     InOtherGame(_loc2_ + 1);
                  }
                  ++i2;
               }
            }
         }
      }
      
      private function InOtherGame(param1:int = 1) : *
      {
         var _loc2_:String = "10" + param1;
         Main.gameNum.setValue(int(_loc2_));
         Main.gameNum2.setValue(1);
         SelMap.Open(0,0,2);
      }
   }
}

