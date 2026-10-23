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
      
      public static function Open(dead:Boolean = true, jiFen:int = 0) : *
      {
         Main.allClosePanel();
         NewThis();
         _this.Show(dead,jiFen);
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
      
      private function submit_Fun(e:*) : *
      {
         Close();
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Main._this.Loading();
         Player.一起信春哥();
      }
      
      private function Show(dead:Boolean = true, jiFen:int = 0) : *
      {
         var _t2_str:String = null;
         var _t3_Str:String = null;
         var _t4_str:String = null;
         var _t5_str:String = null;
         var _t6_str:String = null;
         if(uint(PK_UI.Pk_timeNum / 27 % 60) < 10)
         {
            _t3_Str = uint(PK_UI.Pk_timeNum / 27 / 60) + ":0" + uint(PK_UI.Pk_timeNum / 27 % 60);
         }
         else
         {
            _t3_Str = uint(PK_UI.Pk_timeNum / 27 / 60) + ":" + uint(PK_UI.Pk_timeNum / 27 % 60);
         }
         if(Main.P1P2)
         {
            _t2_str = Main.player1.level.getValue() + "," + Main.player2.level.getValue();
            _t4_str = Main.player1.getEquipSlot().getSuitStrength() + "," + Main.player2.getEquipSlot().getSuitStrength();
         }
         else
         {
            _t2_str = Main.player1.level.getValue();
            _t4_str = Main.player1.getEquipSlot().getSuitStrength();
         }
         if(dead)
         {
            _t5_str = "生存";
         }
         else
         {
            _t5_str = "死亡";
         }
         _t1_txt.text = PK_UI.killNum.getValue();
         _t2_txt.text = _t2_str;
         _t3_txt.text = _t3_Str;
         _t4_txt.text = _t4_str;
         _t5_txt.text = _t5_str;
         _t6_txt.text = PK_UI.whoNumX.getValue();
         _t7_txt.text = jiFen;
      }
   }
}

