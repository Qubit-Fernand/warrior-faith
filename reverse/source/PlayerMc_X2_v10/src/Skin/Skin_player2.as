package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.Skin;
   import src.other.最终2;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol376")]
   public class Skin_player2 extends Skin
   {
      
      public var 最终2:src.other.最终2;
      
      public function Skin_player2()
      {
         super();
         addFrameScript(102,frame103,127,frame128,144,frame145,165,frame166,229,frame230,268,frame269,279,frame280,302,frame303);
      }
      
      private function Init() : *
      {
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "转职技能4")
         {
            Init_SkillCD();
         }
      }
      
      public function Init_SkillCD() : *
      {
         var _loc1_:int = 0;
         for(_loc1_ in playX.AllSkillCDXX)
         {
            if((playX.AllSkillCDXX[_loc1_][0] as String).substr(0,1) == "c" && (playX.AllSkillCDXX[_loc1_][0] as String).substr(1,2) != "15")
            {
               playX.AllSkillCDXX[_loc1_][1] = playX.AllSkillCD[_loc1_][1];
               playX.AllSkillCDXX[_loc1_][2] = 50;
            }
         }
      }
      
      internal function frame103() : *
      {
         震动();
      }
      
      internal function frame128() : *
      {
         震动();
      }
      
      internal function frame145() : *
      {
         震动();
      }
      
      internal function frame166() : *
      {
         震动();
      }
      
      internal function frame230() : *
      {
         震动();
      }
      
      internal function frame269() : *
      {
         震动();
      }
      
      internal function frame280() : *
      {
         震动();
      }
      
      internal function frame303() : *
      {
         震动();
      }
   }
}

