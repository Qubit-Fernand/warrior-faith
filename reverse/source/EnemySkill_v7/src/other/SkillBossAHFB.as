package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class SkillBossAHFB extends FlyPerson
   {
      
      public function SkillBossAHFB()
      {
         super();
      }
      
      override public function Move() : *
      {
         this.y = who.y;
         this.x = who.x;
         if(this.x > 6000 || this.x < -400)
         {
            life = 0;
         }
      }
   }
}

