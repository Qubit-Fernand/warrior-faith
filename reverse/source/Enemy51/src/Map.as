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
      
      public var stopNumArr:Array = [0,1300,2400,3600,4800,5998];
      
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
      
      private function onENTER_FRAME(e:Event) : *
      {
         if(!stopYn && Main.gameNum.getValue() > 50 && Main.gameNum.getValue() < 100)
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
      
      public function onOver(e:*) : *
      {
         Map.MapLoaded = false;
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         removeEventListener(Event.REMOVED_FROM_STAGE,onOver);
      }
      
      public function GetPathsAndSpeed(pathsArr:Array, _speed:int = 5) : *
      {
         this.paths = pathsArr;
         this.speed = _speed;
      }
      
      public function Quake(qTime:int = 4) : *
      {
         if(quakeTime < qTime)
         {
            quakeTime = qTime;
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
         XueHua();
      }
      
      private function XueHua() : *
      {
         var xx:uint = 0;
         var yy:uint = 0;
         for(var i:uint = 0; i < 200; i++)
         {
            xx = Math.random() * 1600;
            yy = Math.random() * 600;
            NewMC.Open("雪",this.moveChild_Other,xx,yy);
         }
      }
      
      public function onCaoNiMa0(e:*) : *
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
         var yn:Boolean = false;
         var yn1:Boolean = false;
         if(Main.P1P2)
         {
            if(!SetTransferPanel.tbo1() || !SetTransferPanel.tbo2())
            {
               yn1 = true;
            }
         }
         else if(!SetTransferPanel.tbo1())
         {
            yn1 = true;
         }
         if(Main.P1P2)
         {
            if(yn1)
            {
               if(Boolean(Main.player_1) && Boolean(Main.player_2))
               {
                  if(!SetTransferPanel.tbo1() && !SetTransferPanel.tbo2())
                  {
                     if(Main.player1.getLevel() >= 25 || Main.player2.getLevel() >= 25)
                     {
                        yn = true;
                     }
                  }
                  else if(Boolean(SetTransferPanel.tbo1()) && !SetTransferPanel.tbo2())
                  {
                     if(Main.player2.getLevel() >= 25)
                     {
                        yn = true;
                     }
                  }
                  else if(Boolean(SetTransferPanel.tbo2()) && !SetTransferPanel.tbo1())
                  {
                     if(Main.player1.getLevel() >= 25)
                     {
                        yn = true;
                     }
                  }
               }
            }
         }
         else if(yn1)
         {
            if(Main.player_1)
            {
               if(Main.player1.getLevel() >= 25)
               {
                  yn = true;
               }
            }
         }
         if(yn)
         {
            this["转职"].visible = true;
         }
      }
      
      private function 转职面板(e:*) : *
      {
         SetTransferPanel.open();
      }
      
      public function CaoNiMa1() : *
      {
         addEventListener(Event.ADDED_TO_STAGE,onCaoNiMa1);
      }
      
      public function onCaoNiMa1(e:*) : *
      {
         开启Show();
         for(var i:int = 0; i <= 4; i++)
         {
            this["X_btn_8411" + i].addEventListener(MouseEvent.CLICK,Cangjingkong);
         }
         removeEventListener(Event.ADDED_TO_STAGE,onCaoNiMa1);
      }
      
      public function 开启(num:String) : *
      {
         this["X_btn_8411" + num].gotoAndPlay(2);
      }
      
      public function 开启Show() : *
      {
         var i:int = 0;
         for(i in Main.questArr)
         {
            if(Main.questArr[i][0])
            {
               this["X_btn_8411" + i].gotoAndStop(this["X_btn_8411" + i].totalFrames);
            }
         }
      }
      
      public function Cangjingkong(e:MouseEvent) : *
      {
         trace("开启" + e.target.name);
         var nameX2:Number = Number((e.target.name as String).substr(6,5));
         var nameX:Number = Number((e.target.name as String).substr(10,1));
         var gameYN:Boolean = Boolean(Main.getQuest(nameX2));
         if(gameYN)
         {
            return;
         }
         CangjingkongGoto(nameX2,nameX);
      }
      
      public function CangjingkongGoto(nameX2:String, nameX:String) : void
      {
         var yn:Boolean = false;
         for(var i:int = 1; i <= 2; i++)
         {
            if(Boolean(Main["player" + i]) && Boolean(Main["player" + i].getBag().fallQusetBag(nameX2)))
            {
               yn = true;
               break;
            }
         }
         if(yn)
         {
            开启(nameX);
            Main.setQuest(nameX2);
            for(i = 1; i <= 2; i++)
            {
               if(Boolean(Main["player" + i]) && Boolean(Main["player" + i].getBag().fallQusetBag(nameX2)))
               {
                  Main["player" + i] && Main["player" + i].getBag().clearQuest(nameX2);
               }
            }
         }
      }
      
      public function CaoNiMa2() : *
      {
         var i:* = undefined;
         trace("副本地图 Main.questArr = " + Main.questArr);
         for(i in Main.questArr)
         {
            if(!Main.questArr[i][0])
            {
               trace("Ying_" + (i + 1));
               this["Ying_" + (i + 1)].visible = false;
            }
         }
         addEventListener(Event.ENTER_FRAME,OtherGame);
      }
      
      private function OtherGame(e:*) : *
      {
         var i:* = undefined;
         var mc:MovieClip = null;
         var p:Player = null;
         if(this != Main.world)
         {
            removeEventListener(Event.ENTER_FRAME,OtherGame);
            return;
         }
         this["Sel_nanDu_mc"].x = -this.x;
         for(i in Main.questArr)
         {
            mc = this["Ying_" + (i + 1)];
            if(mc.visible)
            {
               for(i2 = 0; i2 < Player.All.length; ++i2)
               {
                  p = Player.All[i2];
                  if(Boolean(p.hit) && Boolean(mc.hitTestObject(p.hit)) && p.getKeyStatus("上",2))
                  {
                     InOtherGame(i + 1);
                  }
               }
            }
         }
      }
      
      private function InOtherGame(i:int = 1) : *
      {
         var str:String = "10" + i;
         Main.gameNum.setValue(int(str));
         Main.gameNum2.setValue(1);
         (this["Sel_nanDu_mc"] as Sel_NanDu).Open();
      }
   }
}

