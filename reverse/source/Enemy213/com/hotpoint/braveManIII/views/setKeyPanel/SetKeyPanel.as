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
      
      public function SetKeyPanel(param1:PrivateClass)
      {
         super();
      }
      
      public static function open(param1:Number = 1) : void
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
         SetKeyPanel._instance.openPlayerData(param1);
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
         var _loc1_:Number = Main._stage.stageWidth / 2;
         var _loc2_:Number = Main._stage.stageHeight / 2;
         this.x = _loc1_ - this.width / 2;
         this.y = _loc2_ - this.height / 2;
      }
      
      private function initKey() : *
      {
         this.p1orP2();
         this.initFrame();
         var _loc1_:uint = 0;
         while(_loc1_ < this.keyNum)
         {
            this.p1ArrKeyArr[_loc1_] = false;
            this.p2ArrKeyArr[_loc1_] = false;
            this["p1_" + _loc1_].id = _loc1_;
            this["p1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
            this["p1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
            this["p1_" + _loc1_].addEventListener(MouseEvent.CLICK,this.clickHandle);
            _loc1_++;
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
         var _loc1_:uint = 0;
         while(_loc1_ < this.keyNum)
         {
            this["p1_" + _loc1_].mouseChildren = false;
            this["p1_" + _loc1_].buttonMode = true;
            this["p1_" + _loc1_].gotoAndStop("k" + Main.player1._keyArr[_loc1_]);
            _loc1_++;
         }
      }
      
      private function initP2Frame() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.keyNum)
         {
            this["p1_" + _loc1_].mouseChildren = false;
            this["p1_" + _loc1_].buttonMode = true;
            this["p1_" + _loc1_].gotoAndStop("k" + Main.player2._keyArr[_loc1_]);
            _loc1_++;
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
      
      private function openPlayerData(param1:Number = 1) : void
      {
         this.p1orP2();
         if(param1 == 1)
         {
            this.updateFramep1();
         }
         if(param1 == 2)
         {
            p1_btn.gotoAndStop(4);
            this.updateFramep2();
         }
         sureMast.visible = false;
      }
      
      private function updateFramep1() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.keyNum)
         {
            if(Main.player1._keyArr[_loc1_] != -1)
            {
               this["p1_" + _loc1_].gotoAndStop("k" + Main.player1._keyArr[_loc1_]);
            }
            else
            {
               this["p1_" + _loc1_].gotoAndStop("kx");
            }
            this.p1ArrKeyArr[_loc1_] = false;
            this["p1_" + _loc1_].key_mast.gotoAndStop(1);
            _loc1_++;
         }
      }
      
      private function updateFramep2() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.keyNum)
         {
            if(Main.player2._keyArr[_loc1_] != -1)
            {
               this["p1_" + _loc1_].gotoAndStop("k" + Main.player2._keyArr[_loc1_]);
            }
            else
            {
               this["p1_" + _loc1_].gotoAndStop("kx");
            }
            this.p2ArrKeyArr[_loc1_] = false;
            this["p1_" + _loc1_].key_mast.gotoAndStop(1);
            _loc1_++;
         }
      }
      
      private function closeOk() : Boolean
      {
         var _loc1_:uint = 0;
         if(Main.player2 != null)
         {
            _loc1_ = 0;
            while(true)
            {
               if(_loc1_ < this.keyNum)
               {
                  if(Main.player1._keyArr[_loc1_] == -1)
                  {
                     break;
                  }
                  if(Main.player2._keyArr[_loc1_] == -1)
                  {
                     return false;
                  }
                  continue;
               }
               _loc1_++;
            }
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < this.keyNum)
         {
            if(Main.player1._keyArr[_loc1_] == -1)
            {
               return false;
            }
            _loc1_++;
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
      
      private function btnClick(param1:BtnEvent) : void
      {
         if(param1.target.id == 3)
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
         if(param1.target.id == 4)
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
      
      private function changeHandle(param1:BtnEvent) : void
      {
         this.targetId = param1.target.id;
         if(param1.target.id == 1)
         {
            this.updateFramep1();
         }
         if(param1.target.id == 2)
         {
            p1_btn.gotoAndStop(4);
            this.updateFramep2();
         }
      }
      
      private function btnCloseHandle(param1:BtnEvent) : void
      {
         if(param1.target.id == 1)
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
         if(param1.target.id == 2)
         {
            this.saveDate();
            trace("确定按钮");
         }
         if(param1.target.id == 3)
         {
            sureMast.visible = false;
            trace("关闭提示面板");
         }
      }
      
      private function downHandle(param1:KeyboardEvent) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.p1ArrKeyArr.length)
         {
            if(Main.player2 == null)
            {
               if(this.p1ArrKeyArr[_loc2_])
               {
                  _loc3_ = 0;
                  while(_loc3_ < this.p1ArrKeyArr.length)
                  {
                     if(Main.player1._keyArr[_loc3_] == param1.keyCode)
                     {
                        Main.player1._keyArr[_loc3_] = -1;
                        this["p1_" + _loc3_].gotoAndStop("kx");
                     }
                     _loc3_++;
                  }
                  Main.player1._keyArr[_loc2_] = param1.keyCode;
                  this["p1_" + _loc2_].gotoAndStop("k" + Main.player1._keyArr[_loc2_]);
                  this["p1_" + _loc2_].key_mast.gotoAndStop(1);
                  this.p1ArrKeyArr[_loc2_] = false;
                  break;
               }
            }
            else if(this.targetId == 1)
            {
               if(this.p1ArrKeyArr[_loc2_])
               {
                  _loc3_ = 0;
                  while(_loc3_ < this.p1ArrKeyArr.length)
                  {
                     if(Main.player1._keyArr[_loc3_] == param1.keyCode)
                     {
                        Main.player1._keyArr[_loc3_] = -1;
                        this["p1_" + _loc3_].gotoAndStop("kx");
                     }
                     if(Main.player2._keyArr[_loc3_] == param1.keyCode)
                     {
                        trace("按1时 2重复的是:" + param1.keyCode);
                        Main.player2._keyArr[_loc3_] = -1;
                     }
                     _loc3_++;
                  }
                  Main.player1._keyArr[_loc2_] = param1.keyCode;
                  this["p1_" + _loc2_].gotoAndStop("k" + Main.player1._keyArr[_loc2_]);
                  this["p1_" + _loc2_].key_mast.gotoAndStop(1);
                  this.p1ArrKeyArr[_loc2_] = false;
                  break;
               }
            }
            else if(this.targetId == 2)
            {
               if(this.p2ArrKeyArr[_loc2_])
               {
                  _loc3_ = 0;
                  while(_loc3_ < this.p2ArrKeyArr.length)
                  {
                     if(Main.player2._keyArr[_loc3_] == param1.keyCode)
                     {
                        Main.player2._keyArr[_loc3_] = -1;
                        this["p1_" + _loc3_].gotoAndStop("kx");
                     }
                     if(Main.player1._keyArr[_loc3_] == param1.keyCode)
                     {
                        trace("按2时 1重复的是:" + param1.keyCode);
                        Main.player1._keyArr[_loc3_] = -1;
                     }
                     _loc3_++;
                  }
                  Main.player2._keyArr[_loc2_] = param1.keyCode;
                  this["p1_" + _loc2_].gotoAndStop("k" + Main.player2._keyArr[_loc2_]);
                  this["p1_" + _loc2_].key_mast.gotoAndStop(1);
                  this.p2ArrKeyArr[_loc2_] = false;
                  break;
               }
            }
            _loc2_++;
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         if(param1.target.key_mast)
         {
            if(Main.player2 == null)
            {
               this.p1Click(param1.target);
            }
            else if(this.targetId == 1)
            {
               this.p1Click(param1.target);
            }
            else if(this.targetId == 2)
            {
               this.p2Click(param1.target);
            }
         }
      }
      
      private function p1Click(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.keyNum)
         {
            this.p1ArrKeyArr[_loc2_] = false;
            this["p1_" + _loc2_].key_mast.gotoAndStop(1);
            if(Main.player1._keyArr[_loc2_] != -1)
            {
               this["p1_" + _loc2_].gotoAndStop("k" + Main.player1._keyArr[_loc2_]);
            }
            else
            {
               this["p1_" + _loc2_].gotoAndStop("kx");
            }
            _loc2_++;
         }
         param1.gotoAndStop("k0");
         param1.key_mast.gotoAndStop(3);
         this.p1ArrKeyArr[param1.id] = true;
      }
      
      private function p2Click(param1:MovieClip) : void
      {
         i = 0;
         while(i < this.keyNum)
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
            ++i;
         }
         param1.gotoAndStop("k0");
         param1.key_mast.gotoAndStop(3);
         this.p2ArrKeyArr[param1.id] = true;
      }
      
      private function outHandle(param1:MouseEvent) : void
      {
         if(param1.target.key_mast)
         {
            if(Main.player2 == null)
            {
               this.p1out(param1.target);
            }
            else if(this.targetId == 1)
            {
               this.p1out(param1.target);
            }
            else if(this.targetId == 2)
            {
               this.p2out(param1.target);
            }
         }
      }
      
      private function p1out(param1:MovieClip) : void
      {
         if(this.p1ArrKeyArr[param1.id])
         {
            param1.key_mast.gotoAndStop(3);
         }
         else
         {
            param1.key_mast.gotoAndStop(1);
         }
      }
      
      private function p2out(param1:MovieClip) : void
      {
         if(this.p2ArrKeyArr[param1.id])
         {
            param1.key_mast.gotoAndStop(3);
         }
         else
         {
            param1.key_mast.gotoAndStop(1);
         }
      }
      
      private function overHandle(param1:MouseEvent) : void
      {
         if(Main.player2 == null)
         {
            this.p1over(param1.target);
         }
         else if(this.targetId == 1)
         {
            this.p1over(param1.target);
         }
         else if(this.targetId == 2)
         {
            this.p2over(param1.target);
         }
      }
      
      private function p1over(param1:MovieClip) : void
      {
         if(this.p1ArrKeyArr[param1.id])
         {
            param1.key_mast.gotoAndStop(3);
         }
         else
         {
            param1.key_mast.gotoAndStop(2);
         }
      }
      
      private function p2over(param1:MovieClip) : void
      {
         if(this.p2ArrKeyArr[param1.id])
         {
            param1.key_mast.gotoAndStop(3);
         }
         else
         {
            param1.key_mast.gotoAndStop(2);
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
