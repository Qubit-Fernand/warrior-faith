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
      
      public static function NpcGetPlayerObj(param1:int) : *
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         Data_qinMiDu.TestData();
         if(InitData.qinMiDu_Max_Arr[param1].getValue() <= InitData.qinMiDu_Arr[param1].getValue())
         {
            _loc2_ = All_Npc.get_Obj_And_ObjId(param1);
            if(Boolean(_loc2_) && _loc2_[0] == 6)
            {
               if(_loc2_[1] == 101)
               {
                  Main.player_1.MoneyUP(_loc2_[2]);
                  if(Main.P1P2)
                  {
                     Main.player_2.MoneyUP(_loc2_[2]);
                  }
                  JinMiDu_Down(param1);
               }
               if(_loc2_[1] == 102)
               {
                  Main.player1.addPoint(_loc2_[2]);
                  if(Main.P1P2)
                  {
                     Main.player2.addPoint(_loc2_[2]);
                  }
                  JinMiDu_Down(param1);
               }
            }
            else if(Boolean(_loc2_) && _loc2_[0] == 1)
            {
               _loc3_ = int(StoragePanel.storage.backEquipEmptyNum());
               if(_loc3_ >= _loc2_[2])
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc2_[2])
                  {
                     StoragePanel.storage.addEquipStorage(EquipFactory.createEquipByID(_loc2_[1]));
                     _loc4_++;
                  }
                  JinMiDu_Down(param1);
                  ShortTip.open(28);
               }
               else
               {
                  ShortTip.open(27);
               }
            }
            else if(Boolean(_loc2_) && _loc2_[0] == 2)
            {
               _loc5_ = int(StoragePanel.storage.canPutGemNum(_loc2_[1]));
               if(_loc5_ >= _loc2_[2])
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc2_[2])
                  {
                     StoragePanel.storage.addGemStorage(GemFactory.creatGemById(_loc2_[1]));
                     _loc4_++;
                  }
                  JinMiDu_Down(param1);
                  ShortTip.open(28);
               }
               else
               {
                  ShortTip.open(27);
               }
            }
            else if(Boolean(_loc2_) && _loc2_[0] == 3)
            {
               _loc6_ = int(StoragePanel.storage.backSuppliesEmptyNum());
               if(_loc6_ >= _loc2_[2])
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc2_[2])
                  {
                     StoragePanel.storage.addSuppliesStorage(SuppliesFactory.getSuppliesById(_loc2_[1]));
                     _loc4_++;
                  }
                  JinMiDu_Down(param1);
                  ShortTip.open(28);
               }
               else
               {
                  ShortTip.open(27);
               }
            }
            else if(!(Boolean(_loc2_) && _loc2_[0] == 4))
            {
               if(Boolean(_loc2_) && _loc2_[0] == 5)
               {
                  _loc7_ = int(Main.player1.getBag().backOtherBagNum());
                  if(_loc7_ >= _loc2_[2])
                  {
                     _loc4_ = 0;
                     while(_loc4_ < _loc2_[2])
                     {
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(_loc2_[1]));
                        _loc4_++;
                     }
                     JinMiDu_Down(param1);
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
      
      public static function get_Obj_And_ObjId(param1:int) : Array
      {
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:XML = Data_qinMiDu.data;
         var _loc3_:int = InitData.qinMiDu_num[param1].getValue() % 7;
         if(_loc3_ == 0)
         {
            _loc3_ = 7;
         }
         for(_loc4_ in _loc2_.亲密度)
         {
            _loc5_ = int(_loc2_.亲密度[_loc4_].循环ID);
            _loc6_ = int(_loc2_.亲密度[_loc4_].角色);
            if(_loc3_ == _loc5_ && _loc6_ == param1)
            {
               _loc7_ = int(_loc2_.亲密度[_loc4_].物品类型);
               _loc8_ = int(_loc2_.亲密度[_loc4_].物品ID);
               _loc9_ = int(_loc2_.亲密度[_loc4_].物品数量);
               _loc10_ = int(_loc2_.亲密度[_loc4_].图标);
               return [_loc7_,_loc8_,_loc9_,_loc10_];
            }
         }
         return null;
      }
      
      public static function get_AllObj_Pic_And_Num(param1:int) : Array
      {
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:XML = Data_qinMiDu.data;
         var _loc3_:Array = [-1];
         var _loc4_:int = 1;
         while(_loc4_ < 8)
         {
            _loc3_[_loc4_] = new Array();
            for(_loc5_ in _loc2_.亲密度)
            {
               _loc6_ = int(_loc2_.亲密度[_loc5_].循环ID);
               _loc7_ = int(_loc2_.亲密度[_loc5_].角色);
               if(_loc4_ == _loc6_ && _loc7_ == param1)
               {
                  _loc3_[_loc4_][0] = int(_loc2_.亲密度[_loc5_].物品数量);
                  _loc3_[_loc4_][1] = int(_loc2_.亲密度[_loc5_].图标);
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function JinMiDu_Down(param1:int) : *
      {
         InitData.qinMiDu_Arr[param1].setValue(InitData.qinMiDu_Arr[param1].getValue() - 1470 / 147);
         InitData.qinMiDu_Time[param1].setValue(Main.serverTime.getValue());
         InitData.qinMiDu_num[param1].setValue(int(InitData.qinMiDu_num[param1].getValue()) + 1);
      }
      
      private static function selChiYuan(param1:int) : Boolean
      {
         if(StoragePanel.storage.canPutOtherNum(objArr[param1]) > 0)
         {
            if(!Main.player_1.data._rebirth)
            {
               StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(objArr[param1]));
            }
            if(Main.P1P2)
            {
               if(StoragePanel.storage.canPutOtherNum(objArr[param1]) > 0)
               {
                  if(!Main.player_2.data._rebirth)
                  {
                     StoragePanel.storage.addOtherobjStorage(OtherFactory.creatOther(objArr[param1]));
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

