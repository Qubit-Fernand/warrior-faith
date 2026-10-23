package src
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol37")]
   public class Door extends MovieClip
   {
      
      public var hit:MovieClip;
      
      private var time:int = 0;
      
      public var openYN:Boolean = false;
      
      public function Door()
      {
         super();
         if(this.name == "地图" || this.name == "苍井空" || this.name == "加藤鹰" || this.name == "回村2")
         {
            Open();
         }
         else
         {
            Close();
         }
      }
      
      public function Close() : *
      {
         openYN = false;
         this.visible = false;
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
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
         if(!this.visible)
         {
            return;
         }
         for(i2 = 0; i2 < Player.All.length; ++i2)
         {
            p = Player.All[i2];
            if(Boolean(p.hit) && this.hit.hitTestObject(p.hit))
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
         else if(this.name == "继续")
         {
            ++Main.gameNum2;
            Main._this.GameStart();
         }
         else if(this.name == "回村")
         {
            Main.Save();
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

