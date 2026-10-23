package com.hotpoint.braveManIII.views.setKeyPanel
{
   import com.hotpoint.braveManIII.events.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import src.*;
   
   public class SetKeyPanel extends MovieClip
   {
      
      private static var _instance:SetKeyPanel;
      
      private static var _instance1:SetKeyPanel;
      
      public static var ysArr:Array = [87,83,65,68,74,75,76,72,85,73,79,49,50,51,32,78];
      
      public static var ysArr2:Array = [38,40,37,39,97,98,99,100,101,102,107,103,104,105,96,34];
      
      private var overBo:Boolean;
      
      private var oldCurrent:uint;
      
      private var p1ArrKeyArr:Array = [];
      
      private var p2ArrKeyArr:Array = [];
      
      private var keyNum:uint = 16;
      
      private var targetId:uint = 1;
      
      private var cchuArr:Array = [];
      
      private var sure2:Array = [38,40,37,39,97,98,99,100,101,102,107,103,104,105,96,34];
      
      private var sure1:Array = [87,83,65,68,74,75,76,72,85,73,79,49,50,51,32,78];
      
      private var clickState:Boolean;
      
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
         var stageWidth:Number = NaN;
         var stageHeight:Number = NaN;
         stageWidth = Main._stage.stageWidth / 2;
         stageHeight = Main._stage.stageHeight / 2;
         this.x = stageWidth - this.width / 2;
         this.y = stageHeight - this.height / 2;
      }
      
      private function initP1Frame() : void
      {
         var i:uint = 0;
         for(i = 0; i < keyNum; i++)
         {
            this["p1_" + i].mouseChildren = false;
            this["p1_" + i].buttonMode = true;
            this["p1_" + i].gotoAndStop("k" + Main.player1._keyArr[i]);
         }
      }
      
      private function p1out(mc:MovieClip) : void
      {
         if(p1ArrKeyArr[mc.id])
         {
            mc.key_mast.gotoAndStop(3);
         }
         else
         {
            mc.key_mast.gotoAndStop(1);
         }
      }
      
      private function openPlayerData(playerType:Number = 1) : void
      {
         p1orP2();
         if(playerType == 1)
         {
            updateFramep1();
         }
         if(playerType == 2)
         {
            p1_btn.gotoAndStop(4);
            updateFramep2();
         }
         sureMast.visible = false;
      }
      
      private function overHandle(e:MouseEvent) : void
      {
         if(Main.player2 == null)
         {
            p1over(e.target);
         }
         else if(targetId == 1)
         {
            p1over(e.target);
         }
         else if(targetId == 2)
         {
            p2over(e.target);
         }
      }
      
      private function outHandle(e:MouseEvent) : void
      {
         if(e.target.key_mast)
         {
            if(Main.player2 == null)
            {
               p1out(e.target);
            }
            else if(targetId == 1)
            {
               p1out(e.target);
            }
            else if(targetId == 2)
            {
               p2out(e.target);
            }
         }
      }
      
      private function closeOk() : Boolean
      {
         var i:uint = 0;
         if(Main.player2 != null)
         {
            i = 0;
            while(i < keyNum)
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
         for(i = 0; i < keyNum; i++)
         {
            if(Main.player1._keyArr[i] == -1)
            {
               return false;
            }
         }
         return true;
      }
      
      private function initKey() : *
      {
         var i:uint = 0;
         p1orP2();
         initFrame();
         for(i = 0; i < keyNum; i++)
         {
            p1ArrKeyArr[i] = false;
            p2ArrKeyArr[i] = false;
            this["p1_" + i].id = i;
            this["p1_" + i].addEventListener(MouseEvent.MOUSE_OVER,overHandle);
            this["p1_" + i].addEventListener(MouseEvent.MOUSE_OUT,outHandle);
            this["p1_" + i].addEventListener(MouseEvent.CLICK,clickHandle);
         }
         sureMast.visible = false;
         Main._stage.addEventListener(KeyboardEvent.KEY_DOWN,downHandle);
         addEventListener(BtnEvent.DO_CLOSE,btnCloseHandle);
         addEventListener(BtnEvent.DO_CHANGE,changeHandle);
         addEventListener(BtnEvent.DO_CLICK,btnClick);
      }
      
      private function initFrame() : void
      {
         if(!Main.P1P2)
         {
            initP1Frame();
         }
         else
         {
            if(targetId == 1)
            {
               initP1Frame();
            }
            if(targetId == 2)
            {
               initP2Frame();
            }
         }
      }
      
      private function p2out(mc:MovieClip) : void
      {
         if(p2ArrKeyArr[mc.id])
         {
            mc.key_mast.gotoAndStop(3);
         }
         else
         {
            mc.key_mast.gotoAndStop(1);
         }
      }
      
      private function p1over(mc:MovieClip) : void
      {
         if(p1ArrKeyArr[mc.id])
         {
            mc.key_mast.gotoAndStop(3);
         }
         else
         {
            mc.key_mast.gotoAndStop(2);
         }
      }
      
      private function p1Click(mc:MovieClip) : void
      {
         var i:uint = 0;
         for(i = 0; i < keyNum; i++)
         {
            p1ArrKeyArr[i] = false;
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
         p1ArrKeyArr[mc.id] = true;
      }
      
      private function btnCloseHandle(e:BtnEvent) : void
      {
         if(e.target.id == 1)
         {
            this.visible = false;
            close();
            if(Main.player2 == null)
            {
               Main.player1._keyArr = DeepCopyUtil.clone(sure1);
            }
            else
            {
               Main.player1._keyArr = DeepCopyUtil.clone(sure1);
               Main.player2._keyArr = DeepCopyUtil.clone(sure2);
            }
         }
         if(e.target.id == 2)
         {
            saveDate();
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
         var i:int = 0;
         var s:uint = 0;
         for(i = 0; i < p1ArrKeyArr.length; i++)
         {
            if(Main.player2 == null)
            {
               if(p1ArrKeyArr[i])
               {
                  for(s = 0; s < p1ArrKeyArr.length; s++)
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
                  p1ArrKeyArr[i] = false;
                  break;
               }
            }
            else if(targetId == 1)
            {
               if(p1ArrKeyArr[i])
               {
                  for(s = 0; s < p1ArrKeyArr.length; s++)
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
                  p1ArrKeyArr[i] = false;
                  break;
               }
            }
            else if(targetId == 2)
            {
               if(p2ArrKeyArr[i])
               {
                  for(s = 0; s < p2ArrKeyArr.length; s++)
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
                  p2ArrKeyArr[i] = false;
                  break;
               }
            }
         }
      }
      
      private function p2over(mc:MovieClip) : void
      {
         if(p2ArrKeyArr[mc.id])
         {
            mc.key_mast.gotoAndStop(3);
         }
         else
         {
            mc.key_mast.gotoAndStop(2);
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
      
      private function btnClick(e:BtnEvent) : void
      {
         if(e.target.id == 3)
         {
            if(closeOk())
            {
               saveDate();
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
               updateFramep1();
            }
            else
            {
               if(targetId == 1)
               {
                  Main.player1._keyArr = DeepCopyUtil.clone(ysArr);
                  Main.player2._keyArr = DeepCopyUtil.clone(ysArr2);
                  updateFramep1();
               }
               if(targetId == 2)
               {
                  Main.player1._keyArr = DeepCopyUtil.clone(ysArr);
                  Main.player2._keyArr = DeepCopyUtil.clone(ysArr2);
                  updateFramep2();
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
               p1Click(e.target);
            }
            else if(targetId == 1)
            {
               p1Click(e.target);
            }
            else if(targetId == 2)
            {
               p2Click(e.target);
            }
         }
      }
      
      private function initP2Frame() : void
      {
         var i:uint = 0;
         for(i = 0; i < keyNum; i++)
         {
            this["p1_" + i].mouseChildren = false;
            this["p1_" + i].buttonMode = true;
            this["p1_" + i].gotoAndStop("k" + Main.player2._keyArr[i]);
         }
      }
      
      private function saveDate() : void
      {
         trace("保存数据");
         if(Main.player2 == null)
         {
            sure1 = DeepCopyUtil.clone(Main.player1._keyArr);
         }
         else
         {
            sure1 = DeepCopyUtil.clone(Main.player1._keyArr);
            sure2 = DeepCopyUtil.clone(Main.player2._keyArr);
         }
         this.visible = false;
      }
      
      private function updateFramep1() : void
      {
         var i:uint = 0;
         for(i = 0; i < keyNum; i++)
         {
            if(Main.player1._keyArr[i] != -1)
            {
               this["p1_" + i].gotoAndStop("k" + Main.player1._keyArr[i]);
            }
            else
            {
               this["p1_" + i].gotoAndStop("kx");
            }
            p1ArrKeyArr[i] = false;
            this["p1_" + i].key_mast.gotoAndStop(1);
         }
      }
      
      private function updateFramep2() : void
      {
         var i:uint = 0;
         for(i = 0; i < keyNum; i++)
         {
            if(Main.player2._keyArr[i] != -1)
            {
               this["p1_" + i].gotoAndStop("k" + Main.player2._keyArr[i]);
            }
            else
            {
               this["p1_" + i].gotoAndStop("kx");
            }
            p2ArrKeyArr[i] = false;
            this["p1_" + i].key_mast.gotoAndStop(1);
         }
      }
      
      private function p2Click(mc:MovieClip) : void
      {
         for(i = 0; i < keyNum; ++i)
         {
            p2ArrKeyArr[i] = false;
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
         p2ArrKeyArr[mc.id] = true;
      }
      
      private function changeHandle(e:BtnEvent) : void
      {
         targetId = e.target.id;
         if(e.target.id == 1)
         {
            updateFramep1();
         }
         if(e.target.id == 2)
         {
            p1_btn.gotoAndStop(4);
            updateFramep2();
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
