package src.other
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol64")]
   public class 陷阱_岩石 extends MovieClip
   {
      
      public static var gongJi_hpX:Number = VT.GetTempVT("6*10*10");
      
      public var hit:伤害区;
      
      public var gongJi_hp:Number;
      
      public var times:int = 1;
      
      public var 硬直:int = 20;
      
      public var RL:Boolean = false;
      
      public var runArr:Array = [50,30,4];
      
      public var who:MovieClip = this;
      
      public function 陷阱_岩石()
      {
         super();
         gongJi_hp = gongJi_hpX;
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(e:* = null) : *
      {
         if(!this["hit"])
         {
            if(GameData.deadMcYN)
            {
               stop();
            }
            removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            return;
         }
         for(i2 = 0; i2 < Player.All.length; ++i2)
         {
            if(Boolean(this["hit"]) && Boolean((Player.All[i2] as Player).hp.getValue() > 0) && Boolean(Player.All[i2].hit) && Boolean(this["hit"].hitTestObject(Player.All[i2].hit)))
            {
               (Player.All[i2] as Player).HpXX(this);
            }
         }
      }
   }
}

