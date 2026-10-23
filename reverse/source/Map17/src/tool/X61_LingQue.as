package src.tool
{
   import com.hotpoint.braveManIII.repository.other.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   
   public class X61_LingQue extends MovieClip
   {
      
      private var urlLoader:URLLoader = new URLLoader();
      
      private var phpUrl:URLRequest = new URLRequest("http://huodong2.4399.com/2012/liwu/liwu.php");
      
      public function X61_LingQue()
      {
         super();
         _close_btn.addEventListener(MouseEvent.CLICK,onClose);
         _btn.addEventListener(MouseEvent.CLICK,onLingQue);
         _txt.addEventListener(MouseEvent.CLICK,onTXT);
      }
      
      private function onTXT(e:*) : *
      {
         _txt.text = "";
      }
      
      private function onClose(e:*) : *
      {
         _close_btn.removeEventListener(MouseEvent.CLICK,onClose);
         _btn.removeEventListener(MouseEvent.CLICK,onLingQue);
         this.parent.removeChild(this);
      }
      
      private function onLingQue(e:*) : *
      {
         if(Main.lingQueArr[0])
         {
            _txt.text = "你已经领过了";
            return;
         }
         phpUrl.method = URLRequestMethod.GET;
         var str:String = _txt.text;
         phpUrl.data = "ac=check&code=" + str + "&game=ysdyx";
         urlLoader.load(phpUrl);
         urlLoader.addEventListener(Event.COMPLETE,completeHandler3);
      }
      
      private function completeHandler3(e:Event) : void
      {
         var str:String = (e.currentTarget as URLLoader).data;
         if(str == "1")
         {
            if(!Main.P1P2)
            {
               if(Main.player1.getBag().backOtherBagNum() > 0)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63149));
                  Main.lingQueArr[0] = true;
                  _txt.text = "领取成功!!";
               }
               else
               {
                  _txt.text = "背包已满";
               }
            }
            else if(Main.player1.getBag().backOtherBagNum() > 0 && Main.player2.getBag().backOtherBagNum() > 0)
            {
               Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63149));
               Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63149));
               Main.lingQueArr[0] = true;
               _txt.text = "领取成功!!";
            }
            else
            {
               _txt.text = "背包已满";
            }
         }
         else
         {
            if(str == "0|004")
            {
               str = "兑换码无效";
            }
            else if(str == "0|001")
            {
               str = "活动还没开始";
            }
            else if(str == "0|002")
            {
               str = "活动已经结束";
            }
            else
            {
               str = "未登录";
            }
            _txt.text = "" + str;
         }
      }
   }
}

