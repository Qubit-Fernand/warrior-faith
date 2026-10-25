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
      
      public function JingLing(_data:Elves, p:Player)
      {
         super();
         who = p;
         who.data.playerJL_Data = data = _data;
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
         var classStr:String = ElvesFactory.getClassName(data.getId());
         var classRef:Class = ChongWu.loadData.getClass(classStr) as Class;
         skin = new classRef();
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

