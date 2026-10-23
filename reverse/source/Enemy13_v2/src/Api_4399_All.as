package src
{
   import com.ByteArrayXX.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.views.elvesPanel.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
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
         trace("支付事件类型--------->" + param1.type + "  e.data is Boolean------>" + (param1.data is Boolean));
         switch(param1.type)
         {
            case "logsuccess":
               trace("登录成功------>uid:" + param1.data.uid + "  name:" + param1.data.name);
               Api_4399_All.getPayShow();
               break;
            case "incMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  trace("增加游戏币后的余额为:" + param1.data.balance);
                  Money_sel_Num(param1.data.balance);
                  Shop4399.moneyAll.setValue(param1.data.balance);
                  break;
               }
               trace("增加游戏币错误!");
               break;
            case "decMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  trace("减少游戏币后的余额为:" + param1.data.balance);
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
                  break;
               }
               trace("减少游戏币错误!");
               break;
            case "getMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  trace("获取游戏币余额为:" + param1.data.balance);
                  Money_sel_Num(param1.data.balance);
                  Shop4399.moneyAll.setValue(param1.data.balance);
                  break;
               }
               trace("获取游戏币余额错误!");
               break;
            case "payMoney":
               trace("充值游戏币失败!");
               break;
            case "paiedMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  trace("获取累积消费的游戏币为:" + param1.data.balance);
                  Shop4399.totalPaiedMoney.setValue(param1.data.balance);
                  break;
               }
               trace("获取累积消费的游戏币错误!");
               break;
            case "rechargedMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  trace("获取累积充值的游戏币为:" + param1.data.balance);
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
                  break;
               }
               trace("获取累积充值的游戏币错误！");
               break;
            case "payError":
               if(param1.data == null)
               {
                  break;
               }
               trace("使用支付接口其他错误----->" + param1.data.info);
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
         var _loc13_:Array = null;
         var _loc14_:Object = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:* = 0;
         var _loc19_:int = 0;
         var _loc20_:Object = null;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         var _loc23_:* = undefined;
         var _loc24_:Object = null;
         var _loc25_:int = 0;
         var _loc26_:Object = null;
         var _loc27_:Array = null;
         var _loc28_:VT = null;
         var _loc29_:Object = null;
         var _loc30_:Array = null;
         var _loc31_:* = undefined;
         var _loc32_:Object = null;
         var _loc2_:String = "";
         var _loc3_:String = "";
         switch(param1.type)
         {
            case ShopEvent.SHOP_ERROR:
               _loc3_ = "商城API错误信息------>" + String(param1.data);
               trace(_loc3_);
               break;
            case ShopEvent.SHOP_DEL_SUCC:
               _loc2_ = String(Object(param1.data).callIdx);
               _loc3_ = "删除物品成功，接口标记为:" + _loc2_;
               trace(_loc3_);
               break;
            case ShopEvent.SHOP_GET_PACKAGEINFO:
               _loc3_ = "成功获取了背包的数据:\n";
               trace(_loc3_);
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
               trace(_loc3_);
               _loc19_ = 0;
               while(_loc19_ < _loc8_)
               {
                  _loc20_ = _loc4_["item" + _loc19_];
                  _loc3_ = "物品" + (_loc19_ + 1);
                  trace(_loc3_);
                  _loc3_ = " 物品id:" + _loc20_.proId + " 背包id:" + _loc20_.pId + " 数量:" + _loc20_.count;
                  _loc3_ += " 价格:" + _loc20_.price + " 名称:" + _loc20_.title;
                  _loc3_ += " 图片地址:" + _loc20_.thumb + " 描述:" + _loc20_.description;
                  trace(_loc3_);
                  if(_loc20_.keys != undefined)
                  {
                     for(_loc21_ in _loc20_.keys)
                     {
                        _loc3_ = "显示----------->属性名:" + _loc21_ + "  属性值:" + _loc20_.keys[_loc21_];
                        trace(_loc3_);
                     }
                  }
                  if(_loc20_.hideKeys != undefined)
                  {
                     for(_loc22_ in _loc20_.hideKeys)
                     {
                        _loc3_ = "隐藏--------->属性名:" + _loc22_ + "  属性值:" + _loc20_.hideKeys[_loc22_];
                        trace(_loc3_);
                     }
                  }
                  _loc19_++;
               }
               break;
            case ShopEvent.SHOP_UPDATE_EXTEND:
               _loc3_ = "请设置扩展字段，你可以不填哦\n";
               _loc9_ = param1.data as Object;
               _loc3_ += "所要购买的物品id为:" + _loc9_.proId;
               trace(_loc3_);
               break;
            case ShopEvent.SHOP_MODIFY_EX:
               _loc2_ = String(Object(param1.data).callIdx);
               _loc3_ = "修改扩展属性成功，接口标记为:" + _loc2_;
               trace(_loc3_);
               break;
            case ShopEvent.SHOP_ADDFREE_SUCC:
               _loc2_ = String(Object(param1.data).callIdx);
               _loc3_ = "添加免费物品成功，接口标记为:" + _loc2_;
               trace(_loc3_);
               break;
            case ShopEvent.SHOP_UPDATEPRO_SUCC:
               _loc2_ = String(Object(param1.data).callIdx);
               _loc3_ = "修改平铺物品属性成功，接口标记为:" + _loc2_;
               trace(_loc3_);
               break;
            case ShopEvent.SHOP_GET_FREEPACKAGEINFO:
               break;
            case ShopEvent.SHOP_ADD_SUCC:
               _loc3_ = "成功购买付费物品";
               trace(_loc3_);
               break;
            case ShopEvent.SHOP_GET_TYPENOTICE:
               _loc3_ = "成功获取公告及物品分类信息";
               trace(_loc3_);
               _loc10_ = param1.data as Array;
               if(_loc10_ == null)
               {
                  break;
               }
               _loc11_ = String(_loc10_[0]);
               _loc3_ = "公告信息---->" + _loc11_;
               trace(_loc3_);
               _loc12_ = _loc10_[1] as Array;
               if(_loc12_ == null)
               {
                  break;
               }
               for(_loc23_ in _loc12_)
               {
                  _loc24_ = _loc12_[_loc23_];
                  _loc3_ = "分类id:" + _loc24_.id + "  分类名:" + _loc24_.label;
                  trace(_loc3_);
               }
               break;
            case ShopEvent.SHOP_GET_PAYPACKAGEINFO:
               _loc3_ = "成功获取了付费物品数据集!";
               trace(_loc3_);
               _loc13_ = param1.data as Array;
               if(_loc13_ == null)
               {
                  break;
               }
               _loc14_ = _loc13_.shift();
               if(_loc14_ == null)
               {
                  break;
               }
               _loc15_ = int(_loc14_.cur);
               _loc16_ = int(_loc14_.total);
               _loc17_ = int(_loc13_.length);
               trace(_loc3_);
               _loc18_ = int(_loc17_ - 1);
               _loc25_ = 0;
               while(_loc25_ < _loc17_)
               {
                  _loc26_ = _loc13_[_loc25_];
                  if(_loc26_ != null)
                  {
                     _loc3_ = "物品" + (_loc25_ + 1);
                     trace(_loc3_);
                     _loc3_ = " 物品id:" + _loc26_.id + " 价格:" + _loc26_.price;
                     _loc3_ += " 名称:" + _loc26_.title + " 图片地址:" + _loc26_.thumb;
                     _loc3_ += " 描述:" + _loc26_.description + "  限购数量:" + _loc26_.infinite;
                     trace(_loc3_);
                     Shop4399.NewShop4399();
                     if(_loc26_.keys != undefined)
                     {
                        _loc27_ = _loc26_.keys as Array;
                        if(_loc27_ != null)
                        {
                           for(_loc28_ in _loc27_)
                           {
                              _loc29_ = _loc27_[_loc28_];
                              _loc3_ = "显示-------->属性名:" + _loc29_["proName"];
                              _loc3_ += "  属性值:" + _loc29_["proValue"];
                              trace(_loc3_);
                           }
                        }
                     }
                     if(_loc26_.hideKeys != undefined)
                     {
                        _loc30_ = _loc26_.hideKeys as Array;
                        if(_loc30_ != null)
                        {
                           Shop4399.ShopArr[_loc18_ + 1] = new Array();
                           _loc28_ = VT.createVT(0);
                           _loc28_.setValue(_loc26_.price);
                           Shop4399.ShopArr[_loc18_ + 1][0] = _loc28_;
                           Shop4399.ShopArr[_loc18_ + 1][4] = _loc26_.description;
                           Shop4399.ShopArr[_loc18_ + 1][5] = _loc26_.title;
                           for(_loc31_ in _loc30_)
                           {
                              _loc32_ = _loc30_[_loc31_];
                              if(_loc32_["proName"] == "宝石类" || _loc32_["proName"] == "其他类" || _loc32_["proName"] == "时装类" || _loc32_["proName"] == "消耗类")
                              {
                                 Shop4399.ShopArr[_loc18_ + 1][1] = _loc32_["proName"];
                                 Shop4399.ShopArr[_loc18_ + 1][2] = _loc32_["proValue"];
                              }
                              else if(_loc32_["proName"] == "图片")
                              {
                                 Shop4399.ShopArr[_loc18_ + 1][3] = _loc32_["proValue"];
                              }
                           }
                        }
                     }
                     _loc18_--;
                  }
                  _loc25_++;
               }
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
         trace("网络存档失败了！");
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
            TiaoShi.txtShow("%%%%%%%%%%%%%%%% GetRankListsData  %%" + PaiMing_Arr[0][2] + "," + PaiMing_Arr[0][1] + "," + PaiMing_Arr[0][0]);
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
   }
}

