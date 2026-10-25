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
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import com.hotpoint.braveManIII.views.strengthenPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src._data.*;
   
   public class Shop_LiBao extends MovieClip
   {
      
      public static var shopX:Shop_LiBao;
      
      public static const data:Class = Shop_LiBao_data;
      
      public static const data2:Class = Shop_LiBao_data2;
      
      public var myXml:XML = new XML();
      
      public var myXml2:XML = new XML();
      
      public var selGetX_Num:int = 1;
      
      private var liBaoPoint:VT = VT.createVT();
      
      private var liBaoPointArr:Array = [0,99,4999999,999,2000000,3000000,5000000,6000000,7000000,8000000,9000000];
      
      public function Shop_LiBao()
      {
         var i:int = 0;
         super();
         myXml = XMLAsset.createXML(Shop_LiBao.data);
         myXml2 = XMLAsset.createXML(Shop_LiBao.data2);
         Close_btn.addEventListener(MouseEvent.CLICK,CloseX);
         lingQu_btn.addEventListener(MouseEvent.CLICK,GetX);
         for(i = 0; i < 5; i++)
         {
            this["btn_" + i].addEventListener(MouseEvent.CLICK,ShowObjArr);
         }
         for(i = 1; i < 7; i++)
         {
            this["pic_mc" + i].gotoAndStop(1);
         }
         LingQu_btn_YN();
      }
      
      public static function NewShopX() : *
      {
         if(!shopX)
         {
            shopX = new Shop_LiBao();
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
         if(shopX)
         {
            shopX.x = 5000;
            shopX.y = 5000;
            shopX.visible = false;
         }
      }
      
      private function Show() : *
      {
         liBaoPoint.setValue(Shop4399.moneyAll.getValue() + Shop4399.totalPaiedMoney.getValue() - Shop4399.huoDongPaiedMoney.getValue());
         point_txt.text = liBaoPoint.getValue() + "点券";
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
         if(Boolean(isNumOK(selGetX_Num)) && !Main.lingQueArr[selGetX_Num])
         {
            for(x = 1; x < 7; x++)
            {
               id = int(myXml2.充值礼包[0]["id" + x]);
               num = int(myXml2.充值礼包[0]["数量" + x]);
               if(id != 0)
               {
                  type_And_Id = isType(id);
                  trace("@@@ id = " + id + " , num = " + num + ", type = " + type_And_Id);
                  for(y = 0; y < num; y++)
                  {
                     if(type_And_Id[0] == "装备类")
                     {
                        StoragePanel.storage.addEquipStorage(EquipFactory.createEquipByID(type_And_Id[1]));
                     }
                     if(type_And_Id[0] == "宝石类")
                     {
                        StoragePanel.storage.addGemStorage(GemFactory.creatGemById(type_And_Id[1]));
                     }
                     if(type_And_Id[0] == "消耗类")
                     {
                        StoragePanel.storage.addSuppliesStorage(SuppliesFactory.getSuppliesById(type_And_Id[1]));
                     }
                     if(type_And_Id[0] == "其他类")
                     {
                        StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(type_And_Id[1]));
                     }
                  }
               }
            }
            ++Main.lingQueArr[selGetX_Num];
            LingQu_btn_YN();
         }
      }
      
      private function isNumOK(num:int) : Boolean
      {
         var i1:int = int(StoragePanel.storage.backEquipEmptyNum());
         var i2:int = int(StoragePanel.storage.backGemEmptyNum());
         var i3:int = int(StoragePanel.storage.backSuppliesEmptyNum());
         var i4:int = int(StoragePanel.storage.backOtherEmptyNum());
         if(int(myXml2.充值礼包[num].格数_装备) >= i1)
         {
            return false;
         }
         if(int(myXml2.充值礼包[num].格数_宝石) >= i2)
         {
            return false;
         }
         if(int(myXml2.充值礼包[num].格数_消耗) >= i3)
         {
            return false;
         }
         if(int(myXml2.充值礼包[num].格数_其他) >= i4)
         {
            return false;
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
         var i:int = 0;
         var arr2:Array = null;
         selGetX_Num = int((e.target.name as String).substr(4,1)) + 1;
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
            }
            else
            {
               this["pic_mc" + (i + 1)].gotoAndStop(1);
            }
         }
         LingQu_btn_YN();
      }
      
      private function LingQu_btn_YN() : *
      {
         if(!Main.lingQueArr[selGetX_Num] && liBaoPoint.getValue() > liBaoPointArr[selGetX_Num])
         {
            lingQu_btn.visible = true;
            lingQu_btn.x = 710;
            lingQu_btn.y = 478;
         }
         else
         {
            lingQu_btn.visible = false;
            lingQu_btn.x = lingQu_btn.y = 5000;
         }
      }
   }
}

