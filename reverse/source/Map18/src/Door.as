package src
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol24")]
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
         else
         {
            Close();
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
         if(time > 0)
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
                  removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                  GoWhere();
               }
            }
         }
      }
      
      public function GoWhere() : *
      {
         var win:WinShow = null;
         Close();
         Main.allClosePanel();
         if(this.name == "地图")
         {
            SelMap.Open();
         }
         else if(this.name == "继续" || this.name == "继续2")
         {
            ++Main.gameNum2;
            Main._this.GameStart();
         }
         else if(this.name == "回村")
         {
            win = new WinShow();
         }
         else if(this.name == "回村2")
         {
            Main.gameNum = 0;
            Main.gameNum2 = 0;
            Main._this.Loading();
         }
         else if(this.name == "苍井空")
         {
            Main.gameNum = 0;
            Main.gameNum2 = 1;
            Main._this.Loading();
         }
         else if(this.name == "加藤鹰")
         {
            Main.gameNum = 0;
            Main.gameNum2 = 2;
            Main._this.Loading();
         }
      }
   }
}

