package src
{
   import com.*;
   import com.hotpoint.braveManIII.Tool.*;
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
   
   public class Shop_LiBao2 extends MovieClip
   {
      
      public static var shopX:Shop_LiBao2;
      
      public static const data:Class = Shop_LiBao2_data;
      
      public static const data2:Class = Shop_LiBao2_data2;
      
      public var myXml:XML = new XML();
      
      public var myXml2:XML = new XML();
      
      public var selGetX_Num:int = 1;
      
      private var liBaoPointArr:Array = [0,9,249,1499,2799,4499,6499,8499,8499,8499,8499];
      
      public function Shop_LiBao2()
      {
         var i:int = 0;
         super();
         Main._stage.addEventListener(Event.ACTIVATE,onACTIVATEx2);
         myXml = XMLAsset.createXML(Shop_LiBao2.data);
         myXml2 = XMLAsset.createXML(Shop_LiBao2.data2);
         Close_btn.addEventListener(MouseEvent.CLICK,CloseX);
         lingQu_btn.addEventListener(MouseEvent.CLICK,GetX);
         for(i = 0; i < 7; i++)
         {
            this["btn_" + i].addEventListener(MouseEvent.CLICK,ShowObjArr);
         }
         for(i = 1; i < 7; i++)
         {
            this["pic_mc" + i].gotoAndStop(1);
         }
         LingQu_btn_YN();
         QieHuan_btn.addEventListener(MouseEvent.CLICK,QieHuanFun);
         add_Money_btn.addEventListener(MouseEvent.CLICK,Open_AddMoney);
      }
      
      public static function NewShopX() : *
      {
         if(!shopX)
         {
            shopX = new Shop_LiBao2();
         }
         Main._stage.addChild(shopX);
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         SelType = "全部";
         Main.allClosePanel();
         NewShopX();
         shopX.x = xx;
         shopX.y = yy;
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
         var xx:int = int(Shop4399.totalRecharged.getValue());
         if(!shopX || xx < 0)
         {
            return;
         }
         for(var i:int = 1; i < shopX.liBaoPointArr.length; i++)
         {
            if(Boolean(Main.lingQueArr2) && Boolean(Main.lingQueArr2[i] != 0) && xx < shopX.liBaoPointArr[i])
            {
               Main.NoGame();
            }
         }
      }
      
      public function Show() : *
      {
         var i:int = 0;
         var arr2:Array = null;
         for(i = 0; i < 10; i++)
         {
            this["v" + i].visible = false;
         }
         this["v" + (selGetX_Num - 1)].visible = true;
         trace("选中按钮 = " + selGetX_Num);
         var arr:Array = isObjArr(selGetX_Num);
         trace("选中按钮arr = " + arr);
         for(i in arr)
         {
            if(arr[i] != 0)
            {
               arr2 = isType(arr[i]);
               trace("选中按钮arr2 = = = " + arr2);
               this["pic_mc" + (i + 1)].gotoAndStop(arr2[3]);
               this["pic_mc" + (i + 1)].mouseChildren = false;
               this["pic_mc" + (i + 1)].addEventListener(MouseEvent.MOUSE_OVER,onMOUSE_OVER);
               this["pic_mc" + (i + 1)].addEventListener(MouseEvent.MOUSE_OUT,onMOUSE_OUT);
            }
            else
            {
               this["pic_mc" + (i + 1)].gotoAndStop(1);
               this["pic_mc" + (i + 1)].mouseChildren = false;
               this["pic_mc" + (i + 1)].removeEventListener(MouseEvent.MOUSE_OVER,onMOUSE_OVER);
               this["pic_mc" + (i + 1)].removeEventListener(MouseEvent.MOUSE_OUT,onMOUSE_OUT);
            }
         }
         LingQu_btn_YN();
         ShowPoint();
      }
      
      public function ShowPoint() : *
      {
         var xx:int = int(Shop4399.totalRecharged.getValue());
         if(xx < 0)
         {
            HDpoint_txt.text = "数据查询中请稍候";
         }
         else
         {
            HDpoint_txt.text = xx + "点券";
         }
      }
      
      private function CloseX(e:*) : *
      {
         Close();
      }
      
      private function GetX(e:*) : *
      {
         var x:int = 0;
         var id:int = 0;
         var num:int = 0;
         var type_And_Id:Array = null;
         var y:int = 0;
         if(Boolean(isNumOK(selGetX_Num)) && Main.lingQueArr2[selGetX_Num] <= 0)
         {
            for(x = 1; x < 7; x++)
            {
               id = int(myXml2.充值礼包[selGetX_Num - 1]["id" + x]);
               num = int(myXml2.充值礼包[selGetX_Num - 1]["数量" + x]);
               trace("@@@ id = " + id + "??");
               if(id != 0)
               {
                  type_And_Id = isType(id);
                  trace("@@@ id = " + id + " , num = " + num + ", type = " + type_And_Id);
                  for(y = 0; y < num; y++)
                  {
                     if(type_And_Id[0] == "装备类")
                     {
                        StoragePanel.storage.addEquipStorage(EquipFactory.createEquipByID(type_And_Id[1]));
                        if(Main.P1P2)
                        {
                           StoragePanel.storage.addEquipStorage(EquipFactory.createEquipByID(type_And_Id[1]));
                        }
                     }
                     else if(type_And_Id[0] == "宝石类")
                     {
                        StoragePanel.storage.addGemStorage(GemFactory.creatGemById(type_And_Id[1]));
                     }
                     else if(type_And_Id[0] == "消耗类")
                     {
                        StoragePanel.storage.addSuppliesStorage(SuppliesFactory.getSuppliesById(type_And_Id[1]));
                     }
                     else if(type_And_Id[0] == "其他类")
                     {
                        StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(type_And_Id[1]));
                        if(Main.P1P2)
                        {
                           StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(type_And_Id[1]));
                        }
                     }
                     else if(type_And_Id[0] == "属性类")
                     {
                        if(type_And_Id[4] == 1)
                        {
                           Main.player1.addPoint(type_And_Id[5]);
                           if(Main.P1P2)
                           {
                              Main.player2.addPoint(type_And_Id[5]);
                           }
                        }
                     }
                  }
               }
            }
            ++Main.lingQueArr2[selGetX_Num];
            ShortTip.open(44);
            LingQu_btn_YN();
         }
      }
      
      private function isNumOK(id:int) : Boolean
      {
         var i:int = 0;
         var 装备数量:int = 0;
         var 宝石数量:int = 0;
         var 消耗数量:int = 0;
         var 其他数量:int = 0;
         var idX:int = 0;
         var i1:int = int(StoragePanel.storage.backEquipEmptyNum());
         var i2:int = int(StoragePanel.storage.backGemEmptyNum());
         var i3:int = int(StoragePanel.storage.backSuppliesEmptyNum());
         var i4:int = int(StoragePanel.storage.backOtherEmptyNum());
         for(i in myXml.充值礼包物品)
         {
            装备数量 = int(myXml2.充值礼包[i].格数_装备);
            宝石数量 = int(myXml2.充值礼包[i].格数_宝石);
            消耗数量 = int(myXml2.充值礼包[i].格数_消耗);
            其他数量 = int(myXml2.充值礼包[i].格数_其他);
            if(Main.P1P2)
            {
               装备数量 *= 2;
               其他数量 *= 2;
            }
            idX = int(myXml.充值礼包物品[i].ID);
            if(id == idX)
            {
               if(装备数量 >= i1)
               {
                  ShortTip.open(27);
                  return false;
               }
               if(宝石数量 >= i2)
               {
                  ShortTip.open(27);
                  return false;
               }
               if(消耗数量 >= i3)
               {
                  ShortTip.open(27);
                  return false;
               }
               if(其他数量 >= i4)
               {
                  ShortTip.open(27);
                  return false;
               }
               return true;
            }
         }
         return true;
      }
      
      private function isType(id:int) : Array
      {
         var i:int = 0;
         var idX:int = 0;
         var arr:Array = null;
         for(i in myXml.充值礼包物品)
         {
            idX = int(myXml.充值礼包物品[i].ID);
            if(id == idX)
            {
               return [String(myXml.充值礼包物品[i].类型),int(myXml.充值礼包物品[i].物品ID),String(myXml.充值礼包物品[i].名称),int(myXml.充值礼包物品[i].图标),Number(myXml.充值礼包物品[i].备用1),Number(myXml.充值礼包物品[i].备用2),Number(myXml.充值礼包物品[i].备用3),String(myXml.充值礼包物品[i].说明)];
            }
         }
         return null;
      }
      
      private function isObjArr(id:int) : Array
      {
         var i:int = 0;
         var arr:Array = null;
         for(i in myXml2.充值礼包)
         {
            if(id == myXml2.充值礼包[i].ID)
            {
               return [myXml2.充值礼包[i].id1,myXml2.充值礼包[i].id2,myXml2.充值礼包[i].id3,myXml2.充值礼包[i].id4,myXml2.充值礼包[i].id5,myXml2.充值礼包[i].id6];
            }
         }
         return null;
      }
      
      private function ShowObjArr(e:MouseEvent) : *
      {
         selGetX_Num = int((e.target.name as String).substr(4,1)) + 1;
         shopX.Show();
      }
      
      private function LingQu_btn_YN() : *
      {
         var xx:int = int(Shop4399.totalRecharged.getValue());
         if(!Main.lingQueArr2[selGetX_Num] && xx > liBaoPointArr[selGetX_Num])
         {
            lingQu_btn.visible = true;
         }
         else
         {
            lingQu_btn.visible = false;
         }
      }
      
      private function onMOUSE_OVER(e:MouseEvent) : *
      {
         var i:int = int((e.target.name as String).substr(6,1));
         objInfo(i,e.target.x + 50,e.target.y);
      }
      
      private function onMOUSE_OUT(e:*) : *
      {
         _txt_infoMC.x = _txt_infoMC.y = 5000;
      }
      
      private function objInfo(num:int, xx:int, yy:int) : *
      {
         var arr2:Array = null;
         _txt_infoMC.x = xx;
         _txt_infoMC.y = yy;
         var arr:Array = isObjArr(selGetX_Num);
         if(arr[num - 1] != 0)
         {
            arr2 = isType(arr[num - 1]);
            _txt_infoMC._txt.text = arr2[2] + "\n" + arr2[7];
         }
      }
      
      private function onACTIVATEx2(e:*) : *
      {
         if(this.visible && Boolean(Shop_LiBao.selYN2) && Shop4399.totalRecharged.getValue() < 0)
         {
            Api_4399_All.GetTotalRecharged();
         }
      }
      
      private function QieHuanFun(e:*) : *
      {
         Main.allClosePanel();
         Shop_LiBao.Open();
      }
      
      private function Open_AddMoney(e:* = null) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
            Shop_LiBao.selYN2 = true;
            HDpoint_txt.text = "数据查询中请稍候";
         }
      }
   }
}

