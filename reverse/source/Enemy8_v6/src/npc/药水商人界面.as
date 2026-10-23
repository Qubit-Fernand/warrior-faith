package src.npc
{
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import com.hotpoint.braveManIII.views.strengthenPanel.*;
   import com.hotpoint.braveManIII.views.suppliesShopPanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 药水商人界面 extends MovieClip
   {
      
      private static var only:药水商人界面;
      
      public function 药水商人界面()
      {
         super();
         buy_btn.addEventListener(MouseEvent.CLICK,BUY);
         close1.addEventListener(MouseEvent.CLICK,CloseXX);
         close2.addEventListener(MouseEvent.CLICK,CloseXX);
         temp_btn.addEventListener(MouseEvent.CLICK,getObj_mc_Open);
         temp2_btn.addEventListener(MouseEvent.CLICK,jieMian2_Open);
         getObj_mc.song_btn.addEventListener(MouseEvent.CLICK,GetNpc_Obj);
         getObj_mc.close.addEventListener(MouseEvent.CLICK,getObj_mc_Close);
         jieMian2.ling_btn.addEventListener(MouseEvent.CLICK,GetPlayer_Obj);
         jieMian2.quxiao_btn.addEventListener(MouseEvent.CLICK,jieMian2_Close);
         getObj_mc.A_mc.numUP_btn.addEventListener(MouseEvent.CLICK,SongNumUP);
         getObj_mc.A_mc.numDOWN_btn.addEventListener(MouseEvent.CLICK,SongNumDOWN);
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         if(!only)
         {
            only = new 药水商人界面();
         }
         Main._stage.addChild(only);
         only.x = param1;
         only.y = param2;
         only.visible = true;
         only.ShowJinDu();
         only.xiaoLiDaiNum();
         only.LingQuYN();
      }
      
      public static function Close() : *
      {
         if(!only)
         {
            only = new 药水商人界面();
         }
         only.x = 5000;
         only.y = 5000;
         only.visible = false;
      }
      
      private function GetNpc_Obj(param1:*) : *
      {
         getObj_mc_Open();
         Use_xiaoLiDaiNum(int(getObj_mc.A_mc._txt.text));
         ShowJinDu();
         TaskData.isOk();
      }
      
      private function GetPlayer_Obj(param1:*) : *
      {
         All_Npc.NpcGetPlayerObj(3);
         LingQuYN();
         ShowJinDu();
      }
      
      private function BUY(param1:*) : *
      {
         SuppliesShopPanel.open();
         药水商人界面.Close();
      }
      
      private function CloseXX(param1:*) : *
      {
         Close();
      }
      
      private function ShowJinDu() : *
      {
         qinMiDu_txt.text = InitData.qinMiDu_Arr[3].getValue() + "/" + InitData.qinMiDu_Max_Arr[3].getValue();
         if(InitData.qinMiDu_Arr[3].getValue() <= InitData.qinMiDu_Max_Arr[3].getValue())
         {
            jindutiao_mc.XX_mc.scaleX = InitData.qinMiDu_Arr[3].getValue() / InitData.qinMiDu_Max_Arr[3].getValue();
         }
         else
         {
            jindutiao_mc.XX_mc.scaleX = 1;
         }
      }
      
      private function getObj_mc_Open(param1:* = null) : *
      {
         getObj_mc.x = 300;
         getObj_mc.y = 100;
         getObj_mc.visible = true;
         jieMian2_Close();
      }
      
      private function getObj_mc_Close(param1:* = null) : *
      {
         getObj_mc.x = 5000;
         getObj_mc.y = 5000;
         getObj_mc.visible = false;
      }
      
      private function jieMian2_Open(param1:* = null) : *
      {
         jieMian2.x = 300;
         jieMian2.y = 100;
         jieMian2.visible = true;
         getObj_mc_Close();
         ShowPicAndNum();
         if(InitData.qinMiDu_Arr[3].getValue() < InitData.qinMiDu_Max_Arr[3].getValue())
         {
            jieMian2.ling_btn.visible = false;
         }
         else if(LingQuYN())
         {
            jieMian2.ling_btn.visible = true;
         }
      }
      
      private function jieMian2_Close(param1:* = null) : *
      {
         jieMian2.x = 5000;
         jieMian2.y = 5000;
         jieMian2.visible = false;
      }
      
      private function SongNumUP(param1:* = null) : *
      {
         if(int(getObj_mc.A_mc._txt.text) < 20 && xiaoLiDaiNum() > int(getObj_mc.A_mc._txt.text))
         {
            getObj_mc.A_mc._txt.text = int(getObj_mc.A_mc._txt.text) + 1;
         }
         else
         {
            getObj_mc.A_mc._txt.text = 1;
         }
      }
      
      private function SongNumDOWN(param1:* = null) : *
      {
         if(int(getObj_mc.A_mc._txt.text) > 1)
         {
            getObj_mc.A_mc._txt.text = int(getObj_mc.A_mc._txt.text) - 1;
         }
         else
         {
            getObj_mc.A_mc._txt.text = 20;
         }
      }
      
      private function xiaoLiDaiNum() : int
      {
         var _loc1_:int = int(Main.player1.getBag().getOtherobjNum(63102));
         var _loc2_:int = 0;
         if(Main.P1P2)
         {
            _loc2_ = int(Main.player2.getBag().getOtherobjNum(63102));
         }
         var _loc3_:int = _loc1_ + _loc2_;
         if(_loc3_ < 1)
         {
            temp_btn.visible = false;
         }
         else
         {
            temp_btn.visible = true;
         }
         return _loc3_;
      }
      
      private function Use_xiaoLiDaiNum(param1:int) : *
      {
         var _loc5_:int = 0;
         var _loc2_:int = int(Main.player1.getBag().getOtherobjNum(63102));
         var _loc3_:int = 0;
         if(Main.P1P2)
         {
            _loc3_ = int(Main.player2.getBag().getOtherobjNum(63102));
         }
         var _loc4_:int = _loc2_ + _loc3_;
         if(_loc4_ >= param1)
         {
            if(_loc2_ <= param1)
            {
               Main.player1.getBag().getAndUseOtherobj(63102,_loc2_);
               if(Main.P1P2)
               {
                  Main.player2.getBag().getAndUseOtherobj(63102,param1 - _loc2_);
               }
            }
            else
            {
               Main.player1.getBag().getAndUseOtherobj(63102,param1);
            }
            _loc5_ = param1 * 3;
            InitData.qinMiDu_Arr[3].setValue(InitData.qinMiDu_Arr[3].getValue() + _loc5_);
         }
      }
      
      private function LingQuYN() : Boolean
      {
         if(InitData.qinMiDu_Time[3].getValue() >= Main.serverTime.getValue())
         {
            jieMian2.ling_btn.visible = false;
            return false;
         }
         return true;
      }
      
      private function ShowPicAndNum() : *
      {
         var _loc1_:Array = All_Npc.get_AllObj_Pic_And_Num(3);
         var _loc2_:* = InitData.qinMiDu_num[3].getValue() % 7;
         if(_loc2_ == 0)
         {
            _loc2_ = 7;
         }
         var _loc3_:int = 1;
         while(_loc3_ < 8)
         {
            jieMian2["s1_" + _loc3_].gotoAndStop(_loc1_[_loc2_][1]);
            if(_loc3_ < 2)
            {
               jieMian2["_txt" + _loc3_].text = "x " + _loc1_[_loc2_][0];
            }
            _loc2_++;
            if(_loc2_ > 7)
            {
               _loc2_ = 1;
            }
            _loc3_++;
         }
      }
   }
}

