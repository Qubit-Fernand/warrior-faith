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
            this.MapData = this["_Data"];
            if(this.MapData["Data1"])
            {
               this.MapData1 = this.MapData["Data1"];
            }
            if(this.MapData["Data2"])
            {
               this.MapData2 = this.MapData["Data2"];
            }
            this.stopX_1 = 0;
            if(this["moveChild"])
            {
               this._width = this.stopX_2 = this["moveChild"].width;
            }
            else
            {
               this._width = this.stopX_2 = 1600;
            }
            addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
            addEventListener(Event.REMOVED_FROM_STAGE,this.onOver);
         }
         if(this["moveChild"])
         {
            this["moveChild"].addChild(this.moveChild_Back);
            this["moveChild"].addChild(this.moveChild_ChongWu);
            this["moveChild"].addChild(this.moveChild_Enemy);
            this["moveChild"].addChild(this.moveChild_Player);
            this["moveChild"].addChild(this.moveChild_Other);
            if(this["map_3"])
            {
               this["moveChild"].addChild(this["map_3"]);
               this["map_3"].mouseChildren = this["map_3"].mouseEnabled = false;
            }
         }
         else
         {
            addChild(this.moveChild_Back);
            addChild(this.moveChild_ChongWu);
            addChild(this.moveChild_Enemy);
            addChild(this.moveChild_Player);
            addChild(this.moveChild_Other);
            if(this["map_3"])
            {
               addChild(this["map_3"]);
               this["map_3"].mouseChildren = this["map_3"].mouseEnabled = false;
            }
         }
         this.moveChild_Other.mouseChildren = this.moveChild_Other.mouseEnabled = false;
         this.moveChild_Player.mouseChildren = this.moveChild_Player.mouseEnabled = false;
         this.moveChild_ChongWu.mouseChildren = this.moveChild_ChongWu.mouseEnabled = false;
         if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 0)
         {
            this.CaoNiMa0();
         }
         else if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 1)
         {
            this.CaoNiMa1();
         }
         else if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 2)
         {
            this.CaoNiMa2();
         }
         Main._stage.stageFocusRect = false;
         Main._stage.focus = this;
      }
      
      public function NoStop() : *
      {
         Main.world.stopYn = false;
         this.stopX_1 = 0;
         if(this["moveChild"])
         {
            this.stopX_2 = this["moveChild"].width;
         }
         else
         {
            this.stopX_2 = 1600;
         }
      }
      
      private function onENTER_FRAME(e:Event) : *
      {
         if(!this.stopYn && Main.gameNum.getValue() > 50 && Main.gameNum.getValue() < 100)
         {
            if(Main.world.x <= -this.stopNumArr[Main.gameNum2.getValue()] + 940)
            {
               this.stopYn = true;
               this.stopX_1 = this.stopNumArr[Main.gameNum2.getValue() - 1];
               this.stopX_2 = -Main.world.x + 940;
               if(this.stopX_2 - this.stopX_1 < 940)
               {
                  this.stopX_1 = this.stopX_2 - 938;
               }
            }
         }
         if(this != Main.world)
         {
            removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
            return;
         }
         this.背景移动();
         this.地震();
      }
      
      private function Run() : *
      {
         this.runX = this.runY = 0;
         if(this.paths.length > 1)
         {
            if(this.x > this.paths[this.nextNode][0])
            {
               if(this.x - this.speed < this.paths[this.nextNode][0])
               {
                  this.x = this.paths[this.nextNode][0];
               }
               else
               {
                  this.x -= this.speed;
                  this.runX = -this.speed;
               }
            }
            else if(this.x < this.paths[this.nextNode][0])
            {
               if(this.x + this.speed > this.paths[this.nextNode][0])
               {
                  this.x = this.paths[this.nextNode][0];
               }
               else
               {
                  this.x += this.speed;
                  this.runX = this.speed;
               }
            }
            if(this.y > this.paths[this.nextNode][1])
            {
               if(this.y - this.speed < this.paths[this.nextNode][1])
               {
                  this.y = this.paths[this.nextNode][1];
               }
               else
               {
                  this.y -= this.speed;
               }
            }
            else if(this.y < this.paths[this.nextNode][1])
            {
               if(this.y + this.speed > this.paths[this.nextNode][1])
               {
                  this.y = this.paths[this.nextNode][1];
               }
               else
               {
                  this.y += this.speed;
               }
            }
            if(this.x == this.paths[this.nextNode][0] && this.y == this.paths[this.nextNode][1])
            {
               if(this.nextNode + 1 == this.paths.length)
               {
                  this.nextNode = 0;
               }
               else
               {
                  ++this.nextNode;
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
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onOver);
      }
      
      public function GetPathsAndSpeed(pathsArr:Array, _speed:int = 5) : *
      {
         this.paths = pathsArr;
         this.speed = _speed;
      }
      
      public function Quake(qTime:int = 4) : *
      {
         if(this.quakeTime < qTime)
         {
            this.quakeTime = qTime;
         }
      }
      
      private function 地震() : *
      {
         if(this.quakeTime <= 0)
         {
            this.y = 0;
            return;
         }
         if(this.quakeTime % 2 == 0)
         {
            this.y = -this.quakeNum;
         }
         else
         {
            this.y = 0;
         }
         --this.quakeTime;
      }
      
      public function CaoNiMa0() : *
      {
         addEventListener(Event.ADDED_TO_STAGE,this.onCaoNiMa0);
         this.XueHua();
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
         this.开启Show0();
         removeEventListener(Event.ADDED_TO_STAGE,this.onCaoNiMa0);
      }
      
      public function 开启Show0() : *
      {
         if(!this["转职"])
         {
            return;
         }
         this["转职"].visible = false;
         this["转职"].addEventListener(MouseEvent.CLICK,this.转职面板);
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
         addEventListener(Event.ADDED_TO_STAGE,this.onCaoNiMa1);
      }
      
      public function onCaoNiMa1(e:*) : *
      {
         this.开启Show();
         for(var i:int = 0; i <= 4; i++)
         {
            this["X_btn_8411" + i].addEventListener(MouseEvent.CLICK,this.Cangjingkong);
         }
         removeEventListener(Event.ADDED_TO_STAGE,this.onCaoNiMa1);
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
         var nameX2:Number = Number((e.target.name as String).substr(6,5));
         var nameX:Number = Number((e.target.name as String).substr(10,1));
         var gameYN:Boolean = Boolean(Main.getQuest(nameX2));
         if(gameYN)
         {
            return;
         }
         this.CangjingkongGoto(nameX2,nameX);
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
            this.开启(nameX);
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
         for(i in Main.questArr)
         {
            if(!Main.questArr[i][0])
            {
               this["Ying_" + (i + 1)].visible = false;
            }
         }
         addEventListener(Event.ENTER_FRAME,this.OtherGame);
      }
      
      private function OtherGame(e:*) : *
      {
         var i:* = undefined;
         var mc:MovieClip = null;
         var p:Player = null;
         if(this != Main.world)
         {
            removeEventListener(Event.ENTER_FRAME,this.OtherGame);
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
                     this.InOtherGame(i + 1);
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

