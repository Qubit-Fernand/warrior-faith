package src.npc
{
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
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   import src._data.*;
   
   public class All_Npc
   {
      
      private static var objArr:Array = [0,63108,63109,63110,63111];
      
      public function All_Npc()
      {
         super();
      }
      
      public static function NpcGetPlayerObj(XXX:int) : *
      {
         var arr:Array = null;
         var i1:int = 0;
         var x1:int = 0;
         var i2:int = 0;
         var i3:int = 0;
         var i5:int = 0;
         if(!selChiYuan(XXX))
         {
            ShortTip.open(27);
            return;
         }
         if(InitData.qinMiDu_Max_Arr[XXX].getValue() <= InitData.qinMiDu_Arr[XXX].getValue())
         {
            arr = All_Npc.get_Obj_And_ObjId(XXX);
            if(Boolean(arr) && arr[0] == 6)
            {
               if(arr[1] == 101)
               {
                  Main.player_1.MoneyUP(arr[2]);
                  if(Main.P1P2)
                  {
                     Main.player_2.MoneyUP(arr[2]);
                  }
                  JinMiDu_Down(XXX);
               }
               if(arr[1] == 102)
               {
                  Main.player1.addPoint(arr[2]);
                  if(Main.P1P2)
                  {
                     Main.player2.addPoint(arr[2]);
                  }
                  JinMiDu_Down(XXX);
               }
            }
            else if(Boolean(arr) && arr[0] == 1)
            {
               i1 = int(StoragePanel.storage.backEquipEmptyNum());
               if(i1 >= arr[2])
               {
                  for(x1 = 0; x1 < arr[2]; x1++)
                  {
                     StoragePanel.storage.addEquipStorage(EquipFactory.createEquipByID(arr[1]));
                  }
                  JinMiDu_Down(XXX);
                  ShortTip.open(28);
               }
               else
               {
                  ShortTip.open(27);
               }
            }
            else if(Boolean(arr) && arr[0] == 2)
            {
               i2 = int(StoragePanel.storage.canPutGemNum(arr[1]));
               if(i2 >= arr[2])
               {
                  for(x1 = 0; x1 < arr[2]; x1++)
                  {
                     StoragePanel.storage.addGemStorage(GemFactory.creatGemById(arr[1]));
                  }
                  JinMiDu_Down(XXX);
                  ShortTip.open(28);
               }
               else
               {
                  ShortTip.open(27);
               }
            }
            else if(Boolean(arr) && arr[0] == 3)
            {
               i3 = int(StoragePanel.storage.backSuppliesEmptyNum());
               if(i3 >= arr[2])
               {
                  for(x1 = 0; x1 < arr[2]; x1++)
                  {
                     StoragePanel.storage.addSuppliesStorage(SuppliesFactory.getSuppliesById(arr[1]));
                  }
                  JinMiDu_Down(XXX);
                  ShortTip.open(28);
               }
               else
               {
                  ShortTip.open(27);
               }
            }
            else if(!(Boolean(arr) && arr[0] == 4))
            {
               if(Boolean(arr) && arr[0] == 5)
               {
                  i5 = int(StoragePanel.storage.canPutOtherNum(arr[1]));
                  if(i5 >= arr[2])
                  {
                     for(x1 = 0; x1 < arr[2]; x1++)
                     {
                        StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(arr[1]));
                     }
                     JinMiDu_Down(XXX);
                     ShortTip.open(28);
                  }
                  else
                  {
                     ShortTip.open(27);
                  }
               }
            }
         }
      }
      
      public static function get_Obj_And_ObjId(who:int) : Array
      {
         var i:* = undefined;
         var 循环:int = 0;
         var 角色:int = 0;
         var 类型:int = 0;
         var ID:int = 0;
         var 数量:int = 0;
         var 图标:int = 0;
         var xml:XML = Data_qinMiDu.data;
         var id:int = InitData.qinMiDu_num[who].getValue() % 7;
         if(id == 0)
         {
            id = 7;
         }
         for(i in xml.亲密度)
         {
            循环 = int(xml.亲密度[i].循环ID);
            角色 = int(xml.亲密度[i].角色);
            if(id == 循环 && 角色 == who)
            {
               类型 = int(xml.亲密度[i].物品类型);
               ID = int(xml.亲密度[i].物品ID);
               数量 = int(xml.亲密度[i].物品数量);
               图标 = int(xml.亲密度[i].图标);
               return [类型,ID,数量,图标];
            }
         }
         return null;
      }
      
      public static function get_AllObj_Pic_And_Num(who:int) : Array
      {
         var i:* = undefined;
         var 循环:int = 0;
         var 角色:int = 0;
         var xml:XML = Data_qinMiDu.data;
         var arr:Array = [-1];
         for(var xx:int = 1; xx < 8; xx++)
         {
            arr[xx] = new Array();
            for(i in xml.亲密度)
            {
               循环 = int(xml.亲密度[i].循环ID);
               角色 = int(xml.亲密度[i].角色);
               if(xx == 循环 && 角色 == who)
               {
                  arr[xx][0] = int(xml.亲密度[i].物品数量);
                  arr[xx][1] = int(xml.亲密度[i].图标);
               }
            }
         }
         return arr;
      }
      
      public static function JinMiDu_Down(who:int) : *
      {
         InitData.qinMiDu_Arr[who].setValue(InitData.qinMiDu_Arr[who].getValue() - 1470 / 147);
         InitData.qinMiDu_Time[who].setValue(Main.serverTime.getValue());
         InitData.qinMiDu_num[who].setValue(int(InitData.qinMiDu_num[who].getValue()) + 1);
      }
      
      private static function selChiYuan(_XXX:int) : Boolean
      {
         if(StoragePanel.storage.canPutOtherNum(objArr[_XXX]) > 0)
         {
            if(!Main.player_1.data._rebirth)
            {
               StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(objArr[_XXX]));
            }
            if(Main.P1P2)
            {
               if(StoragePanel.storage.canPutOtherNum(objArr[_XXX]) > 0)
               {
                  if(!Main.player_2.data._rebirth)
                  {
                     StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(objArr[_XXX]));
                  }
                  return true;
               }
               return false;
            }
            return true;
         }
         return false;
      }
   }
}

