package src.tool
{
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5889")]
   public class JiFenLingQue extends MovieClip
   {
      
      public var duihuan_5:SimpleButton;
      
      public var _3_txt:TextField;
      
      public var duihuan_4:SimpleButton;
      
      public var _5_btn:SimpleButton;
      
      public var _close_btn:SimpleButton;
      
      public var _2_txt:TextField;
      
      public var _4_btn:SimpleButton;
      
      public var _7_btn:SimpleButton;
      
      public var _6_btn:SimpleButton;
      
      public var _txt:TextField;
      
      public var _3_btn:SimpleButton;
      
      public var _2_btn:SimpleButton;
      
      public var http_btn:SimpleButton;
      
      public var duihuan_3:SimpleButton;
      
      public var _5_txt:TextField;
      
      public var duihuan_2:SimpleButton;
      
      public var _4_txt:TextField;
      
      public var qieHuan_btn:SimpleButton;
      
      public var _7_txt:TextField;
      
      public var duihuan_1:SimpleButton;
      
      public var _btn:SimpleButton;
      
      public var _6_txt:TextField;
      
      public var duihuan_7:SimpleButton;
      
      public var duihuan_6:SimpleButton;
      
      private var LianJieArr:Array = ["","http://my.4399.com/jifen/product-id-75","http://my.4399.com/jifen/product-id-25","http://my.4399.com/jifen/product-id-78","http://my.4399.com/jifen/product-id-95","http://my.4399.com/jifen/product-id-113","http://huodong2.4399.com/2013/ertongjie","http://my.4399.com/jifen/product-id-123"];
      
      public function JiFenLingQue()
      {
         super();
         _close_btn.addEventListener(MouseEvent.CLICK,onClose);
         qieHuan_btn.addEventListener(MouseEvent.CLICK,onQieHuan);
         _txt.addEventListener(MouseEvent.CLICK,onTXT);
         _btn.addEventListener(MouseEvent.CLICK,onLingQue);
         _2_txt.addEventListener(MouseEvent.CLICK,onTXT2);
         _2_btn.addEventListener(MouseEvent.CLICK,onLingQue2);
         _3_txt.addEventListener(MouseEvent.CLICK,onTXT3);
         _3_btn.addEventListener(MouseEvent.CLICK,onLingQue3);
         _4_txt.addEventListener(MouseEvent.CLICK,onTXT4);
         _4_btn.addEventListener(MouseEvent.CLICK,onLingQue4);
         _5_txt.addEventListener(MouseEvent.CLICK,onTXT5);
         _5_btn.addEventListener(MouseEvent.CLICK,onLingQue5);
         _6_txt.addEventListener(MouseEvent.CLICK,onTXT6);
         _6_btn.addEventListener(MouseEvent.CLICK,onLingQue6);
         _7_txt.addEventListener(MouseEvent.CLICK,onTXT7);
         _7_btn.addEventListener(MouseEvent.CLICK,onLingQue7);
         duihuan_1.addEventListener(MouseEvent.CLICK,WangZhiLianJie);
         duihuan_2.addEventListener(MouseEvent.CLICK,WangZhiLianJie);
         duihuan_3.addEventListener(MouseEvent.CLICK,WangZhiLianJie);
         duihuan_4.addEventListener(MouseEvent.CLICK,WangZhiLianJie);
         duihuan_5.addEventListener(MouseEvent.CLICK,WangZhiLianJie);
         duihuan_6.addEventListener(MouseEvent.CLICK,WangZhiLianJie);
         duihuan_7.addEventListener(MouseEvent.CLICK,WangZhiLianJie);
         if(http_btn)
         {
            http_btn.addEventListener(MouseEvent.CLICK,论坛);
         }
      }
      
      private function WangZhiLianJie(param1:MouseEvent) : *
      {
         var idx:uint = uint(param1.target.name.substr(8,1));
         var req:URLRequest = new URLRequest(LianJieArr[idx]);
         navigateToURL(req,"_blank");
      }
      
      private function 论坛(param1:*) : *
      {
         var req:URLRequest = new URLRequest("http://my.4399.com/forums-thread-tagid-81127-id-31978375.html");
         navigateToURL(req,"_blank");
      }
      
      private function onQieHuan(param1:*) : *
      {
      }
      
      private function onClose(param1:* = null) : *
      {
         _close_btn.removeEventListener(MouseEvent.CLICK,onClose);
         qieHuan_btn.removeEventListener(MouseEvent.CLICK,onQieHuan);
         _btn.removeEventListener(MouseEvent.CLICK,onLingQue);
         _2_btn.removeEventListener(MouseEvent.CLICK,onLingQue2);
         _3_btn.removeEventListener(MouseEvent.CLICK,onLingQue3);
         _4_btn.removeEventListener(MouseEvent.CLICK,onLingQue4);
         _5_btn.removeEventListener(MouseEvent.CLICK,onLingQue5);
         _6_btn.removeEventListener(MouseEvent.CLICK,onLingQue6);
         _7_btn.removeEventListener(MouseEvent.CLICK,onLingQue7);
         if(http_btn)
         {
            http_btn.removeEventListener(MouseEvent.CLICK,论坛);
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function onTXT(param1:*) : *
      {
         _txt.text = "";
      }
      
      private function onTXT2(param1:*) : *
      {
         _2_txt.text = "";
      }
      
      private function onTXT3(param1:*) : *
      {
         _3_txt.text = "";
      }
      
      private function onTXT4(param1:*) : *
      {
         _4_txt.text = "";
      }
      
      private function onTXT5(param1:*) : *
      {
         _5_txt.text = "";
      }
      
      private function onTXT6(param1:*) : *
      {
         _6_txt.text = "";
      }
      
      private function onTXT7(param1:*) : *
      {
         _7_txt.text = "";
      }
      
      private function onLingQue(param1:*) : *
      {
         _btn.visible = false;
         if(TeShuHuoDong.TeShuHuoDongArr[7])
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"你已经领过了");
            return;
         }
         if(!checkOtherBag(1))
         {
            _btn.visible = true;
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包已满");
            return;
         }
         giveOtherToPlayers(63209);
         ++TeShuHuoDong.TeShuHuoDongArr[7];
         _btn.visible = false;
         Main.Save();
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"领取成功!");
      }
      
      private function onLingQue2(param1:*) : *
      {
         if(TeShuHuoDong.TeShuHuoDongArr[4])
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"你已经领过了");
            _2_btn.visible = false;
            return;
         }
         if(!checkOtherBag(1))
         {
            _2_btn.visible = true;
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包已满");
            return;
         }
         giveOtherToPlayers(63194);
         ++TeShuHuoDong.TeShuHuoDongArr[4];
         _2_btn.visible = false;
         Main.Save();
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"领取成功!");
      }
      
      private function onLingQue3(param1:*) : *
      {
         if(TeShuHuoDong.TeShuHuoDongArr[6])
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"你已经领过了");
            _3_btn.visible = false;
            return;
         }
         if(!checkOtherBag(1))
         {
            _3_btn.visible = true;
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包已满");
            return;
         }
         giveOtherToPlayers(63193);
         ++TeShuHuoDong.TeShuHuoDongArr[6];
         _3_btn.visible = false;
         Main.Save();
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"领取成功!");
      }
      
      private function onLingQue4(param1:*) : *
      {
         if(TeShuHuoDong.TeShuHuoDongArr[8])
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"你已经领过了");
            _4_btn.visible = false;
            return;
         }
         if(!checkOtherBag(1))
         {
            _4_btn.visible = true;
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包已满");
            return;
         }
         giveOtherToPlayers(63220);
         ++TeShuHuoDong.TeShuHuoDongArr[8];
         _4_btn.visible = false;
         Main.Save();
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"领取成功!");
      }
      
      private function onLingQue5(param1:*) : *
      {
         if(TeShuHuoDong.TeShuHuoDongArr[9])
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"你已经领过了");
            _5_btn.visible = false;
            return;
         }
         if(!checkOtherBag(1))
         {
            _5_btn.visible = true;
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包已满");
            return;
         }
         giveOtherToPlayers(63221);
         ++TeShuHuoDong.TeShuHuoDongArr[9];
         _5_btn.visible = false;
         Main.Save();
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"领取成功!");
      }
      
      private function onLingQue6(param1:*) : *
      {
         if(TeShuHuoDong.TeShuHuoDongArr[14])
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"你已经领过了");
            _6_btn.visible = false;
            return;
         }
         if(!checkOtherBag(1))
         {
            _6_btn.visible = true;
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包已满");
            return;
         }
         giveOtherToPlayers(63238);
         ++TeShuHuoDong.TeShuHuoDongArr[14];
         _6_btn.visible = false;
         Main.Save();
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"周年礼包领取成功!!");
      }
      
      private function onLingQue7(param1:*) : *
      {
         if(TeShuHuoDong.TeShuHuoDongArr[12])
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"你已经领过了");
            _7_btn.visible = false;
            return;
         }
         if(!checkOtherBag(1))
         {
            _7_btn.visible = true;
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包已满");
            return;
         }
         giveOtherToPlayers(63231);
         ++TeShuHuoDong.TeShuHuoDongArr[12];
         _7_btn.visible = false;
         Main.Save();
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"绝世礼包领取成功!!");
      }
      
      private function checkOtherBag(need:int) : Boolean
      {
         if(Main.P1P2)
         {
            if(Main.player1.getBag().backOtherBagNum() < need)
            {
               return false;
            }
            if(Main.player2.getBag().backOtherBagNum() < need)
            {
               return false;
            }
            return true;
         }
         return Main.player1.getBag().backOtherBagNum() >= need;
      }
      
      private function giveOtherToPlayers(id:int) : void
      {
         if(!Main.P1P2)
         {
            Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(id));
         }
         else
         {
            Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(id));
            Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(id));
         }
      }
   }
}

