package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
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
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         Main.DuoKai_Fun();
         SelType = "全部";
         Main.allClosePanel();
         NewShopKillPoint();
         Main._stage.addChild(shopX);
         shopX.Show();
         shopX.x = param1;
         shopX.y = param2;
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
            Data_KillShop.BuyArrInit();
         }
      }
      
      public static function ShowShopX(param1:int) : *
      {
         var _loc2_:int = 1;
         if(Data_KillShop.buyArr.length == 0)
         {
            Data_KillShop.BuyArrInit();
         }
         do
         {
            _loc2_ = Math.random() * (ShopArr2.length - 1) + 1;
         }
         while(Data_KillShop.buyArr[param1][_loc2_]);
         ShopArr2索引[param1] = _loc2_;
         shopX["shopX_" + param1].Buy_btn.addEventListener(MouseEvent.CLICK,BuyNUM2);
         shopX["shopX_" + param1].pic_mc.gotoAndStop(ShopArr2[_loc2_][5]);
         shopX["shopX_" + param1].name_txt.text = "" + ShopArr2[_loc2_][4];
         var _loc3_:String = "";
         if(ShopArr2[_loc2_][7].getValue() > 0)
         {
            _loc3_ += ShopArr2[_loc2_][7].getValue() + "金币\n";
         }
         if(ShopArr2[_loc2_][8].getValue() > 0)
         {
            _loc3_ += ShopArr2[_loc2_][8].getValue() + "击杀点";
         }
         shopX["shopX_" + param1].money_txt.text = _loc3_;
         shopX["shopX_" + param1].info_txt.text = "" + ShopArr2[_loc2_][6];
         shopX["shopX_" + param1].BuyNum_txt.text = Data_KillShop.buyArr[param1][0].getValue() + "次.";
      }
      
      public static function AddBuyNum(param1:int) : *
      {
         if(!ShopArr[num][param1])
         {
            return;
         }
         shopX["shop" + param1 + "_mc"].Buy_btn.mouseEnabled = true;
         shopX["shop" + param1 + "_mc"].Buy_btn.addEventListener(MouseEvent.CLICK,BuyNUM);
         shopX["shop" + param1 + "_mc"].pic_mc.gotoAndStop(ShopArr[num][param1][5]);
         shopX["shop" + param1 + "_mc"].name_txt.text = "" + ShopArr[num][param1][4];
         var _loc2_:String = "";
         if(ShopArr[num][param1][7].getValue() > 0)
         {
            _loc2_ += ShopArr[num][param1][7].getValue() + "金币\n";
         }
         if(ShopArr[num][param1][8].getValue() > 0)
         {
            _loc2_ += ShopArr[num][param1][8].getValue() + "击杀点";
         }
         shopX["shop" + param1 + "_mc"].money_txt.text = _loc2_;
         shopX["shop" + param1 + "_mc"].info_txt.text = "" + ShopArr[num][param1][6];
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
         WhoBuyOpen();
      }
      
      private static function BuyNUM2(param1:MouseEvent) : *
      {
         var _loc3_:int = 0;
         var _loc2_:int = int((param1.target.parent.name as String).substr(6,1));
         shop_num2.setValue(_loc2_);
         if(shopX["shopX_" + _loc2_]["skin"].visible)
         {
            No_BuyS_Open();
            return;
         }
         if(Data_KillShop.buyArr[shop_num2.getValue()][0].getValue() > 0)
         {
            _loc3_ = 1;
            while(_loc3_ < ShopKillPoint.ShopArr2.length + 1)
            {
               Data_KillShop.buyArr[shop_num2.getValue()][_loc3_] = false;
               _loc3_++;
            }
            WhoBuyOpen2();
         }
         else
         {
            No_BuyNum_Open();
         }
      }
      
      private static function WhoBuyOpen(param1:* = null) : *
      {
         if(uint(shopX["shop" + shop_num.getValue() + "_mc"].BuyNum_txt.text) <= 0)
         {
            return;
         }
         buyNum.setValue(uint(shopX["shop" + shop_num.getValue() + "_mc"].BuyNum_txt.text));
         shopX.whoBuy_mc.x = shopX.whoBuy_mc.y = 0;
         shopX.whoBuy_mc.close_btn.addEventListener(MouseEvent.CLICK,WhoBuyClose);
         shopX.whoBuy_mc.pic_mc.gotoAndStop(ShopArr[num][shop_num.getValue()][5]);
         shopX.whoBuy_mc.名字.text = ShopArr[num][shop_num.getValue()][4];
         shopX.whoBuy_mc.说明.text = ShopArr[num][shop_num.getValue()][6];
         var _loc2_:String = "";
         if(ShopArr[num][shop_num.getValue()][7].getValue() > 0)
         {
            _loc2_ += ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue() + "金币 ";
         }
         if(ShopArr[num][shop_num.getValue()][8].getValue() > 0)
         {
            _loc2_ += ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue() + "击杀点";
         }
         shopX.whoBuy_mc.点券.text = _loc2_;
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
      
      private static function WhoBuyOpen2(param1:* = null) : *
      {
         buyNum.setValue(1);
         shopX.whoBuy_mc.x = shopX.whoBuy_mc.y = 0;
         shopX.whoBuy_mc.close_btn.addEventListener(MouseEvent.CLICK,WhoBuyClose);
         shopX.whoBuy_mc.pic_mc.gotoAndStop(ShopArr2[ShopArr2索引[shop_num2.getValue()]][5]);
         shopX.whoBuy_mc.名字.text = ShopArr2[ShopArr2索引[shop_num2.getValue()]][4];
         shopX.whoBuy_mc.说明.text = ShopArr2[ShopArr2索引[shop_num2.getValue()]][6];
         var _loc2_:String = "";
         if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() > 0)
         {
            _loc2_ += ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue() + "金币 ";
         }
         if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() > 0)
         {
            _loc2_ += ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue() + "击杀点";
         }
         shopX.whoBuy_mc.点券.text = _loc2_;
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
      
      private static function WhoBuyClose(param1:* = null) : *
      {
         shopX.whoBuy_mc.x = shopX.whoBuy_mc.y = 5000;
      }
      
      private static function BuyObj(param1:MouseEvent) : *
      {
         Data_KillShop.TestData();
         var _loc2_:int = int(param1.target.name.substr(1,1));
         if(ShopArr[num][shop_num.getValue()][2] == "宝石类")
         {
            if((Main["player_" + _loc2_] as Player).data.getBag().canPutGemNum(ShopArr[num][shop_num.getValue()][3].getValue()) >= buyNum.getValue())
            {
               if((Main["player_" + _loc2_] as Player).data.getGold() < ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue() || (Main["player_" + _loc2_] as Player).data.killPoint.getValue() < ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + _loc2_] as Player).data.payGold(ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue());
                  (Main["player_" + _loc2_] as Player).data.killPoint.setValue((Main["player_" + _loc2_] as Player).data.killPoint.getValue() - ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue());
                  GetObj(Main["player_" + _loc2_]);
                  JiHua_Interface.ppp2_6 = true;
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
            if((Main["player_" + _loc2_] as Player).data.getBag().canPutOtherNum(ShopArr[num][shop_num.getValue()][3].getValue()) >= buyNum.getValue())
            {
               if((Main["player_" + _loc2_] as Player).data.getGold() < ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue() || (Main["player_" + _loc2_] as Player).data.killPoint.getValue() < ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + _loc2_] as Player).data.payGold(ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue());
                  (Main["player_" + _loc2_] as Player).data.killPoint.setValue((Main["player_" + _loc2_] as Player).data.killPoint.getValue() - ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue());
                  GetObj(Main["player_" + _loc2_]);
                  JiHua_Interface.ppp2_6 = true;
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
         else if(ShopArr[num][shop_num.getValue()][2] == "消耗品类")
         {
            if((Main["player_" + _loc2_] as Player).data.getBag().backSuppliesBagNum() >= buyNum.getValue())
            {
               if((Main["player_" + _loc2_] as Player).data.getGold() < ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue() || (Main["player_" + _loc2_] as Player).data.killPoint.getValue() < ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + _loc2_] as Player).data.payGold(ShopArr[num][shop_num.getValue()][7].getValue() * buyNum.getValue());
                  (Main["player_" + _loc2_] as Player).data.killPoint.setValue((Main["player_" + _loc2_] as Player).data.killPoint.getValue() - ShopArr[num][shop_num.getValue()][8].getValue() * buyNum.getValue());
                  GetObj(Main["player_" + _loc2_]);
                  JiHua_Interface.ppp2_6 = true;
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
      }
      
      private static function BuyObj2(param1:MouseEvent) : *
      {
         Data_KillShop.TestData();
         var _loc2_:int = int(param1.target.name.substr(1,1));
         if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][2] == "宝石类")
         {
            if((Main["player_" + _loc2_] as Player).data.getBag().canPutGemNum(ShopArr2[ShopArr2索引[shop_num2.getValue()]][3].getValue()) >= buyNum.getValue())
            {
               if((Main["player_" + _loc2_] as Player).data.getGold() < ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue() || (Main["player_" + _loc2_] as Player).data.killPoint.getValue() < ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + _loc2_] as Player).data.payGold(ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue());
                  (Main["player_" + _loc2_] as Player).data.killPoint.setValue((Main["player_" + _loc2_] as Player).data.killPoint.getValue() - ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue());
                  GetObj2(Main["player_" + _loc2_]);
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
            if((Main["player_" + _loc2_] as Player).data.getBag().canPutOtherNum(ShopArr2[ShopArr2索引[shop_num2.getValue()]][3].getValue()) >= buyNum.getValue())
            {
               if((Main["player_" + _loc2_] as Player).data.getGold() < ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue() || (Main["player_" + _loc2_] as Player).data.killPoint.getValue() < ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + _loc2_] as Player).data.payGold(ShopArr2[ShopArr2索引[shop_num2.getValue()]][7].getValue() * buyNum.getValue());
                  (Main["player_" + _loc2_] as Player).data.killPoint.setValue((Main["player_" + _loc2_] as Player).data.killPoint.getValue() - ShopArr2[ShopArr2索引[shop_num2.getValue()]][8].getValue() * buyNum.getValue());
                  GetObj2(Main["player_" + _loc2_]);
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
         else if(ShopArr[ShopArr2索引][shop_num.getValue()][2] == "消耗品类")
         {
            if((Main["player_" + _loc2_] as Player).data.getBag().backSuppliesBagNum() >= buyNum.getValue())
            {
               if((Main["player_" + _loc2_] as Player).data.getGold() < ShopArr[ShopArr2索引][shop_num.getValue()][7].getValue() * buyNum.getValue() || (Main["player_" + _loc2_] as Player).data.killPoint.getValue() < ShopArr[ShopArr2索引][shop_num.getValue()][8].getValue() * buyNum.getValue())
               {
                  金币不足();
               }
               else
               {
                  (Main["player_" + _loc2_] as Player).data.payGold(ShopArr[ShopArr2索引][shop_num.getValue()][7].getValue() * buyNum.getValue());
                  (Main["player_" + _loc2_] as Player).data.killPoint.setValue((Main["player_" + _loc2_] as Player).data.killPoint.getValue() - ShopArr[ShopArr2索引][shop_num.getValue()][8].getValue() * buyNum.getValue());
                  GetObj(Main["player_" + _loc2_]);
               }
            }
            else
            {
               道具已满();
            }
            WhoBuyClose();
         }
      }
      
      public static function GetObj(param1:Player) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(ShopArr[num][shop_num.getValue()][2] == "宝石类")
         {
            _loc2_ = 0;
            while(_loc2_ < buyNum.getValue())
            {
               param1.data.getBag().addGemBag(GemFactory.creatGemById(ShopArr[num][shop_num.getValue()][3].getValue()));
               _loc2_++;
            }
         }
         else if(ShopArr[num][shop_num.getValue()][2] == "其他类")
         {
            _loc3_ = 0;
            while(_loc3_ < buyNum.getValue())
            {
               param1.data.getBag().addOtherobjBag(OtherFactory.creatOther(ShopArr[num][shop_num.getValue()][3].getValue()));
               _loc3_++;
            }
         }
         else if(ShopArr[num][shop_num.getValue()][2] == "消耗品类")
         {
            _loc3_ = 0;
            while(_loc3_ < buyNum.getValue())
            {
               param1.data.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(ShopArr[num][shop_num.getValue()][3].getValue()));
               _loc3_++;
            }
         }
         购买成功();
         shopX.Show2();
      }
      
      public static function GetObj2(param1:Player) : *
      {
         if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][2] == "宝石类")
         {
            param1.data.getBag().addGemBag(GemFactory.creatGemById(ShopArr2[ShopArr2索引[shop_num2.getValue()]][3].getValue()));
         }
         else if(ShopArr2[ShopArr2索引[shop_num2.getValue()]][2] == "其他类")
         {
            param1.data.getBag().addOtherobjBag(OtherFactory.creatOther(ShopArr2[ShopArr2索引[shop_num2.getValue()]][3].getValue()));
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
      
      public static function No_BuyNum_Open(param1:* = null) : *
      {
         shopX.No_BuyNum_mc.x = shopX.No_BuyNum_mc.y = 0;
         shopX.No_BuyNum_mc.buy_btn.addEventListener(MouseEvent.CLICK,No_BuyNum_BUY);
         shopX.No_BuyNum_mc.close_btn.addEventListener(MouseEvent.CLICK,No_BuyNum_BUY_Close);
      }
      
      private static function No_BuyNum_Close(param1:* = null) : *
      {
         if(shopX)
         {
            shopX.No_BuyNum_mc.x = shopX.No_BuyNum_mc.y = 5000;
         }
      }
      
      private static function No_BuyNum_BUY(param1:*) : *
      {
         shopX.No_BuyNum_mc.x = shopX.No_BuyNum_mc.y = 0;
         if((Shop4399.moneyAll as VT).getValue() < InitData.BuyNum_Money.getValue())
         {
            NoMoney_info_Open();
         }
         else
         {
            No_BuyNum_YN = true;
            Api_4399_All.BuyObj(InitData.BuyNum_Money.getValue());
         }
      }
      
      private static function No_BuyNum_BUY_Close(param1:* = null) : *
      {
         shopX.No_BuyNum_mc.x = shopX.No_BuyNum_mc.y = 5000;
      }
      
      public static function No_BuyS_Open(param1:* = null) : *
      {
         shopX.No_BuyS_mc.x = shopX.No_BuyS_mc.y = 0;
         shopX.No_BuyS_mc.buy_btn.addEventListener(MouseEvent.CLICK,No_BuyS_BUY);
         shopX.No_BuyS_mc.close_btn.addEventListener(MouseEvent.CLICK,No_BuyS_Close);
      }
      
      private static function No_BuyS_Close(param1:* = null) : *
      {
         shopX.No_BuyS_mc.x = shopX.No_BuyS_mc.y = 5000;
      }
      
      private static function No_BuyS_BUY(param1:*) : *
      {
         shopX.No_BuyS_mc.x = shopX.No_BuyS_mc.y = 0;
         if((Shop4399.moneyAll as VT).getValue() < InitData.BuyS_Money.getValue())
         {
            NoMoney_info_Open();
         }
         else
         {
            No_BuyS_YN = true;
            Api_4399_All.BuyObj(InitData.BuyS_Money.getValue());
         }
      }
      
      private static function No_BuyS_BUY_Close(param1:*) : *
      {
         shopX.No_BuyS_mc.x = shopX.No_BuyS_mc.y = 5000;
      }
      
      public static function NoMoney_info_Open(param1:* = null) : *
      {
         shopX.NoMoney_mc.x = shopX.NoMoney_mc.y = 0;
         shopX.NoMoney_mc.yes_btn.addEventListener(MouseEvent.CLICK,NoMoney_info_Close);
         shopX.NoMoney_mc.addMoney_btn.addEventListener(MouseEvent.CLICK,Open_AddMoney2);
      }
      
      private static function NoMoney_info_Close(param1:* = null) : *
      {
         shopX.NoMoney_mc.x = shopX.NoMoney_mc.y = 5000;
      }
      
      private static function Open_AddMoney2(param1:* = null) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      public static function GetBuyNum() : *
      {
         var _loc1_:int = 0;
         if(No_BuyNum_YN)
         {
            (Data_KillShop.buyArr[shop_num2.getValue()][0] as VT).setValue(InitData.BuyNum_3.getValue());
            _loc1_ = 1;
            while(_loc1_ < ShopKillPoint.ShopArr2.length + 1)
            {
               Data_KillShop.buyArr[shop_num2.getValue()][_loc1_] = false;
               _loc1_++;
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
      
      private function point_shop_Open(param1:*) : *
      {
         Shop4399.Open();
      }
      
      private function CloseX(param1:*) : *
      {
         Close();
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
      
      private function Show() : *
      {
         var _loc1_:int = 1;
         while(_loc1_ <= numX)
         {
            RemoveBuyNum(_loc1_);
            AddBuyNum(_loc1_);
            _loc1_++;
         }
         total_txt.text = num + "/" + numTotal;
         txtShow();
      }
      
      public function Show2() : *
      {
         var _loc1_:int = 1;
         while(_loc1_ < 5)
         {
            if(KaiQiShopArr2[_loc1_])
            {
               shopX["shopX_" + _loc1_]["skin"].visible = false;
            }
            ShowShopX(_loc1_);
            _loc1_++;
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
      
      private function Sel_all(param1:*) : *
      {
         Data_KillShop.SelType();
         num = 1;
         shopX.Show();
      }
      
      private function Sel_baoshi(param1:*) : *
      {
         Data_KillShop.SelType(1);
         num = 1;
         shopX.Show();
      }
      
      private function Sel_shizhuang(param1:*) : *
      {
         Data_KillShop.SelType(2);
         num = 1;
         shopX.Show();
      }
      
      private function Sel_zhizuoshu(param1:*) : *
      {
         Data_KillShop.SelType(3);
         num = 1;
         shopX.Show();
      }
   }
}

