package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.ItemsTooltip;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class Shop4399 extends MovieClip
   {
      
      public static var shopX:Shop4399;
      
      public static var tooltip:ItemsTooltip;
      
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
      
      public static var moneyAll:VT = VT.createVT(-1);
      
      public static var totalPaiedMoney:VT = VT.createVT(-1);
      
      public static var totalRecharged:VT = VT.createVT(-2);
      
      public static var p1p2X:int = 1;
      
      public function Shop4399()
      {
         super();
         Main._stage.addEventListener(Event.ACTIVATE,this.onACTIVATE);
         close_btn.addEventListener(MouseEvent.CLICK,this.CloseX);
         add_Money_btn.addEventListener(MouseEvent.CLICK,this.Open_AddMoney);
         SelType_全部_btn.addEventListener(MouseEvent.CLICK,this.Show全部);
         SelType_其他_btn.addEventListener(MouseEvent.CLICK,this.Show其他);
         SelType_宝石_btn.addEventListener(MouseEvent.CLICK,this.Show宝石);
         SelType_时装_btn.addEventListener(MouseEvent.CLICK,this.Show时装);
         back_btn.addEventListener(MouseEvent.CLICK,this.前页);
         next_btn.addEventListener(MouseEvent.CLICK,this.后页);
         show_1.addEventListener(MouseEvent.CLICK,this.Show_1P);
         if(Main.P1P2)
         {
            show_2.addEventListener(MouseEvent.CLICK,this.Show_2P);
         }
         KillOpen_btn.addEventListener(MouseEvent.CLICK,this.KillOpen);
         _BLACK_mc.visible = false;
      }
      
      public static function NewShop4399() : *
      {
         if(!shopX)
         {
            shopX = new Shop4399();
         }
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         SelType = "全部";
         Main.allClosePanel();
         NewShop4399();
         Main._stage.addChild(shopX);
         shopX.Show();
         shopX.x = xx;
         shopX.y = yy;
         shopX.visible = true;
         Shop4399.WhoBuyClose();
         shopX._BLACK_mc.visible = false;
         txtShow();
      }
      
      public static function Close() : *
      {
         NewShop4399();
         shopX.x = 5000;
         shopX.y = 5000;
         shopX.visible = false;
      }
      
      public static function AddBuyNum(XX:int) : *
      {
         shopX["shop" + XX + "_mc"].Buy_btn.mouseEnabled = true;
         shopX["shop" + XX + "_mc"].Buy_btn.addEventListener(MouseEvent.CLICK,BuyNUM);
         shopX["shop" + XX + "_mc"].pic_mc.gotoAndStop(int(ShopArr_Temp[XX + numXXX][3]));
         shopX["shop" + XX + "_mc"].name_txt.text = "" + ShopArr_Temp[XX + numXXX][5];
         shopX["shop" + XX + "_mc"].money_txt.text = "" + (ShopArr_Temp[XX + numXXX][0] as VT).getValue() + "点券";
         shopX["shop" + XX + "_mc"].info_txt.text = "" + ShopArr_Temp[XX + numXXX][4];
         shopX["shop" + XX + "_mc"].BuyNum_txt.text = "1";
         shopX["shop" + XX + "_mc"].numUP_btn.addEventListener(MouseEvent.CLICK,BuyNUM_UP);
         shopX["shop" + XX + "_mc"].numDOWN_btn.addEventListener(MouseEvent.CLICK,BuyNUM_DOWN);
      }
      
      public static function RemoveBuyNum(XX:int) : *
      {
         shopX["shop" + XX + "_mc"].Buy_btn.mouseEnabled = false;
         shopX["shop" + XX + "_mc"].Buy_btn.removeEventListener(MouseEvent.CLICK,BuyNUM);
         shopX["shop" + XX + "_mc"].pic_mc.gotoAndStop(1);
         shopX["shop" + XX + "_mc"].name_txt.text = "";
         shopX["shop" + XX + "_mc"].money_txt.text = "";
         shopX["shop" + XX + "_mc"].info_txt.text = "";
         shopX["shop" + XX + "_mc"].BuyNum_txt.text = "";
         shopX["shop" + XX + "_mc"].numUP_btn.removeEventListener(MouseEvent.CLICK,BuyNUM_UP);
         shopX["shop" + XX + "_mc"].numDOWN_btn.removeEventListener(MouseEvent.CLICK,BuyNUM_DOWN);
      }
      
      private static function BuyNUM_UP(e:MouseEvent) : *
      {
         var X2:int = int((e.target.parent.name as String).substr(4,1));
         var xx:int = int(shopX["shop" + X2 + "_mc"].BuyNum_txt.text);
         if(xx < 20)
         {
            shopX["shop" + X2 + "_mc"].BuyNum_txt.text = "" + (xx + 1);
         }
         else
         {
            shopX["shop" + X2 + "_mc"].BuyNum_txt.text = "" + 1;
         }
      }
      
      private static function BuyNUM_DOWN(e:MouseEvent) : *
      {
         var X2:int = int((e.target.parent.name as String).substr(4,1));
         var xx:int = int(shopX["shop" + X2 + "_mc"].BuyNum_txt.text);
         if(xx > 1)
         {
            shopX["shop" + X2 + "_mc"].BuyNum_txt.text = "" + (xx - 1);
         }
         else
         {
            shopX["shop" + X2 + "_mc"].BuyNum_txt.text = "" + 20;
         }
      }
      
      private static function BuyNUM(e:MouseEvent) : *
      {
         var X2:int = int((e.target.parent.name as String).substr(4,1)) + numXXX;
         shop_num.setValue(X2);
         Shop4399.WhoBuyOpen();
      }
      
      private static function WhoBuyOpen(e:* = null) : *
      {
         buyNum.setValue(int(shopX["shop" + (shop_num.getValue() - numXXX) + "_mc"].BuyNum_txt.text));
         shopX.whoBuy_mc.x = shopX.whoBuy_mc.y = 0;
         shopX.whoBuy_mc.close_btn.addEventListener(MouseEvent.CLICK,WhoBuyClose);
         shopX.whoBuy_mc.P1_buy_btn.addEventListener(MouseEvent.CLICK,BuyObj);
         shopX.whoBuy_mc.pic_mc.gotoAndStop(ShopArr_Temp[shop_num.getValue()][3]);
         shopX.whoBuy_mc.名字.text = ShopArr_Temp[shop_num.getValue()][5];
         shopX.whoBuy_mc.说明.text = ShopArr_Temp[shop_num.getValue()][4];
         shopX.whoBuy_mc.点券.text = (ShopArr_Temp[shop_num.getValue()][0] as VT).getValue() * buyNum.getValue() + "点券";
         shopX.whoBuy_mc.数量.text = buyNum.getValue();
         if(Main.P1P2)
         {
            shopX.whoBuy_mc.P2_buy_btn.addEventListener(MouseEvent.CLICK,BuyObj);
         }
         else
         {
            shopX.whoBuy_mc.P2_buy_btn.visible = false;
         }
      }
      
      private static function WhoBuyClose(e:* = null) : *
      {
         shopX.whoBuy_mc.x = shopX.whoBuy_mc.y = 5000;
      }
      
      private static function BuyObj(e:MouseEvent) : *
      {
         var who:int = int(e.target.name.substr(1,1));
         if(ShopArr_Temp[shop_num.getValue()][1] == "宝石类")
         {
            if((Main["player_" + who] as Player).data.getBag().canPutGemNum(ShopArr_Temp[shop_num.getValue()][2]) >= buyNum.getValue())
            {
               if((Shop4399.moneyAll as VT).getValue() < (ShopArr_Temp[shop_num.getValue()][0] as VT).getValue() * buyNum.getValue())
               {
                  Shop4399.NoMoney_info_Open();
               }
               else
               {
                  Api_4399_All.Money_down((ShopArr_Temp[shop_num.getValue()][0] as VT).getValue() * buyNum.getValue());
                  tempObjArr[0] = Main["player_" + who];
                  tempObjArr[1] = "宝石类";
                  tempObjArr[2] = ShopArr_Temp[shop_num.getValue()][2];
                  shopX._BLACK_mc.visible = true;
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
         else if(ShopArr_Temp[shop_num.getValue()][1] == "其他类")
         {
            if((Main["player_" + who] as Player).data.getBag().canPutOtherNum(ShopArr_Temp[shop_num.getValue()][2]) >= buyNum.getValue())
            {
               if((Shop4399.moneyAll as VT).getValue() < (ShopArr_Temp[shop_num.getValue()][0] as VT).getValue() * buyNum.getValue())
               {
                  Shop4399.NoMoney_info_Open();
               }
               else
               {
                  Api_4399_All.Money_down((ShopArr_Temp[shop_num.getValue()][0] as VT).getValue() * buyNum.getValue());
                  tempObjArr[0] = Main["player_" + who];
                  tempObjArr[1] = "其他类";
                  tempObjArr[2] = ShopArr_Temp[shop_num.getValue()][2];
                  shopX._BLACK_mc.visible = true;
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
         else if(ShopArr_Temp[shop_num.getValue()][1] == "时装类")
         {
            if((Main["player_" + who] as Player).data.getBag().backequipBagNum() >= buyNum.getValue())
            {
               if((Shop4399.moneyAll as VT).getValue() < (ShopArr_Temp[shop_num.getValue()][0] as VT).getValue() * buyNum.getValue())
               {
                  Shop4399.NoMoney_info_Open();
               }
               else
               {
                  Api_4399_All.Money_down((ShopArr_Temp[shop_num.getValue()][0] as VT).getValue() * buyNum.getValue());
                  tempObjArr[0] = Main["player_" + who];
                  tempObjArr[1] = "时装类";
                  tempObjArr[2] = ShopArr_Temp[shop_num.getValue()][2];
                  shopX._BLACK_mc.visible = true;
               }
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
         var iii:int = 0;
         var iii2:int = 0;
         var iii3:int = 0;
         shopX._BLACK_mc.visible = false;
         if(tempObjArr.length == 3)
         {
            if(tempObjArr[0] is Player)
            {
               if(tempObjArr[1] == "宝石类")
               {
                  for(iii = 0; iii < buyNum.getValue(); iii++)
                  {
                     tempObjArr[0].data.getBag().addGemBag(GemFactory.creatGemById(tempObjArr[2]));
                  }
               }
               else if(tempObjArr[1] == "其他类")
               {
                  for(iii2 = 0; iii2 < buyNum.getValue(); iii2++)
                  {
                     tempObjArr[0].data.getBag().addOtherobjBag(OtherFactory.creatOther(tempObjArr[2]));
                  }
               }
               else if(tempObjArr[1] == "时装类")
               {
                  for(iii3 = 0; iii3 < buyNum.getValue(); iii3++)
                  {
                     tempObjArr[0].data.getBag().addEquipBag(EquipFactory.createEquipByID(tempObjArr[2]));
                  }
               }
            }
            Main.Save();
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
      
      private static function showLV(level:Number) : *
      {
         var str:String = null;
         var left:int = 0;
         var right:int = 0;
         if(level < 10)
         {
            shopX["level_1_mc"].gotoAndStop(level);
            shopX["level_2_mc"].visible = false;
         }
         else
         {
            shopX["level_2_mc"].visible = true;
            str = level.toString();
            left = int(str.substring(0,1));
            right = int(str.substring(1,2));
            shopX["level_1_mc"].gotoAndStop(left);
            if(right == 0)
            {
               shopX["level_2_mc"].gotoAndStop(10);
            }
            else
            {
               shopX["level_2_mc"].gotoAndStop(right);
            }
         }
      }
      
      public static function NoMoney_info_Open(e:* = null) : *
      {
         Shop4399.shopX.NoMoney_mc.x = Shop4399.shopX.NoMoney_mc.y = 0;
         Shop4399.shopX.NoMoney_mc.yes_btn.addEventListener(MouseEvent.CLICK,NoMoney_info_Close);
         Shop4399.shopX.NoMoney_mc.addMoney_btn.addEventListener(MouseEvent.CLICK,Open_AddMoney2);
      }
      
      private static function NoMoney_info_Close(e:* = null) : *
      {
         Shop4399.shopX.NoMoney_mc.x = Shop4399.shopX.NoMoney_mc.y = 5000;
      }
      
      private static function Open_AddMoney2(e:* = null) : *
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
      
      private function KillOpen(e:*) : *
      {
         ShopKillPoint.Open();
      }
      
      private function Show_1P(e:*) : *
      {
         Shop4399.p1p2X = 1;
         Shop4399.txtShow();
      }
      
      private function Show_2P(e:*) : *
      {
         Shop4399.p1p2X = 2;
         Shop4399.txtShow();
      }
      
      public function 前页(e:*) : *
      {
         if(num > 1)
         {
            --num;
            shopX.Show();
         }
      }
      
      public function 后页(e:*) : *
      {
         if(num < numTotal)
         {
            ++num;
            shopX.Show();
         }
      }
      
      public function Show全部(e:*) : *
      {
         SelType = "全部";
         num = 1;
         shopX.Show();
      }
      
      public function Show其他(e:*) : *
      {
         SelType = "其他类";
         num = 1;
         shopX.Show();
      }
      
      public function Show宝石(e:*) : *
      {
         SelType = "宝石类";
         num = 1;
         shopX.Show();
      }
      
      public function Show时装(e:*) : *
      {
         SelType = "时装类";
         num = 1;
         shopX.Show();
      }
      
      private function onACTIVATE(e:*) : *
      {
         if(shopX.visible)
         {
            Api_4399_All.Money_sel2();
         }
      }
      
      private function CloseX(e:*) : *
      {
         Close();
      }
      
      public function Show() : *
      {
         for(var i:int = 0; i < 6; i++)
         {
            RemoveBuyNum(i + 1);
         }
         if(Main.serviceHold)
         {
            if(Shop4399.ShopArr.length == 0)
            {
               Api_4399_All.getPayShow();
            }
            if(Shop4399.shopX.money_All_txt.text == "")
            {
               Api_4399_All.Money_sel();
            }
            this.TempShow();
         }
      }
      
      private function TempShow() : *
      {
         var i:int = 0;
         var i2:int = 0;
         name_txt.text = Main.logName;
         for(i = 0; i < 4; i++)
         {
            if(i == 3)
            {
               ZY_txt.text = "新手";
            }
            else if(Main["player" + p1p2X]._transferArr[i])
            {
               if(i == 0)
               {
                  ZY_txt.text = "杀戮战神";
               }
               else if(i == 1)
               {
                  ZY_txt.text = "汲魂术士";
               }
               else
               {
                  ZY_txt.text = "毁灭拳神";
               }
               break;
            }
         }
         if(SelType == "全部")
         {
            ShopArr_Temp = DeepCopyUtil.clone(ShopArr);
         }
         else
         {
            ShopArr_Temp = new Array();
            ShopArr_Temp[0] = -1;
            for(i in ShopArr)
            {
               if(ShopArr[i][1] == SelType)
               {
                  ShopArr_Temp[ShopArr_Temp.length] = DeepCopyUtil.clone(ShopArr[i]);
               }
            }
         }
         numXXX = (num - 1) * numX;
         numTotal = int(ShopArr_Temp.length / numX) + 1;
         total_txt.text = num + "/" + numTotal;
         for(i2 = 1; i2 < numX + 1; i2++)
         {
            if(Boolean(ShopArr_Temp[i2 + numXXX]) && ShopArr_Temp[i2 + numXXX] != null)
            {
               AddBuyNum(i2);
            }
         }
      }
      
      private function Open_AddMoney(e:* = null) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
   }
}

