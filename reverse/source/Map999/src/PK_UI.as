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
      
      public static var whoNum:int = 0;
      
      public static var PK_ing:Boolean = false;
      
      public static var loadPlayerNum:int = 0;
      
      public static var PlayerNumMax_XX:int = 1;
      
      public static var PlayerNum_XX:int = 0;
      
      public static var DataArr:Array = new Array();
      
      public static var playerDataArr:Array = new Array();
      
      public static var loadPaiHangGoGame:Boolean = false;
      
      public var 初始化mc:MovieClip = new 游戏初始化();
      
      public var pageNum:int = 1;
      
      public var pageX:int = 10;
      
      public var selPageX:int = 20;
      
      public var timeNum:uint = 0;
      
      public var userPage:VT = VT.createVT(-99);
      
      public var paiHang_MAX:uint = 5000;
      
      public function PK_UI()
      {
         super();
         go_btn.addEventListener(MouseEvent.CLICK,GameStart);
         close_btn.addEventListener(MouseEvent.CLICK,Close);
         addEventListener(Event.ENTER_FRAME,TimeXX);
         pageDOWN_btn.addEventListener(MouseEvent.CLICK,PageDOWN);
         pageUP_btn.addEventListener(MouseEvent.CLICK,PageUP);
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
         Main._stage.addChild(_this);
         loadPlayerData = false;
         loadPaiHangGoGame = false;
      }
      
      public static function Close(e:* = null) : *
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
      
      public static function AddOtherPlayer() : *
      {
         if(PK_ing && PlayerNum_XX < PlayerNumMax_XX)
         {
            Load_OtherPlayer();
            ++PlayerNum_XX;
            TiaoShi.txtShow("go^^^^^PlayerNum_XX < PlayerNumMax_XX^^^");
         }
      }
      
      private static function Load_OtherPlayer() : *
      {
         var tempArr:Array = new Array();
         for(var i:int = whoNum; i < whoNum + 10; i++)
         {
            if(!DataArr[i])
            {
               break;
            }
            tempArr[i] = DataArr[i];
         }
         var who:int = whoNum;
         if(tempArr.length > 5)
         {
            who = Math.random() * 5 + whoNum;
         }
         else
         {
            who = Math.random() * tempArr.length + whoNum;
         }
         loadPlayerNum = who;
         Load_OtherPlayerData(who);
      }
      
      public static function Load_OtherPlayerData(num:int) : *
      {
         var NP:Player2 = null;
         var tmpObj:Object = null;
         var ii:uint = num % 5;
         if(Boolean(playerDataArr[ii]) && playerDataArr[ii] != null)
         {
            NP = new Player2();
            NP.data = DeepCopyUtil.clone(playerDataArr[ii]);
            NP.Load_All_Player_Data();
            Main.world.moveChild_Player.addChild(NP);
            NP.x = Math.random() * 1000 + 100;
            NP.y = 400;
            NP.newSkin();
            TiaoShi.txtShow("缓存读取玩家数据!!!!!! 添加 " + ii);
         }
         else
         {
            tmpObj = DataArr[num];
            Api_4399_All.GetUserData(tmpObj.uId,tmpObj.index);
            TiaoShi.txtShow("无缓存读取玩家数据 读取中..." + num);
         }
      }
      
      public function Show() : *
      {
         for(var i:int = 0; i < 11; i++)
         {
            this["num_" + i].x_txt.text = "";
            this["num_" + i].id_txt.text = "";
            this["num_" + i].save_txt.text = "";
            this["num_" + i].score_txt.text = "";
            this["num_" + i].X123_mc.gotoAndStop(4);
         }
         pageNum = 1;
         Api_4399_All.GetRankListsData(1,selPageX,14);
         Api_4399_All.GetOneRankInfo();
      }
      
      public function get_PaiHang_Data(dataAry:Array, pageN:int) : *
      {
         var i:* = undefined;
         if(dataAry == null || dataAry.length == 0)
         {
            return;
         }
         var x:int = (pageN - 1) * selPageX;
         for(i in dataAry)
         {
            DataArr[x + i] = dataAry[i];
         }
         if(pageNum == 1)
         {
            PaiHang_Show(pageNum);
            TiaoShi.txtShow("get_PaiHang_Data##########  pageNum == 1  ####");
         }
         if(loadPaiHangGoGame)
         {
            goGame(pageN);
            loadPaiHangGoGame = false;
            TiaoShi.txtShow("get_PaiHang_Data##########  goGame(pageN) ####");
         }
      }
      
      public function PaiHang_Show(num:uint) : *
      {
         var tmpObj:Object = null;
         if(DataArr == null || DataArr.length == 0)
         {
            return;
         }
         var x:int = (num - 1) * pageX;
         var x10:int = 0;
         for(var i:* = x; i < x + 10; i++)
         {
            if(!DataArr[i])
            {
               this["num_" + x10].x_txt.text = "";
               this["num_" + x10].id_txt.text = "";
               this["num_" + x10].save_txt.text = "";
               this["num_" + x10].score_txt.text = "";
               this["num_" + x10].X123_mc.gotoAndStop(4);
            }
            else
            {
               tmpObj = DataArr[i];
               this["num_" + x10].x_txt.text = tmpObj.rank;
               this["num_" + x10].id_txt.text = tmpObj.userName;
               this["num_" + x10].save_txt.text = uint(tmpObj.index) + 1;
               this["num_" + x10].score_txt.text = tmpObj.score;
               if(tmpObj.rank < 4)
               {
                  this["num_" + x10].X123_mc.gotoAndStop(tmpObj.rank);
               }
            }
            x10++;
         }
      }
      
      public function PaiHang_Show_X(dataAry:Array) : *
      {
         var i:int = 0;
         var tmpObj:Object = null;
         TiaoShi.txtShow("PaiHang_Show_X~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~@");
         if(dataAry != null && dataAry.length != 0)
         {
            for(i in dataAry)
            {
               tmpObj = dataAry[i];
               if(int(tmpObj.index) == Main.saveNum)
               {
                  this["num_10"].x_txt.text = tmpObj.rank;
                  this["num_10"].id_txt.text = tmpObj.userName;
                  this["num_10"].save_txt.text = uint(tmpObj.index) + 1;
                  this["num_10"].score_txt.text = tmpObj.score;
                  if(tmpObj.rank < 4)
                  {
                     this["num_10"].X123_mc.gotoAndStop(tmpObj.rank);
                  }
                  userPage.setValue(int(tmpObj.rank) / pageX);
                  TiaoShi.txtShow("查询玩家userPage = " + userPage.getValue());
                  return;
               }
            }
            this["num_10"].x_txt.text = "?";
            this["num_10"].id_txt.text = Main.logName;
            this["num_10"].save_txt.text = Main.saveNum + 1;
            this["num_10"].score_txt.text = "未上榜";
            this["num_10"].X123_mc.gotoAndStop(4);
            TiaoShi.txtShow("查询玩家userPage 2 = " + userPage.getValue());
         }
         else
         {
            this["num_10"].x_txt.text = "?";
            this["num_10"].id_txt.text = Main.logName;
            this["num_10"].save_txt.text = Main.saveNum + 1;
            this["num_10"].score_txt.text = "未上榜";
            this["num_10"].X123_mc.gotoAndStop(4);
            TiaoShi.txtShow("查询玩家userPage 3 = " + userPage.getValue());
         }
      }
      
      private function TimeXX(e:*) : *
      {
         ++timeNum;
         if(PK_ing == false && timeNum > 27 * 30)
         {
            timeNum = 0;
            DataArr = new Array();
            playerDataArr = new Array();
            TiaoShi.txtShow("playerDataArr = new Array()!!!!!!!!!!!!!!!!!!!!!!清除playerDataArr!");
         }
      }
      
      private function PageUP(e:*) : *
      {
         if(pageNum < 2)
         {
            ++pageNum;
            PaiHang_Show(pageNum);
            page_txt.text = pageNum + "/2";
         }
      }
      
      private function PageDOWN(e:*) : *
      {
         if(pageNum > 1)
         {
            --pageNum;
            PaiHang_Show(pageNum);
            page_txt.text = pageNum + "/2";
         }
      }
      
      private function SelPage(num:int) : Boolean
      {
         loadPaiHangGoGame = true;
         var xx:int = selPageX * num;
         if(!DataArr[xx])
         {
            Api_4399_All.GetRankListsData(num,selPageX,14);
            return false;
         }
         return true;
      }
      
      private function GameStart(e:*) : *
      {
         var yn:Boolean = false;
         var num:int = 0;
         addChild(初始化mc);
         ShortTip.open(1);
         if(userPage.getValue() >= 0)
         {
            yn = Boolean(SelPage(userPage.getValue()));
            if(yn)
            {
               goGame(userPage.getValue());
               TiaoShi.txtShow("GameStart 有排名玩家 Y");
            }
         }
         else
         {
            num = paiHang_MAX / selPageX;
            yn = Boolean(SelPage(num));
            if(yn)
            {
               goGame(num);
               TiaoShi.txtShow("GameStart 排行榜人数 Y");
            }
            else
            {
               goGame(0);
               TiaoShi.txtShow("GameStart 排行榜人数 XX");
            }
         }
         if(Main.P1P2)
         {
            PlayerNumMax_XX = 2;
         }
         else
         {
            PlayerNumMax_XX = 1;
         }
         PK_ing = true;
         PlayerNum_XX = 0;
      }
      
      private function goGame(num:int = 0) : *
      {
         if(初始化mc.parent)
         {
            初始化mc.parent.removeChild(初始化mc);
         }
         PK_UI.Close();
         Main.gameNum.setValue(999);
         Main.gameNum2.setValue(1);
         InitData.pkHpMaxNum_yn.setValue(955558);
         Main._this.Loading();
         whoNum = num;
         TiaoShi.txtShow("goGame^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      }
   }
}

