package src
{
   import com.hotpoint.braveManIII.models.elves.Elves;
   import com.hotpoint.braveManIII.repository.elves.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class JingLing extends MovieClip
   {
      
      public var who:Player;
      
      public var data:Elves;
      
      public var RL:Boolean = true;
      
      public function JingLing(param1:Elves, param2:Player)
      {
         super();
         who = param2;
         who.data.playerJL_Data = data = param1;
         who.playerJL = this;
         addSkin();
         mouseChildren = mouseEnabled = false;
      }
      
      public function Close() : *
      {
         this.parent.removeChild(this);
         who.playerJL = null;
         who.data.playerJL_Data = null;
      }
      
      private function addSkin() : *
      {
         var _loc1_:String = ElvesFactory.getClassName(data.getId());
         var _loc2_:Class = ChongWu.loadData.getClass(_loc1_) as Class;
         skin = new _loc2_();
         addChild(skin);
         if(who.skin)
         {
            who.skin.addChild(this);
            this.y = who.skin.y - 70;
            this.x = who.skin.x + 70;
         }
      }
   }
}

