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
         this.who = p;
         this.who.data.playerJL_Data = this.data = _data;
         this.who.playerJL = this;
         this.addSkin();
         mouseChildren = mouseEnabled = false;
      }
      
      public function Close() : *
      {
         this.parent.removeChild(this);
         this.who.playerJL = null;
         this.who.data.playerJL_Data = null;
      }
      
      private function addSkin() : *
      {
         var classStr:String = ElvesFactory.getClassName(this.data.getId());
         var classRef:Class = ChongWu.loadData.getClass(classStr) as Class;
         skin = new classRef();
         addChild(skin);
         if(this.who.skin)
         {
            this.who.skin.addChild(this);
            this.y = this.who.skin.y - 70;
            this.x = this.who.skin.x + 70;
         }
      }
   }
}

