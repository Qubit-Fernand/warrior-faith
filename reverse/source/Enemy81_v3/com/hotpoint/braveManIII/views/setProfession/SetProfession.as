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
         trace("选职业");
         playerNum = num;
         typeStata = 0;
         initFrame(num);
         initEvent();
         if(num == 1)
         {
            allMc.xxBtn.visible = false;
            BisClick("p1_",clickArr1);
            allMc.t1_0.gotoAndStop(1);
            allMc.t1_1.gotoAndStop(2);
            allMc.t1_2.visible = false;
         }
         else if(num == 3)
         {
            addEventListener(Event.ENTER_FRAME,onEntHandle);
         }
      }
      
      private function onEntHandle(e:Event) : void
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
      
      public function initData2(num:uint = 1) : void
      {
         trace("洗职业");
         typeStata = 1;
         playerXX = num;
         initFrame(num);
         initEvent();
      }
      
      public function initFrame(num:uint = 1) : void
      {
         gotoNum(num);
      }
      
      public function initEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CLICK,clickHandle);
         this.addEventListener(BtnEvent.DO_CHANGE,changeHandle);
      }
      
      private function changeHandle(e:BtnEvent) : void
      {
         var mc:MovieClip = e.target as MovieClip;
         var nameId:String = mc.name.substr(1,1);
         var id:String = mc.name.substr(3,1);
         clickArr(nameId,id);
      }
      
      private function clickArr(nameId:String, id:String) : void
      {
         if(nameId == "1")
         {
            clickArr1 = changeClick(clickArr1,Number(id));
            if(towTrue(clickArr1))
            {
               clickArr1 = clickGoto(clickArr1,Number(id));
               t1ViFalse(Number(id));
            }
            BisClick("p1_",clickArr1);
            t1Goto("t1_",id);
         }
         else if(nameId == "2")
         {
            clickArr2 = changeClick(clickArr2,Number(id));
            if(towTrue(clickArr2))
            {
               clickArr2 = clickGoto(clickArr2,Number(id));
               t2ViFalse(Number(id));
            }
            BisClick("p2_",clickArr2);
            t1Goto("t2_",id);
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
         if(typeStata == 0)
         {
            num = Number(p1ok());
            if(playerNum == 1)
            {
               if(num == 2)
               {
                  skinArr1 = zyArr(clickArr1);
                  closeData();
                  Strat.startGame();
               }
            }
            else if(playerNum == 3)
            {
               num2 = Number(p2ok());
               if(num == 2 && num2 == 2)
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
               num = Number(p1ok());
               if(num == 2)
               {
                  skinArr1 = zyArr(clickArr1);
                  closeData();
               }
            }
            else if(playerXX == 2)
            {
               num2 = Number(p2ok());
               if(num == 2)
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
         var num:Number = Number(okArr(clickArr1));
         if(num < 2)
         {
            trace("角色1至少选择2个角色");
         }
         else if(num > 2)
         {
            trace("角色1不能选3个职业");
         }
         else if(num == 2)
         {
            trace("p1+OK");
         }
         return num;
      }
      
      private function p2ok() : Number
      {
         var num2:Number = Number(okArr(clickArr2));
         if(num2 < 2)
         {
            trace("角色2至少选择2个角色");
         }
         else if(num2 > 2)
         {
            trace("角色2不能选3个职业");
         }
         else if(num2 == 2)
         {
            trace("p2+OK");
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

