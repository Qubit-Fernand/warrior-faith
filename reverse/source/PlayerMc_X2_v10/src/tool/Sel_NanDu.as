package src.tool
{
   import com.greensock.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   import src._data.*;
   
   public class Sel_NanDu extends MovieClip
   {
      
      public var type:uint = 1;
      
      private var selLV:uint = 1;
      
      public function Sel_NanDu()
      {
         super();
         NanDu1_btn.addEventListener(MouseEvent.CLICK,NanDu1);
         NanDu2_btn.addEventListener(MouseEvent.CLICK,NanDu2);
         NanDu3_btn.addEventListener(MouseEvent.CLICK,NanDu3);
         NanDu1_btn.addEventListener(MouseEvent.ROLL_OVER,NanDu1_ROLL_OVER);
         NanDu2_btn.addEventListener(MouseEvent.ROLL_OVER,NanDu2_ROLL_OVER);
         NanDu3_btn.addEventListener(MouseEvent.ROLL_OVER,NanDu3_ROLL_OVER);
         var _loc1_:uint = 1;
         while(_loc1_ <= 12)
         {
            this["obj_" + _loc1_].addEventListener(MouseEvent.ROLL_OVER,SelObj);
            this["obj_" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,SelObj_out);
            _loc1_++;
         }
         Close_btn.addEventListener(MouseEvent.CLICK,Close);
         info_mc.x = info_mc.y = -2000;
      }
      
      public function Open(param1:uint = 0, param2:uint = 0, param3:uint = 1) : *
      {
         info_mc.x = info_mc.y = -2000;
         type = param3;
         NanDu1_mc.gotoAndStop("d" + Main.gameNum.getValue());
         NanDu2_mc.gotoAndStop("d" + Main.gameNum.getValue());
         NanDu3_mc.gotoAndStop("d" + Main.gameNum.getValue());
         this.x = param1;
         this.y = param2;
         this.visible = true;
         NanDu2_btn.visible = NanDu3_btn.visible = false;
         TweenMax.to(NanDu2_mc,0,{"colorMatrixFilter":{"saturation":0}});
         TweenMax.to(NanDu3_mc,0,{"colorMatrixFilter":{"saturation":0}});
         TweenMax.to(Star2,0,{"colorMatrixFilter":{"saturation":0}});
         TweenMax.to(Star3,0,{"colorMatrixFilter":{"saturation":0}});
         if(Main.guanKa[Main.gameNum.getValue()] > 1)
         {
            NanDu2_btn.visible = true;
            TweenMax.to(NanDu2_mc,0,{"colorMatrixFilter":{"saturation":1}});
            TweenMax.to(Star2,0,{"colorMatrixFilter":{"saturation":1}});
         }
         if(Main.guanKa[Main.gameNum.getValue()] > 2)
         {
            NanDu3_btn.visible = true;
            TweenMax.to(NanDu3_mc,0,{"colorMatrixFilter":{"saturation":1}});
            TweenMax.to(Star3,0,{"colorMatrixFilter":{"saturation":1}});
         }
         NanDu1_ROLL_OVER();
         CengJiuShow();
      }
      
      public function Close(param1:* = null) : *
      {
         this.x = this.y = 5000;
         this.visible = false;
      }
      
      private function NanDu1(param1:*) : *
      {
         GameData.gameLV = 1;
         GameGo();
      }
      
      private function NanDu2(param1:*) : *
      {
         GameData.gameLV = 2;
         GameGo();
      }
      
      private function NanDu3(param1:*) : *
      {
         GameData.gameLV = 3;
         GameGo();
      }
      
      private function NanDu1_ROLL_OVER(param1:* = null) : *
      {
         selLV = 1;
         var _loc2_:Array = GaneObjFactory.GetNumArr(Main.gameNum.getValue(),1);
         var _loc3_:uint = 1;
         while(_loc3_ <= 12)
         {
            this["obj_" + _loc3_].gotoAndStop(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      private function NanDu2_ROLL_OVER(param1:*) : *
      {
         selLV = 2;
         var _loc2_:Array = GaneObjFactory.GetNumArr(Main.gameNum.getValue(),2);
         var _loc3_:uint = 1;
         while(_loc3_ <= 12)
         {
            this["obj_" + _loc3_].gotoAndStop(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      private function NanDu3_ROLL_OVER(param1:*) : *
      {
         selLV = 3;
         var _loc2_:Array = GaneObjFactory.GetNumArr(Main.gameNum.getValue(),3);
         var _loc3_:uint = 1;
         while(_loc3_ <= 12)
         {
            this["obj_" + _loc3_].gotoAndStop(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      private function SelObj(param1:MouseEvent) : *
      {
         var _loc2_:uint = uint((param1.target.name as String).substr(4,2));
         var _loc3_:Array = GaneObjFactory.GetInfo(Main.gameNum.getValue(),selLV,_loc2_);
         if(_loc3_[0] != 0)
         {
            info_mc.x = param1.target.x + 50;
            info_mc.y = param1.target.y - 5;
            info_mc.name_txt.text = _loc3_[0];
            info_mc.info_txt.text = _loc3_[1];
            if(_loc3_[2] == 2)
            {
               ColorX(info_mc.name_txt,"0x0066ff");
            }
            else if(_loc3_[2] == 3)
            {
               ColorX(info_mc.name_txt,"0xFF3399");
            }
            else if(_loc3_[2] == 4)
            {
               ColorX(info_mc.name_txt,"0xFF9933");
            }
         }
         else
         {
            info_mc.x = info_mc.y = -2000;
         }
      }
      
      private function SelObj_out(param1:MouseEvent) : *
      {
         info_mc.x = info_mc.y = -2000;
      }
      
      private function GameGo() : *
      {
         Close();
         SelMap.Close();
         Main.gameNum2.setValue(1);
         Main._this.Loading();
      }
      
      private function CengJiuShow() : *
      {
         var _loc2_:uint = 0;
         var _loc1_:Array = AchPanel.getStateByGkId(Main.gameNum.getValue());
         TiaoShi.txtShow(">>>>>>>>>>>>>>>>>>成就完成:" + _loc1_);
         for(_loc2_ in _loc1_)
         {
            if(_loc1_[_loc2_] == 3)
            {
               ColorX(this["cj_" + _loc2_],"0x66FF00");
            }
            else
            {
               ColorX(this["cj_" + _loc2_],"0xFFFFFF");
            }
         }
      }
      
      private function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
   }
}

