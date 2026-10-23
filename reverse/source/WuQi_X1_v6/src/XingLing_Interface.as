package src
{
   import com.*;
   import com.efnx.fps.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src._data.*;
   import src.tool.*;
   
   public class XingLing_Interface extends MovieClip
   {
      
      private static var loadData:ClassLoader;
      
      private static var _this:XingLing_Interface;
      
      private static var OpenYN:Boolean = false;
      
      private static var loadName:String = "XLUP_v3.swf";
      
      public static var UP_Fun_YES_go:Boolean = false;
      
      public static var UP_Fun_YES_go2:Boolean = false;
      
      public static var upOK:Boolean = false;
      
      public static var saveOK:Boolean = false;
      
      private var skin:MovieClip;
      
      private var selNum:VT = VT.createVT(1);
      
      private var selNumMax:uint = 6;
      
      private var sel_LV_Num:VT = VT.createVT(1);
      
      private var sel_LV_NumMax:uint = 4;
      
      private var up_Money_1:Boolean = false;
      
      private var up_Money_2:Boolean = false;
      
      private var xuQiuObjArr:Array = [0,63162,63169,63171,63183,63197,63207];
      
      internal var time:uint = 0;
      
      public function XingLing_Interface()
      {
         super();
         LoadSkin();
         _this = this;
      }
      
      private static function InitOpen() : *
      {
         var _loc1_:XingLing_Interface = new XingLing_Interface();
         Main._stage.addChild(_loc1_);
         OpenYN = true;
      }
      
      public static function Open() : *
      {
         if(_this)
         {
            _this.visible = true;
            _this.x = _this.y = 0;
            _this.Show();
         }
         else
         {
            InitOpen();
         }
      }
      
      public static function CloseX() : *
      {
         if(_this)
         {
            _this.visible = false;
            _this.x = _this.y = 5000;
         }
      }
      
      public static function UP_Fun_YES() : *
      {
         var _loc1_:uint = 0;
         if(UP_Fun_YES_go)
         {
            _loc1_ = uint(XingLingFactory.UP(_this.selNum.getValue(),_this.sel_LV_Num.getValue()));
            _this.skin._BLACK_mc.visible = false;
            UP_Fun_YES_go = false;
            _this.Show();
            _this.ShowSanSuo(_loc1_);
            if(_this.up_Money_1)
            {
               Main.Save();
            }
         }
      }
      
      public static function UP2_Fun_YES() : *
      {
         XingLingFactory.UP2(_this.selNum.getValue(),_this.sel_LV_Num.getValue());
         var _loc1_:Array = XingLingFactory.Get_LV(_this.selNum.getValue(),_this.sel_LV_Num.getValue());
         var _loc2_:uint = uint(_loc1_[0]);
         var _loc3_:uint = uint(_loc1_[1]);
         var _loc4_:uint = _this.sel_LV_Num.getValue() + 1;
         if(_loc3_ == 10 && _loc4_ <= _this.sel_LV_NumMax)
         {
            _this.sel_LV_Num.setValue(_loc4_);
            _this.up_Money_1 = _this.up_Money_2 = false;
         }
         _this.skin._BLACK_mc.visible = false;
         _this.Show();
      }
      
      public static function UpPinZhi_Fun_YES() : *
      {
         if(UP_Fun_YES_go2)
         {
            upOK = XingLingFactory.QiangHua(_this.selNum.getValue(),_this.sel_LV_Num.getValue());
            UP_Fun_YES_go2 = false;
            _this.ShowSanSuo(0);
            Main.Save();
         }
      }
      
      private function LoadSkin() : *
      {
         if(!skin && !loadData)
         {
            loadData = new ClassLoader(loadName);
            loadData.addEventListener(Event.COMPLETE,onLoadingOK);
            Play_Interface.interfaceX["load_mc"].visible = true;
         }
      }
      
      private function onLoadingOK(param1:*) : *
      {
         var _loc2_:Class = loadData.getClass("Skin") as Class;
         this.skin = new _loc2_();
         skin.addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addChild(skin);
         Play_Interface.interfaceX["load_mc"].visible = false;
         if(OpenYN)
         {
            Open();
         }
         else
         {
            Close();
         }
      }
      
      private function Close(param1:* = null) : *
      {
         this.visible = false;
         this.x = this.y = 5000;
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         var _loc2_:uint = 0;
         skin._BLACK_mc.visible = false;
         skin._jinJieXuQiu_mc.visible = false;
         skin._jinJieXuQiu_mc.close_btn.addEventListener(MouseEvent.CLICK,JinJieClose);
         skin._jinJieXuQiu_mc.ok_btn.addEventListener(MouseEvent.CLICK,JinJieOK);
         skin.close_btn.addEventListener(MouseEvent.CLICK,Close);
         _loc2_ = 1;
         while(_loc2_ <= selNumMax)
         {
            skin["sel_btn_" + _loc2_].addEventListener(MouseEvent.CLICK,SEL_XingZuo_FUN);
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= sel_LV_NumMax)
         {
            skin["sel2_" + _loc2_].visible = false;
            skin["sel2_" + _loc2_].mouseChildren = false;
            skin["sel2_" + _loc2_].addEventListener(MouseEvent.CLICK,SEL_LV_FUN);
            _loc2_++;
         }
         skin["up_btn"].addEventListener(MouseEvent.CLICK,UP_Fun);
         skin["up2_btn"].addEventListener(MouseEvent.CLICK,UP_Fun2);
         skin["A_mc"].addEventListener(MouseEvent.CLICK,Sel_Money_A);
         skin["B_mc"].addEventListener(MouseEvent.CLICK,Sel_Money_B);
         skin["C_mc"].addEventListener(MouseEvent.CLICK,Sel_Money_C);
         skin["qiangHua_btn"].addEventListener(MouseEvent.CLICK,QiangHua_Fun);
      }
      
      private function Sel_Money_A(param1:* = null) : *
      {
         up_Money_1 = up_Money_2 = true;
         skin["A_mc"]["yes_mc"].visible = true;
         skin["B_mc"]["yes_mc"].visible = false;
         skin["C_mc"]["yes_mc"].visible = false;
      }
      
      private function Sel_Money_B(param1:* = null) : *
      {
         up_Money_1 = up_Money_2 = false;
         skin["A_mc"]["yes_mc"].visible = false;
         skin["B_mc"]["yes_mc"].visible = true;
         skin["C_mc"]["yes_mc"].visible = true;
      }
      
      private function Sel_Money_C(param1:* = null) : *
      {
         up_Money_1 = up_Money_2 = false;
         skin["A_mc"]["yes_mc"].visible = false;
         skin["B_mc"]["yes_mc"].visible = true;
         skin["C_mc"]["yes_mc"].visible = true;
      }
      
      private function SelObj(param1:uint) : *
      {
         if(param1 == 10)
         {
            skin["B_mc"].visible = false;
            skin["C_mc"].visible = true;
         }
         else
         {
            skin["B_mc"].visible = true;
            skin["C_mc"].visible = false;
         }
         if(Boolean(up_Money_1) || Boolean(up_Money_2))
         {
            Sel_Money_A();
         }
         else
         {
            Sel_Money_B();
            Sel_Money_C();
         }
      }
      
      private function Show() : *
      {
         var _loc1_:uint = 0;
         var _loc8_:uint = 0;
         if(Main.guanKa[selNum.getValue() + 17] > 0)
         {
            skin["back_mc"].visible = false;
         }
         else
         {
            skin["back_mc"].visible = true;
         }
         _loc1_ = 1;
         while(_loc1_ <= selNumMax)
         {
            skin["sel_" + _loc1_].visible = false;
            if(_loc1_ == selNum.getValue())
            {
               skin["sel_" + _loc1_].visible = true;
            }
            if(Main.guanKa[_loc1_ + 17] > 0)
            {
               skin["no_Sel_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         var _loc2_:Array = XingLingFactory.Get_LV_Data_Str(selNum.getValue(),sel_LV_Num.getValue());
         var _loc3_:Array = XingLingFactory.Get_LV(selNum.getValue(),sel_LV_Num.getValue());
         var _loc4_:uint = _loc3_[0] + 1;
         var _loc5_:uint = uint(_loc3_[1]);
         skin["qiangHua_btn"].visible = false;
         if(_loc5_ == 10)
         {
            skin["up_btn"].visible = false;
            _loc8_ = uint(XingLingFactory.Get_one_color(selNum.getValue(),sel_LV_Num.getValue()));
            if(_loc8_ < 5 || Boolean(Main.isVip()) && _loc8_ < 6)
            {
               skin["qiangHua_btn"].visible = true;
            }
         }
         else
         {
            skin["up_btn"].visible = true;
         }
         _loc1_ = 1;
         while(_loc1_ <= 10)
         {
            skin["shuXing_" + _loc1_].text = _loc2_[_loc1_];
            TextColor(skin["shuXing_" + _loc1_],_loc4_);
            if(_loc5_ >= _loc1_)
            {
               skin["shuXing_mc_" + _loc1_].gotoAndStop(_loc4_);
            }
            else
            {
               skin["shuXing_mc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
         var _loc6_:uint = uint(XingLingFactory.Get_LV2(selNum.getValue()));
         var _loc7_:Array = XingLingFactory.Get_LV_color(selNum.getValue());
         _loc1_ = 1;
         while(_loc1_ <= sel_LV_NumMax)
         {
            skin["sel2_" + _loc1_]["sel_this"].visible = false;
            if(_loc1_ <= _loc6_)
            {
               skin["sel2_" + _loc1_].visible = true;
            }
            else
            {
               skin["sel2_" + _loc1_].visible = false;
            }
            skin["sel2_" + _loc1_].gotoAndStop(_loc7_[_loc1_] - 1);
            _loc1_++;
         }
         skin["sel2_" + sel_LV_Num.getValue()]["sel_this"].visible = true;
         skin["up2_btn"].visible = false;
         if(sel_LV_Num.getValue() + 1 <= sel_LV_NumMax && _loc7_[sel_LV_Num.getValue() + 1] <= 1)
         {
            skin["up2_btn"].visible = true;
         }
         XuQiuShow(_loc5_);
         SelObj(_loc5_);
         ShowTolal_Data();
      }
      
      private function XuQiuShow(param1:uint) : *
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:* = undefined;
         var _loc6_:uint = 0;
         if(selNum.getValue() == 1)
         {
            _loc2_ = "巨蟹座能源:";
         }
         else if(selNum.getValue() == 2)
         {
            _loc2_ = "双鱼座能源:";
         }
         else if(selNum.getValue() == 3)
         {
            _loc2_ = "水瓶座能源:";
         }
         else if(selNum.getValue() == 4)
         {
            _loc2_ = "射手座能源:";
         }
         else if(selNum.getValue() == 5)
         {
            _loc2_ = "白羊座能源:";
         }
         else if(selNum.getValue() == 6)
         {
            _loc2_ = "金牛座能源:";
         }
         if(param1 == 10)
         {
            _loc3_ = XingLingFactory.Sel_XuQiu_up2(selNum.getValue());
            skin["C_mc"]._txt.text = "星源方块:1" + "/" + getXuQiuNum_Other(63235);
            skin["A_mc"]._txt.text = "点券:9/" + Shop4399.moneyAll.getValue();
         }
         else
         {
            _loc4_ = XingLingFactory.Sel_XuQiu_up1(selNum.getValue());
            _loc5_ = xuQiuObjArr[selNum.getValue()];
            _loc6_ = uint(_loc4_[1]);
            if(Main.isVip())
            {
               _loc6_ /= 2;
            }
            skin["B_mc"]._txt.text = _loc2_ + _loc4_[0] + "/" + getXuQiuNum_Other(_loc5_) + "  击杀点:" + _loc6_ + "/" + getXuQiuNumKill_min();
            skin["A_mc"]._txt.text = "点券:" + _loc4_[2] + "/" + Shop4399.moneyAll.getValue();
         }
      }
      
      private function TextColor(param1:*, param2:uint) : *
      {
         if(param2 == 3)
         {
            TextTool.ColorX(param1,"0x66FF00");
         }
         else if(param2 == 4)
         {
            TextTool.ColorX(param1,"0x3399FF");
         }
         else if(param2 == 5)
         {
            TextTool.ColorX(param1,"0xFF3399");
         }
         else if(param2 == 6)
         {
            TextTool.ColorX(param1,"0xFFCC00");
         }
         else if(param2 == 7)
         {
            TextTool.ColorX(param1,"0xFF0000");
         }
      }
      
      private function ShowTolal_Data() : *
      {
         var _loc1_:Array = XingLingFactory.GetTolal_DataStr();
         var _loc2_:uint = 1;
         while(_loc2_ <= 8)
         {
            skin["shuXingNum_" + _loc2_].text = _loc1_[_loc2_];
            skin["shuXingNum_2" + _loc2_].text = _loc1_[_loc2_ + 8];
            skin["jinSe_txt"].text = "已点亮" + XingLingFactory.dianLiangNum * 10 + "颗";
            skin["jindu"]["_mc"].scaleX = XingLingFactory.dianLiangNumX;
            _loc2_++;
         }
      }
      
      private function ShowSanSuo(param1:uint = 1) : *
      {
         var _loc2_:uint = 0;
         if(param1 == -1)
         {
            _loc2_ = 1;
            while(_loc2_ <= 10)
            {
               skin["shuXing_mc_" + _loc2_]["show_mc"].gotoAndStop(1);
               _loc2_++;
            }
         }
         else if(param1 == 0)
         {
            _loc2_ = 1;
            while(_loc2_ <= 10)
            {
               skin["shuXing_mc_" + _loc2_]["show_mc"].gotoAndPlay(2);
               _loc2_++;
            }
         }
         else
         {
            skin["shuXing_mc_" + param1]["show_mc"].gotoAndPlay(2);
         }
      }
      
      private function SEL_XingZuo_FUN(param1:MouseEvent) : *
      {
         var _loc2_:uint = uint((param1.target.name as String).substr(8,2));
         selNum.setValue(_loc2_);
         sel_LV_Num.setValue(1);
         _this.up_Money_1 = _this.up_Money_2 = false;
         Show();
      }
      
      private function SEL_LV_FUN(param1:MouseEvent) : *
      {
         var _loc2_:uint = 1;
         while(_loc2_ <= sel_LV_NumMax)
         {
            skin["sel2_" + _loc2_]["sel_this"].visible = false;
            _loc2_++;
         }
         var _loc3_:uint = uint((param1.target.name as String).substr(5,2));
         sel_LV_Num.setValue(_loc3_);
         skin["sel2_" + _loc3_]["sel_this"].visible = true;
         Show();
      }
      
      private function UP_Fun(param1:MouseEvent) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc2_:Array = XingLingFactory.Sel_XuQiu_up1(selNum.getValue());
         if(up_Money_1)
         {
            if(Shop4399.moneyAll.getValue() >= _loc2_[2])
            {
               skin._BLACK_mc.visible = true;
               Api_4399_All.Money_down(_loc2_[2]);
               UP_Fun_YES_go = true;
            }
            else
            {
               NewMC.Open("文字提示",this,400,400,30,0,true,2,"点券不足");
            }
         }
         else
         {
            _loc3_ = xuQiuObjArr[selNum.getValue()];
            _loc4_ = XuQiuNum_Other(_loc3_,_loc2_[0]);
            _loc5_ = uint(_loc2_[1]);
            if(Main.isVip())
            {
               _loc5_ /= 2;
            }
            if(_loc4_[0] != 0 && Boolean(XuQiuNum_kill(_loc5_)))
            {
               KouChuObj(_loc4_);
               KouChukill(_loc5_);
               UP_Fun_YES_go = true;
               UP_Fun_YES();
            }
            else
            {
               NewMC.Open("文字提示",this,400,400,30,0,true,2,"材料不足,可选择点券升级");
            }
         }
      }
      
      private function UP_Fun2(param1:MouseEvent) : *
      {
         var _loc3_:String = null;
         skin._jinJieXuQiu_mc.visible = true;
         var _loc2_:Array = XingLingFactory.Sel_XuQiu_up2(selNum.getValue());
         if(selNum.getValue() == 1)
         {
            _loc3_ = "巨蟹座能源: ";
         }
         else if(selNum.getValue() == 2)
         {
            _loc3_ = "双鱼座能源: ";
         }
         else if(selNum.getValue() == 3)
         {
            _loc3_ = "水瓶座能源: ";
         }
         else if(selNum.getValue() == 4)
         {
            _loc3_ = "射手座能源: ";
         }
         else if(selNum.getValue() == 5)
         {
            _loc3_ = "白羊座能源: ";
         }
         else if(selNum.getValue() == 6)
         {
            _loc3_ = "金牛座能源: ";
         }
         var _loc4_:* = xuQiuObjArr[selNum.getValue()];
         skin._jinJieXuQiu_mc.xuQiu_num1.text = _loc3_ + _loc2_[0] + "/" + getXuQiuNum_Other(_loc4_);
         skin._jinJieXuQiu_mc.xuQiu_num2.text = "圣光水晶: " + _loc2_[1] + "/" + getXuQiuNum_Other(63138);
      }
      
      private function JinJieClose(param1:MouseEvent) : *
      {
         skin._jinJieXuQiu_mc.visible = false;
      }
      
      private function JinJieOK(param1:MouseEvent) : *
      {
         skin._jinJieXuQiu_mc.visible = false;
         var _loc2_:* = xuQiuObjArr[selNum.getValue()];
         var _loc3_:Array = XingLingFactory.Sel_XuQiu_up2(selNum.getValue());
         var _loc4_:Array = XuQiuNum_Other(_loc2_,_loc3_[0]);
         var _loc5_:Array = XuQiuNum_Other(63138,_loc3_[1]);
         if(_loc4_[0] != 0 && _loc5_[0] != 0)
         {
            KouChuObj(_loc4_);
            KouChuObj(_loc5_);
            UP2_Fun_YES();
         }
         else
         {
            NewMC.Open("文字提示",this,400,400,30,0,true,2,"材料不足");
         }
      }
      
      private function QiangHua_Fun(param1:MouseEvent) : *
      {
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         skin["qiangHua_btn"].visible = false;
         skin["_BLACK_mc"].visible = true;
         if(up_Money_1)
         {
            _loc2_ = uint(InitData.xingLing_num9.getValue());
            if(Shop4399.moneyAll.getValue() >= _loc2_)
            {
               skin._BLACK_mc.visible = true;
               Api_4399_All.Money_down(_loc2_);
               UP_Fun_YES_go2 = true;
            }
            else
            {
               NewMC.Open("文字提示",this,400,400,30,0,true,2,"点券不足");
               skin["qiangHua_btn"].visible = true;
               skin._BLACK_mc.visible = false;
            }
         }
         else
         {
            _loc3_ = XuQiuNum_Other(63235,InitData.BuyNum_1.getValue());
            if(_loc3_[0] != 0)
            {
               KouChuObj(_loc3_);
               UP_Fun_YES_go2 = true;
               UpPinZhi_Fun_YES();
            }
            else
            {
               NewMC.Open("文字提示",this,400,400,30,0,true,2,"材料不足,可选择点券升级");
               skin["qiangHua_btn"].visible = true;
               skin._BLACK_mc.visible = false;
            }
         }
         addEventListener(Event.ENTER_FRAME,onTime);
      }
      
      private function getXuQiuNumKill_min() : uint
      {
         var _loc1_:uint = 0;
         _loc1_ = uint(Main.player1.killPoint.getValue());
         if(Boolean(Main.P1P2) && _loc1_ > Main.player2.killPoint.getValue())
         {
            _loc1_ = uint(Main.player2.killPoint.getValue());
         }
         return _loc1_;
      }
      
      private function getXuQiuNum_Other(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         _loc2_ += Main.player1.getBag().getOtherobjNum(param1);
         if(Main.P1P2)
         {
            _loc2_ += Main.player2.getBag().getOtherobjNum(param1);
         }
         return _loc2_;
      }
      
      private function XuQiuNum_Other(param1:uint, param2:uint) : Array
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         if(Main.player1.getBag().getOtherobjNum(param1) >= param2)
         {
            return [param1,param2,0];
         }
         if(Main.P1P2)
         {
            _loc4_ = uint(Main.player1.getBag().getOtherobjNum(param1));
            _loc5_ = param2 - Main.player1.getBag().getOtherobjNum(param1);
            if(Main.player2.getBag().getOtherobjNum(param1) >= _loc5_)
            {
               return [param1,_loc4_,_loc5_];
            }
            return [0];
         }
         return [0];
      }
      
      private function KouChuObj(param1:Array) : *
      {
         if(param1[1] > 0)
         {
            Main.player1.getBag().delOtherById(param1[0],param1[1]);
         }
         if(param1[2] > 0)
         {
            Main.player2.getBag().delOtherById(param1[0],param1[2]);
         }
      }
      
      private function XuQiuNum_kill(param1:uint) : Boolean
      {
         if(!Main.P1P2 && Main.player1.killPoint.getValue() >= param1)
         {
            return true;
         }
         if(Boolean(Main.P1P2) && Main.player1.killPoint.getValue() >= param1 && Main.player2.killPoint.getValue() >= param1)
         {
            return true;
         }
         return false;
      }
      
      private function KouChukill(param1:uint) : *
      {
         Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() - param1);
         if(Main.P1P2)
         {
            Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() - param1);
         }
      }
      
      private function onTime(param1:*) : *
      {
         var _loc2_:uint = 0;
         ++time;
         if(time > 50 && saveOK)
         {
            skin._BLACK_mc.visible = false;
            saveOK = false;
            time = 0;
            removeEventListener(Event.ENTER_FRAME,onTime);
            _loc2_ = uint(XingLingFactory.Get_one_color(selNum.getValue(),sel_LV_Num.getValue()));
            if(upOK)
            {
               NewMC.Open("文字提示",_this,400,400,30,0,true,2,"强化成功!");
            }
            else
            {
               NewMC.Open("文字提示",_this,400,400,30,0,true,2,"强化失败!");
            }
            Show();
         }
      }
   }
}

