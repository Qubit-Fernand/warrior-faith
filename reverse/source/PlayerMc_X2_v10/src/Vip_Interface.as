package src
{
   import com.*;
   import com.efnx.fps.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class Vip_Interface extends MovieClip
   {
      
      private static var loadData:ClassLoader;
      
      private static var _this:Vip_Interface;
      
      private static var OpenYN:Boolean = false;
      
      private static var loadName:String = "VIP_v2.swf";
      
      public static var vipUserArr:Array = new Array();
      
      private var skin:MovieClip;
      
      private var waBao:MovieClip;
      
      private var vipOK:Boolean = false;
      
      private var selNum:uint = 5;
      
      private var ruCangQuan_Num:uint = 0;
      
      private var chuanSongOk:Boolean = false;
      
      private var selNum1:uint = 1;
      
      private var selNum2:uint = 1;
      
      private var selNum3:uint = 1;
      
      private var guankaArr:Array = [[1,2,3,4,5,6,7,8,9],[10,11,12,13,14,15,16],[51,52,53,54],[101,102,103,104,105]];
      
      public function Vip_Interface()
      {
         super();
         LoadSkin();
         _this = this;
      }
      
      private static function InitOpen() : *
      {
         var _loc1_:Vip_Interface = new Vip_Interface();
         Main._stage.addChild(_loc1_);
         OpenYN = true;
         SetData();
      }
      
      public static function SetData() : *
      {
         if(vipUserArr.length == 0 || vipUserArr[0].getValue() < Main.serverTime.getValue())
         {
            vipUserArr[0] = VT.createVT(Main.serverTime.getValue());
            vipUserArr[1] = VT.createVT(3);
            vipUserArr[2] = VT.createVT(5);
         }
      }
      
      public static function Open() : *
      {
         if(_this)
         {
            _this.visible = true;
            _this.x = _this.y = 0;
            _this.skin.vip_mc.visible = false;
            _this.skin._BLACK_mc.visible = false;
            _this.waBao = _this.skin.waBao_mc;
            _this.WaBao_Close();
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
      
      public static function GetVip() : *
      {
         if(Boolean(_this) && Boolean(_this.vipOK))
         {
            _this.vipOK = false;
            Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63215));
            NewMC.Open("文字提示",_this,400,400,30,0,true,2,"vip称号已放入背包");
            _this.skin._BLACK_mc.visible = false;
            Main.Save();
         }
      }
      
      public static function DianQuanChuanSong() : *
      {
         if(Boolean(_this) && Boolean(_this.chuanSongOk))
         {
            _this.chuanSongOk = false;
            Main.gameNum.setValue(17);
            Main.gameNum2.setValue(_this.selNum * 5);
            GameData.gameLV = 4;
            Main.water = VT.createVT(1);
            Main._this.Loading();
            _this.Close();
            if(_this.ruCangQuan_Num == 1)
            {
               Main.player1.getBag().delOtherById(63155,1);
            }
            else if(_this.ruCangQuan_Num == 2)
            {
               Main.player2.getBag().delOtherById(63155,1);
            }
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
         Play_Interface.interfaceX["load_mc"].visible = false;
         var _loc2_:Class = loadData.getClass("Skin") as Class;
         this.skin = new _loc2_();
         addChild(skin);
         skin.Close_btn.addEventListener(MouseEvent.CLICK,Close);
         skin.chuanSong_btn.addEventListener(MouseEvent.CLICK,ChuanSong);
         skin.chuanSong_btn2.addEventListener(MouseEvent.CLICK,ChuanSong2);
         skin.waBao_btn.addEventListener(MouseEvent.CLICK,WaBao_Open);
         var _loc3_:uint = 1;
         while(_loc3_ < 6)
         {
            skin["btn_" + _loc3_].addEventListener(MouseEvent.CLICK,SelChuanSong);
            _loc3_++;
         }
         skin.buyVip_btn.addEventListener(MouseEvent.CLICK,BuyVip);
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
      
      private function Show() : *
      {
         var _loc1_:uint = 1;
         while(_loc1_ < 6)
         {
            if(selNum == _loc1_)
            {
               skin["sel_" + _loc1_].visible = true;
            }
            else
            {
               skin["sel_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         skin.chuanSong_txt.text = "炼狱传送免费次数:" + vipUserArr[1].getValue();
         skin.waBao_txt.text = "关卡寻宝剩余次数:" + vipUserArr[2].getValue();
         skin["chuanSong_btn2"].visible = false;
         if(vipUserArr[1].getValue() <= 0)
         {
            skin["chuanSong_btn2"].visible = true;
         }
         var _loc2_:Boolean = false;
         if(Main.player1.getBag().getOtherobjNum(63215) > 0 || Boolean(Main.P1P2) && Main.player2.getBag().getOtherobjNum(63215) > 0)
         {
            _loc2_ = true;
         }
         if(Boolean(Main.isVip()) || _loc2_)
         {
            skin.buyVip_btn.visible = false;
         }
      }
      
      private function BuyVip(param1:*) : *
      {
         skin.vip_mc.visible = true;
         skin.vip_mc.close_btn.addEventListener(MouseEvent.CLICK,vipClose);
         skin.vip_mc.buy_btn.addEventListener(MouseEvent.CLICK,vipBuyGo);
      }
      
      private function vipClose(param1:*) : *
      {
         skin.vip_mc.visible = false;
      }
      
      private function vipBuyGo(param1:*) : *
      {
         if(Main.player1.getBag().backOtherBagNum() < 1)
         {
            NewMC.Open("文字提示",this,400,400,30,0,true,2,"其他类背包空间不足!");
            return;
         }
         var _loc2_:uint = uint(InitData.vip2990.getValue());
         if(Shop4399.moneyAll.getValue() >= _loc2_)
         {
            vipOK = true;
            skin._BLACK_mc.visible = true;
            Api_4399_All.BuyObj(InitData.vipID.getValue());
            skin.vip_mc.visible = false;
            return;
         }
         NewMC.Open("文字提示",this,400,400,30,0,true,2,"点券不足");
      }
      
      private function SelChuanSong(param1:MouseEvent) : *
      {
         selNum = (param1.target.name as String).substr(4,1);
         Show();
      }
      
      private function ChuanSong(param1:*) : *
      {
         var _loc2_:uint = 0;
         if(Main.isVip())
         {
            if(Main.player1.getBag().getOtherobjNum(63155) > 0)
            {
               ruCangQuan_Num = 1;
            }
            else
            {
               if(!(Boolean(Main.P1P2) && Main.player2.getBag().getOtherobjNum(63155) > 0))
               {
                  NewMC.Open("文字提示",this,400,350,30,0,true,2,"缺少炼狱入场券");
                  return;
               }
               ruCangQuan_Num = 2;
            }
            if((vipUserArr[1] as VT).getValue() > 0)
            {
               Main.gameNum.setValue(17);
               Main.gameNum2.setValue(selNum * 5);
               GameData.gameLV = 4;
               Main.water = VT.createVT(1);
               Main._this.Loading();
               (vipUserArr[1] as VT).setValue((vipUserArr[1] as VT).getValue() - 1);
               if(ruCangQuan_Num == 1)
               {
                  Main.player1.getBag().delOtherById(63155,1);
               }
               else if(ruCangQuan_Num == 2)
               {
                  Main.player2.getBag().delOtherById(63155,1);
               }
               Close();
               Main.Save();
            }
            _loc2_ = uint((vipUserArr[1] as VT).getValue());
            NewMC.Open("文字提示",this,400,350,30,0,true,2,"今日可使用次数" + _loc2_);
         }
         else
         {
            NewMC.Open("文字提示",this,400,350,30,0,true,2,"vip玩家专用福利,赶快加入吧");
         }
         Show();
      }
      
      private function ChuanSong2(param1:*) : *
      {
         if(Main.isVip())
         {
            if(Main.player1.getBag().getOtherobjNum(63155) > 0)
            {
               ruCangQuan_Num = 1;
            }
            else
            {
               if(!(Boolean(Main.P1P2) && Main.player2.getBag().getOtherobjNum(63155) > 0))
               {
                  NewMC.Open("文字提示",this,400,350,30,0,true,2,"缺少炼狱入场券");
                  return;
               }
               ruCangQuan_Num = 2;
            }
            if(Shop4399.moneyAll.getValue() >= InitData.vip10.getValue())
            {
               skin._BLACK_mc.visible = true;
               Api_4399_All.BuyObj(InitData.vip10.getValue());
               chuanSongOk = true;
            }
            else
            {
               NewMC.Open("文字提示",this,400,400,30,0,true,2,"点券不足");
               skin._BLACK_mc.visible = false;
            }
         }
         else
         {
            NewMC.Open("文字提示",this,400,350,30,0,true,2,"vip玩家专用福利,赶快加入吧");
         }
         Show();
      }
      
      private function WaBao_Open(param1:* = null) : *
      {
         if(Main.isVip())
         {
            WaBao_Close();
            waBao.visible = true;
            waBao.x = waBao.y = 0;
            WaBaoInit();
            WaBaoShow();
         }
         else
         {
            NewMC.Open("文字提示",this,400,350,30,0,true,2,"vip玩家专用福利,赶快加入吧");
         }
      }
      
      private function WaBao_Close(param1:* = null) : *
      {
         waBao.visible = false;
         waBao.x = waBao.y = 5000;
         waBao.getObj_mc.visible = waBao.get_mc.visible = false;
      }
      
      private function WaBaoInit() : *
      {
         var _loc1_:uint = 0;
         selNum1 = selNum2 = selNum3 = 1;
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            waBao["guanKaBtn_" + _loc1_].addEventListener(MouseEvent.CLICK,Sel_Num);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 8)
         {
            waBao["guanka_" + _loc1_].addEventListener(MouseEvent.CLICK,Sel_Num2);
            _loc1_++;
         }
         waBao["close_btn"].addEventListener(MouseEvent.CLICK,WaBao_Close);
      }
      
      private function Sel_Num(param1:MouseEvent) : *
      {
         var _loc2_:uint = uint((param1.target.name as String).substr(10,1));
         selNum1 = _loc2_;
         TiaoShi.txtShow("Sel_Num selNum1 = " + selNum1);
         WaBaoShow();
      }
      
      private function Sel_Num2(param1:MouseEvent) : *
      {
         var _loc2_:uint = uint((param1.target.name as String).substr(7,1));
         selNum2 = _loc2_;
         WaBaoShow();
      }
      
      private function WaBaoShow() : *
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc1_:uint = 1;
         while(_loc1_ <= 4)
         {
            (waBao["guanKaXXX_" + _loc1_] as MovieClip).gotoAndStop(1);
            if(selNum1 == _loc1_)
            {
               (waBao["guanKaXXX_" + _loc1_] as MovieClip).gotoAndStop(2);
            }
            _loc1_++;
         }
         var _loc2_:uint = (guankaArr[selNum1 - 1] as Array).length / 8 + 0.99999;
         waBao.num_txt.text = selNum3 + "/" + _loc2_;
         TiaoShi.txtShow("selNum1 = " + selNum1 + ", gameNum2X = " + (selNum2 + (_loc2_ - 1) * 8));
         _loc1_ = 1;
         while(_loc1_ <= 8)
         {
            _loc3_ = selNum2 + (selNum2 - 1) * 8 - 1;
            _loc4_ = uint(guankaArr[selNum1 - 1][_loc3_]);
            _loc5_ = _loc3_ + _loc1_;
            TiaoShi.txtShow("gameNum = " + _loc4_ + ", nextNum = " + _loc5_);
            waBao["guanka_" + _loc1_].visible = waBao["guanka_mc_" + _loc1_].visible = false;
            if(Main.guanKa[_loc5_] > 1)
            {
               waBao["guanka_" + _loc1_].visible = waBao["guanka_mc_" + _loc1_].visible = true;
               waBao["guanka_mc_" + _loc1_].gotoAndStop("d" + _loc5_);
            }
            _loc1_++;
         }
         TiaoShi.txtShow("-----------------");
      }
   }
}

