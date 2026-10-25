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
         buy_btn.addEventListener(MouseEvent.CLICK,this.BUY);
         close1.addEventListener(MouseEvent.CLICK,this.CloseXX);
         close2.addEventListener(MouseEvent.CLICK,this.CloseXX);
         temp_btn.addEventListener(MouseEvent.CLICK,this.getObj_mc_Open);
         temp2_btn.addEventListener(MouseEvent.CLICK,this.jieMian2_Open);
         getObj_mc.song_btn.addEventListener(MouseEvent.CLICK,this.GetNpc_Obj);
         getObj_mc.close.addEventListener(MouseEvent.CLICK,this.getObj_mc_Close);
         jieMian2.ling_btn.addEventListener(MouseEvent.CLICK,this.GetPlayer_Obj);
         jieMian2.quxiao_btn.addEventListener(MouseEvent.CLICK,this.jieMian2_Close);
         getObj_mc.A_mc.numUP_btn.addEventListener(MouseEvent.CLICK,this.SongNumUP);
         getObj_mc.A_mc.numDOWN_btn.addEventListener(MouseEvent.CLICK,this.SongNumDOWN);
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!only)
         {
            only = new 药水商人界面();
         }
         Main._stage.addChild(only);
         only.x = xx;
         only.y = yy;
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
      
      private function GetNpc_Obj(e:*) : *
      {
         this.getObj_mc_Open();
         this.Use_xiaoLiDaiNum(int(getObj_mc.A_mc._txt.text));
         this.ShowJinDu();
         TaskData.isOk();
      }
      
      private function GetPlayer_Obj(e:*) : *
      {
         All_Npc.NpcGetPlayerObj(3);
         this.LingQuYN();
         this.ShowJinDu();
      }
      
      private function BUY(e:*) : *
      {
         SuppliesShopPanel.open();
         药水商人界面.Close();
      }
      
      private function CloseXX(e:*) : *
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
      
      private function getObj_mc_Open(e:* = null) : *
      {
         getObj_mc.x = 300;
         getObj_mc.y = 100;
         getObj_mc.visible = true;
         this.jieMian2_Close();
      }
      
      private function getObj_mc_Close(e:* = null) : *
      {
         getObj_mc.x = 5000;
         getObj_mc.y = 5000;
         getObj_mc.visible = false;
      }
      
      private function jieMian2_Open(e:* = null) : *
      {
         jieMian2.x = 300;
         jieMian2.y = 100;
         jieMian2.visible = true;
         this.getObj_mc_Close();
         this.ShowPicAndNum();
         if(InitData.qinMiDu_Arr[3].getValue() < InitData.qinMiDu_Max_Arr[3].getValue())
         {
            jieMian2.ling_btn.visible = false;
         }
         else if(this.LingQuYN())
         {
            jieMian2.ling_btn.visible = true;
         }
      }
      
      private function jieMian2_Close(e:* = null) : *
      {
         jieMian2.x = 5000;
         jieMian2.y = 5000;
         jieMian2.visible = false;
      }
      
      private function SongNumUP(e:* = null) : *
      {
         if(int(getObj_mc.A_mc._txt.text) < 20 && this.xiaoLiDaiNum() > int(getObj_mc.A_mc._txt.text))
         {
            getObj_mc.A_mc._txt.text = int(getObj_mc.A_mc._txt.text) + 1;
         }
         else
         {
            getObj_mc.A_mc._txt.text = 1;
         }
      }
      
      private function SongNumDOWN(e:* = null) : *
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
         var p1num:int = int(Main.player1.getBag().getOtherobjNum(63102));
         var p2num:int = 0;
         if(Main.P1P2)
         {
            p2num = int(Main.player2.getBag().getOtherobjNum(63102));
         }
         var 数量:int = p1num + p2num;
         if(数量 < 1)
         {
            temp_btn.visible = false;
         }
         else
         {
            temp_btn.visible = true;
         }
         return 数量;
      }
      
      private function Use_xiaoLiDaiNum(ii:int) : *
      {
         var 点数:int = 0;
         var p1num:int = int(Main.player1.getBag().getOtherobjNum(63102));
         var p2num:int = 0;
         if(Main.P1P2)
         {
            p2num = int(Main.player2.getBag().getOtherobjNum(63102));
         }
         var 数量:int = p1num + p2num;
         if(数量 >= ii)
         {
            if(p1num <= ii)
            {
               Main.player1.getBag().getAndUseOtherobj(63102,p1num);
               if(Main.P1P2)
               {
                  Main.player2.getBag().getAndUseOtherobj(63102,ii - p1num);
               }
               else
               {
                  trace("扣除小礼袋数量 #出现异常！");
               }
            }
            else
            {
               Main.player1.getBag().getAndUseOtherobj(63102,ii);
            }
            点数 = ii * 3;
            InitData.qinMiDu_Arr[3].setValue(InitData.qinMiDu_Arr[3].getValue() + 点数);
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
         var arr:Array = All_Npc.get_AllObj_Pic_And_Num(3);
         trace("InitData.qinMiDu_num[3] = " + InitData.qinMiDu_num[3].getValue());
         var xxx:* = InitData.qinMiDu_num[3].getValue() % 7;
         if(xxx == 0)
         {
            xxx = 7;
         }
         for(var xx:int = 1; xx < 8; xx++)
         {
            trace("!!!!!!!!!!!!~~~~~~~~~~~xxx = " + xxx + ",arr[xxx][1] = " + arr[xxx][1]);
            jieMian2["s1_" + xx].gotoAndStop(arr[xxx][1]);
            if(xx < 2)
            {
               jieMian2["_txt" + xx].text = "x " + arr[xxx][0];
            }
            xxx++;
            if(xxx > 7)
            {
               xxx = 1;
            }
         }
      }
   }
}

