package src
{
   import com.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class PK_JiFen_UI extends MovieClip
   {
      
      public static var _this:PK_JiFen_UI;
      
      public function PK_JiFen_UI()
      {
         super();
         submit_btn.addEventListener(MouseEvent.CLICK,this.submit_Fun);
      }
      
      public static function Open(param1:Boolean = true, param2:int = 0) : *
      {
         Main.allClosePanel();
         NewThis();
         _this.Show(param1,param2);
         _this.x = _this.y = 0;
         _this.visible = true;
         Main._stage.addChild(_this);
      }
      
      public static function Close() : *
      {
         NewThis();
         _this.x = _this.y = 5000;
         _this.visible = false;
      }
      
      private static function NewThis() : *
      {
         if(!_this)
         {
            _this = new PK_JiFen_UI();
         }
      }
      
      private function submit_Fun(param1:*) : *
      {
         Close();
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Main._this.Loading();
         Player.一起信春哥();
      }
      
      private function Show(param1:Boolean = true, param2:int = 0) : *
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(uint(PK_UI.Pk_timeNum / 27 % 60) < 10)
         {
            _loc4_ = uint(PK_UI.Pk_timeNum / 27 / 60) + ":0" + uint(PK_UI.Pk_timeNum / 27 % 60);
         }
         else
         {
            _loc4_ = uint(PK_UI.Pk_timeNum / 27 / 60) + ":" + uint(PK_UI.Pk_timeNum / 27 % 60);
         }
         if(Main.P1P2)
         {
            _loc3_ = Main.player1.level.getValue() + "," + Main.player2.level.getValue();
            _loc5_ = Main.player1.getEquipSlot().getSuitStrength() + "," + Main.player2.getEquipSlot().getSuitStrength();
         }
         else
         {
            _loc3_ = Main.player1.level.getValue();
            _loc5_ = Main.player1.getEquipSlot().getSuitStrength();
         }
         if(param1)
         {
            _loc6_ = "生存";
         }
         else
         {
            _loc6_ = "死亡";
         }
         _t1_txt.text = PK_UI.killNum.getValue();
         _t2_txt.text = _loc3_;
         _t3_txt.text = _loc4_;
         _t4_txt.text = _loc5_;
         _t5_txt.text = _loc6_;
         _t6_txt.text = PK_UI.whoNumX.getValue();
         _t7_txt.text = param2;
      }
   }
}

