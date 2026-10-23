package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.ItemsTooltip;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.tool.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5941")]
   public class Shop4399 extends MovieClip
   {
      
      public static var shopX:Shop4399;
      
      public static var tooltip:ItemsTooltip;
      
      public static var who_btn:int;
      
      public static var num:int = 1;
      
      public static var numTotal:int = 1;
      
      public static var numX:int = 6;
      
      public static var numXXX:int = 0;
      
      public static var ShopArr:Array = new Array();
      
      private static var ShopArr_Temp:Array = new Array();
      
      private static var SelType:String = "全部";
      
      private static var buyNum:VT = VT.createVT();
      
      private static var shop_num:VT = VT.createVT();
      
      public static var buyArr:Array = new Array();
      
      public static var tempObjArr:Array = new Array();
      
      public static var moneyAll:VT = VT.createVT(999999);
      
      public static var totalPaiedMoney:VT = VT.createVT(999999);
      
      public static var totalRecharged:VT = VT.createVT(999999);
      
      public static var p1p2X:int = 1;
      
      public static var SelMoneyTime:int = 0;
      
      public static var duokai_Buy:Boolean = false;
      
      public var level_1_mc:MovieClip;
      
      public var show_2:SimpleButton;
      
      public var SelType_宝石_btn:SimpleButton;
      
      public var shop3_mc:MovieClip;
      
      public var add_Money_btn:SimpleButton;
      
      public var shop1_mc:MovieClip;
      
      public var ZY_txt:TextField;
      
      public var shop6_mc:MovieClip;
      
      public var 道具已满_mc:MovieClip;
      
      public var name_txt:TextField;
      
      public var shop4_mc:MovieClip;
      
      public var money_All_txt:TextField;
      
      public var total_txt:TextField;
      
      public var shop5_mc:MovieClip;
      
      public var _BLACK_mc:游戏初始化;
      
      public var SelType_全部_btn:SimpleButton;
      
      public var KillOpen_btn:SimpleButton;
      
      public var NoMoney_mc:MovieClip;
      
      public var 购买成功_mc:MovieClip;
      
      public var Info_mc:MovieClip;
      
      public var SelType_其他_btn:SimpleButton;
      
      public var close_btn:SimpleButton;
      
      public var level_2_mc:MovieClip;
      
      public var SelType_时装_btn:SimpleButton;
      
      public var back_btn:SimpleButton;
      
      public var whoBuy_mc:购买物品提示栏;
      
      public var show_1:SimpleButton;
      
      public var next_btn:SimpleButton;
      
      public var shop2_mc:MovieClip;
      
      public function Shop4399()
      {
         super();
         Main._stage.addEventListener(Event.ACTIVATE,onACTIVATE);
         close_btn.addEventListener(MouseEvent.CLICK,CloseX);
         add_Money_btn.addEventListener(MouseEvent.CLICK,Open_AddMoney);
         SelType_全部_btn.addEventListener(MouseEvent.CLICK,Show全部);
         SelType_其他_btn.addEventListener(MouseEvent.CLICK,Show其他);
         SelType_宝石_btn.addEventListener(MouseEvent.CLICK,Show宝石);
         SelType_时装_btn.addEventListener(MouseEvent.CLICK,Show时装);
         back_btn.addEventListener(MouseEvent.CLICK,前页);
         next_btn.addEventListener(MouseEvent.CLICK,后页);
         show_1.addEventListener(MouseEvent.CLICK,Show_1P);
         if(Main.P1P2)
         {
            show_2.addEventListener(MouseEvent.CLICK,Show_2P);
         }
         KillOpen_btn.addEventListener(MouseEvent.CLICK,KillOpen);
         _BLACK_mc.visible = false;
      }
      
      public static function NewShop4399() : *
      {
         if(!shopX)
         {
            shopX = new Shop4399();
         }
      }
      
      public static function Open(param1:uint = 1, param2:int = 0, param3:int = 0) : *
      {
         Shop4399.duokai_Buy = false;
         SelType = "全部";
         Main.allClosePanel();
         NewShop4399();
         Main._stage.addChild(shopX);
         shopX.Show();
         shopX.x = param2;
         shopX.y = param3;
         shopX.visible = true;
         Shop4399.WhoBuyClose();
         shopX._BLACK_mc.visible = false;
         txtShow();
         if(param1 != 1)
         {
            num = param1;
         }
         shopX.Show();
      }
      
      public static function Close() : *
      {
         NewShop4399();
         shopX.x = 5000;
         shopX.y = 5000;
         shopX.visible = false;
      }
      
      public static function AddBuyNum(param1:int) : *
      {
         shopX["shop" + param1 + "_mc"].Buy_btn.mouseEnabled = true;
         shopX["shop" + param1 + "_mc"].Buy_btn.addEventListener(MouseEvent.CLICK,BuyNUM);
         shopX["shop" + param1 + "_mc"].pic_mc.gotoAndStop(int(ShopArr_Temp[param1 + numXXX][3]));
         shopX["shop" + param1 + "_mc"].name_txt.text = "" + ShopArr_Temp[param1 + numXXX][5];
         shopX["shop" + param1 + "_mc"].money_txt.text = "" + (ShopArr_Temp[param1 + numXXX][0] as VT).getValue() + "点券";
         shopX["shop" + param1 + "_mc"].info_txt.text = "" + ShopArr_Temp[param1 + numXXX][4];
         shopX["shop" + param1 + "_mc"].BuyNum_txt.text = "1";
         shopX["shop" + param1 + "_mc"].numUP_btn.addEventListener(MouseEvent.CLICK,BuyNUM_UP);
         shopX["shop" + param1 + "_mc"].numDOWN_btn.addEventListener(MouseEvent.CLICK,BuyNUM_DOWN);
      }
      
      public static function RemoveBuyNum(param1:int) : *
      {
         shopX["shop" + param1 + "_mc"].Buy_btn.mouseEnabled = false;
         shopX["shop" + param1 + "_mc"].Buy_btn.removeEventListener(MouseEvent.CLICK,BuyNUM);
         shopX["shop" + param1 + "_mc"].pic_mc.gotoAndStop(1);
         shopX["shop" + param1 + "_mc"].name_txt.text = "";
         shopX["shop" + param1 + "_mc"].money_txt.text = "";
         shopX["shop" + param1 + "_mc"].info_txt.text = "";
         shopX["shop" + param1 + "_mc"].BuyNum_txt.text = "";
         shopX["shop" + param1 + "_mc"].numUP_btn.removeEventListener(MouseEvent.CLICK,BuyNUM_UP);
         shopX["shop" + param1 + "_mc"].numDOWN_btn.removeEventListener(MouseEvent.CLICK,BuyNUM_DOWN);
      }
      
      private static function BuyNUM_UP(param1:MouseEvent) : *
      {
         var _loc2_:int = int((param1.target.parent.name as String).substr(4,1));
         var _loc3_:int = int(shopX["shop" + _loc2_ + "_mc"].BuyNum_txt.text);
         if(_loc3_ < 20)
         {
            shopX["shop" + _loc2_ + "_mc"].BuyNum_txt.text = "" + (_loc3_ + 1);
         }
         else
         {
            shopX["shop" + _loc2_ + "_mc"].BuyNum_txt.text = "" + 1;
         }
      }
      
      private static function BuyNUM_DOWN(param1:MouseEvent) : *
      {
         var _loc2_:int = int((param1.target.parent.name as String).substr(4,1));
         var _loc3_:int = int(shopX["shop" + _loc2_ + "_mc"].BuyNum_txt.text);
         if(_loc3_ > 1)
         {
            shopX["shop" + _loc2_ + "_mc"].BuyNum_txt.text = "" + (_loc3_ - 1);
         }
         else
         {
            shopX["shop" + _loc2_ + "_mc"].BuyNum_txt.text = "" + 20;
         }
      }
      
      private static function BuyNUM(param1:MouseEvent) : *
      {
         var _loc2_:int = int((param1.target.parent.name as String).substr(4,1)) + numXXX;
         shop_num.setValue(_loc2_);
         Shop4399.WhoBuyOpen();
      }
      
      private static function WhoBuyOpen(param1:* = null) : *
      {
         if(uint(shopX["shop" + (shop_num.getValue() - numXXX) + "_mc"].BuyNum_txt.text) <= 0)
         {
            return;
         }
         buyNum.setValue(uint(shopX["shop" + (shop_num.getValue() - numXXX) + "_mc"].BuyNum_txt.text));
         shopX.whoBuy_mc.x = shopX.whoBuy_mc.y = 0;
         shopX.whoBuy_mc.close_btn.addEventListener(MouseEvent.CLICK,WhoBuyClose);
         shopX.whoBuy_mc.P1_buy_btn.addEventListener(MouseEvent.CLICK,BuyObj_DuokaiJianCe);
         shopX.whoBuy_mc.pic_mc.gotoAndStop(ShopArr_Temp[shop_num.getValue()][3]);
         shopX.whoBuy_mc.名字.text = ShopArr_Temp[shop_num.getValue()][5];
         shopX.whoBuy_mc.说明.text = ShopArr_Temp[shop_num.getValue()][4];
         shopX.whoBuy_mc.点券.text = (ShopArr_Temp[shop_num.getValue()][0] as VT).getValue() * buyNum.getValue() + "点券";
         shopX.whoBuy_mc.数量.text = buyNum.getValue();
         if(Main.P1P2)
         {
            shopX.whoBuy_mc.P2_buy_btn.addEventListener(MouseEvent.CLICK,BuyObj_DuokaiJianCe);
         }
         else
         {
            shopX.whoBuy_mc.P2_buy_btn.visible = false;
         }
      }
      
      private static function BuyObj_DuokaiJianCe(param1:MouseEvent) : *
      {
         who_btn = int(param1.target.name.substr(1,1));
         BuyObj();
      }
      
      private static function WhoBuyClose(param1:* = null) : *
      {
         shopX.whoBuy_mc.x = shopX.whoBuy_mc.y = 5000;
      }
      
      public static function BuyObj() : *
      {
         var _loc1_:int = who_btn;
         if(ShopArr_Temp[shop_num.getValue()][1] == "宝石类")
         {
            if((Main["player_" + _loc1_] as Player).data.getBag().canPutGemNum(ShopArr_Temp[shop_num.getValue()][2].getValue()) >= buyNum.getValue())
            {
               Api_4399_All.BuyObj(ShopArr_Temp[shop_num.getValue()][7].getValue(),buyNum.getValue());
               tempObjArr[0] = Main["player_" + _loc1_];
               tempObjArr[1] = "宝石类";
               tempObjArr[2] = ShopArr_Temp[shop_num.getValue()][2];
               GetObj();
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
         else if(ShopArr_Temp[shop_num.getValue()][1] == "其他类")
         {
            if((Main["player_" + _loc1_] as Player).data.getBag().canPutOtherNum(ShopArr_Temp[shop_num.getValue()][2].getValue()) >= buyNum.getValue())
            {
               Api_4399_All.BuyObj(ShopArr_Temp[shop_num.getValue()][7].getValue(),buyNum.getValue());
               tempObjArr[0] = Main["player_" + _loc1_];
               tempObjArr[1] = "其他类";
               tempObjArr[2] = ShopArr_Temp[shop_num.getValue()][2];
               GetObj();
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
         else if(ShopArr_Temp[shop_num.getValue()][1] == "时装类")
         {
            if((Main["player_" + _loc1_] as Player).data.getBag().backequipBagNum() >= buyNum.getValue())
            {
               Api_4399_All.BuyObj(ShopArr_Temp[shop_num.getValue()][7].getValue(),buyNum.getValue());
               tempObjArr[0] = Main["player_" + _loc1_];
               tempObjArr[1] = "时装类";
               tempObjArr[2] = ShopArr_Temp[shop_num.getValue()][2];
               GetObj();
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
         else if(ShopArr_Temp[shop_num.getValue()][1] == "消耗类")
         {
            if((Main["player_" + _loc1_] as Player).data.getBag().backSuppliesBagNum() >= buyNum.getValue())
            {
               Api_4399_All.BuyObj(ShopArr_Temp[shop_num.getValue()][7].getValue(),buyNum.getValue());
               tempObjArr[0] = Main["player_" + _loc1_];
               tempObjArr[1] = "消耗类";
               tempObjArr[2] = ShopArr_Temp[shop_num.getValue()][2];
               GetObj();
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
      }
      
      public static function GetObj() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         shopX._BLACK_mc.visible = false;
         if(tempObjArr.length == 3)
         {
            if(tempObjArr[0] is Player)
            {
               if(tempObjArr[1] == "宝石类")
               {
                  _loc1_ = 0;
                  while(_loc1_ < buyNum.getValue())
                  {
                     tempObjArr[0].data.getBag().addGemBag(GemFactory.creatGemById(tempObjArr[2].getValue()));
                     _loc1_++;
                  }
               }
               else if(tempObjArr[1] == "其他类")
               {
                  _loc2_ = 0;
                  while(_loc2_ < buyNum.getValue())
                  {
                     tempObjArr[0].data.getBag().addOtherobjBag(OtherFactory.creatOther(tempObjArr[2].getValue()));
                     _loc2_++;
                  }
               }
               else if(tempObjArr[1] == "时装类")
               {
                  _loc3_ = 0;
                  while(_loc3_ < buyNum.getValue())
                  {
                     tempObjArr[0].data.getBag().addEquipBag(EquipFactory.createEquipByID(tempObjArr[2].getValue()));
                     _loc3_++;
                  }
               }
               else if(tempObjArr[1] == "消耗类")
               {
                  _loc4_ = 0;
                  while(_loc4_ < buyNum.getValue())
                  {
                     tempObjArr[0].data.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(tempObjArr[2].getValue()));
                     _loc4_++;
                  }
               }
            }
            Main.Save2();
            tempObjArr = new Array();
            购买成功();
            txtShow();
         }
      }
      
      private static function txtShow() : *
      {
         if(p1p2X == 1)
         {
            showLV(Main.player_1.data.getLevel());
         }
         else
         {
            showLV(Main.player_2.data.getLevel());
         }
      }
      
      private static function showLV(param1:Number) : *
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 < 10)
         {
            shopX["level_1_mc"].gotoAndStop(param1);
            shopX["level_2_mc"].visible = false;
         }
         else
         {
            shopX["level_2_mc"].visible = true;
            _loc2_ = param1.toString();
            _loc3_ = int(_loc2_.substring(0,1));
            _loc4_ = int(_loc2_.substring(1,2));
            shopX["level_1_mc"].gotoAndStop(_loc3_);
            if(_loc4_ == 0)
            {
               shopX["level_2_mc"].gotoAndStop(10);
            }
            else
            {
               shopX["level_2_mc"].gotoAndStop(_loc4_);
            }
         }
      }
      
      public static function NoMoney_info_Open(param1:* = null) : *
      {
         Shop4399.shopX.NoMoney_mc.x = Shop4399.shopX.NoMoney_mc.y = 0;
         Shop4399.shopX.NoMoney_mc.yes_btn.addEventListener(MouseEvent.CLICK,NoMoney_info_Close);
         Shop4399.shopX.NoMoney_mc.addMoney_btn.addEventListener(MouseEvent.CLICK,Open_AddMoney2);
      }
      
      private static function NoMoney_info_Close(param1:* = null) : *
      {
         Shop4399.shopX.NoMoney_mc.x = Shop4399.shopX.NoMoney_mc.y = 5000;
      }
      
      private static function Open_AddMoney2(param1:* = null) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      private static function 购买成功() : *
      {
         shopX.购买成功_mc.x = shopX.购买成功_mc.y = 0;
         shopX.购买成功_mc.gotoAndPlay(1);
      }
      
      private static function 道具已满() : *
      {
         shopX.道具已满_mc.x = shopX.道具已满_mc.y = 0;
         shopX.道具已满_mc.gotoAndPlay(1);
      }
      
      private function KillOpen(param1:*) : *
      {
         ShopKillPoint.Open();
      }
      
      private function Show_1P(param1:*) : *
      {
         Shop4399.p1p2X = 1;
         Shop4399.txtShow();
      }
      
      private function Show_2P(param1:*) : *
      {
         Shop4399.p1p2X = 2;
         Shop4399.txtShow();
      }
      
      public function 前页(param1:*) : *
      {
         if(num > 1)
         {
            --num;
            shopX.Show();
         }
      }
      
      public function 后页(param1:*) : *
      {
         if(num < numTotal)
         {
            ++num;
            shopX.Show();
         }
      }
      
      public function Show全部(param1:*) : *
      {
         SelType = "全部";
         num = 1;
         shopX.Show();
      }
      
      public function Show其他(param1:*) : *
      {
         SelType = "其他类";
         num = 1;
         shopX.Show();
      }
      
      public function Show宝石(param1:*) : *
      {
         SelType = "宝石类";
         num = 1;
         shopX.Show();
      }
      
      public function Show时装(param1:*) : *
      {
         SelType = "时装类";
         num = 1;
         shopX.Show();
      }
      
      private function onACTIVATE(param1:*) : *
      {
         if(shopX.visible && Shop4399.SelMoneyTime > 0)
         {
            Api_4399_All.Money_sel2();
         }
      }
      
      private function CloseX(param1:*) : *
      {
         Close();
      }
      
      public function Show() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            RemoveBuyNum(_loc1_ + 1);
            _loc1_++;
         }
         Shop4399.shopX.money_All_txt.text = moneyAll.getValue();
         TempShow();
      }
      
      private function TempShow() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         name_txt.text = Main.logName;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            if(_loc1_ == 3)
            {
               ZY_txt.text = "新手";
            }
            else if(Main["player" + p1p2X]._transferArr[_loc1_])
            {
               if(_loc1_ == 0)
               {
                  ZY_txt.text = "杀戮战神";
                  break;
               }
               if(_loc1_ == 1)
               {
                  ZY_txt.text = "汲魂术士";
                  break;
               }
               ZY_txt.text = "毁灭拳神";
               break;
            }
            _loc1_++;
         }
         ShopArr_Temp = [-1];
         for(_loc1_ in ShopArr)
         {
            if(SelType != "全部" && ShopArr[_loc1_][1] == SelType || SelType == "全部" && ShopArr[_loc1_][1] != "直接消费")
            {
               ShopArr_Temp[ShopArr_Temp.length] = DeepCopyUtil.clone(ShopArr[_loc1_]);
            }
         }
         numXXX = (num - 1) * numX;
         numTotal = int(ShopArr_Temp.length / numX);
         total_txt.text = num + "/" + numTotal;
         _loc2_ = 1;
         while(_loc2_ < numX + 1)
         {
            if(Boolean(ShopArr_Temp[_loc2_ + numXXX]) && ShopArr_Temp[_loc2_ + numXXX] != null)
            {
               AddBuyNum(_loc2_);
            }
            _loc2_++;
         }
      }
      
      private function Open_AddMoney(param1:* = null) : *
      {
         if(Main.serviceHold)
         {
            SelMoneyTime = 50000;
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
   }
}

