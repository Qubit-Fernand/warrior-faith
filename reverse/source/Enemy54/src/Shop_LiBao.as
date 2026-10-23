package src
{
   import com.*;
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import com.hotpoint.braveManIII.views.strengthenPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src._data.*;
   import src.tool.*;
   
   public class Shop_LiBao extends MovieClip
   {
      
      public static var shopX:Shop_LiBao;
      
      public static const data:Class = Shop_LiBao_data;
      
      public static const data2:Class = Shop_LiBao_data2;
      
      public static var HDpoint:VT = VT.createVT(-1);
      
      public static var selYN:Boolean = true;
      
      public static var selYN2:Boolean = false;
      
      public var myXml:XML = new XML();
      
      public var myXml2:XML = new XML();
      
      public var selGetX_Num:int = 1;
      
      private var liBaoPointArr:Array = [0,99,499,999,1999,2999,3999,4999,9999,9999,9999];
      
      public function Shop_LiBao()
      {
         var _loc1_:int = 0;
         super();
         Main._stage.addEventListener(Event.ACTIVATE,onACTIVATEx2);
         myXml = XMLAsset.createXML(Shop_LiBao.data);
         myXml2 = XMLAsset.createXML(Shop_LiBao.data2);
         Close_btn.addEventListener(MouseEvent.CLICK,CloseX);
         lingQu_btn.addEventListener(MouseEvent.CLICK,GetX);
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            this["btn_" + _loc1_].addEventListener(MouseEvent.CLICK,ShowObjArr);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ < 7)
         {
            this["pic_mc" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
         LingQu_btn_YN();
         QieHuan_btn.addEventListener(MouseEvent.CLICK,QieHuanFun);
         add_Money_btn.addEventListener(MouseEvent.CLICK,Open_AddMoney);
      }
      
      public static function NewShopX() : *
      {
         if(!shopX)
         {
            shopX = new Shop_LiBao();
         }
         Main._stage.addChild(shopX);
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         SelType = "全部";
         Main.allClosePanel();
         NewShopX();
         shopX.x = param1;
         shopX.y = param2;
         shopX.visible = true;
         shopX.Show();
      }
      
      public static function Close() : *
      {
         NewShopX();
         if(shopX)
         {
            shopX.x = 5000;
            shopX.y = 5000;
            shopX.visible = false;
         }
      }
      
      public static function JianCe() : *
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(Shop4399.totalRecharged.getValue());
         if(!shopX)
         {
            return;
         }
         if(_loc1_ < 0)
         {
            _loc2_ = 3;
            while(_loc2_ < Main.lingQueArr.length)
            {
               if(Main.lingQueArr[_loc2_] > 0)
               {
                  SelliBao();
               }
               _loc2_++;
            }
            return;
         }
         _loc2_ = 3;
         while(_loc2_ < shopX.liBaoPointArr.length)
         {
            if(Boolean(_loc1_ >= 0 && Main.lingQueArr) && Boolean(Main.lingQueArr[_loc2_] != 0) && _loc1_ < shopX.liBaoPointArr[_loc2_])
            {
               SaveXX.Save(12,_loc1_,false,false,false);
            }
            _loc2_++;
         }
      }
      
      public static function SelliBao() : *
      {
         if(selYN && Shop4399.totalRecharged.getValue() < 0)
         {
            Api_4399_All.GetTotalRecharged(1);
            Api_4399_All.GetTotalRecharged();
            selYN = false;
         }
      }
      
      public static function subString() : *
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         for(_loc1_ in Strat.SAVE_LIST)
         {
            _loc2_ = Strat.SAVE_LIST[_loc1_];
            if(_loc2_.substr(0,1) == "$")
            {
               _loc3_ = _loc2_.split("$");
               Strat.SAVE_LIST[_loc1_] = _loc3_[2];
            }
         }
      }
      
      public function Show() : *
      {
         var _loc1_:int = 0;
         var _loc3_:Array = null;
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            this["v" + _loc1_].visible = false;
            _loc1_++;
         }
         this["v" + (selGetX_Num - 1)].visible = true;
         trace("选中按钮 = " + selGetX_Num);
         var _loc2_:Array = isObjArr(selGetX_Num);
         trace("选中按钮arr = " + _loc2_);
         for(_loc1_ in _loc2_)
         {
            if(_loc2_[_loc1_] != 0)
            {
               _loc3_ = isType(_loc2_[_loc1_]);
               trace("选中按钮arr2 = = = " + _loc3_);
               this["pic_mc" + (_loc1_ + 1)].gotoAndStop(_loc3_[3]);
               this["pic_mc" + (_loc1_ + 1)].mouseChildren = false;
               this["pic_mc" + (_loc1_ + 1)].addEventListener(MouseEvent.MOUSE_OVER,onMOUSE_OVER);
               this["pic_mc" + (_loc1_ + 1)].addEventListener(MouseEvent.MOUSE_OUT,onMOUSE_OUT);
            }
            else
            {
               this["pic_mc" + (_loc1_ + 1)].gotoAndStop(1);
               this["pic_mc" + (_loc1_ + 1)].mouseChildren = false;
               this["pic_mc" + (_loc1_ + 1)].removeEventListener(MouseEvent.MOUSE_OVER,onMOUSE_OVER);
               this["pic_mc" + (_loc1_ + 1)].removeEventListener(MouseEvent.MOUSE_OUT,onMOUSE_OUT);
            }
         }
         LingQu_btn_YN();
         ShowPoint();
      }
      
      public function ShowPoint() : *
      {
         var _loc1_:int = Shop4399.totalRecharged.getValue() - Shop_LiBao.HDpoint.getValue();
         if(_loc1_ < 0)
         {
            HDpoint_txt.text = "数据查询中请稍候";
         }
         else
         {
            HDpoint_txt.text = _loc1_ + "点券";
         }
      }
      
      private function CloseX(param1:*) : *
      {
         Close();
      }
      
      private function GetX(param1:*) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         if(Boolean(isNumOK(selGetX_Num)) && Main.lingQueArr[selGetX_Num] <= 0)
         {
            _loc2_ = 1;
            while(_loc2_ < 7)
            {
               _loc3_ = int(myXml2.充值礼包[selGetX_Num - 1]["id" + _loc2_]);
               _loc4_ = int(myXml2.充值礼包[selGetX_Num - 1]["数量" + _loc2_]);
               trace("@@@ id = " + _loc3_ + "??");
               if(_loc3_ != 0)
               {
                  _loc5_ = isType(_loc3_);
                  trace("@@@ id = " + _loc3_ + " , num = " + _loc4_ + ", type = " + _loc5_);
                  _loc6_ = 0;
                  while(_loc6_ < _loc4_)
                  {
                     if(_loc5_[0] == "装备类")
                     {
                        StoragePanel.storage.addEquipStorage(EquipFactory.createEquipByID(_loc5_[1]));
                        if(Main.P1P2)
                        {
                           StoragePanel.storage.addEquipStorage(EquipFactory.createEquipByID(_loc5_[1]));
                        }
                     }
                     else if(_loc5_[0] == "宝石类")
                     {
                        StoragePanel.storage.addGemStorage(GemFactory.creatGemById(_loc5_[1]));
                     }
                     else if(_loc5_[0] == "消耗类")
                     {
                        StoragePanel.storage.addSuppliesStorage(SuppliesFactory.getSuppliesById(_loc5_[1]));
                     }
                     else if(_loc5_[0] == "其他类")
                     {
                        StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(_loc5_[1]));
                        if(Main.P1P2)
                        {
                           StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(_loc5_[1]));
                        }
                     }
                     else if(_loc5_[0] == "属性类")
                     {
                        if(_loc5_[4] == 1)
                        {
                           Main.player1.addPoint(_loc5_[5]);
                           if(Main.P1P2)
                           {
                              Main.player2.addPoint(_loc5_[5]);
                           }
                        }
                     }
                     _loc6_++;
                  }
               }
               _loc2_++;
            }
            ++Main.lingQueArr[selGetX_Num];
            ShortTip.open(44);
            LingQu_btn_YN();
         }
      }
      
      private function isNumOK(param1:int) : Boolean
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:int = int(StoragePanel.storage.backEquipEmptyNum());
         var _loc3_:int = int(StoragePanel.storage.backGemEmptyNum());
         var _loc4_:int = int(StoragePanel.storage.backSuppliesEmptyNum());
         var _loc5_:int = int(StoragePanel.storage.backOtherEmptyNum());
         for(_loc6_ in myXml.充值礼包物品)
         {
            _loc7_ = int(myXml2.充值礼包[_loc6_].格数_装备);
            _loc8_ = int(myXml2.充值礼包[_loc6_].格数_宝石);
            _loc9_ = int(myXml2.充值礼包[_loc6_].格数_消耗);
            _loc10_ = int(myXml2.充值礼包[_loc6_].格数_其他);
            if(Main.P1P2)
            {
               _loc7_ *= 2;
               _loc10_ *= 2;
            }
            _loc11_ = int(myXml.充值礼包物品[_loc6_].ID);
            if(param1 == _loc11_)
            {
               if(_loc7_ >= _loc2_)
               {
                  ShortTip.open(27);
                  return false;
               }
               if(_loc8_ >= _loc3_)
               {
                  ShortTip.open(27);
                  return false;
               }
               if(_loc9_ >= _loc4_)
               {
                  ShortTip.open(27);
                  return false;
               }
               if(_loc10_ >= _loc5_)
               {
                  ShortTip.open(27);
                  return false;
               }
               return true;
            }
         }
         return true;
      }
      
      private function isType(param1:int) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         for(_loc2_ in myXml.充值礼包物品)
         {
            _loc3_ = int(myXml.充值礼包物品[_loc2_].ID);
            if(param1 == _loc3_)
            {
               return [String(myXml.充值礼包物品[_loc2_].类型),int(myXml.充值礼包物品[_loc2_].物品ID),String(myXml.充值礼包物品[_loc2_].名称),int(myXml.充值礼包物品[_loc2_].图标),Number(myXml.充值礼包物品[_loc2_].备用1),Number(myXml.充值礼包物品[_loc2_].备用2),Number(myXml.充值礼包物品[_loc2_].备用3),String(myXml.充值礼包物品[_loc2_].说明)];
            }
         }
         return null;
      }
      
      private function isObjArr(param1:int) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         for(_loc2_ in myXml2.充值礼包)
         {
            if(param1 == myXml2.充值礼包[_loc2_].ID)
            {
               return [myXml2.充值礼包[_loc2_].id1,myXml2.充值礼包[_loc2_].id2,myXml2.充值礼包[_loc2_].id3,myXml2.充值礼包[_loc2_].id4,myXml2.充值礼包[_loc2_].id5,myXml2.充值礼包[_loc2_].id6];
            }
         }
         return null;
      }
      
      private function ShowObjArr(param1:MouseEvent) : *
      {
         selGetX_Num = int((param1.target.name as String).substr(4,1)) + 1;
         shopX.Show();
      }
      
      private function LingQu_btn_YN() : *
      {
         var _loc1_:int = Shop4399.totalRecharged.getValue() - Shop_LiBao.HDpoint.getValue();
         if(!Main.lingQueArr[selGetX_Num] && _loc1_ > liBaoPointArr[selGetX_Num])
         {
            lingQu_btn.visible = true;
         }
         else
         {
            lingQu_btn.visible = false;
         }
      }
      
      private function onMOUSE_OVER(param1:MouseEvent) : *
      {
         var _loc2_:int = int((param1.target.name as String).substr(6,1));
         objInfo(_loc2_,param1.target.x + 50,param1.target.y);
      }
      
      private function onMOUSE_OUT(param1:*) : *
      {
         _txt_infoMC.x = _txt_infoMC.y = 5000;
      }
      
      private function objInfo(param1:int, param2:int, param3:int) : *
      {
         var _loc5_:Array = null;
         _txt_infoMC.x = param2;
         _txt_infoMC.y = param3;
         var _loc4_:Array = isObjArr(selGetX_Num);
         if(_loc4_[param1 - 1] != 0)
         {
            _loc5_ = isType(_loc4_[param1 - 1]);
            _txt_infoMC._txt.text = _loc5_[2] + "\n" + _loc5_[7];
         }
      }
      
      private function onACTIVATEx2(param1:*) : *
      {
         if(this.visible && selYN2 && Shop4399.totalRecharged.getValue() < 0)
         {
            Api_4399_All.GetTotalRecharged();
         }
      }
      
      private function QieHuanFun(param1:*) : *
      {
         Main.allClosePanel();
         Shop_LiBao2.Open();
      }
      
      private function Open_AddMoney(param1:* = null) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
            selYN2 = true;
            HDpoint_txt.text = "数据查询中请稍候";
         }
      }
   }
}

