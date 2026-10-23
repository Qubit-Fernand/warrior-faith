package com.hotpoint.braveManIII.views.setProfession
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.player.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class SetProfession extends MovieClip
   {
      
      private static var _instance:SetProfession;
      
      public static var skinArr1:Array = [0,1];
      
      public static var skinArr2:Array = [0,1];
      
      public static var clickArr1:Array = [true,true,false];
      
      public static var clickArr2:Array = [true,true,false];
      
      private var playerNum:Number = 1;
      
      private var playerXX:Number = 1;
      
      private var typeStata:Number = 0;
      
      private var keyNum1:Number = 0;
      
      private var keyNum2:Number = 0;
      
      private var bo:Boolean;
      
      public function SetProfession()
      {
         super();
      }
      
      public static function open1(param1:uint = 1) : void
      {
         if(SetProfession._instance == null)
         {
            SetProfession._instance = new SetProfession();
         }
         SetProfession._instance.initData(param1);
         SetProfession._instance.visible = true;
         Main._stage.addChild(SetProfession._instance);
      }
      
      public static function open2(param1:uint = 1) : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(SetProfession._instance == null)
         {
            SetProfession._instance = new SetProfession();
         }
         SetProfession._instance.initData2(param1);
         SetProfession._instance.visible = true;
         Main._stage.addChild(SetProfession._instance);
      }
      
      public static function close() : void
      {
         SetProfession._instance.visible = false;
      }
      
      public function initData(param1:uint = 1) : void
      {
         playerNum = param1;
         typeStata = 0;
         initFrame(param1);
         initEvent();
         if(param1 == 1)
         {
            allMc.xxBtn.visible = false;
            BisClick("p1_",clickArr1);
            allMc.t1_0.gotoAndStop(1);
            allMc.t1_1.gotoAndStop(2);
            allMc.t1_2.visible = false;
         }
         else if(param1 == 3)
         {
            addEventListener(Event.ENTER_FRAME,onEntHandle);
         }
      }
      
      private function onEntHandle(param1:Event) : void
      {
         if(Boolean(allMc.p1_0) && Boolean(allMc.p1_1) && Boolean(allMc.p1_2) && (Boolean(allMc.p2_0) && Boolean(allMc.p2_1) && Boolean(allMc.p2_2)))
         {
            if(!bo)
            {
               bo = true;
               BisClick("p1_",clickArr1);
               BisClick("p2_",clickArr2);
               allMc.t1_0.gotoAndStop(1);
               allMc.t1_1.gotoAndStop(2);
               allMc.t1_2.visible = false;
               allMc.t2_0.gotoAndStop(1);
               allMc.t2_1.gotoAndStop(2);
               allMc.t2_2.visible = false;
            }
         }
      }
      
      public function initData2(param1:uint = 1) : void
      {
         typeStata = 1;
         playerXX = param1;
         initFrame(param1);
         initEvent();
      }
      
      public function initFrame(param1:uint = 1) : void
      {
         gotoNum(param1);
      }
      
      public function initEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CLICK,clickHandle);
         this.addEventListener(BtnEvent.DO_CHANGE,changeHandle);
      }
      
      private function changeHandle(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:String = _loc2_.name.substr(1,1);
         var _loc4_:String = _loc2_.name.substr(3,1);
         clickArr(_loc3_,_loc4_);
      }
      
      private function clickArr(param1:String, param2:String) : void
      {
         if(param1 == "1")
         {
            clickArr1 = changeClick(clickArr1,Number(param2));
            if(towTrue(clickArr1))
            {
               clickArr1 = clickGoto(clickArr1,Number(param2));
               t1ViFalse(Number(param2));
            }
            BisClick("p1_",clickArr1);
            t1Goto("t1_",param2);
         }
         else if(param1 == "2")
         {
            clickArr2 = changeClick(clickArr2,Number(param2));
            if(towTrue(clickArr2))
            {
               clickArr2 = clickGoto(clickArr2,Number(param2));
               t2ViFalse(Number(param2));
            }
            BisClick("p2_",clickArr2);
            t1Goto("t2_",param2);
         }
      }
      
      private function t1Goto(param1:String, param2:Number) : void
      {
         if(!allMc[param1 + param2].visible)
         {
            allMc[param1 + param2].visible = true;
            allMc[param1 + param2].gotoAndStop(2);
         }
      }
      
      private function t1ViFalse(param1:Number) : void
      {
         switch(param1)
         {
            case 0:
               allMc.t1_1.visible = false;
               allMc.t1_2.gotoAndStop(1);
               break;
            case 1:
               allMc.t1_2.visible = false;
               allMc.t1_0.gotoAndStop(1);
               break;
            case 2:
               allMc.t1_0.visible = false;
               allMc.t1_1.gotoAndStop(1);
         }
      }
      
      private function t2ViFalse(param1:Number) : void
      {
         switch(param1)
         {
            case 0:
               allMc.t2_1.visible = false;
               allMc.t2_2.gotoAndStop(1);
               break;
            case 1:
               allMc.t2_2.visible = false;
               allMc.t2_0.gotoAndStop(1);
               break;
            case 2:
               allMc.t2_0.visible = false;
               allMc.t2_1.gotoAndStop(1);
         }
      }
      
      private function clickGoto(param1:Array, param2:Number) : Array
      {
         switch(param2)
         {
            case 0:
               param1[1] = false;
               break;
            case 1:
               param1[2] = false;
               break;
            case 2:
               param1[0] = false;
         }
         return param1;
      }
      
      private function towTrue(param1:Array) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_])
            {
               _loc2_++;
            }
            _loc3_++;
         }
         if(_loc2_ == 3)
         {
            return true;
         }
         return false;
      }
      
      public function zyArr(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_])
            {
               _loc2_.push(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function changeClick(param1:Array, param2:Number) : Array
      {
         if(!param1[param2])
         {
            param1[param2] = true;
         }
         return param1;
      }
      
      private function BisClick(param1:String, param2:Array) : void
      {
         var _loc3_:uint = 0;
         while(_loc3_ < 3)
         {
            allMc[param1 + _loc3_].isClick = param2[_loc3_];
            _loc3_++;
         }
      }
      
      private function clickHandle(param1:BtnEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(typeStata == 0)
         {
            _loc2_ = Number(p1ok());
            if(playerNum == 1)
            {
               if(_loc2_ == 2)
               {
                  skinArr1 = zyArr(clickArr1);
                  closeData();
                  Strat.startGame();
               }
            }
            else if(playerNum == 3)
            {
               _loc3_ = Number(p2ok());
               if(_loc2_ == 2 && _loc3_ == 2)
               {
                  skinArr1 = zyArr(clickArr1);
                  skinArr2 = zyArr(clickArr2);
                  closeData();
                  Strat.startGame();
               }
            }
         }
         else if(typeStata == 1)
         {
            if(playerXX == 1)
            {
               _loc2_ = Number(p1ok());
               if(_loc2_ == 2)
               {
                  skinArr1 = zyArr(clickArr1);
                  closeData();
               }
            }
            else if(playerXX == 2)
            {
               _loc3_ = Number(p2ok());
               if(_loc2_ == 2)
               {
                  skinArr2 = zyArr(clickArr1);
                  closeData();
               }
            }
         }
         removeEventListener(Event.ENTER_FRAME,onEntHandle);
      }
      
      private function p1ok() : Number
      {
         var _loc1_:Number = Number(okArr(clickArr1));
         if(_loc1_ >= 2)
         {
            if(_loc1_ <= 2)
            {
               if(_loc1_ == 2)
               {
               }
            }
         }
         return _loc1_;
      }
      
      private function p2ok() : Number
      {
         var _loc1_:Number = Number(okArr(clickArr2));
         if(_loc1_ >= 2)
         {
            if(_loc1_ <= 2)
            {
               if(_loc1_ == 2)
               {
               }
            }
         }
         return _loc1_;
      }
      
      private function closeData() : void
      {
         this.visible = false;
      }
      
      private function okArr(param1:Array) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_])
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function gotoNum(param1:Number) : void
      {
         if(param1 == 1)
         {
            allMc.gotoAndStop(1);
         }
         else if(param1 == 2)
         {
            allMc.gotoAndStop(2);
         }
         else if(param1 == 3)
         {
            allMc.gotoAndStop(3);
         }
      }
   }
}

