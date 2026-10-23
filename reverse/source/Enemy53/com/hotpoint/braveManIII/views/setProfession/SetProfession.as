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
      
      public static function open1(num:uint = 1) : void
      {
         if(SetProfession._instance == null)
         {
            SetProfession._instance = new SetProfession();
         }
         SetProfession._instance.initData(num);
         SetProfession._instance.visible = true;
         Main._stage.addChild(SetProfession._instance);
      }
      
      public static function open2(typeNum:uint = 1) : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(SetProfession._instance == null)
         {
            SetProfession._instance = new SetProfession();
         }
         SetProfession._instance.initData2(typeNum);
         SetProfession._instance.visible = true;
         Main._stage.addChild(SetProfession._instance);
      }
      
      public static function close() : void
      {
         SetProfession._instance.visible = false;
      }
      
      public function initData(num:uint = 1) : void
      {
         this.playerNum = num;
         this.typeStata = 0;
         this.initFrame(num);
         this.initEvent();
         if(num == 1)
         {
            allMc.xxBtn.visible = false;
            this.BisClick("p1_",clickArr1);
            allMc.t1_0.gotoAndStop(1);
            allMc.t1_1.gotoAndStop(2);
            allMc.t1_2.visible = false;
         }
         else if(num == 3)
         {
            addEventListener(Event.ENTER_FRAME,this.onEntHandle);
         }
      }
      
      private function onEntHandle(e:Event) : void
      {
         if(Boolean(allMc.p1_0) && Boolean(allMc.p1_1) && Boolean(allMc.p1_2) && (Boolean(allMc.p2_0) && Boolean(allMc.p2_1) && Boolean(allMc.p2_2)))
         {
            if(!this.bo)
            {
               this.bo = true;
               this.BisClick("p1_",clickArr1);
               this.BisClick("p2_",clickArr2);
               allMc.t1_0.gotoAndStop(1);
               allMc.t1_1.gotoAndStop(2);
               allMc.t1_2.visible = false;
               allMc.t2_0.gotoAndStop(1);
               allMc.t2_1.gotoAndStop(2);
               allMc.t2_2.visible = false;
            }
         }
      }
      
      public function initData2(num:uint = 1) : void
      {
         this.typeStata = 1;
         this.playerXX = num;
         this.initFrame(num);
         this.initEvent();
      }
      
      public function initFrame(num:uint = 1) : void
      {
         this.gotoNum(num);
      }
      
      public function initEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CLICK,this.clickHandle);
         this.addEventListener(BtnEvent.DO_CHANGE,this.changeHandle);
      }
      
      private function changeHandle(e:BtnEvent) : void
      {
         var mc:MovieClip = e.target as MovieClip;
         var nameId:String = mc.name.substr(1,1);
         var id:String = mc.name.substr(3,1);
         this.clickArr(nameId,id);
      }
      
      private function clickArr(nameId:String, id:String) : void
      {
         if(nameId == "1")
         {
            clickArr1 = this.changeClick(clickArr1,Number(id));
            if(this.towTrue(clickArr1))
            {
               clickArr1 = this.clickGoto(clickArr1,Number(id));
               this.t1ViFalse(Number(id));
            }
            this.BisClick("p1_",clickArr1);
            this.t1Goto("t1_",id);
         }
         else if(nameId == "2")
         {
            clickArr2 = this.changeClick(clickArr2,Number(id));
            if(this.towTrue(clickArr2))
            {
               clickArr2 = this.clickGoto(clickArr2,Number(id));
               this.t2ViFalse(Number(id));
            }
            this.BisClick("p2_",clickArr2);
            this.t1Goto("t2_",id);
         }
      }
      
      private function t1Goto(str:String, id:Number) : void
      {
         if(!allMc[str + id].visible)
         {
            allMc[str + id].visible = true;
            allMc[str + id].gotoAndStop(2);
         }
      }
      
      private function t1ViFalse(id:Number) : void
      {
         switch(id)
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
      
      private function t2ViFalse(id:Number) : void
      {
         switch(id)
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
      
      private function clickGoto(arr:Array, id:Number) : Array
      {
         switch(id)
         {
            case 0:
               arr[1] = false;
               break;
            case 1:
               arr[2] = false;
               break;
            case 2:
               arr[0] = false;
         }
         return arr;
      }
      
      private function towTrue(arr:Array) : Boolean
      {
         var num:uint = 0;
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(arr[i])
            {
               num++;
            }
         }
         if(num == 3)
         {
            return true;
         }
         return false;
      }
      
      public function zyArr(arr:Array) : Array
      {
         var zyArr:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(arr[i])
            {
               zyArr.push(i);
            }
         }
         return zyArr;
      }
      
      private function changeClick(arr:Array, id:Number) : Array
      {
         if(!arr[id])
         {
            arr[id] = true;
         }
         return arr;
      }
      
      private function BisClick(str:String, arr:Array) : void
      {
         for(var i:uint = 0; i < 3; i++)
         {
            allMc[str + i].isClick = arr[i];
         }
      }
      
      private function clickHandle(e:BtnEvent) : void
      {
         var num:Number = NaN;
         var num2:Number = NaN;
         if(this.typeStata == 0)
         {
            num = Number(this.p1ok());
            if(this.playerNum == 1)
            {
               if(num == 2)
               {
                  skinArr1 = this.zyArr(clickArr1);
                  this.closeData();
                  Strat.startGame();
               }
            }
            if(this.playerNum == 3)
            {
               num2 = Number(this.p2ok());
               if(num == 2 && num2 == 2)
               {
                  skinArr1 = this.zyArr(clickArr1);
                  skinArr2 = this.zyArr(clickArr2);
                  this.closeData();
                  Strat.startGame();
               }
            }
         }
         else if(this.typeStata == 1)
         {
            if(this.playerXX == 1)
            {
               num = Number(this.p1ok());
               if(num == 2)
               {
                  skinArr1 = this.zyArr(clickArr1);
                  this.closeData();
               }
            }
            if(this.playerXX == 2)
            {
               num2 = Number(this.p2ok());
               if(num == 2)
               {
                  skinArr2 = this.zyArr(clickArr1);
                  this.closeData();
               }
            }
         }
         removeEventListener(Event.ENTER_FRAME,this.onEntHandle);
      }
      
      private function p1ok() : Number
      {
         var num:Number = Number(this.okArr(clickArr1));
         if(num >= 2)
         {
            if(num <= 2)
            {
               if(num == 2)
               {
               }
            }
         }
         return num;
      }
      
      private function p2ok() : Number
      {
         var num2:Number = Number(this.okArr(clickArr2));
         if(num2 >= 2)
         {
            if(num2 <= 2)
            {
               if(num2 == 2)
               {
               }
            }
         }
         return num2;
      }
      
      private function closeData() : void
      {
         this.visible = false;
      }
      
      private function okArr(arr:Array) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(arr[i])
            {
               num++;
            }
         }
         return num;
      }
      
      public function gotoNum(num:Number) : void
      {
         if(num == 1)
         {
            allMc.gotoAndStop(1);
         }
         else if(num == 2)
         {
            allMc.gotoAndStop(2);
         }
         else if(num == 3)
         {
            allMc.gotoAndStop(3);
         }
      }
   }
}

