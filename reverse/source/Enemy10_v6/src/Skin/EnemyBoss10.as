package src.Skin
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class EnemyBoss10 extends EnemySkin
   {
      
      internal var kk:HitXX = null;
      
      internal var time_Temp:int = 0;
      
      internal var fanBool:Boolean = false;
      
      public function EnemyBoss10()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击4")
         {
            TweenMax.to(this,3,{"dropShadowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":18,
               "blurY":18
            }});
            this.addEventListener(Event.ENTER_FRAME,fanshang);
         }
      }
      
      internal function fanshang(e:*) : *
      {
         var i:* = undefined;
         fanBool = true;
         ++time_Temp;
         if(time_Temp > 400)
         {
            time_Temp = 0;
            fanBool = false;
            TweenMax.to(this,1,{"dropShadowFilter":{
               "color":16711680,
               "alpha":0
            }});
            this.removeEventListener(Event.ENTER_FRAME,fanshang);
         }
         if(fanBool == true)
         {
            for(i in HitXX.AllHitXX)
            {
               if((this.parent as Enemy).hitXX == HitXX.AllHitXX[i])
               {
                  (this.parent as Enemy).hitXX.runArr = [0,0,0];
                  (this.parent as Enemy).hitXX.硬直 = 0;
                  (this.parent as Enemy).hitXX.times = 200;
                  (this.parent as Enemy).hitXX.gongJi_hp = (this.parent as Enemy).hitXX.gongJi_hp * ((this.parent as Enemy).hitXX.who as Player).use_gongji.getValue() * 0.1;
                  if((this.parent as Enemy).hitXX != kk)
                  {
                     kk = (this.parent as Enemy).hitXX;
                     ((this.parent as Enemy).hitXX.who as Player).HpXX((this.parent as Enemy).hitXX);
                  }
                  trace("反伤！！" + (this.parent as Enemy).hitXX.gongJi_hp);
               }
            }
         }
      }
   }
}

