package src
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class Door extends MovieClip
   {
      
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
         this.visible = false;
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function Open() : *
      {
         this.visible = true;
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         var _loc2_:Player = null;
         if(!this.visible)
         {
            return;
         }
         i2 = 0;
         while(i2 < Player.All.length)
         {
            _loc2_ = Player.All[i2];
            if(Boolean(_loc2_.hit) && Boolean(this.hit.hitTestObject(_loc2_.hit)))
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
            Main.gameNum = 0;
            Main.gameNum2 = 0;
            Main._this.Loading();
            Player.一起信春哥();
            Main.Save();
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

