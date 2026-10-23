package src
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class Door extends MovieClip
   {
      
      public var openYN:Boolean = false;
      
      private var time:int = 0;
      
      public function Door()
      {
         super();
         if(this.name == "地图" || this.name == "回村2" || this.name == "继续2")
         {
            this.Open();
         }
         else if(this.name == "苍井空" && (Boolean(Main.questBag()) || Boolean(Main.getAllQuest())))
         {
            this.Open();
         }
         else if(this.name == "加藤鹰" && Boolean(Main.getAllQuest()))
         {
            this.Open();
         }
         else
         {
            this.Close();
         }
      }
      
      public function Open(param1:int = 0) : *
      {
         this.openYN = true;
         if(!visible)
         {
            this.time = param1;
         }
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function Close() : *
      {
         this.openYN = false;
         this.visible = false;
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         var _loc2_:Player = null;
         if(this.parent != Main.world)
         {
            removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
            return;
         }
         if(this.time > 0)
         {
            --this.time;
            return;
         }
         this.visible = true;
         i2 = 0;
         while(i2 < Player.All.length)
         {
            _loc2_ = Player.All[i2];
            if(Boolean(visible) && Boolean(_loc2_.hit) && Boolean(this.hit.hitTestObject(_loc2_.hit)))
            {
               if(_loc2_.getKeyStatus("上",2) && this.parent == Main.world)
               {
                  removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
                  this.GoWhere();
               }
            }
            ++i2;
         }
      }
      
      public function GoWhere() : *
      {
         var _loc1_:WinShow = null;
         GameData.winYN = false;
         this.Close();
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
            _loc1_ = new WinShow();
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
      }
   }
}

