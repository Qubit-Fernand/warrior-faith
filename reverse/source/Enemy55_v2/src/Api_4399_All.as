package src
{
   import com.ByteArrayXX.*;
   import com.hotpoint.braveManIII.views.elvesPanel.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.makePanel.*;
   import com.hotpoint.braveManIII.views.petPanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import com.hotpoint.braveManIII.views.stampPanel.*;
   import com.hotpoint.braveManIII.views.wantedPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   import unit4399.events.*;
   
   public class Api_4399_All
   {
      
      public static var tempArr:Array;
      
      public static var sel_PaiHang_Over:Boolean = false;
      
      private static var selYN:Boolean = false;
      
      public static var totalRecharged_Arr:Array = new Array();
      
      public static var totalDate_Arr:Array = ["0","2012-08-09|17:00:00"];
      
      public static var GetUserData_Arr:Array = new Array();
      
      public static var PaiMing_Arr:Array = new Array();
      
      public function Api_4399_All()
      {
         super();
      }
      
      public static function Init(param1:Stage) : *
      {
         PayMoneyVar.getInstance();
         param1.addEventListener(PayEvent.LOG,onPayEventHandler,false,0,true);
         param1.addEventListener("usePayApi",onPayEventHandler,false,0,true);
         param1.addEventListener(PayEvent.INC_MONEY,onPayEventHandler,false,0,true);
         param1.addEventListener(PayEvent.DEC_MONEY,onPayEventHandler,false,0,true);
         param1.addEventListener(PayEvent.GET_MONEY,onPayEventHandler,false,0,true);
         param1.addEventListener(PayEvent.PAY_MONEY,onPayEventHandler,false,0,true);
         param1.addEventListener(PayEvent.PAIED_MONEY,onPayEventHandler,false,0,true);
         param1.addEventListener(PayEvent.RECHARGED_MONEY,onPayEventHandler,false,0,true);
         param1.addEventListener(PayEvent.PAY_ERROR,onPayEventHandler,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_ERROR,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_DEL_SUCC,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_GET_PACKAGEINFO,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_UPDATE_EXTEND,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_ADDFREE_SUCC,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_UPDATEPRO_SUCC,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_GET_FREEPACKAGEINFO,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_ADD_SUCC,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_GET_PAYPACKAGEINFO,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_GET_TYPENOTICE,onShopHandler2,false,0,true);
         param1.addEventListener(ShopEvent.SHOP_MODIFY_EX,onShopHandler2,false,0,true);
         param1.addEventListener(RankListEvent.RANKLIST_ERROR,onRankListErrorHandler);
         param1.addEventListener(RankListEvent.RANKLIST_SUCCESS,onRankListSuccessHandler);
         param1.addEventListener(ShopEvent.SHOP_ERROR_ND,onShopEventHandler);
         param1.addEventListener(ShopEvent.SHOP_BUY_ND,onShopEventHandler);
         param1.addEventListener(ShopEvent.SHOP_GET_LIST,onShopEventHandler);
      }
      
      private static function logedHandler(param1:SaveEvent) : void
      {
         if(!param1.ret)
         {
         }
      }
      
      private static function onUserLogOutHandler(param1:Event) : void
      {
      }
      
      private static function onPayEventHandler(param1:PayEvent) : void
      {
         var _loc2_:Object = null;
         switch(param1.type)
         {
            case "logsuccess":
               Api_4399_All.getPayShow();
               break;
            case "incMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  Money_sel_Num(param1.data.balance);
                  Shop4399.moneyAll.setValue(param1.data.balance);
               }
               break;
            case "decMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  Money_sel_Num(param1.data.balance);
                  Shop4399.moneyAll.setValue(param1.data.balance);
                  Shop4399.GetObj();
                  ShopKillPoint.GetBuyNum();
                  ShopKillPoint.GetBuyS();
                  xilianPanel.xlOK();
                  MenuTooltip.lijifuhua();
                  MenuTooltip.xufeiRMB();
                  PetPanel.jnrmbOK();
                  PetPanel.sjrmbOK();
                  PetPanel.wxrmbOK();
                  WantedPanel.lqczOK();
                  StampPanel.tyKeyOK();
                  ElvesPanel.blueXSOK();
                  ElvesPanel.pinkXSOK();
                  ElvesPanel.goldXSOK();
                  ElvesPanel.chongzhiOK();
                  MakePanel._instance.GetBuyObj();
                  Sel_NanDu2.DianQuanGoGame();
                  XingLing_Interface.UP_Fun_YES();
                  XingLing_Interface.UpPinZhi_Fun_YES();
                  Vip_Interface.GetVip();
                  Vip_Interface.DianQuanChuanSong();
               }
               break;
            case "getMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  Shop4399.moneyAll.setValue(param1.data.balance);
                  Money_sel_Num(param1.data.balance);
               }
               break;
            case "payMoney":
               break;
            case "paiedMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  Shop4399.totalPaiedMoney.setValue(param1.data.balance);
               }
               break;
            case "rechargedMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  if(totalRecharged_Arr[0] == 0)
                  {
                     Shop4399.totalRecharged.setValue(param1.data.balance);
                     Shop_LiBao.selYN = Shop_LiBao.selYN2 = false;
                  }
                  else if(totalRecharged_Arr[0] == 1)
                  {
                     Shop_LiBao.HDpoint.setValue(param1.data.balance);
                  }
                  totalRecharged_Arr.shift();
                  if(totalRecharged_Arr.length > 0)
                  {
                     if(totalRecharged_Arr[0] == 0)
                     {
                        Main.serviceHold.getTotalRechargedFun();
                     }
                     else if(totalRecharged_Arr[0] == 1)
                     {
                        _loc2_ = new Object();
                        _loc2_.eDate = totalDate_Arr[1];
                        Main.serviceHold.getTotalRechargedFun(_loc2_);
                     }
                     else
                     {
                        TiaoShi.XXX.push("查询条件错误?!");
                     }
                  }
                  if(Shop_LiBao.shopX)
                  {
                     Shop_LiBao.shopX.ShowPoint();
                  }
                  if(Shop_LiBao2.shopX)
                  {
                     Shop_LiBao2.shopX.ShowPoint();
                  }
               }
               break;
            case "payError":
               if(param1.data == null)
               {
                  break;
               }
               if((param1.data.info as String).substr(0,1) == "4")
               {
                  Shop4399.NoMoney_info_Open();
               }
         }
      }
      
      private static function onShopHandler2(param1:ShopEvent) : void
      {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:int = 0;
         var _loc14_:Object = null;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:Object = null;
         var _loc2_:String = "";
         var _loc3_:String = "";
         switch(param1.type)
         {
            case ShopEvent.SHOP_ERROR:
               _loc3_ = "商城API错误信息------>" + String(param1.data);
               break;
            case ShopEvent.SHOP_DEL_SUCC:
               _loc2_ = String(Object(param1.data).callIdx);
               _loc3_ = "删除物品成功，接口标记为:" + _loc2_;
               break;
            case ShopEvent.SHOP_GET_PACKAGEINFO:
               _loc3_ = "成功获取了背包的数据:\n";
               _loc4_ = param1.data as Object;
               if(_loc4_ == null)
               {
                  break;
               }
               _loc5_ = String(_loc4_.getType);
               _loc2_ = String(_loc4_.callIdx);
               _loc6_ = int(_loc4_.cur);
               _loc7_ = int(_loc4_.total);
               _loc8_ = int(_loc4_.itemNum);
               _loc3_ = "接口标记为: " + _loc2_ + "当前操作来自:" + _loc5_ + "  总共有" + _loc8_ + "类物品  当前是第" + _loc6_;
               _loc3_ += "页  总共有" + _loc7_ + "页";
               _loc13_ = 0;
               while(_loc13_ < _loc8_)
               {
                  _loc14_ = _loc4_["item" + _loc13_];
                  _loc3_ = "物品" + (_loc13_ + 1);
                  _loc3_ = " 物品id:" + _loc14_.proId + " 背包id:" + _loc14_.pId + " 数量:" + _loc14_.count;
                  _loc3_ += " 价格:" + _loc14_.price + " 名称:" + _loc14_.title;
                  _loc3_ += " 图片地址:" + _loc14_.thumb + " 描述:" + _loc14_.description;
                  if(_loc14_.keys != undefined)
                  {
                     for(_loc15_ in _loc14_.keys)
                     {
                        _loc3_ = "显示----------->属性名:" + _loc15_ + "  属性值:" + _loc14_.keys[_loc15_];
                     }
                  }
                  if(_loc14_.hideKeys != undefined)
                  {
                     for(_loc16_ in _loc14_.hideKeys)
                     {
                        _loc3_ = "隐藏--------->属性名:" + _loc16_ + "  属性值:" + _loc14_.hideKeys[_loc16_];
                     }
                  }
                  _loc13_++;
               }
               break;
            case ShopEvent.SHOP_UPDATE_EXTEND:
               _loc3_ = "请设置扩展字段，你可以不填哦\n";
               _loc9_ = param1.data as Object;
               _loc3_ += "所要购买的物品id为:" + _loc9_.proId;
               break;
            case ShopEvent.SHOP_MODIFY_EX:
               _loc2_ = String(Object(param1.data).callIdx);
               _loc3_ = "修改扩展属性成功，接口标记为:" + _loc2_;
               break;
            case ShopEvent.SHOP_ADDFREE_SUCC:
               _loc2_ = String(Object(param1.data).callIdx);
               _loc3_ = "添加免费物品成功，接口标记为:" + _loc2_;
               break;
            case ShopEvent.SHOP_UPDATEPRO_SUCC:
               _loc2_ = String(Object(param1.data).callIdx);
               _loc3_ = "修改平铺物品属性成功，接口标记为:" + _loc2_;
               break;
            case ShopEvent.SHOP_GET_FREEPACKAGEINFO:
               break;
            case ShopEvent.SHOP_ADD_SUCC:
               _loc3_ = "成功购买付费物品";
               break;
            case ShopEvent.SHOP_GET_TYPENOTICE:
               _loc3_ = "成功获取公告及物品分类信息";
               _loc10_ = param1.data as Array;
               if(_loc10_ == null)
               {
                  break;
               }
               _loc11_ = String(_loc10_[0]);
               _loc3_ = "公告信息---->" + _loc11_;
               _loc12_ = _loc10_[1] as Array;
               if(_loc12_ == null)
               {
                  break;
               }
               for(_loc17_ in _loc12_)
               {
                  _loc18_ = _loc12_[_loc17_];
                  _loc3_ = "分类id:" + _loc18_.id + "  分类名:" + _loc18_.label;
               }
               break;
            case ShopEvent.SHOP_GET_PAYPACKAGEINFO:
         }
      }
      
      private static function saveProcess(param1:SaveEvent) : void
      {
         var _loc2_:Array = null;
         switch(param1.type)
         {
            case SaveEvent.SAVE_GET:
               break;
            case SaveEvent.SAVE_SET:
               if(param1.ret as Boolean == true)
               {
               }
               break;
            case SaveEvent.SAVE_LIST:
               _loc2_ = param1.ret as Array;
               if(_loc2_ == null)
               {
               }
         }
      }
      
      private static function netSaveErrorHandler(param1:Event) : void
      {
      }
      
      public static function Money_up(param1:int) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = param1;
            Main.serviceHold.incMoney_As3(PayMoneyVar.instance);
         }
      }
      
      public static function Money_down(param1:int) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = param1;
            Main.serviceHold.decMoney_As3(PayMoneyVar.instance);
         }
      }
      
      public static function Money_sel() : *
      {
         if(Main.serviceHold)
         {
            if(selYN == false)
            {
               Main.serviceHold.getBalance();
               selYN = true;
            }
         }
      }
      
      public static function TotalPaied() : *
      {
         if(Main.serviceHold)
         {
            Main.serviceHold.getTotalPaiedFun();
         }
      }
      
      public static function Money_sel2() : *
      {
         if(Main.serviceHold)
         {
            Main.serviceHold.getBalance();
         }
      }
      
      public static function GetTotalRecharged(param1:int = 0) : *
      {
         var _loc2_:Object = null;
         if(Main.serviceHold)
         {
            totalRecharged_Arr.push(param1);
            if(totalRecharged_Arr.length == 1)
            {
               if(param1 == 0)
               {
                  Main.serviceHold.getTotalRechargedFun();
               }
               else if(param1 == 1)
               {
                  _loc2_ = new Object();
                  _loc2_.eDate = totalDate_Arr[param1];
                  Main.serviceHold.getTotalRechargedFun(_loc2_);
               }
            }
         }
      }
      
      private static function Money_sel_Num(param1:int) : *
      {
         if(Shop4399.shopX)
         {
            Shop4399.shopX.money_All_txt.text = "" + param1;
         }
         if(ShopKillPoint.shopX)
         {
            ShopKillPoint.shopX.point_txt.text = "" + param1;
         }
         if(xilianPanel.xlPanel)
         {
            xilianPanel.xlPanel.point_txt.text = "" + param1;
         }
         if(PetPanel.petPanel)
         {
            PetPanel.petPanel.point_txt.text = "" + param1;
         }
         if(ItemsPanel.itemsPanel)
         {
            ItemsPanel.itemsPanel.djPoint.text = "" + param1;
         }
         if(SelMap.selMapX)
         {
            SelMap.selMapX.Sel_nanDu_mc2.x4_txt.text = "" + param1;
         }
         if(WantedPanel.xsrwPanel)
         {
            WantedPanel.xsrwPanel._moneyP_txt.text = "" + param1;
         }
         if(ElvesPanel.elvesPanel)
         {
            ElvesPanel.elvesPanel.dianjuan.text = "" + param1;
         }
         if(MakePanel._instance)
         {
            MakePanel._instance.dianQun_Point.text = "" + param1;
         }
      }
      
      public static function getPayShow(param1:Event = null) : *
      {
         if(Main.serviceHold)
         {
            if(Shop4399.ShopArr.length == 0)
            {
               Main.serviceHold.getPayPacInfoFun(200,1,0);
            }
         }
      }
      
      public static function BuyObj(param1:Object) : void
      {
         if(serviceHold)
         {
            serviceHold.buyPropNd(param1);
         }
      }
      
      private static function onShopEventHandler(param1:ShopEvent) : void
      {
         switch(evt.type)
         {
            case ShopEvent.SHOP_ERROR_ND:
               errorFun(evt.data);
               break;
            case ShopEvent.SHOP_BUY_ND:
               buySuccFun(evt.data);
               break;
            case ShopEvent.SHOP_GET_LIST:
               getSuccFun(evt.data as Array);
         }
      }
      
      private static function errorFun(param1:Object) : void
      {
         trace("eId:" + param1.eId + "  message:" + param1.msg + "\n");
      }
      
      private static function getSuccFun(param1:Array) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Object = null;
         if(param1 == null)
         {
            trace("获取物品列表时，返回空值了\n");
            return;
         }
         if(param1.length == 0)
         {
            trace("无商品列表\n");
            return;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            trace("propNum:" + _loc2_ + "  propId:" + _loc3_.propId + "  price:" + _loc3_.price + "   propType:" + _loc3_.propType + "\n");
         }
      }
      
      public static function GetOneRankInfo(param1:String = "", param2:uint = 110) : *
      {
         if(Main.P1P2)
         {
            param2 = 111;
         }
         if(param1 == "" && Boolean(Main.logName))
         {
            param1 = Main.logName;
         }
         Main.serviceHold.getOneRankInfo(param2,param1);
      }
      
      public static function GetRankListByOwn(param1:uint, param2:uint, param3:uint) : *
      {
         Main.serviceHold.getRankListByOwn(param1,param2,param3);
      }
      
      public static function GetRankListsData(param1:uint = 1, param2:uint = 20, param3:uint = 110) : *
      {
         if(Main.P1P2)
         {
            param3 = 111;
         }
         sel_PaiHang_Over = false;
         var _loc4_:Array = [param1,param2,param3];
         PaiMing_Arr.push(_loc4_);
         TiaoShi.txtShow("%%%%%%%%%%%%%%%%%%%%% PaiMing_Arr.length = " + PaiMing_Arr.length);
         if(PaiMing_Arr.length == 1)
         {
            Main.serviceHold.getRankListsData(PaiMing_Arr[0][2],PaiMing_Arr[0][1],PaiMing_Arr[0][0]);
            TiaoShi.txtShow("%%%%%%%%%%%%%%%% GetRankListsData %%" + PaiMing_Arr[0][2] + "," + PaiMing_Arr[0][1] + "," + PaiMing_Arr[0][0]);
         }
      }
      
      private static function GetRankListsData2(param1:uint = 1, param2:uint = 20, param3:uint = 110) : *
      {
         if(Main.P1P2)
         {
            param3 = 111;
         }
         Main.serviceHold.getRankListsData(param3,param2,param1);
         TiaoShi.txtShow("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GetRankListsData2 %%");
      }
      
      public static function SubmitScore(param1:uint, param2:Array) : *
      {
         Main.serviceHold.submitScoreToRankLists(param1,param2);
      }
      
      public static function GetUserData(param1:String, param2:uint) : *
      {
         TiaoShi.txtShow("GetUserData uid = " + param1 + ",idx = " + param2);
         var _loc3_:Array = [param1,param2];
         GetUserData_Arr.push(_loc3_);
         if(GetUserData_Arr.length == 1)
         {
            Main.serviceHold.getUserData(param1,param2);
         }
      }
      
      public static function GetUserData2(param1:String, param2:uint) : *
      {
         Main.serviceHold.getUserData(param1,param2);
      }
      
      public static function onRankListSuccessHandler(param1:RankListEvent) : void
      {
         var _loc2_:Object = param1.data;
         var _loc3_:* = _loc2_.data;
         switch(_loc2_.apiName)
         {
            case "1":
               decodeRankListInfo1(_loc3_);
               break;
            case "2":
               decodeRankListInfo2(_loc3_);
               break;
            case "4":
               decodeRankListInfo3(_loc3_);
               break;
            case "3":
               decodeSumitScoreInfo(_loc3_);
               break;
            case "5":
               decodeUserData(_loc3_);
         }
      }
      
      public static function onRankListErrorHandler(param1:RankListEvent) : void
      {
         var _loc2_:Object = param1.data;
         var _loc3_:String = "apiFlag:" + _loc2_.apiName + "   errorCode:" + _loc2_.code + "   message:" + _loc2_.message + "\n";
         TiaoShi.ShowPaiHang(_loc3_);
      }
      
      private static function decodeUserData(param1:Object) : void
      {
         if(PK_UI.PK_ing == false)
         {
            GetUserData_Arr = new Array();
            return;
         }
         if(param1 == null)
         {
            ShortTip.open(1);
            return;
         }
         var _loc2_:String = String(param1.data);
         var _loc3_:ByteArray = Base64.decodeToByteArray(_loc2_) as ByteArray;
         _loc3_.position = 0;
         var _loc4_:Object = _loc3_.readObject();
         PK_UI.playerDataArr_id[PK_UI.loadPlayerNum % 5] = GetUserData_Arr[0][0];
         PK_UI.playerDataArr[PK_UI.loadPlayerNum % 5] = _loc4_["p1"];
         PK_UI.Load_OtherPlayerData(PK_UI.loadPlayerNum);
         GetUserData_Arr.shift();
         if(GetUserData_Arr.length > 0)
         {
            GetUserData2(GetUserData_Arr[0][0],GetUserData_Arr[0][1]);
            TiaoShi.txtShow("2读取存档队列处理 查询后面数据" + GetUserData_Arr.length);
         }
      }
      
      private static function decodeSumitScoreInfo(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         var _loc2_:String = "";
         if(param1 == null || param1.length == 0)
         {
            TiaoShi.ShowPaiHang("没有数据,返回结果有问题！\n");
            return;
         }
         tempArr = param1;
         for(_loc3_ in param1)
         {
            _loc4_ = param1[_loc3_];
            _loc2_ += ">>>>>>>>>>第" + (_loc3_ + 1) + "条数据 排行榜ID:" + _loc4_.rId + "\n信息码值:" + _loc4_.code + "\n";
            if(_loc4_.code == "10000")
            {
               _loc2_ += "\n当前排名:" + _loc4_.curRank + ",当前分数:" + _loc4_.curScore + "\n上一局排名:" + _loc4_.lastRank + ",n上一局分数:" + _loc4_.lastScore + "\n";
            }
            else
            {
               _loc2_ += "该排行榜提交的分数出问题了 信息:" + _loc4_.message + "\n";
            }
         }
         TiaoShi.ShowPaiHang(_loc2_);
      }
      
      private static function decodeRankListInfo1(param1:Array) : void
      {
         PK_UI._this.PaiHang_Show_X(param1);
      }
      
      private static function decodeRankListInfo3(param1:Array) : void
      {
         PK_UI._this.get_PaiHang_Data(param1,PaiMing_Arr[0][0]);
         PaiMing_Arr.shift();
         if(PaiMing_Arr.length > 0)
         {
            GetRankListsData2(PaiMing_Arr[0][0],PaiMing_Arr[0][1],PaiMing_Arr[0][2]);
         }
         else
         {
            sel_PaiHang_Over = true;
         }
      }
      
      private function buySuccFun(param1:Object) : void
      {
         trace("propId:" + param1.propId + "  count:" + param1.count + "   balance:" + param1.balance + "   tag:" + param1.tag + "\n");
      }
   }
}

