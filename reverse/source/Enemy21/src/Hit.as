package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2")]
   public class Hit extends MovieClip
   {
      
      public var who:Object;
      
      public function Hit()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onREMOVED_FROM_STAGE);
      }
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         if(this.parent is Skin && this.parent.parent is Player)
         {
            (this.parent.parent as Player).hit = this;
         }
         else if(this.parent is EnemySkin && this.parent.parent is Enemy)
         {
            (this.parent.parent as Enemy).hit = this;
         }
         else if(this.parent is Skin && this.parent.parent is Player2)
         {
            (this.parent.parent as Player2).hit = this;
         }
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         if(this.parent is Skin && this.parent.parent is Player)
         {
            (this.parent.parent as Player).hit = null;
         }
         else if(this.parent is EnemySkin && this.parent.parent is Enemy)
         {
            (this.parent.parent as Enemy).hit = null;
         }
         else if(this.parent is Skin && this.parent.parent is Player2)
         {
            (this.parent.parent as Player2).hit = null;
         }
      }
   }
}

