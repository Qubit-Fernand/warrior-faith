package src.tool
{
   import com.hotpoint.braveManIII.repository.other.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5898")]
   public class X61_LingQue extends MovieClip
   {
      
      public var _close_btn:SimpleButton;
      
      public var _txt:TextField;
      
      public var qieHuan_btn:SimpleButton;
      
      public var _btn:SimpleButton;
      
      private var urlLoader:URLLoader = new URLLoader();
      
      private var phpUrl:URLRequest = new URLRequest("http://huodong2.4399.com/2012/zhounian8/app_flash.php");
      
      public function X61_LingQue()
      {
         super();
         _close_btn.addEventListener(MouseEvent.CLICK,onClose);
         _btn.addEventListener(MouseEvent.CLICK,onLingQue);
         _txt.addEventListener(MouseEvent.CLICK,onTXT);
         qieHuan_btn.addEventListener(MouseEvent.CLICK,onQieHuan);
      }
      
      private function onTXT(param1:*) : *
      {
         _txt.text = "";
      }
      
      private function onClose(param1:* = null) : *
      {
         _close_btn.removeEventListener(MouseEvent.CLICK,onClose);
         _btn.removeEventListener(MouseEvent.CLICK,onLingQue);
         this.parent.removeChild(this);
      }
      
      private function onLingQue(param1:*) : *
      {
         if(TeShuHuoDong.TeShuHuoDongArr[2])
         {
            _txt.text = "你已经领过了";
            return;
         }
         if(Main.P1P2)
         {
            if(Main.player1.getBag().backOtherBagNum() < 1 || Main.player2.getBag().backOtherBagNum() < 1)
            {
               _txt.text = "背包已满";
               return;
            }
         }
         else if(Main.player1.getBag().backOtherBagNum() < 1)
         {
            _txt.text = "背包已满";
            return;
         }
         phpUrl.method = URLRequestMethod.GET;
         var _loc2_:String = _txt.text;
         phpUrl.data = "ac=check&game=ysdyx&code=" + _loc2_ + "&r=" + int(Math.random() * 8999 + 1000);
         urlLoader.load(phpUrl);
         urlLoader.addEventListener(Event.COMPLETE,completeHandler);
      }
      
      private function completeHandler(param1:Event) : void
      {
         var _loc2_:String = (param1.currentTarget as URLLoader).data;
         if(_loc2_ == "1")
         {
            _txt.text = "领取成功!!";
            if(!Main.P1P2)
            {
               if(Main.player1.getBag().backOtherBagNum() > 1)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63174));
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                  ++TeShuHuoDong.TeShuHuoDongArr[2];
                  _txt.text = "领取成功!!";
               }
               else
               {
                  _txt.text = "背包已满";
               }
            }
            else if(Main.player1.getBag().backOtherBagNum() > 1 && Main.player2.getBag().backOtherBagNum() > 1)
            {
               Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63174));
               Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63174));
               Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
               Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
               ++TeShuHuoDong.TeShuHuoDongArr[2];
               _txt.text = "领取成功!!";
            }
            else
            {
               _txt.text = "背包已满";
            }
         }
         else
         {
            if(_loc2_ == "0|001")
            {
               _loc2_ = "活动还没开始";
            }
            else if(_loc2_ == "0|002")
            {
               _loc2_ = "活动已经结束";
            }
            else if(_loc2_ == "0|003")
            {
               _loc2_ = "未登录";
            }
            else if(_loc2_ == "0|004")
            {
               _loc2_ = "兑换码无效";
            }
            _txt.text = "" + _loc2_;
         }
      }
      
      private function onQieHuan(param1:*) : *
      {
         onClose();
         var _loc2_:JiFenLingQue = new JiFenLingQue();
         Main._stage.addChild(_loc2_);
      }
   }
}

