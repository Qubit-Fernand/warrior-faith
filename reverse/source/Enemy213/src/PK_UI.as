package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class PK_UI extends MovieClip
   {
      
      public static var _this:PK_UI;
      
      public static var whoNumX:VT = VT.createVT(5000);
      
      public static var whoNum:int = 0;
      
      public static var PK_ing:Boolean = false;
      
      public static var loadPlayerNum:int = 0;
      
      public static var PlayerNumMax_XX:int = 1;
      
      public static var PlayerNum_XX:int = 0;
      
      public static var DataArr:Array = new Array();
      
      public static var DataArr2:Array = new Array();
      
      public static var playerDataArr:Array = new Array();
      
      public static var playerDataArr_id:Array = new Array();
      
      public static var loadPaiHangGoGame:Boolean = false;
      
      public static var Pk_timeNum:int = 0;
      
      public static var killNum:VT = VT.createVT();
      
      public var 初始化mc:MovieClip = new 游戏初始化();
      
      public var pageNum:int = 1;
      
      public var pageX:int = 10;
      
      public var selPageX:int = 50;
      
      public var timeNum:uint = 0;
      
      public var userPage:VT = VT.createVT(-99);
      
      public var paiHang_MAX:uint = 5000;
      
      public function PK_UI()
      {
         super();
         go_btn.addEventListener(MouseEvent.CLICK,this.GameStart);
         close_btn.addEventListener(MouseEvent.CLICK,Close);
         pageDOWN_btn.addEventListener(MouseEvent.CLICK,this.PageDOWN);
         pageUP_btn.addEventListener(MouseEvent.CLICK,this.PageUP);
      }
      
      public static function Open() : *
      {
         Main.allClosePanel();
         if(!_this)
         {
            _this = new PK_UI();
         }
         _this.visible = true;
         _this.x = _this.y = 0;
         _this.Show();
         Main._this.addChild(_this);
         loadPlayerData = false;
         loadPaiHangGoGame = false;
      }
      
      public static function Close(param1:* = null) : *
      {
         if(!_this)
         {
            _this = new PK_UI();
            Main._stage.addChild(_this);
         }
         _this.visible = false;
         _this.x = _this.y = 5000;
         loadPlayerData = false;
      }
      
      public static function go_goGame(param1:int = 0) : *
      {
      }
      
      public static function AddOtherPlayer() : *
      {
         if(PK_ing && PlayerNum_XX < PlayerNumMax_XX)
         {
            Load_OtherPlayer();
            ++PlayerNum_XX;
            TiaoShi.txtShow("go^^^^^PlayerNum_XX < PlayerNumMax_XX^^^");
         }
         TimeNumFun();
      }
      
      private static function Load_OtherPlayer() : *
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = whoNum + 10;
         var _loc3_:int = whoNum;
         while(_loc3_ < _loc2_)
         {
            if(!DataArr[_loc3_])
            {
               break;
            }
            _loc1_[_loc3_] = DataArr[_loc3_];
            _loc3_++;
         }
         var _loc4_:int = Math.random() * _loc1_.length + whoNum;
         loadPlayerNum = _loc4_;
         Load_OtherPlayerData(_loc4_);
      }
      
      public static function Load_OtherPlayerData(param1:int) : *
      {
         var _loc3_:Player2 = null;
         var _loc4_:Object = null;
         var _loc2_:uint = param1 % 5;
         if(Boolean(playerDataArr[_loc2_]) && playerDataArr[_loc2_] != null)
         {
            _loc3_ = new Player2();
            _loc3_.data = DeepCopyUtil.clone(playerDataArr[_loc2_]);
            _loc3_.Load_All_Player_Data();
            Main.world.moveChild_Player.addChild(_loc3_);
            _loc3_.x = Math.random() * 1000 + 100;
            _loc3_.y = 400;
            _loc3_.newSkin();
            _loc3_.pkmc._txt.text = playerDataArr_id[_loc2_];
            TiaoShi.txtShow("缓存读取玩家数据!添加 " + _loc2_ + ",id" + playerDataArr_id[_loc2_] + ",NP.hp_Max" + _loc3_.hp_Max.getValue());
         }
         else
         {
            _loc4_ = DataArr[param1];
            Api_4399_All.GetUserData(_loc4_.uId,_loc4_.index);
            TiaoShi.txtShow("无缓存读取玩家数据 读取中..." + param1);
         }
      }
      
      public static function TimeNumFun() : *
      {
         ++Pk_timeNum;
         if(Pk_timeNum > 27 * 3600 && PK_ing)
         {
            GameData.PkJiFun(true);
         }
      }
      
      public function Show() : *
      {
         P1_money_txt.text = Main.player1.getGold();
         P1_killPoint_txt.text = Main.player1.killPoint.getValue();
         if(Main.P1P2)
         {
            P2_money_txt.text = Main.player2.getGold();
            P2_killPoint_txt.text = Main.player2.killPoint.getValue();
         }
         var _loc1_:int = 0;
         while(_loc1_ < 11)
         {
            this["num_" + _loc1_].x_txt.text = "";
            this["num_" + _loc1_].id_txt.text = "";
            this["num_" + _loc1_].save_txt.text = "";
            this["num_" + _loc1_].score_txt.text = "";
            this["num_" + _loc1_].X123_mc.gotoAndStop(4);
            _loc1_++;
         }
         this.pageNum = 1;
         page_txt.text = "1/5";
         Api_4399_All.GetRankListsData(1,this.selPageX,110);
         Api_4399_All.GetOneRankInfo();
      }
      
      public function get_PaiHang_Data(param1:Array, param2:int) : *
      {
         var _loc4_:* = undefined;
         if(param1 == null || param1.length == 0)
         {
            TiaoShi.txtShow("get_PaiHang_Data##########  null ####");
            return;
         }
         var _loc3_:int = (param2 - 1) * this.selPageX;
         for(_loc4_ in param1)
         {
            DataArr[_loc3_ + _loc4_] = param1[_loc4_];
         }
         if(this.pageNum == 1)
         {
            this.PaiHang_Show(this.pageNum);
            TiaoShi.txtShow("get_PaiHang_Data##########  pageNum == 1  ####");
         }
         if(loadPaiHangGoGame)
         {
            this.goGame(param2);
            loadPaiHangGoGame = false;
            TiaoShi.txtShow("get_PaiHang_Data##########  goGame(pageN) ####");
         }
      }
      
      public function PaiHang_Show(param1:uint) : *
      {
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         if(DataArr == null || DataArr.length == 0)
         {
            return;
         }
         var _loc2_:int = (param1 - 1) * this.pageX;
         var _loc3_:int = 0;
         var _loc4_:* = _loc2_;
         while(_loc4_ < _loc2_ + 10)
         {
            if(!DataArr[_loc4_])
            {
               this["num_" + _loc3_].x_txt.text = "";
               this["num_" + _loc3_].id_txt.text = "";
               this["num_" + _loc3_].save_txt.text = "";
               this["num_" + _loc3_].score_txt.text = "";
               this["num_" + _loc3_].X123_mc.gotoAndStop(4);
            }
            else
            {
               _loc5_ = _loc3_ + 1 + _loc2_;
               _loc6_ = DataArr[_loc4_];
               this["num_" + _loc3_].x_txt.text = _loc3_ + 10 * (param1 - 1) + 1;
               this["num_" + _loc3_].id_txt.text = _loc6_.userName;
               this["num_" + _loc3_].save_txt.text = uint(_loc6_.index) + 1;
               this["num_" + _loc3_].score_txt.text = _loc6_.score;
               if(_loc5_ < 4)
               {
                  this["num_" + _loc3_].X123_mc.gotoAndStop(_loc5_);
               }
               else
               {
                  this["num_" + _loc3_].X123_mc.gotoAndStop(4);
               }
            }
            _loc3_++;
            _loc4_++;
         }
      }
      
      public function PaiHang_Show_X(param1:Array) : *
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         TiaoShi.txtShow("PaiHang_Show_X~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~@");
         if(param1 != null && param1.length != 0)
         {
            for(_loc2_ in param1)
            {
               _loc3_ = param1[_loc2_];
               if(int(_loc3_.index) == Main.saveNum)
               {
                  this["num_10"].x_txt.text = _loc3_.rank;
                  whoNumX.setValue(int(_loc3_.rank));
                  this["num_10"].id_txt.text = _loc3_.userName;
                  this["num_10"].save_txt.text = uint(_loc3_.index) + 1;
                  this["num_10"].score_txt.text = _loc3_.score;
                  if(_loc3_.rank < 4)
                  {
                     this["num_10"].X123_mc.gotoAndStop(_loc3_.rank);
                  }
                  this.userPage.setValue(int(_loc3_.rank) / this.pageX);
                  TiaoShi.txtShow("查询玩家userPage = " + this.userPage.getValue());
                  return;
               }
            }
            this["num_10"].x_txt.text = "?";
            this["num_10"].id_txt.text = Main.logName;
            this["num_10"].save_txt.text = Main.saveNum + 1;
            this["num_10"].score_txt.text = "未上榜";
            this["num_10"].X123_mc.gotoAndStop(4);
            TiaoShi.txtShow("查询玩家userPage 2 = " + this.userPage.getValue());
         }
         else
         {
            this["num_10"].x_txt.text = "?";
            this["num_10"].id_txt.text = Main.logName;
            this["num_10"].save_txt.text = Main.saveNum + 1;
            this["num_10"].score_txt.text = "未上榜";
            this["num_10"].X123_mc.gotoAndStop(4);
            TiaoShi.txtShow("查询玩家userPage 3 = " + this.userPage.getValue());
         }
      }
      
      private function TimeXX(param1:*) : *
      {
         ++this.timeNum;
         if(PK_ing == false && this.timeNum > 27 * 30)
         {
            this.timeNum = 0;
            playerDataArr = new Array();
            TiaoShi.txtShow("playerDataArr = new Array()!!!!!!!!!!!!!!!!!!!!!!清除playerDataArr!");
         }
      }
      
      private function PageUP(param1:*) : *
      {
         if(this.pageNum < 5)
         {
            ++this.pageNum;
            this.PaiHang_Show(this.pageNum);
            page_txt.text = this.pageNum + "/5";
         }
      }
      
      private function PageDOWN(param1:*) : *
      {
         if(this.pageNum > 1)
         {
            --this.pageNum;
            this.PaiHang_Show(this.pageNum);
            page_txt.text = this.pageNum + "/5";
         }
      }
      
      private function SelPage(param1:int) : Boolean
      {
         loadPaiHangGoGame = true;
         var _loc2_:int = this.selPageX * param1;
         if(!DataArr[_loc2_])
         {
            Api_4399_All.GetRankListsData(param1,this.selPageX,110);
            return false;
         }
         return true;
      }
      
      private function GameStart(param1:*) : *
      {
         if(Main.player1.getGold() < 50000 || Boolean(Main.P1P2) && (Main.player1.getGold() < 50000 || Main.player2.getGold() < 50000))
         {
            ShortTip.open(16);
            return;
         }
         if(Main.player1.killPoint.getValue() < 50 || Boolean(Main.P1P2) && (Main.player1.killPoint.getValue() < 50 || Main.player2.killPoint.getValue() < 50))
         {
            ShortTip.open(32);
            return;
         }
         Main.player1.payGold(50000);
         Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() - 50);
         if(Main.P1P2)
         {
            Main.player2.payGold(50000);
            Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() - 50);
         }
         P1_money_txt.text = Main.player1.getGold();
         P1_killPoint_txt.text = Main.player1.killPoint.getValue();
         if(Main.P1P2)
         {
            P2_money_txt.text = Main.player2.getGold();
            P2_killPoint_txt.text = Main.player2.killPoint.getValue();
         }
         addChild(this.初始化mc);
         this.goGame(0);
         if(Main.P1P2)
         {
            PlayerNumMax_XX = 2;
         }
         else
         {
            PlayerNumMax_XX = 1;
         }
         PlayerNum_XX = 0;
      }
      
      private function goGame(param1:int = 0) : *
      {
         if(this.初始化mc.parent)
         {
            this.初始化mc.parent.removeChild(this.初始化mc);
         }
         PK_UI.Close();
         Main.gameNum.setValue(999);
         Main.gameNum2.setValue(1);
         Main._this.Loading();
         whoNum = param1;
         Pk_timeNum = 0;
         killNum.setValue(0);
      }
   }
}

