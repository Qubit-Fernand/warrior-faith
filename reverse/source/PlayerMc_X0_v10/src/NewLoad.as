package src
{
   import com.hotpoint.braveManIII.models.player.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class NewLoad extends MovieClip
   {
      
      public static var zhuangBeiSkin:Array = [new Array(),new Array(),new Array()];
      
      public static var loadArr:Array = new Array();
      
      public static var loadType:uint = 1;
      
      public static var who:uint = 1;
      
      private static var loadingYN:Boolean = true;
      
      public function NewLoad()
      {
         super();
      }
      
      public static function Loading(param1:uint = 1, param2:uint = 1) : *
      {
         var _loc4_:uint = 0;
         loadType = param1;
         who = param2;
         var _loc3_:uint = 1;
         if(Main.P1P2)
         {
            _loc3_ = 2;
         }
         if(loadType == 3)
         {
            Loading_Equip(PK_UI.whoData);
         }
         else
         {
            _loc4_ = 1;
            while(_loc4_ <= _loc3_)
            {
               if(!Main["player" + _loc4_])
               {
                  Main["player" + _loc4_] = PlayerData.creatPlayerData(_loc4_);
               }
               Loading_Equip(Main["player" + _loc4_]);
               _loc4_++;
            }
         }
         LoadGo();
      }
      
      private static function Loading_Equip(param1:PlayerData) : *
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:* = undefined;
         var _loc11_:String = null;
         var _loc2_:PlayerData = param1;
         var _loc3_:uint = uint(_loc2_.skinArr[_loc2_.skinNum]);
         var _loc4_:String = "equip_" + _loc3_ + "_";
         var _loc7_:Array = [1,6,7,9];
         var _loc8_:uint = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = uint(_loc7_[_loc8_]);
            if(_loc2_.getEquipSlot().getEquipFromSlot(_loc9_) != null)
            {
               _loc5_ = _loc2_.getEquipSlot().getEquipFromSlot(_loc9_).getClassName3();
            }
            else if(_loc8_ == 0 || _loc8_ == 3)
            {
               _loc5_ = 1;
            }
            _loc6_ = _loc2_.getEquipSlot().getEquipFromSlot(_loc9_).getClassName4();
            _loc10_ = zhuangBeiSkin[_loc3_][_loc5_];
            if(!tempData2)
            {
               _loc11_ = "equip_" + _loc3_ + "_" + _loc6_ + ".swf";
               loadArr.push([_loc3_,_loc5_,_loc11_]);
            }
            _loc8_++;
         }
      }
      
      private static function LoadGo() : *
      {
         if(loadArr.length > 0)
         {
            if(loadingYN)
            {
               zhuangBeiSkin[loadArr[0][0]][loadArr[0][1]] = new ClassLoader(loadArr[0][2]);
               zhuangBeiSkin[loadArr[0][0]][loadArr[0][1]].addEventListener(Event.COMPLETE,LoadEnd);
               loadingYN = false;
            }
            if(Play_Interface.interfaceX)
            {
               Play_Interface.interfaceX["load_mc"].visible = true;
            }
         }
         else
         {
            if(loadType == 1)
            {
               Load.newLoad_Ok();
            }
            else if(loadType == 2)
            {
               if(who == 1)
               {
                  Main.player_1.newSkin_LoadEnd();
               }
               else if(who == 2)
               {
                  Main.player_2.newSkin_LoadEnd();
               }
            }
            else if(loadType == 3)
            {
               PK_UI.LoadEnd_And_AddPlayer2();
            }
            if(Play_Interface.interfaceX)
            {
               Play_Interface.interfaceX["load_mc"].visible = false;
            }
         }
      }
      
      private static function LoadEnd(param1:*) : *
      {
         loadArr.splice(0,1);
         loadingYN = true;
         LoadGo();
      }
   }
}

