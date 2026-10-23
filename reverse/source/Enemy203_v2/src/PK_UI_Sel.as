package src
{
   import com.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class PK_UI_Sel extends MovieClip
   {
      
      public static var _this:PK_UI_Sel;
      
      public function PK_UI_Sel()
      {
         super();
         sel_1_btn.addEventListener(MouseEvent.CLICK,this.In_JingJiPaiHang);
      }
      
      public static function Open() : *
      {
         Main.allClosePanel();
         if(!_this)
         {
            _this = new PK_UI_Sel();
         }
         _this.visible = true;
         _this.x = _this.y = 0;
         Main._stage.addChild(_this);
      }
      
      public static function Close(param1:* = null) : *
      {
         if(!_this)
         {
            _this = new PK_UI_Sel();
            Main._stage.addChild(_this);
         }
         _this.visible = false;
         _this.x = _this.y = 5000;
      }
      
      private function In_JingJiPaiHang(param1:*) : *
      {
         PK_UI.Open();
      }
   }
}

