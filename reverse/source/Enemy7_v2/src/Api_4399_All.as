package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   import unit4399.events.*;
   
   public class Api_4399_All
   {
      
      public function Api_4399_All()
      {
         super();
      }
      
      public static function OpenShop(e:Event = null) : *
      {
         if(Main.serviceHold)
         {
            Main.serviceHold.showShopUi();
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
      
      private static function logedHandler(evt:SaveEvent) : void
      {
         if(!evt.ret)
         {
         }
      }
      
      private static function Money_sel_Num(num:int) : *
      {
         Shop4399.shopX.money_All_txt.text = "" + num;
      }
      
      public static function showLogUi(e:Event = null) : void
      {
         if(Main.serviceHold)
         {
            Main.serviceHold.showLogPanel();
         }
      }
      
      public static function getPayShow(e:Event = null) : *
      {
         if(Main.serviceHold)
         {
            if(Shop4399.ShopArr.length == 0)
            {
               Main.serviceHold.getPayPacInfoFun(50,1,0);
               Main._this.Info_txt.text += "\n查询收费物品";
            }
         }
      }
      
      public static function Init(_stage:Stage) : *
      {
         Main._this.Info_txt.text += "商城初始化";
         PayMoneyVar.getInstance();
         Api_4399_All.getPayShow();
         _stage.addEventListener(PayEvent.LOG,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.INC_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.DEC_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.GET_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.PAY_MONEY,onPayEventHandler,false,0,true);
         _stage.addEventListener(PayEvent.PAIED_MONEY,onPayEventHandler,false,0,true);
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
      
      private static function onUserLogOutHandler(evt:Event) : void
      {
      }
      
      public static function Money_sel2(e:Event = null) : *
      {
         if(Main.serviceHold)
         {
            Main.serviceHold.getBalance();
         }
      }
      
      private static function onPayEventHandler(e:PayEvent) : void
      {
         trace("支付事件类型--------->" + e.type + "  e.data is Boolean------>" + (e.data is Boolean));
         switch(e.type)
         {
            case "logsuccess":
               trace("登录成功------>uid:" + e.data.uid + "  name:" + e.data.name);
               break;
            case "incMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  trace("增加游戏币后的余额为:" + e.data.balance);
                  Money_sel_Num(e.data.balance);
                  break;
               }
               trace("增加游戏币错误！");
               break;
            case "decMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  trace("减少游戏币后的余额为:" + e.data.balance);
                  Main._this.Info_txt.text += "\n减少游戏币后的余额为:>>>>>>>>>>>>>>>>>>>>>>" + e.data.balance;
                  Money_sel_Num(e.data.balance);
                  Shop4399.moneyAll.setValue(e.data.balance);
                  Shop4399.GetObj();
                  break;
               }
               trace("减少游戏币错误！");
               break;
            case "getMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  trace("获取游戏币余额为:" + e.data.balance);
                  Main._this.Info_txt.text += "\n游戏币余额为 = " + e.data.balance;
                  Money_sel_Num(e.data.balance);
                  Shop4399.moneyAll.setValue(e.data.balance);
                  break;
               }
               trace("获取游戏币余额错误");
               break;
            case "payMoney":
               trace("充值游戏币失败");
               break;
            case "paiedMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  trace("获取累积消费的游戏币为:" + e.data.balance);
                  break;
               }
               trace("获取累积消费的游戏币错误！");
               break;
            case "payError":
               if(e.data == null)
               {
                  break;
               }
               trace("使用支付接口其他错误----->" + e.data.info);
               Main._this.Info_txt.text += "\n使用支付接口其他错误----->>>>>>>>>>>>>>>>>>>>>>" + e.data.info;
               if((e.data.info as String).substr(0,1) == "4")
               {
                  Shop4399.NoMoney_info_Open();
               }
         }
      }
      
      public static function Money_sel(e:Event = null) : *
      {
         if(Main.serviceHold)
         {
            if(Shop4399.shopX.money_All_txt.text == "")
            {
               Main.serviceHold.getBalance();
            }
         }
      }
      
      private static function netSaveErrorHandler(evt:Event) : void
      {
         trace("网络存档失败了！");
      }
      
      private static function onShopHandler2(evt:ShopEvent) : void
      {
         var callIdx:String = null;
         var str:String = null;
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
         callIdx = "";
         str = "";
         switch(evt.type)
         {
            case ShopEvent.SHOP_ERROR:
               str = "商城API错误信息------>" + String(evt.data);
               trace(str);
               break;
            case ShopEvent.SHOP_DEL_SUCC:
               callIdx = String(Object(evt.data).callIdx);
               str = "删除物品成功，接口标记为:" + callIdx;
               trace(str);
               break;
            case ShopEvent.SHOP_GET_PACKAGEINFO:
               str = "成功获取了背包的数据:\n";
               trace(str);
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
               trace(str);
               for(i = 0; i < itemNum; i++)
               {
                  tmpObj = obj["item" + i];
                  str = "物品" + (i + 1);
                  trace(str);
                  str = " 物品id:" + tmpObj.proId + " 背包id:" + tmpObj.pId + " 数量:" + tmpObj.count;
                  str += " 价格:" + tmpObj.price + " 名称:" + tmpObj.title;
                  str += " 图片地址:" + tmpObj.thumb + " 描述:" + tmpObj.description;
                  trace(str);
                  if(tmpObj.keys != undefined)
                  {
                     for(j in tmpObj.keys)
                     {
                        str = "显示----------->属性名:" + j + "  属性值:" + tmpObj.keys[j];
                        trace(str);
                     }
                  }
                  if(tmpObj.hideKeys != undefined)
                  {
                     for(jj in tmpObj.hideKeys)
                     {
                        str = "隐藏--------->属性名:" + jj + "  属性值:" + tmpObj.hideKeys[jj];
                        trace(str);
                     }
                  }
               }
               break;
            case ShopEvent.SHOP_UPDATE_EXTEND:
               str = "请设置扩展字段，你可以不填哦\n";
               exObj = evt.data as Object;
               str += "所要购买的物品id为:" + exObj.proId;
               trace(str);
               break;
            case ShopEvent.SHOP_MODIFY_EX:
               callIdx = String(Object(evt.data).callIdx);
               str = "修改扩展属性成功，接口标记为:" + callIdx;
               trace(str);
               break;
            case ShopEvent.SHOP_ADDFREE_SUCC:
               callIdx = String(Object(evt.data).callIdx);
               str = "添加免费物品成功，接口标记为:" + callIdx;
               trace(str);
               break;
            case ShopEvent.SHOP_UPDATEPRO_SUCC:
               callIdx = String(Object(evt.data).callIdx);
               str = "修改平铺物品属性成功，接口标记为:" + callIdx;
               trace(str);
               break;
            case ShopEvent.SHOP_GET_FREEPACKAGEINFO:
               break;
            case ShopEvent.SHOP_ADD_SUCC:
               str = "成功购买付费物品";
               Main._this.Info_txt.text += "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>成功购买付费物品";
               trace(str);
               break;
            case ShopEvent.SHOP_GET_TYPENOTICE:
               str = "成功获取公告及物品分类信息";
               trace(str);
               tmpAry2 = evt.data as Array;
               if(tmpAry2 == null)
               {
                  break;
               }
               noticeStr = String(tmpAry2[0]);
               str = "公告信息---->" + noticeStr;
               trace(str);
               typeAry = tmpAry2[1] as Array;
               if(typeAry == null)
               {
                  break;
               }
               for(ee in typeAry)
               {
                  typeObj = typeAry[ee];
                  str = "分类id:" + typeObj.id + "  分类名:" + typeObj.label;
                  trace(str);
               }
               break;
            case ShopEvent.SHOP_GET_PAYPACKAGEINFO:
               str = "成功获取了付费物品数据集!";
               Main._this.Info_txt.text += "成功获取了付费物品数据集!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!!";
               trace(str);
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
               Main._this.Info_txt.text += "\n\n\n >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  总共有" + itemNum3 + "类物品  当前是第" + curPage3 + "页  总共有" + totalPage3 + "页\n\n";
               trace(str);
               for(mm = 0; mm < itemNum3; mm++)
               {
                  tmpObj5 = payDataAry[mm];
                  if(tmpObj5 != null)
                  {
                     str = "物品" + (mm + 1);
                     trace(str);
                     str = " 物品id:" + tmpObj5.id + " 价格:" + tmpObj5.price;
                     str += " 名称:" + tmpObj5.title + " 图片地址:" + tmpObj5.thumb;
                     str += " 描述:" + tmpObj5.description + "  限购数量:" + tmpObj5.infinite;
                     trace(str);
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
                              trace(str);
                           }
                        }
                     }
                     if(tmpObj5.hideKeys != undefined)
                     {
                        hideKeyAry = tmpObj5.hideKeys as Array;
                        if(hideKeyAry != null)
                        {
                           Shop4399.ShopArr[mm + 1] = new Array();
                           p = VT.createVT(0);
                           p.setValue(tmpObj5.price);
                           Shop4399.ShopArr[mm + 1][0] = p;
                           Shop4399.ShopArr[mm + 1][4] = tmpObj5.description;
                           Shop4399.ShopArr[mm + 1][5] = tmpObj5.title;
                           for(t in hideKeyAry)
                           {
                              hideKeyObj = hideKeyAry[t];
                              if(hideKeyObj["proName"] == "宝石类" || hideKeyObj["proName"] == "其他类")
                              {
                                 Shop4399.ShopArr[mm + 1][1] = hideKeyObj["proName"];
                                 Shop4399.ShopArr[mm + 1][2] = hideKeyObj["proValue"];
                              }
                              else if(hideKeyObj["proName"] == "图片")
                              {
                                 Shop4399.ShopArr[mm + 1][3] = hideKeyObj["proValue"];
                                 Main._this.Info_txt.text += "\n图片" + Shop4399.ShopArr[mm + 1][3];
                              }
                           }
                        }
                     }
                  }
               }
         }
      }
      
      private static function closePanelHandler(e:Event) : void
      {
         var logInfo:Object = null;
         logInfo = Main.serviceHold.isLog;
         if(logInfo == null)
         {
            showLogUi();
         }
      }
   }
}

