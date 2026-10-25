package src.other
{
   import com.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.tool.*;
   
   public class MapJG extends MovieClip
   {
      
      public static var arr:Array = [1,2,3,4,5,6];
      
      public static var attTimes:int = 0;
      
      public static var timetemp:int = 0;
      
      public static var step:int = 0;
      
      internal var door:MovieClip;
      
      internal var sjdmc:MovieClip;
      
      internal var a1:OtherSkin;
      
      internal var a2:OtherSkin;
      
      internal var a3:OtherSkin;
      
      internal var a4:OtherSkin;
      
      internal var a5:OtherSkin;
      
      internal var a6:OtherSkin;
      
      internal var a7:OtherSkin;
      
      internal var kongzhi1:int = 27;
      
      internal var kongzhi2:int = 27;
      
      internal var kongzhi3:int = 27;
      
      internal var lights:int = 1;
      
      public function MapJG()
      {
         super();
         this.addEventListener(Event.ADDED_TO_STAGE,this.init);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removeMAP);
      }
      
      public function addskin() : *
      {
         var _loc1_:Class = Enemy.EnemyArr[81].getClass("大门") as Class;
         this.door = new _loc1_();
         this.addChild(this.door);
         _loc1_ = Enemy.EnemyArr[81].getClass("水晶灯动画") as Class;
         this.sjdmc = new _loc1_();
         Main.world.moveChild_Back.addChild(this.sjdmc);
         this.sjdmc.y = 522;
         this.sjdmc.x = 100;
         this.a1 = new OtherSkin(1);
         this.a2 = new OtherSkin(2);
         this.a3 = new OtherSkin(3);
         this.a4 = new OtherSkin(4);
         this.a5 = new OtherSkin(5);
         this.a6 = new OtherSkin(6);
         Main.world["moveChild_Player"].addChild(this.a1);
         Main.world["moveChild_Player"].addChild(this.a2);
         Main.world["moveChild_Player"].addChild(this.a3);
         Main.world["moveChild_Player"].addChild(this.a4);
         Main.world["moveChild_Player"].addChild(this.a5);
         Main.world["moveChild_Player"].addChild(this.a6);
         this.a1.y = 526;
         this.a1.x = 163;
         this.a2.y = 526;
         this.a2.x = 318;
         this.a3.y = 526;
         this.a3.x = 480;
         this.a4.y = 526;
         this.a4.x = 635;
         this.a5.y = 526;
         this.a5.x = 788;
         this.a6.y = 526;
         this.a6.x = 943;
         this.a1.visible = false;
         this.a2.visible = false;
         this.a3.visible = false;
         this.a4.visible = false;
         this.a5.visible = false;
         this.a6.visible = false;
      }
      
      internal function removeMAP(param1:*) : *
      {
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.removeMAP);
         this.removeEventListener(Event.ENTER_FRAME,this.timerGo);
      }
      
      internal function init(param1:*) : *
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.init);
         this.addskin();
         step = 0;
         timetemp = 0;
         TiaoShi.txtShow("step = " + step);
         TiaoShi.txtShow("timetemp = " + timetemp);
         this.addEventListener(Event.ENTER_FRAME,this.timerGo);
      }
      
      internal function setRandom() : *
      {
         var _loc1_:Array = [];
         while(arr.length > 0)
         {
            _loc1_.push(arr.splice(Math.floor(Math.random() * arr.length),1)[0]);
         }
         arr = _loc1_;
      }
      
      public function timerGo(param1:*) : *
      {
         var _loc2_:int = 0;
         ++timetemp;
         if(step == 0 && timetemp == 1)
         {
            NewMC.Open("文字提示1",Main._this,480,290,0,0,false,2);
         }
         if(step == 0 && timetemp > 162)
         {
            this.sjdmc.gotoAndPlay(1);
            step = 1;
            timetemp = 0;
         }
         if(step == 1 && timetemp > 19)
         {
            this.a1.visible = true;
            this.a2.visible = true;
            this.a3.visible = true;
            this.a4.visible = true;
            this.a5.visible = true;
            this.a6.visible = true;
            step = 2;
            timetemp = 0;
         }
         if(step == 2)
         {
            timetemp = 0;
            arr = [1,2,3,4,5,6];
            this.setRandom();
            step = 3;
         }
         if(step == 3)
         {
            if(timetemp > this.kongzhi1)
            {
               _loc2_ = 0;
               while(_loc2_ < arr.length)
               {
                  if(this.lights == arr[_loc2_])
                  {
                     this["a" + (_loc2_ + 1)].skin.gotoAndPlay(2);
                     ++this.lights;
                     timetemp = 0;
                     break;
                  }
                  _loc2_++;
               }
               if(this.lights > 6)
               {
                  step = 4;
                  this.lights = 1;
               }
            }
         }
         if(step == 4)
         {
            if(attTimes == 6)
            {
               step = 5;
               timetemp = 0;
               attTimes = 0;
            }
         }
         if(step == 5)
         {
            NewMC.Open("文字提示2",Main._this,480,290,0,0,false,2);
            this.door.gotoAndPlay(2);
            this.sjdmc.gotoAndPlay(21);
            this.a1.visible = false;
            this.a2.visible = false;
            this.a3.visible = false;
            this.a4.visible = false;
            this.a5.visible = false;
            this.a6.visible = false;
            step = 8;
            timetemp = 0;
         }
         if(step == 6)
         {
            if(timetemp == 1)
            {
               NewMC.Open("文字提示3",Main._this,480,290,0,0,false,2);
            }
            this.sjdmc.gotoAndPlay(21);
            this.a1.visible = false;
            this.a2.visible = false;
            this.a3.visible = false;
            this.a4.visible = false;
            this.a5.visible = false;
            this.a6.visible = false;
            if(timetemp > 21)
            {
               Main.world.moveChild_Enemy.addChild(new Enemy(5007));
               step = 7;
            }
         }
         if(step == 7)
         {
            if(Enemy.All.length <= 0)
            {
               step = 5;
               timetemp = 0;
            }
         }
         if(step == 8)
         {
            if(timetemp > 170)
            {
               step = 9;
               timetemp = 0;
            }
         }
         if(step == 9 && timetemp > 50)
         {
            this.sjdmc.gotoAndPlay(1);
            step = 10;
            timetemp = 0;
         }
         if(step == 10 && timetemp > 19)
         {
            this.a1.visible = true;
            this.a2.visible = true;
            this.a3.visible = true;
            this.a4.visible = true;
            this.a5.visible = true;
            this.a6.visible = true;
            step = 11;
            timetemp = 0;
         }
         if(step == 11)
         {
            timetemp = 0;
            arr = [1,2,3,4,5,6];
            this.setRandom();
            step = 12;
         }
         if(step == 12)
         {
            if(timetemp > this.kongzhi2)
            {
               _loc2_ = 0;
               while(_loc2_ < arr.length)
               {
                  if(this.lights == arr[_loc2_])
                  {
                     this["a" + (_loc2_ + 1)].skin.gotoAndPlay(2);
                     ++this.lights;
                     timetemp = 0;
                     break;
                  }
                  _loc2_++;
               }
               if(this.lights > 6)
               {
                  step = 13;
                  this.lights = 1;
               }
            }
         }
         if(step == 13)
         {
            if(attTimes == 6)
            {
               step = 14;
               timetemp = 0;
               attTimes = 0;
            }
         }
         if(step == 14)
         {
            NewMC.Open("文字提示4",Main._this,480,290,0,0,false,2);
            this.door.gotoAndPlay(174);
            this.sjdmc.gotoAndPlay(21);
            this.a1.visible = false;
            this.a2.visible = false;
            this.a3.visible = false;
            this.a4.visible = false;
            this.a5.visible = false;
            this.a6.visible = false;
            step = 17;
            timetemp = 0;
         }
         if(step == 15)
         {
            if(timetemp == 1)
            {
               NewMC.Open("文字提示3",Main._this,480,290,0,0,false,2);
            }
            this.sjdmc.gotoAndPlay(21);
            this.a1.visible = false;
            this.a2.visible = false;
            this.a3.visible = false;
            this.a4.visible = false;
            this.a5.visible = false;
            this.a6.visible = false;
            if(timetemp > 21)
            {
               Main.world.moveChild_Enemy.addChild(new Enemy(5007));
               Main.world.moveChild_Enemy.addChild(new Enemy(5009));
               step = 16;
            }
         }
         if(step == 16)
         {
            if(Enemy.All.length <= 0)
            {
               step = 14;
               timetemp = 0;
            }
         }
         if(step == 17)
         {
            if(timetemp > 170)
            {
               step = 18;
               timetemp = 0;
            }
         }
         if(step == 18 && timetemp > 50)
         {
            this.sjdmc.gotoAndPlay(1);
            step = 19;
            timetemp = 0;
         }
         if(step == 19 && timetemp > 19)
         {
            this.a1.visible = true;
            this.a2.visible = true;
            this.a3.visible = true;
            this.a4.visible = true;
            this.a5.visible = true;
            this.a6.visible = true;
            step = 20;
            timetemp = 0;
         }
         if(step == 20)
         {
            timetemp = 0;
            arr = [1,2,3,4,5,6];
            this.setRandom();
            step = 21;
         }
         if(step == 21)
         {
            if(timetemp > this.kongzhi3)
            {
               _loc2_ = 0;
               while(_loc2_ < arr.length)
               {
                  if(this.lights == arr[_loc2_])
                  {
                     this["a" + (_loc2_ + 1)].skin.gotoAndPlay(2);
                     ++this.lights;
                     timetemp = 0;
                     break;
                  }
                  _loc2_++;
               }
               if(this.lights > 6)
               {
                  step = 22;
                  this.lights = 1;
               }
            }
         }
         if(step == 22)
         {
            if(attTimes == 6)
            {
               step = 23;
               timetemp = 0;
               attTimes = 0;
            }
         }
         if(step == 23)
         {
            NewMC.Open("文字提示5",Main._this,480,290,0,0,false,2);
            this.door.gotoAndPlay(345);
            this.sjdmc.gotoAndPlay(21);
            this.a1.visible = false;
            this.a2.visible = false;
            this.a3.visible = false;
            this.a4.visible = false;
            this.a5.visible = false;
            this.a6.visible = false;
            step = 26;
            timetemp = 0;
         }
         if(step == 24)
         {
            if(timetemp == 1)
            {
               NewMC.Open("文字提示3",Main._this,480,290,0,0,false,2);
            }
            this.sjdmc.gotoAndPlay(21);
            this.a1.visible = false;
            this.a2.visible = false;
            this.a3.visible = false;
            this.a4.visible = false;
            this.a5.visible = false;
            this.a6.visible = false;
            if(timetemp > 21)
            {
               Main.world.moveChild_Enemy.addChild(new Enemy(5008));
               step = 25;
            }
         }
         if(step == 25)
         {
            if(Enemy.All.length <= 0)
            {
               step = 23;
               timetemp = 0;
            }
         }
         if(step == 26)
         {
            if(timetemp > 230)
            {
               this.parent.removeChild(this);
               Main.world.moveChild_Back.removeChild(this.sjdmc);
               Main.world.moveChild_Enemy.addChild(new Enemy(5003));
               timetemp = 0;
            }
         }
      }
   }
}

