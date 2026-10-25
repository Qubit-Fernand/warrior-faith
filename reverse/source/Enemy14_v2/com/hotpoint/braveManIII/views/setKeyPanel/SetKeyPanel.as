package com.hotpoint.braveManIII.views.setKeyPanel
{
   import com.hotpoint.braveManIII.events.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import src.*;
   
   public class SetKeyPanel extends MovieClip
   {
      
      private static var _instance1:SetKeyPanel;
      
      private static var _instance:SetKeyPanel;
      
      public static var ysArr:Array = [87,83,65,68,74,75,76,72,85,73,79,49,50,51,32,78];
      
      public static var ysArr2:Array = [38,40,37,39,97,98,99,100,101,102,107,103,104,105,96,34];
      
      private var keyNum:uint = 16;
      
      private var sure1:Array = [87,83,65,68,74,75,76,72,85,73,79,49,50,51,32,78];
      
      private var sure2:Array = [38,40,37,39,97,98,99,100,101,102,107,103,104,105,96,34];
      
      private var cchuArr:Array = [];
      
      private var p1ArrKeyArr:Array = [];
      
      private var p2ArrKeyArr:Array = [];
      
      private var clickState:Boolean;
      
      private var overBo:Boolean;
      
      private var oldCurrent:uint;
      
      private var targetId:uint = 1;
      
      public function SetKeyPanel(pvt:PrivateClass)
      {
         super();
      }
      
      public static function open(playerType:Number = 1) : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(SetKeyPanel._instance == null)
         {
            SetKeyPanel._instance = new SetKeyPanel(new PrivateClass());
            SetKeyPanel._instance.initKey();
         }
         SetKeyPanel._instance.setXY();
         Main._stage.addChild(SetKeyPanel._instance);
         SetKeyPanel._instance.openPlayerData(playerType);
         SetKeyPanel._instance.visible = true;
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(SetKeyPanel._instance != null)
         {
            if(SetKeyPanel._instance.visible == true)
            {
               SetKeyPanel._instance.visible = false;
            }
         }
      }
      
      private function setXY() : void
      {
         var stageWidth:Number = Main._stage.stageWidth / 2;
         var stageHeight:Number = Main._stage.stageHeight / 2;
         this.x = stageWidth - this.width / 2;
         this.y = stageHeight - this.height / 2;
      }
      
      private function initKey() : *
      {
         this.p1orP2();
         this.initFrame();
         for(var i:uint = 0; i < this.keyNum; i++)
         {
            this.p1ArrKeyArr[i] = false;
            this.p2ArrKeyArr[i] = false;
            this["p1_" + i].id = i;
            this["p1_" + i].addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
            this["p1_" + i].addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
            this["p1_" + i].addEventListener(MouseEvent.CLICK,this.clickHandle);
         }
         sureMast.visible = false;
         Main._stage.addEventListener(KeyboardEvent.KEY_DOWN,this.downHandle);
         addEventListener(BtnEvent.DO_CLOSE,this.btnCloseHandle);
         addEventListener(BtnEvent.DO_CHANGE,this.changeHandle);
         addEventListener(BtnEvent.DO_CLICK,this.btnClick);
      }
      
      private function initFrame() : void
      {
         if(!Main.P1P2)
         {
            this.initP1Frame();
         }
         else
         {
            if(this.targetId == 1)
            {
               this.initP1Frame();
            }
            if(this.targetId == 2)
            {
               this.initP2Frame();
            }
         }
      }
      
      private function initP1Frame() : void
      {
         for(var i:uint = 0; i < this.keyNum; i++)
         {
            this["p1_" + i].mouseChildren = false;
            this["p1_" + i].buttonMode = true;
            this["p1_" + i].gotoAndStop("k" + Main.player1._keyArr[i]);
         }
      }
      
      private function initP2Frame() : void
      {
         for(var i:uint = 0; i < this.keyNum; i++)
         {
            this["p1_" + i].mouseChildren = false;
            this["p1_" + i].buttonMode = true;
            this["p1_" + i].gotoAndStop("k" + Main.player2._keyArr[i]);
         }
      }
      
      private function p1orP2() : void
      {
         if(Main.P1P2)
         {
            setKeyMast.visible = false;
         }
         else
         {
            setKeyMast.visible = true;
            p2_btn.isClick = false;
            p2_btn.gotoAndStop(4);
         }
      }
      
      private function openPlayerData(playerType:Number = 1) : void
      {
         this.p1orP2();
         if(playerType == 1)
         {
            this.updateFramep1();
         }
         if(playerType == 2)
         {
            p1_btn.gotoAndStop(4);
            this.updateFramep2();
         }
         sureMast.visible = false;
      }
      
      private function updateFramep1() : void
      {
         for(var i:uint = 0; i < this.keyNum; i++)
         {
            if(Main.player1._keyArr[i] != -1)
            {
               this["p1_" + i].gotoAndStop("k" + Main.player1._keyArr[i]);
            }
            else
            {
               this["p1_" + i].gotoAndStop("kx");
            }
            this.p1ArrKeyArr[i] = false;
            this["p1_" + i].key_mast.gotoAndStop(1);
         }
      }
      
      private function updateFramep2() : void
      {
         for(var i:uint = 0; i < this.keyNum; i++)
         {
            if(Main.player2._keyArr[i] != -1)
            {
               this["p1_" + i].gotoAndStop("k" + Main.player2._keyArr[i]);
            }
            else
            {
               this["p1_" + i].gotoAndStop("kx");
            }
            this.p2ArrKeyArr[i] = false;
            this["p1_" + i].key_mast.gotoAndStop(1);
         }
      }
      
      private function closeOk() : Boolean
      {
         var i:uint = 0;
         if(Main.player2 != null)
         {
            i = 0;
            while(i < this.keyNum)
            {
               if(Main.player1._keyArr[i] == -1)
               {
                  return false;
               }
               if(Main.player2._keyArr[i] == -1)
               {
                  return false;
               }
               i++;
            }
            return true;
         }
         for(i = 0; i < this.keyNum; i++)
         {
            if(Main.player1._keyArr[i] == -1)
            {
               return false;
            }
         }
         return true;
      }
      
      private function saveDate() : void
      {
         trace("保存数据");
         if(Main.player2 == null)
         {
            this.sure1 = DeepCopyUtil.clone(Main.player1._keyArr);
         }
         else
         {
            this.sure1 = DeepCopyUtil.clone(Main.player1._keyArr);
            this.sure2 = DeepCopyUtil.clone(Main.player2._keyArr);
         }
         this.visible = false;
      }
      
      private function btnClick(e:BtnEvent) : void
      {
         if(e.target.id == 3)
         {
            if(this.closeOk())
            {
               this.saveDate();
            }
            else
            {
               sureMast.visible = true;
               trace("键位未设置");
            }
         }
         if(e.target.id == 4)
         {
            if(Main.player2 == null)
            {
               Main.player1._keyArr = DeepCopyUtil.clone(ysArr);
               this.updateFramep1();
            }
            else
            {
               if(this.targetId == 1)
               {
                  Main.player1._keyArr = DeepCopyUtil.clone(ysArr);
                  Main.player2._keyArr = DeepCopyUtil.clone(ysArr2);
                  this.updateFramep1();
               }
               if(this.targetId == 2)
               {
                  Main.player1._keyArr = DeepCopyUtil.clone(ysArr);
                  Main.player2._keyArr = DeepCopyUtil.clone(ysArr2);
                  this.updateFramep2();
               }
            }
         }
      }
      
      private function changeHandle(e:BtnEvent) : void
      {
         this.targetId = e.target.id;
         if(e.target.id == 1)
         {
            this.updateFramep1();
         }
         if(e.target.id == 2)
         {
            p1_btn.gotoAndStop(4);
            this.updateFramep2();
         }
      }
      
      private function btnCloseHandle(e:BtnEvent) : void
      {
         if(e.target.id == 1)
         {
            this.visible = false;
            close();
            if(Main.player2 == null)
            {
               Main.player1._keyArr = DeepCopyUtil.clone(this.sure1);
            }
            else
            {
               Main.player1._keyArr = DeepCopyUtil.clone(this.sure1);
               Main.player2._keyArr = DeepCopyUtil.clone(this.sure2);
            }
         }
         if(e.target.id == 2)
         {
            this.saveDate();
            trace("确定按钮");
         }
         if(e.target.id == 3)
         {
            sureMast.visible = false;
            trace("关闭提示面板");
         }
      }
      
      private function downHandle(e:KeyboardEvent) : void
      {
         var s:uint = 0;
         for(var i:int = 0; i < this.p1ArrKeyArr.length; i++)
         {
            if(Main.player2 == null)
            {
               if(this.p1ArrKeyArr[i])
               {
                  for(s = 0; s < this.p1ArrKeyArr.length; s++)
                  {
                     if(Main.player1._keyArr[s] == e.keyCode)
                     {
                        Main.player1._keyArr[s] = -1;
                        this["p1_" + s].gotoAndStop("kx");
                     }
                  }
                  Main.player1._keyArr[i] = e.keyCode;
                  this["p1_" + i].gotoAndStop("k" + Main.player1._keyArr[i]);
                  this["p1_" + i].key_mast.gotoAndStop(1);
                  this.p1ArrKeyArr[i] = false;
                  break;
               }
            }
            else if(this.targetId == 1)
            {
               if(this.p1ArrKeyArr[i])
               {
                  for(s = 0; s < this.p1ArrKeyArr.length; s++)
                  {
                     if(Main.player1._keyArr[s] == e.keyCode)
                     {
                        Main.player1._keyArr[s] = -1;
                        this["p1_" + s].gotoAndStop("kx");
                     }
                     if(Main.player2._keyArr[s] == e.keyCode)
                     {
                        trace("按1时 2重复的是:" + e.keyCode);
                        Main.player2._keyArr[s] = -1;
                     }
                  }
                  Main.player1._keyArr[i] = e.keyCode;
                  this["p1_" + i].gotoAndStop("k" + Main.player1._keyArr[i]);
                  this["p1_" + i].key_mast.gotoAndStop(1);
                  this.p1ArrKeyArr[i] = false;
                  break;
               }
            }
            else if(this.targetId == 2)
            {
               if(this.p2ArrKeyArr[i])
               {
                  for(s = 0; s < this.p2ArrKeyArr.length; s++)
                  {
                     if(Main.player2._keyArr[s] == e.keyCode)
                     {
                        Main.player2._keyArr[s] = -1;
                        this["p1_" + s].gotoAndStop("kx");
                     }
                     if(Main.player1._keyArr[s] == e.keyCode)
                     {
                        trace("按2时 1重复的是:" + e.keyCode);
                        Main.player1._keyArr[s] = -1;
                     }
                  }
                  Main.player2._keyArr[i] = e.keyCode;
                  this["p1_" + i].gotoAndStop("k" + Main.player2._keyArr[i]);
                  this["p1_" + i].key_mast.gotoAndStop(1);
                  this.p2ArrKeyArr[i] = false;
                  break;
               }
            }
         }
      }
      
      private function clickHandle(e:MouseEvent) : void
      {
         if(e.target.key_mast)
         {
            if(Main.player2 == null)
            {
               this.p1Click(e.target);
            }
            else if(this.targetId == 1)
            {
               this.p1Click(e.target);
            }
            else if(this.targetId == 2)
            {
               this.p2Click(e.target);
            }
         }
      }
      
      private function p1Click(mc:MovieClip) : void
      {
         for(var i:uint = 0; i < this.keyNum; i++)
         {
            this.p1ArrKeyArr[i] = false;
            this["p1_" + i].key_mast.gotoAndStop(1);
            if(Main.player1._keyArr[i] != -1)
            {
               this["p1_" + i].gotoAndStop("k" + Main.player1._keyArr[i]);
            }
            else
            {
               this["p1_" + i].gotoAndStop("kx");
            }
         }
         mc.gotoAndStop("k0");
         mc.key_mast.gotoAndStop(3);
         this.p1ArrKeyArr[mc.id] = true;
      }
      
      private function p2Click(mc:MovieClip) : void
      {
         for(i = 0; i < this.keyNum; ++i)
         {
            this.p2ArrKeyArr[i] = false;
            this["p1_" + i].key_mast.gotoAndStop(1);
            if(Main.player2._keyArr[i] != -1)
            {
               this["p1_" + i].gotoAndStop("k" + Main.player2._keyArr[i]);
            }
            else
            {
               this["p1_" + i].gotoAndStop("kx");
            }
         }
         mc.gotoAndStop("k0");
         mc.key_mast.gotoAndStop(3);
         this.p2ArrKeyArr[mc.id] = true;
      }
      
      private function outHandle(e:MouseEvent) : void
      {
         if(e.target.key_mast)
         {
            if(Main.player2 == null)
            {
               this.p1out(e.target);
            }
            else if(this.targetId == 1)
            {
               this.p1out(e.target);
            }
            else if(this.targetId == 2)
            {
               this.p2out(e.target);
            }
         }
      }
      
      private function p1out(mc:MovieClip) : void
      {
         if(this.p1ArrKeyArr[mc.id])
         {
            mc.key_mast.gotoAndStop(3);
         }
         else
         {
            mc.key_mast.gotoAndStop(1);
         }
      }
      
      private function p2out(mc:MovieClip) : void
      {
         if(this.p2ArrKeyArr[mc.id])
         {
            mc.key_mast.gotoAndStop(3);
         }
         else
         {
            mc.key_mast.gotoAndStop(1);
         }
      }
      
      private function overHandle(e:MouseEvent) : void
      {
         if(Main.player2 == null)
         {
            this.p1over(e.target);
         }
         else if(this.targetId == 1)
         {
            this.p1over(e.target);
         }
         else if(this.targetId == 2)
         {
            this.p2over(e.target);
         }
      }
      
      private function p1over(mc:MovieClip) : void
      {
         if(this.p1ArrKeyArr[mc.id])
         {
            mc.key_mast.gotoAndStop(3);
         }
         else
         {
            mc.key_mast.gotoAndStop(2);
         }
      }
      
      private function p2over(mc:MovieClip) : void
      {
         if(this.p2ArrKeyArr[mc.id])
         {
            mc.key_mast.gotoAndStop(3);
         }
         else
         {
            mc.key_mast.gotoAndStop(2);
         }
      }
   }
}

class PrivateClass
{
   
   public function PrivateClass()
   {
      super();
   }
}
