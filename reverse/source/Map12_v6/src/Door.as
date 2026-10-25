package src
{
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.tool.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol43")]
   public class Door extends MovieClip
   {
      
      public var hit:MovieClip;
      
      public var openYN:Boolean = false;
      
      private var time:int = 0;
      
      public function Door()
      {
         super();
         if(this.name == "地图" || this.name == "回村2" || this.name == "继续2")
         {
            Open();
         }
         else if(this.name == "苍井空" && (Boolean(Main.questBag()) || Boolean(Main.getAllQuest())))
         {
            Open();
         }
         else if(this.name == "加藤鹰" && Boolean(Main.getAllQuest()))
         {
            Open();
         }
         else if(this.name == "竞技场")
         {
            Open();
         }
         else
         {
            Close();
         }
         if(TiaoShi.chuanSongYN)
         {
            Open();
         }
      }
      
      public function Open(t:int = 0) : *
      {
         openYN = true;
         if(!visible)
         {
            time = t;
         }
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function Close() : *
      {
         openYN = false;
         this.visible = false;
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         var p:Player = null;
         if(this.parent != Main.world)
         {
            removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            return;
         }
         if(time > 0 && this.name != "竞技场")
         {
            --time;
            return;
         }
         this.visible = true;
         for(i2 = 0; i2 < Player.All.length; ++i2)
         {
            p = Player.All[i2];
            if(Boolean(visible) && Boolean(p.hit) && this.hit.hitTestObject(p.hit))
            {
               if(p.getKeyStatus("上",2) && this.parent == Main.world)
               {
                  if(this.name != "竞技场")
                  {
                     removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                  }
                  GoWhere();
               }
            }
         }
      }
      
      public function GoWhere() : *
      {
         var win:WinShow = null;
         GameData.winYN = false;
         if(this.name != "竞技场")
         {
            Close();
         }
         Main.allClosePanel();
         if(this.name == "地图")
         {
            SelMap.Open();
         }
         else if(this.name == "继续" || this.name == "继续2")
         {
            Main.gameNum2.setValue(Main.gameNum2.getValue() + 1);
            Main._this.GameStart();
         }
         else if(this.name == "回村")
         {
            win = new WinShow();
         }
         else if(this.name == "回村2")
         {
            Main.gameNum.setValue(0);
            Main.gameNum2.setValue(0);
            Main._this.Loading();
         }
         else if(this.name == "苍井空")
         {
            Main.gameNum.setValue(0);
            Main.gameNum2.setValue(1);
            Main._this.Loading();
         }
         else if(this.name == "加藤鹰")
         {
            Main.gameNum.setValue(0);
            Main.gameNum2.setValue(2);
            Main._this.Loading();
         }
         else if(this.name == "竞技场")
         {
            if(Main.player1.level.getValue() < 50 || Boolean(Main.P1P2) && (Main.player1.level.getValue() < 50 || Main.player2.level.getValue() < 50))
            {
               ShortTip.open(46);
            }
            else
            {
               PK_UI_Sel.Open();
            }
         }
      }
   }
}

