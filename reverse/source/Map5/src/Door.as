package src
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol34")]
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
      
      public function Open(param1:int = 0) : *
      {
         openYN = true;
         if(!visible)
         {
            time = param1;
         }
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         var _loc2_:Player = null;
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
         i2 = 0;
         while(i2 < Player.All.length)
         {
            _loc2_ = Player.All[i2];
            if(Boolean(_loc2_.hit) && this.hit.hitTestObject(_loc2_.hit))
            {
               if(_loc2_.getKeyStatus("上",2) && this.parent == Main.world)
               {
                  removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
                  GoWhere();
               }
            }
            ++i2;
         }
      }
      
      public function GoWhere() : *
      {
         var _loc1_:WinShow = null;
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
            _loc1_ = new WinShow();
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

