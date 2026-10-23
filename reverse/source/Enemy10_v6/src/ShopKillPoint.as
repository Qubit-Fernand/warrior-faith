package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src._data.*;
   
   public class ShopKillPoint extends MovieClip
   {
      
      public static var shopX:ShopKillPoint;
      
      public static var num:int = 1;
      
      public static var numTotal:int = 1;
      
      public static var numX:int = 6;
      
      public static var numXXX:int = 0;
      
      public static var shop_num:VT = VT.createVT();
      
      public static var shop_num2:VT = VT.createVT(1);
      
      public static var buyNum:VT = VT.createVT();
      
      public static var ShopArr:Array = new Array();
      
      public static var ShopArr2:Array = new Array();
      
      public static var ShopArr2索引:Array = new Array();
      
      public static var KaiQiShopArr2:Array = [0,true,false,false,false];
      
      public static var No_BuyNum_YN:Boolean = false;
      
      public static var No_BuyS_YN:Boolean = false;
      
      public function ShopKillPoint()
      {
         super();
         close_btn.addEventListener(MouseEvent.CLICK,CloseX);
         back_btn.addEventListener(MouseEvent.CLICK,前页);
         next_btn.addEventListener(MouseEvent.CLICK,后页);
         point_shop_btn.addEventListener(MouseEvent.CLICK,point_shop_Open);
         SelType_all.addEventListener(MouseEvent.CLICK,Sel_all);
         SelType_baoshi.addEventListener(MouseEvent.CLICK,Sel_baoshi);
         SelType_shizhuang.addEventListener(MouseEvent.CLICK,Sel_shizhuang);
         SelType_zhizuoshu.addEventListener(MouseEvent.CLICK,Sel_zhizuoshu);
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         SelType = "全部";
         Main.allClosePanel();
         NewShopKillPoint();
         Main._stage.addChild(shopX);
         shopX.Show();
         shopX.x = xx;
         shopX.y = yy;
         shopX.visible = true;
      }
      
      public static function Close() : *
      {
         if(shopX)
         {
            shopX.x = 5000;
            shopX.y = 5000;
            shopX.visible = false;
         }
      }
      
      public static function NewShopKillPoint() : *
      {
         if(!shopX)
         {
            shopX = new ShopKillPoint();
            Main._stage.addChild(shopX);
            shopX.Show2();
         }
      }
      
      public static function ShowShopX(XX:int) : *
      {
         var xxx:int = 1;
         do
         {
            xxx = Math.random() * (ShopArr2.length - 1) + 1;
         }
         while(Data_KillShop.buyArr[XX][xxx]);
         ShopArr2索引[XX] = xxx;
         shopX["shopX_" + XX].Buy_btn.addEventListener(MouseEvent.CLICK,BuyNUM2);
         shopX["shopX_" + XX].pic_mc.gotoAndStop(ShopArr2[xxx][5]);
         shopX["shopX_" + XX].name_txt.text = "" + ShopArr2[xxx][4];
         var 价格:String = "";
         if(ShopArr2[xxx][7].getValue() > 0)
         {
            价格 += ShopArr2[xxx][7].getValue() + "金币\n";
         }
         if(ShopArr2[xxx][8].getValue() > 0)
         {
            价格 += ShopArr2[xxx][8].getValue() + "击杀点";
         }
         shopX["shopX_" + XX].money_txt.text = 价格;
         shopX["shopX_" + XX].info_txt.text = "" + ShopArr2[xxx][6];
         shopX["shopX_" + XX].BuyNum_txt.text = Data_KillShop.buyArr[XX][0].getValue() + "次.";
      }
      
      public static function AddBuyNum(XX:int) : *
      {
         if(!ShopArr[num][XX])
         {
            return;
         }
         shopX["shop" + XX + "_mc"].Buy_btn.mouseEnabled = true;
         shopX["shop" + XX + "_mc"].Buy_btn.addEventListener(MouseEvent.CLICK,BuyNUM);
         shopX["shop" + XX + "_mc"].pic_mc.gotoAndStop(ShopArr[num][XX][5]);
         shopX["shop" + XX + "_mc"].name_txt.text = "" + ShopArr[num][XX][4];
         var 价格:String = "";
         if(ShopArr[num][XX][7].getValue() > 0)
         {
            价格 += ShopArr[num][XX][7].getValue() + "金币\n";
         }
         if(ShopArr[num][XX][8].getValue() > 0)
         {
            价格 += ShopArr[num][XX][8].getValue() + "击杀点";
         }
         shopX["shop" + XX + "_mc"].money_txt.text = 价格;
         shopX["shop" + XX + "_mc"].info_txt.text = "" + ShopArr[num][XX][6];
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
         WhoBuyOpen();
      }
      
      private static function BuyNUM2(e:MouseEvent) : *
      {
         var i2:int = 0;
         var X2:int = int((e.target.parent.name as String).substr(6,1));
         shop_num2.setValue(X2);
         if(shopX["shopX_" + X2]["skin"].visible)
         {
            No_BuyS_Open();
            return;
         }
         if(Data_KillShop.buyArr[shop_num2.getValue()][0].getValue() > 0)
         {
            for(i2 = 1; i2 < ShopKillPoint.ShopArr2.length + 1; i2++)
            {
               Data_KillShop.buyArr[shop_num2.getValue()][i2] = false;
            }
            WhoBuyOpen2();
         }
         else
         {
            No_BuyNum_Open();
         }
      }
      
      private static function WhoBuyOpen(e:* = null) : *
      {
         buyNum.setValue(int(shopX["shop" + shop_num.getValue() + "_mc"].BuyNum_txt.text));
         shopX.whoBuy_mc.x = shopX.whoBuy_mc.y = 0;
         shopX.whoBuy_mc.close_btn.addEventListener(MouseEvent.CLICK,WhoBuyClose);
         shopX.whoBuy_mc.pic_mc.gotoAndStop(ShopArr[num][shop_num.getValue()][5]);
         shopX.whoBuy_mc.名字.text = ShopArr[num][shop_num.getValue()][4];
         shopX.whoBuy_mc.说明.text = ShopArr[num][shop_num.getValue()][6];
         var 价格:String = "";
         if(ShopArr[num][shop_num.getValue()][7].getValue() > 0)
         {
            价格 += ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue() + "金币 ";
         }
         if(ShopArr[num][shop_num.getValue()][8].getValue() > 0)
         {
            价格 += ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue() + "击杀点";
         }
         shopX.whoBuy_mc.点券.text = 价格;
         shopX.whoBuy_mc.数量.text = buyNum.getValue();
         shopX.whoBuy_mc.P1_buy_btn.addEventListener(MouseEvent.CLICK,BuyObj);
         shopX.whoBuy_mc.P1_buy_btn.removeEventListener(MouseEvent.CLICK,BuyObj2);
         if(Main.P1P2)
         {
            shopX.whoBuy_mc.P2_buy_btn.addEventListener(MouseEvent.CLICK,BuyObj);
            shopX.whoBuy_mc.P2_buy_btn.removeEventListener(MouseEvent.CLICK,BuyObj2);
         }
         else
         {
            shopX.whoBuy_mc.P2_buy_btn.visible = false;
         }
      }
      
      private static function WhoBuyOpen2(e:* = null) : *
      {
         buyNum.setValue(1);
         shopX.whoBuy_mc.x = shopX.whoBuy_mc.y = 0;
         shopX.whoBuy_mc.close_btn.addEventListener(MouseEvent.CLICK,WhoBuyClose);
         shopX.whoBuy_mc.pic_mc.gotoAndStop(ShopArr2[ShopArr2索引[shop_num2.getValue()]][5]);
         shopX.whoBuy_mc.名字.text = ShopArr2[ShopArr2索引[shop_num2.getValue()]][4];
         shopX.whoBuy_mc.说明.text = ShopArr2[ShopArr2索引[shop_num2.getValue()]][6];
         var 价格:String = "";
         if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() > 0)
         {
            价格 += ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue() + "金币 ";
         }
         if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() > 0)
         {
            价格 += ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue() + "击杀点";
         }
         shopX.whoBuy_mc.点券.text = 价格;
         shopX.whoBuy_mc.数量.text = 1;
         shopX.whoBuy_mc.P1_buy_btn.addEventListener(MouseEvent.CLICK,BuyObj2);
         shopX.whoBuy_mc.P1_buy_btn.removeEventListener(MouseEvent.CLICK,BuyObj);
         if(Main.P1P2)
         {
            shopX.whoBuy_mc.P2_buy_btn.addEventListener(MouseEvent.CLICK,BuyObj2);
            shopX.whoBuy_mc.P2_buy_btn.removeEventListener(MouseEvent.CLICK,BuyObj);
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
         if(ShopArr[num][shop_num.getValue()][2] == "宝石类")
         {
            if((Main["player_" + who] as Player).data.getBag().canPutGemNum(ShopArr[num][shop_num.getValue()][3]) >= buyNum.getValue())
            {
               if((Main["player_" + who] as Player).data.getGold() < ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue() || (Main["player_" + who] as Player).data.killPoint.getValue() < ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + who] as Player).data.payGold(ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue());
                  (Main["player_" + who] as Player).data.killPoint.setValue((Main["player_" + who] as Player).data.killPoint.getValue() - ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue());
                  GetObj(Main["player_" + who]);
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
         else if(ShopArr[num][shop_num.getValue()][2] == "其他类")
         {
            if((Main["player_" + who] as Player).data.getBag().canPutOtherNum(ShopArr[num][shop_num.getValue()][3]) >= buyNum.getValue())
            {
               if((Main["player_" + who] as Player).data.getGold() < ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue() || (Main["player_" + who] as Player).data.killPoint.getValue() < ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + who] as Player).data.payGold(ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue());
                  (Main["player_" + who] as Player).data.killPoint.setValue((Main["player_" + who] as Player).data.killPoint.getValue() - ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue());
                  GetObj(Main["player_" + who]);
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
      }
      
      private static function BuyObj2(e:MouseEvent) : *
      {
         var who:int = int(e.target.name.substr(1,1));
         if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][2] == "宝石类")
         {
            if((Main["player_" + who] as Player).data.getBag().canPutGemNum(ShopArr2[ShopArr2索引[shop_num2.getValue()]][3]) >= buyNum.getValue())
            {
               if((Main["player_" + who] as Player).data.getGold() < ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue() || (Main["player_" + who] as Player).data.killPoint.getValue() < ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + who] as Player).data.payGold(ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue());
                  (Main["player_" + who] as Player).data.killPoint.setValue((Main["player_" + who] as Player).data.killPoint.getValue() - ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue());
                  GetObj2(Main["player_" + who]);
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
         else if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][2] == "其他类")
         {
            if((Main["player_" + who] as Player).data.getBag().canPutOtherNum(ShopArr2[ShopArr2索引[shop_num2.getValue()]][3]) >= buyNum.getValue())
            {
               if((Main["player_" + who] as Player).data.getGold() < ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue() || (Main["player_" + who] as Player).data.killPoint.getValue() < ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + who] as Player).data.payGold(ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue());
                  (Main["player_" + who] as Player).data.killPoint.setValue((Main["player_" + who] as Player).data.killPoint.getValue() - ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue());
                  GetObj2(Main["player_" + who]);
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
      }
      
      public static function GetObj(who:Player) : *
      {
         var iii:int = 0;
         var iii2:int = 0;
         if(ShopArr[num][shop_num.getValue()][2] == "宝石类")
         {
            for(iii = 0; iii < buyNum.getValue(); iii++)
            {
               who.data.getBag().addGemBag(GemFactory.creatGemById(ShopArr[num][shop_num.getValue()][3]));
            }
         }
         else if(ShopArr[num][shop_num.getValue()][2] == "其他类")
         {
            for(iii2 = 0; iii2 < buyNum.getValue(); iii2++)
            {
               who.data.getBag().addOtherobjBag(OtherFactory.creatOther(ShopArr[num][shop_num.getValue()][3]));
            }
         }
         购买成功();
         shopX.Show2();
      }
      
      public static function GetObj2(who:Player) : *
      {
         if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][2] == "宝石类")
         {
            who.data.getBag().addGemBag(GemFactory.creatGemById(ShopArr2[ShopArr2索引[shop_num2.getValue()]][3]));
         }
         else if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][2] == "其他类")
         {
            who.data.getBag().addOtherobjBag(OtherFactory.creatOther(ShopArr2[ShopArr2索引[shop_num2.getValue()]][3]));
         }
         Data_KillShop.buyArr[shop_num2.getValue()][ShopArr2索引[shop_num2.getValue()]] = true;
         (Data_KillShop.buyArr[shop_num2.getValue()][0] as VT).setValue((Data_KillShop.buyArr[shop_num2.getValue()][0] as VT).getValue() - 1);
         购买成功();
         shopX.Show2();
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
      
      private static function 金币不足() : *
      {
         shopX.金币不足_mc.x = shopX.金币不足_mc.y = 0;
         shopX.金币不足_mc.gotoAndPlay(1);
      }
      
      public static function No_BuyNum_Open(e:* = null) : *
      {
         shopX.No_BuyNum_mc.x = shopX.No_BuyNum_mc.y = 0;
         shopX.No_BuyNum_mc.buy_btn.addEventListener(MouseEvent.CLICK,No_BuyNum_BUY);
         shopX.No_BuyNum_mc.close_btn.addEventListener(MouseEvent.CLICK,No_BuyNum_BUY_Close);
      }
      
      private static function No_BuyNum_Close(e:* = null) : *
      {
         if(shopX)
         {
            shopX.No_BuyNum_mc.x = shopX.No_BuyNum_mc.y = 5000;
         }
      }
      
      private static function No_BuyNum_BUY(e:*) : *
      {
         shopX.No_BuyNum_mc.x = shopX.No_BuyNum_mc.y = 0;
         if((Shop4399.moneyAll as VT).getValue() < InitData.BuyNum_Money.getValue())
         {
            NoMoney_info_Open();
         }
         else
         {
            No_BuyNum_YN = true;
            Api_4399_All.Money_down(InitData.BuyNum_Money.getValue());
         }
      }
      
      private static function No_BuyNum_BUY_Close(e:* = null) : *
      {
         shopX.No_BuyNum_mc.x = shopX.No_BuyNum_mc.y = 5000;
      }
      
      public static function No_BuyS_Open(e:* = null) : *
      {
         shopX.No_BuyS_mc.x = shopX.No_BuyS_mc.y = 0;
         shopX.No_BuyS_mc.buy_btn.addEventListener(MouseEvent.CLICK,No_BuyS_BUY);
         shopX.No_BuyS_mc.close_btn.addEventListener(MouseEvent.CLICK,No_BuyS_Close);
      }
      
      private static function No_BuyS_Close(e:* = null) : *
      {
         shopX.No_BuyS_mc.x = shopX.No_BuyS_mc.y = 5000;
      }
      
      private static function No_BuyS_BUY(e:*) : *
      {
         shopX.No_BuyS_mc.x = shopX.No_BuyS_mc.y = 0;
         if((Shop4399.moneyAll as VT).getValue() < InitData.BuyS_Money.getValue())
         {
            NoMoney_info_Open();
         }
         else
         {
            No_BuyS_YN = true;
            Api_4399_All.Money_down(InitData.BuyS_Money.getValue());
         }
      }
      
      private static function No_BuyS_BUY_Close(e:*) : *
      {
         shopX.No_BuyS_mc.x = shopX.No_BuyS_mc.y = 5000;
      }
      
      public static function NoMoney_info_Open(e:* = null) : *
      {
         shopX.NoMoney_mc.x = shopX.NoMoney_mc.y = 0;
         shopX.NoMoney_mc.yes_btn.addEventListener(MouseEvent.CLICK,NoMoney_info_Close);
         shopX.NoMoney_mc.addMoney_btn.addEventListener(MouseEvent.CLICK,Open_AddMoney2);
      }
      
      private static function NoMoney_info_Close(e:* = null) : *
      {
         shopX.NoMoney_mc.x = shopX.NoMoney_mc.y = 5000;
      }
      
      private static function Open_AddMoney2(e:* = null) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      public static function GetBuyNum() : *
      {
         var i2:int = 0;
         if(No_BuyNum_YN)
         {
            (Data_KillShop.buyArr[shop_num2.getValue()][0] as VT).setValue(InitData.BuyNum_3.getValue());
            for(i2 = 1; i2 < ShopKillPoint.ShopArr2.length + 1; i2++)
            {
               Data_KillShop.buyArr[shop_num2.getValue()][i2] = false;
            }
            if(shopX)
            {
               shopX.Show2();
            }
            Main.Save();
            No_BuyNum_YN = false;
            No_BuyNum_Close();
         }
      }
      
      public static function GetBuyS() : *
      {
         if(No_BuyS_YN)
         {
            KaiQiShopArr2[shop_num2.getValue()] = true;
            shopX["shopX_" + shop_num2.getValue()]["skin"].visible = false;
            ShowShopX(shop_num2.getValue());
            No_BuyS_YN = false;
            No_BuyS_Close();
            Main.Save();
         }
      }
      
      private function point_shop_Open(e:*) : *
      {
         Shop4399.Open();
      }
      
      private function CloseX(e:*) : *
      {
         Close();
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
      
      private function Show() : *
      {
         for(var i:int = 1; i <= numX; i++)
         {
            RemoveBuyNum(i);
            AddBuyNum(i);
         }
         total_txt.text = num + "/" + numTotal;
         txtShow();
      }
      
      public function Show2() : *
      {
         for(var i:int = 1; i < 5; i++)
         {
            if(KaiQiShopArr2[i])
            {
               shopX["shopX_" + i]["skin"].visible = false;
            }
            ShowShopX(i);
         }
         txtShow();
      }
      
      private function txtShow() : *
      {
         point_txt.text = Shop4399.moneyAll.getValue();
         money_1_txt.text = Main.player_1.data.getGold();
         kill_1_txt.text = Main.player_1.data.killPoint.getValue();
         if(Main.P1P2)
         {
            money_2_txt.text = Main.player_2.data.getGold();
            kill_2_txt.text = Main.player_2.data.killPoint.getValue();
         }
      }
      
      private function Sel_all(e:*) : *
      {
         Data_KillShop.SelType();
         num = 1;
         shopX.Show();
      }
      
      private function Sel_baoshi(e:*) : *
      {
         Data_KillShop.SelType(1);
         num = 1;
         shopX.Show();
      }
      
      private function Sel_shizhuang(e:*) : *
      {
         Data_KillShop.SelType(2);
         num = 1;
         shopX.Show();
      }
      
      private function Sel_zhizuoshu(e:*) : *
      {
         Data_KillShop.SelType(3);
         num = 1;
         shopX.Show();
      }
   }
}

