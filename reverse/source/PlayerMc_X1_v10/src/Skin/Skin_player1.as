package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol239")]
   public class Skin_player1 extends Skin
   {
      
      public function Skin_player1()
      {
         super();
         addFrameScript(74,frame75,180,frame181,222,frame223,256,frame257,284,frame285);
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "技能3")
         {
            NewMC.Open("法师技能3",this.parent,0,0,540);
         }
      }
      
      internal function frame75() : *
      {
         震动();
      }
      
      internal function frame181() : *
      {
         震动();
      }
      
      internal function frame223() : *
      {
         震动();
      }
      
      internal function frame257() : *
      {
         震动();
      }
      
      internal function frame285() : *
      {
         震动();
      }
   }
}

