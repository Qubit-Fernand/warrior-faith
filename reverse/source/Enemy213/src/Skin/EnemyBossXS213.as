package src.Skin
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class EnemyBossXS213 extends EnemySkin
   {
      
      internal var kk:HitXX = null;
      
      internal var time_Temp:int = 0;
      
      internal var rushNum:int = 0;
      
      internal var time_XX:int = 0;
      
      internal var hitMY:HitXX = null;
      
      public function EnemyBossXS213()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击2")
         {
            this.addEventListener(Event.ENTER_FRAME,this.move);
         }
         if(param1 == "攻击4")
         {
            TweenMax.to(this,3,{"dropShadowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":18,
               "blurY":18
            }});
            this.addEventListener(Event.ENTER_FRAME,this.xixue);
         }
         if(param1 == "攻击5")
         {
            TweenMax.to(this,3,{"dropShadowFilter":{
               "color":16750848,
               "alpha":1,
               "blurX":18,
               "blurY":18
            }});
            this.addEventListener(Event.ENTER_FRAME,this.bisha);
         }
         if(param1 == "死亡")
         {
            Main.wts.wantedTaskComplete();
         }
      }
      
      internal function move(param1:Event) : *
      {
         this.rushNum += 1;
         if(this.rushNum > 11 && this.rushNum < 58)
         {
            if(this.parent.RL == true)
            {
               if(this.parent.x < 1580)
               {
                  this.parent.x += 18;
               }
            }
            else if(this.parent.x > 20)
            {
               this.parent.x -= 18;
            }
         }
         if(this.rushNum > 58)
         {
            this.rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.move);
         }
      }
      
      internal function bisha(param1:*) : *
      {
         var _loc2_:* = undefined;
         for(_loc2_ in HitXX.AllHitXX)
         {
            if(!(HitXX.AllHitXX[_loc2_].parent is Fly) && HitXX.AllHitXX[_loc2_].who is Enemy && ((HitXX.AllHitXX[_loc2_].who as Enemy).id == 213 || (HitXX.AllHitXX[_loc2_].who as Enemy).id == 214 || (HitXX.AllHitXX[_loc2_].who as Enemy).id == 215))
            {
               this.addEventListener(Event.ENTER_FRAME,this.shanghai);
               TweenMax.to(this,1,{"dropShadowFilter":{
                  "color":16711680,
                  "alpha":0
               }});
               this.removeEventListener(Event.ENTER_FRAME,this.bisha);
               Enemy.xuanshang5 = true;
            }
         }
      }
      
      internal function shanghai(param1:*) : *
      {
         var _loc2_:* = undefined;
         ++this.time_XX;
         for(_loc2_ in HitXX.AllHitXX)
         {
            if(HitXX.AllHitXX[_loc2_] == Main.player_1.hitXX)
            {
               HitXX.AllHitXX[_loc2_].gongJi_hp = 99999999;
               Main.player_1.HpXX(HitXX.AllHitXX[_loc2_]);
            }
         }
         if(this.time_XX > 20)
         {
            this.time_XX = 0;
            this.removeEventListener(Event.ENTER_FRAME,this.shanghai);
         }
      }
      
      internal function xixue(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         ++this.time_Temp;
         if(this.time_Temp > 400)
         {
            this.time_Temp = 0;
            TweenMax.to(this,1,{"dropShadowFilter":{
               "color":16711680,
               "alpha":0
            }});
            this.removeEventListener(Event.ENTER_FRAME,this.xixue);
            Enemy.xuanshang5 = true;
         }
         for(_loc2_ in HitXX.AllHitXX)
         {
            if(Main.player_1.hitXX == HitXX.AllHitXX[_loc2_] && this.hitMY != HitXX.AllHitXX[_loc2_])
            {
               this.hitMY = HitXX.AllHitXX[_loc2_];
               if(this.parent)
               {
                  (this.parent as Enemy).life.setValue((this.parent as Enemy).life.getValue() + 100000);
                  if((this.parent as Enemy).life.getValue() > (this.parent as Enemy).lifeMAX.getValue())
                  {
                     (this.parent as Enemy).life.setValue((this.parent as Enemy).lifeMAX.getValue());
                  }
                  _loc3_ = 100 - this.parent.life.getValue() / this.parent.lifeMAX.getValue() * 100;
                  this.parent.lifeMC.gotoAndStop(_loc3_);
               }
            }
         }
      }
   }
}

