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
      
      public static function Init(_stage:Stage) : *
      {
         PayMoneyVar.getInstance();
         _stage.addEventListener(PayEvent.LOG,onPayEventHandler,false,0,true);
         _stage.addEventListener("usePayApi",onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.INC_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.DEC_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.GET_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.PAY_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.PAIED_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.RECHARGED_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.PAY_ERROR,onPayEventHandler,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_ERROR,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_DEL_SUCC,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_GET_PACKAGEINFO,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_UPDATE_EXTEND,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_ADDFREE_SUCC,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_UPDATEPRO_SUCC,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_GET_FREEPACKAGEINFO,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_ADD_SUCC,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_GET_PAYPACKAGEINFO,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_GET_TYPENOTICE,onShopHandler2,false,0,true);
         _stage.addEventListener(ShopEvent.SHOP_MODIFY_EX,onShopHandler2,false,0,true);
         _stage.addEventListener(RankListEvent.RANKLIST_ERROR,onRankListErrorHandler);
         _stage.addEventListener(RankListEvent.RANKLIST_SUCCESS,onRankListSuccessHandler);
      }
      
      private static function logedHandler(evt:SaveEvent) : void
      {
         if(!evt.ret)
         {
         }
      }
      
      private static function onUserLogOutHandler(evt:Event) : void
      {
      }
      
      private static function onPayEventHandler(e:PayEvent) : void
      {
         var date:Object = null;
         switch(e.type)
         {
            case "logsuccess":
               Api_4399_All.getPayShow();
               break;
            case "incMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  Money_sel_Num(e.data.balance);
                  Shop4399.moneyAll.setValue(e.data.balance);
               }
               break;
            case "decMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  Money_sel_Num(e.data.balance);
                  Shop4399.moneyAll.setValue(e.data.balance);
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
               }
               break;
            case "getMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  Money_sel_Num(e.data.balance);
                  Shop4399.moneyAll.setValue(e.data.balance);
               }
               break;
            case "payMoney":
               break;
            case "paiedMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  Shop4399.totalPaiedMoney.setValue(e.data.balance);
               }
               break;
            case "rechargedMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  if(totalRecharged_Arr[0] == 0)
                  {
                     Shop4399.totalRecharged.setValue(e.data.balance);
                     Shop_LiBao.selYN = Shop_LiBao.selYN2 = false;
                  }
                  else if(totalRecharged_Arr[0] == 1)
                  {
                     Shop_LiBao.HDpoint.setValue(e.data.balance);
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
                        date = new Object();
                        date.eDate = totalDate_Arr[1];
                        Main.serviceHold.getTotalRechargedFun(date);
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
               if(e.data == null)
               {
                  break;
               }
               if((e.data.info as String).substr(0,1) == "4")
               {
                  Shop4399.NoMoney_info_Open();
               }
         }
      }
      
      private static function onShopHandler2(evt:ShopEvent) : void
      {
         var obj:Object = null;
         var getType:String = null;
         var curPage:int = 0;
         var totalPage:int = 0;
         var itemNum:int = 0;
         var exObj:Object = null;
         var tmpAry2:Array = null;
         var noticeStr:String = null;
         var typeAry:Array = null;
         var payDataAry:Array = null;
         var obj4:Object = null;
         var curPage3:int = 0;
         var totalPage3:int = 0;
         var itemNum3:int = 0;
         var mmX:* = 0;
         var i:int = 0;
         var tmpObj:Object = null;
         var j:* = undefined;
         var jj:* = undefined;
         var ee:* = undefined;
         var typeObj:Object = null;
         var mm:int = 0;
         var tmpObj5:Object = null;
         var keyAry:Array = null;
         var p:VT = null;
         var keyObj:Object = null;
         var hideKeyAry:Array = null;
         var t:* = undefined;
         var hideKeyObj:Object = null;
         var callIdx:String = "";
         var str:String = "";
         switch(evt.type)
         {
            case ShopEvent.SHOP_ERROR:
               str = "商城API错误信息------>" + String(evt.data);
               break;
            case ShopEvent.SHOP_DEL_SUCC:
               callIdx = String(Object(evt.data).callIdx);
               str = "删除物品成功，接口标记为:" + callIdx;
               break;
            case ShopEvent.SHOP_GET_PACKAGEINFO:
               str = "成功获取了背包的数据:\n";
               obj = evt.data as Object;
               if(obj == null)
               {
                  break;
               }
               getType = String(obj.getType);
               callIdx = String(obj.callIdx);
               curPage = int(obj.cur);
               totalPage = int(obj.total);
               itemNum = int(obj.itemNum);
               str = "接口标记为: " + callIdx + "当前操作来自:" + getType + "  总共有" + itemNum + "类物品  当前是第" + curPage;
               str += "页  总共有" + totalPage + "页";
               for(i = 0; i < itemNum; i++)
               {
                  tmpObj = obj["item" + i];
                  str = "物品" + (i + 1);
                  str = " 物品id:" + tmpObj.proId + " 背包id:" + tmpObj.pId + " 数量:" + tmpObj.count;
                  str += " 价格:" + tmpObj.price + " 名称:" + tmpObj.title;
                  str += " 图片地址:" + tmpObj.thumb + " 描述:" + tmpObj.description;
                  if(tmpObj.keys != undefined)
                  {
                     for(j in tmpObj.keys)
                     {
                        str = "显示----------->属性名:" + j + "  属性值:" + tmpObj.keys[j];
                     }
                  }
                  if(tmpObj.hideKeys != undefined)
                  {
                     for(jj in tmpObj.hideKeys)
                     {
                        str = "隐藏--------->属性名:" + jj + "  属性值:" + tmpObj.hideKeys[jj];
                     }
                  }
               }
               break;
            case ShopEvent.SHOP_UPDATE_EXTEND:
               str = "请设置扩展字段，你可以不填哦\n";
               exObj = evt.data as Object;
               str += "所要购买的物品id为:" + exObj.proId;
               break;
            case ShopEvent.SHOP_MODIFY_EX:
               callIdx = String(Object(evt.data).callIdx);
               str = "修改扩展属性成功，接口标记为:" + callIdx;
               break;
            case ShopEvent.SHOP_ADDFREE_SUCC:
               callIdx = String(Object(evt.data).callIdx);
               str = "添加免费物品成功，接口标记为:" + callIdx;
               break;
            case ShopEvent.SHOP_UPDATEPRO_SUCC:
               callIdx = String(Object(evt.data).callIdx);
               str = "修改平铺物品属性成功，接口标记为:" + callIdx;
               break;
            case ShopEvent.SHOP_GET_FREEPACKAGEINFO:
               break;
            case ShopEvent.SHOP_ADD_SUCC:
               str = "成功购买付费物品";
               break;
            case ShopEvent.SHOP_GET_TYPENOTICE:
               str = "成功获取公告及物品分类信息";
               tmpAry2 = evt.data as Array;
               if(tmpAry2 == null)
               {
                  break;
               }
               noticeStr = String(tmpAry2[0]);
               str = "公告信息---->" + noticeStr;
               typeAry = tmpAry2[1] as Array;
               if(typeAry == null)
               {
                  break;
               }
               for(ee in typeAry)
               {
                  typeObj = typeAry[ee];
                  str = "分类id:" + typeObj.id + "  分类名:" + typeObj.label;
               }
               break;
            case ShopEvent.SHOP_GET_PAYPACKAGEINFO:
               str = "成功获取了付费物品数据集!";
               payDataAry = evt.data as Array;
               if(payDataAry == null)
               {
                  break;
               }
               obj4 = payDataAry.shift();
               if(obj4 == null)
               {
                  break;
               }
               curPage3 = int(obj4.cur);
               totalPage3 = int(obj4.total);
               itemNum3 = int(payDataAry.length);
               mmX = int(itemNum3 - 1);
               for(mm = 0; mm < itemNum3; mm++)
               {
                  tmpObj5 = payDataAry[mm];
                  if(tmpObj5 != null)
                  {
                     str = "物品" + (mm + 1);
                     str = " 物品id:" + tmpObj5.id + " 价格:" + tmpObj5.price;
                     str += " 名称:" + tmpObj5.title + " 图片地址:" + tmpObj5.thumb;
                     str += " 描述:" + tmpObj5.description + "  限购数量:" + tmpObj5.infinite;
                     Shop4399.NewShop4399();
                     if(tmpObj5.keys != undefined)
                     {
                        keyAry = tmpObj5.keys as Array;
                        if(keyAry != null)
                        {
                           for(p in keyAry)
                           {
                              keyObj = keyAry[p];
                              str = "显示-------->属性名:" + keyObj["proName"];
                              str += "  属性值:" + keyObj["proValue"];
                           }
                        }
                     }
                     if(tmpObj5.hideKeys != undefined)
                     {
                        hideKeyAry = tmpObj5.hideKeys as Array;
                        if(hideKeyAry != null)
                        {
                           Shop4399.ShopArr[mmX + 1] = new Array();
                           p = VT.createVT(0);
                           p.setValue(tmpObj5.price);
                           Shop4399.ShopArr[mmX + 1][0] = p;
                           Shop4399.ShopArr[mmX + 1][4] = tmpObj5.description;
                           Shop4399.ShopArr[mmX + 1][5] = tmpObj5.title;
                           for(t in hideKeyAry)
                           {
                              hideKeyObj = hideKeyAry[t];
                              if(hideKeyObj["proName"] == "宝石类" || hideKeyObj["proName"] == "其他类" || hideKeyObj["proName"] == "时装类")
                              {
                                 Shop4399.ShopArr[mmX + 1][1] = hideKeyObj["proName"];
                                 Shop4399.ShopArr[mmX + 1][2] = hideKeyObj["proValue"];
                              }
                              else if(hideKeyObj["proName"] == "图片")
                              {
                                 Shop4399.ShopArr[mmX + 1][3] = hideKeyObj["proValue"];
                              }
                           }
                        }
                     }
                     mmX--;
                  }
               }
         }
      }
      
      private static function saveProcess(e:SaveEvent) : void
      {
         var data:Array = null;
         switch(e.type)
         {
            case SaveEvent.SAVE_GET:
               break;
            case SaveEvent.SAVE_SET:
               if(e.ret as Boolean == true)
               {
               }
               break;
            case SaveEvent.SAVE_LIST:
               data = e.ret as Array;
               if(data == null)
               {
               }
         }
      }
      
      private static function netSaveErrorHandler(evt:Event) : void
      {
      }
      
      public static function Money_up(num:int) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = num;
            Main.serviceHold.incMoney_As3(PayMoneyVar.instance);
         }
      }
      
      public static function Money_down(num:int) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = num;
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
      
      public static function GetTotalRecharged(type:int = 0) : *
      {
         var date:Object = null;
         if(Main.serviceHold)
         {
            totalRecharged_Arr.push(type);
            if(totalRecharged_Arr.length == 1)
            {
               if(type == 0)
               {
                  Main.serviceHold.getTotalRechargedFun();
               }
               else if(type == 1)
               {
                  date = new Object();
                  date.eDate = totalDate_Arr[type];
                  Main.serviceHold.getTotalRechargedFun(date);
               }
            }
         }
      }
      
      private static function Money_sel_Num(num:int) : *
      {
         if(Shop4399.shopX)
         {
            Shop4399.shopX.money_All_txt.text = "" + num;
         }
         if(ShopKillPoint.shopX)
         {
            ShopKillPoint.shopX.point_txt.text = "" + num;
         }
         if(xilianPanel.xlPanel)
         {
            xilianPanel.xlPanel.point_txt.text = "" + num;
         }
         if(PetPanel.petPanel)
         {
            PetPanel.petPanel.point_txt.text = "" + num;
         }
         if(ItemsPanel.itemsPanel)
         {
            ItemsPanel.itemsPanel.djPoint.text = "" + num;
         }
         if(SelMap.selMapX)
         {
            SelMap.selMapX.Sel_nanDu_mc2.x4_txt.text = "" + num;
         }
         if(WantedPanel.xsrwPanel)
         {
            WantedPanel.xsrwPanel._moneyP_txt.text = "" + num;
         }
         if(ElvesPanel.elvesPanel)
         {
            ElvesPanel.elvesPanel.dianjuan.text = "" + num;
         }
      }
      
      public static function getPayShow(e:Event = null) : *
      {
         if(Main.serviceHold)
         {
            if(Shop4399.ShopArr.length == 0)
            {
               Main.serviceHold.getPayPacInfoFun(200,1,0);
            }
         }
      }
      
      public static function GetOneRankInfo(uname:String = "", rankListId:uint = 14) : *
      {
         if(uname == "" && Boolean(Main.logName))
         {
            uname = Main.logName;
         }
         Main.serviceHold.getOneRankInfo(rankListId,uname);
      }
      
      public static function GetRankListByOwn(rankListId:uint, idx:uint, rankNum:uint) : *
      {
         Main.serviceHold.getRankListByOwn(rankListId,idx,rankNum);
      }
      
      public static function GetRankListsData(pageNum:uint = 1, pageSize:uint = 20, rankListId:uint = 14) : *
      {
         sel_PaiHang_Over = false;
         var arr:Array = [pageNum,pageSize,rankListId];
         PaiMing_Arr.push(arr);
         Main.serviceHold.getRankListsData(rankListId,pageSize,pageNum);
      }
      
      public static function SubmitScore(idx:uint, rankInfoAry:Array) : *
      {
         Main.serviceHold.submitScoreToRankLists(idx,rankInfoAry);
      }
      
      public static function GetUserData(uid:String, idx:uint) : *
      {
         var arr:Array = [uid,idx];
         GetUserData_Arr.push(arr);
         Main.serviceHold.getUserData(uid,idx);
      }
      
      public static function onRankListSuccessHandler(evt:RankListEvent) : void
      {
         var obj:Object = evt.data;
         var data:* = obj.data;
         switch(obj.apiName)
         {
            case "1":
               decodeRankListInfo1(data);
               break;
            case "2":
               decodeRankListInfo2(data);
               break;
            case "4":
               decodeRankListInfo3(data);
               break;
            case "3":
               decodeSumitScoreInfo(data);
               break;
            case "5":
               decodeUserData(data);
         }
      }
      
      public static function onRankListErrorHandler(evt:RankListEvent) : void
      {
         var obj:Object = evt.data;
         var str:String = "apiFlag:" + obj.apiName + "   errorCode:" + obj.code + "   message:" + obj.message + "\n";
         TiaoShi.ShowPaiHang(str);
      }
      
      private static function decodeUserData(dataObj:Object) : void
      {
         if(PK_UI.PK_ing == false)
         {
            GetUserData_Arr = new Array();
            return;
         }
         if(dataObj == null)
         {
            ShortTip.open(1);
            return;
         }
         var tmpStr:String = String(dataObj.data);
         var newByteArray:ByteArray = Base64.decodeToByteArray(tmpStr) as ByteArray;
         newByteArray.position = 0;
         var objXX:Object = newByteArray.readObject();
         PK_UI.playerDataArr[PK_UI.loadPlayerNum % 5] = objXX["p1"];
         PK_UI.Load_OtherPlayerData(PK_UI.loadPlayerNum);
         TiaoShi.txtShow("加载玩家完成 = " + PK_UI.loadPlayerNum);
         GetUserData_Arr.shift();
         if(GetUserData_Arr.length > 0)
         {
            GetUserData(GetUserData_Arr[0][0],GetUserData_Arr[0][1]);
            TiaoShi.txtShow("读取存档队列处理 查询后面数据" + GetUserData_Arr.length);
         }
         ShortTip.open(2);
      }
      
      private static function decodeSumitScoreInfo(dataAry:Array) : void
      {
         var i:* = undefined;
         var tmpObj:Object = null;
         var str:String = "";
         if(dataAry == null || dataAry.length == 0)
         {
            TiaoShi.ShowPaiHang("没有数据,返回结果有问题！\n");
            return;
         }
         tempArr = dataAry;
         for(i in dataAry)
         {
            tmpObj = dataAry[i];
            str += ">>>>>>>>>>第" + (i + 1) + "条数据 排行榜ID:" + tmpObj.rId + "\n信息码值:" + tmpObj.code + "\n";
            if(tmpObj.code == "10000")
            {
               str += "\n当前排名:" + tmpObj.curRank + ",当前分数:" + tmpObj.curScore + "\n上一局排名:" + tmpObj.lastRank + ",n上一局分数:" + tmpObj.lastScore + "\n";
            }
            else
            {
               str += "该排行榜提交的分数出问题了 信息:" + tmpObj.message + "\n";
            }
         }
         TiaoShi.ShowPaiHang(str);
         ShortTip.open(3);
      }
      
      private static function decodeRankListInfo1(dataAry:Array) : void
      {
         PK_UI._this.PaiHang_Show_X(dataAry);
      }
      
      private static function decodeRankListInfo3(dataAry:Array) : void
      {
         PK_UI._this.get_PaiHang_Data(dataAry,PaiMing_Arr[0][0]);
         PaiMing_Arr.shift();
         if(PaiMing_Arr.length > 0)
         {
            GetRankListsData(PaiMing_Arr[0][0],PaiMing_Arr[0][1],PaiMing_Arr[0][2]);
         }
         else
         {
            sel_PaiHang_Over = true;
         }
      }
   }
}

