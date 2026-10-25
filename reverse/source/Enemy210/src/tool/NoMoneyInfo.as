package src.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   import src.*;
   
   public class NoMoneyInfo extends MovieClip
   {
      
      public function NoMoneyInfo()
      {
         super();
         yes_btn.addEventListener(MouseEvent.CLICK,Close);
         addMoney_btn.addEventListener(MouseEvent.CLICK,Open_AddMoney2);
      }
      
      public function Open(money:uint = 0) : *
      {
         this.visible = true;
         this.x = this.y = 0;
         this._txt.text = "购买需要" + money + "点券";
      }
      
      public function Close(e:* = null) : *
      {
         this.visible = false;
         this.x = this.y = 5000;
      }
      
      private function Open_AddMoney2(e:* = null) : *
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
         Close();
      }
   }
}

