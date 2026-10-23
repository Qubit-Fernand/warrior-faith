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
         this.addEventListener(Event.ADDED_TO_STAGE,init);
         this.addEventListener(Event.REMOVED_FROM_STAGE,removeMAP);
      }
      
      public function addskin() : *
      {
         var classRef:Class = Enemy.EnemyArr[81].getClass("大门") as Class;
         door = new classRef();
         this.addChild(door);
         classRef = Enemy.EnemyArr[81].getClass("水晶灯动画") as Class;
         sjdmc = new classRef();
         Main.world.moveChild_Back.addChild(sjdmc);
         sjdmc.y = 522;
         sjdmc.x = 100;
         a1 = new OtherSkin(1);
         a2 = new OtherSkin(2);
         a3 = new OtherSkin(3);
         a4 = new OtherSkin(4);
         a5 = new OtherSkin(5);
         a6 = new OtherSkin(6);
         Main.world["moveChild_Player"].addChild(a1);
         Main.world["moveChild_Player"].addChild(a2);
         Main.world["moveChild_Player"].addChild(a3);
         Main.world["moveChild_Player"].addChild(a4);
         Main.world["moveChild_Player"].addChild(a5);
         Main.world["moveChild_Player"].addChild(a6);
         a1.y = 526;
         a1.x = 163;
         a2.y = 526;
         a2.x = 318;
         a3.y = 526;
         a3.x = 480;
         a4.y = 526;
         a4.x = 635;
         a5.y = 526;
         a5.x = 788;
         a6.y = 526;
         a6.x = 943;
         a1.visible = false;
         a2.visible = false;
         a3.visible = false;
         a4.visible = false;
         a5.visible = false;
         a6.visible = false;
      }
      
      internal function removeMAP(e:*) : *
      {
         this.removeEventListener(Event.REMOVED_FROM_STAGE,removeMAP);
         this.removeEventListener(Event.ENTER_FRAME,timerGo);
      }
      
      internal function init(e:*) : *
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,init);
         addskin();
         step = 0;
         timetemp = 0;
         TiaoShi.txtShow("step = " + step);
         TiaoShi.txtShow("timetemp = " + timetemp);
         this.addEventListener(Event.ENTER_FRAME,timerGo);
      }
      
      internal function setRandom() : *
      {
         var newArr:Array = [];
         while(arr.length > 0)
         {
            newArr.push(arr.splice(Math.floor(Math.random() * arr.length),1)[0]);
         }
         arr = newArr;
      }
      
      public function timerGo(e:*) : *
      {
         var i:int = 0;
         ++timetemp;
         if(step == 0 && timetemp == 1)
         {
            NewMC.Open("文字提示1",Main._this,480,290,0,0,false,2);
         }
         if(step == 0 && timetemp > 162)
         {
            sjdmc.gotoAndPlay(1);
            step = 1;
            timetemp = 0;
         }
         if(step == 1 && timetemp > 19)
         {
            a1.visible = true;
            a2.visible = true;
            a3.visible = true;
            a4.visible = true;
            a5.visible = true;
            a6.visible = true;
            step = 2;
            timetemp = 0;
         }
         if(step == 2)
         {
            timetemp = 0;
            arr = [1,2,3,4,5,6];
            setRandom();
            step = 3;
         }
         if(step == 3)
         {
            if(timetemp > kongzhi1)
            {
               for(i = 0; i < arr.length; i++)
               {
                  if(lights == arr[i])
                  {
                     this["a" + (i + 1)].skin.gotoAndPlay(2);
                     ++lights;
                     timetemp = 0;
                     break;
                  }
               }
               if(lights > 6)
               {
                  step = 4;
                  lights = 1;
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
            door.gotoAndPlay(2);
            sjdmc.gotoAndPlay(21);
            a1.visible = false;
            a2.visible = false;
            a3.visible = false;
            a4.visible = false;
            a5.visible = false;
            a6.visible = false;
            step = 8;
            timetemp = 0;
         }
         if(step == 6)
         {
            if(timetemp == 1)
            {
               NewMC.Open("文字提示3",Main._this,480,290,0,0,false,2);
            }
            sjdmc.gotoAndPlay(21);
            a1.visible = false;
            a2.visible = false;
            a3.visible = false;
            a4.visible = false;
            a5.visible = false;
            a6.visible = false;
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
            sjdmc.gotoAndPlay(1);
            step = 10;
            timetemp = 0;
         }
         if(step == 10 && timetemp > 19)
         {
            a1.visible = true;
            a2.visible = true;
            a3.visible = true;
            a4.visible = true;
            a5.visible = true;
            a6.visible = true;
            step = 11;
            timetemp = 0;
         }
         if(step == 11)
         {
            timetemp = 0;
            arr = [1,2,3,4,5,6];
            setRandom();
            step = 12;
         }
         if(step == 12)
         {
            if(timetemp > kongzhi2)
            {
               for(i = 0; i < arr.length; i++)
               {
                  if(lights == arr[i])
                  {
                     this["a" + (i + 1)].skin.gotoAndPlay(2);
                     ++lights;
                     timetemp = 0;
                     break;
                  }
               }
               if(lights > 6)
               {
                  step = 13;
                  lights = 1;
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
            door.gotoAndPlay(174);
            sjdmc.gotoAndPlay(21);
            a1.visible = false;
            a2.visible = false;
            a3.visible = false;
            a4.visible = false;
            a5.visible = false;
            a6.visible = false;
            step = 17;
            timetemp = 0;
         }
         if(step == 15)
         {
            if(timetemp == 1)
            {
               NewMC.Open("文字提示3",Main._this,480,290,0,0,false,2);
            }
            sjdmc.gotoAndPlay(21);
            a1.visible = false;
            a2.visible = false;
            a3.visible = false;
            a4.visible = false;
            a5.visible = false;
            a6.visible = false;
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
            sjdmc.gotoAndPlay(1);
            step = 19;
            timetemp = 0;
         }
         if(step == 19 && timetemp > 19)
         {
            a1.visible = true;
            a2.visible = true;
            a3.visible = true;
            a4.visible = true;
            a5.visible = true;
            a6.visible = true;
            step = 20;
            timetemp = 0;
         }
         if(step == 20)
         {
            timetemp = 0;
            arr = [1,2,3,4,5,6];
            setRandom();
            step = 21;
         }
         if(step == 21)
         {
            if(timetemp > kongzhi3)
            {
               for(i = 0; i < arr.length; i++)
               {
                  if(lights == arr[i])
                  {
                     this["a" + (i + 1)].skin.gotoAndPlay(2);
                     ++lights;
                     timetemp = 0;
                     break;
                  }
               }
               if(lights > 6)
               {
                  step = 22;
                  lights = 1;
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
            door.gotoAndPlay(345);
            sjdmc.gotoAndPlay(21);
            a1.visible = false;
            a2.visible = false;
            a3.visible = false;
            a4.visible = false;
            a5.visible = false;
            a6.visible = false;
            step = 26;
            timetemp = 0;
         }
         if(step == 24)
         {
            if(timetemp == 1)
            {
               NewMC.Open("文字提示3",Main._this,480,290,0,0,false,2);
            }
            sjdmc.gotoAndPlay(21);
            a1.visible = false;
            a2.visible = false;
            a3.visible = false;
            a4.visible = false;
            a5.visible = false;
            a6.visible = false;
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
               Main.world.moveChild_Back.removeChild(sjdmc);
               Main.world.moveChild_Enemy.addChild(new Enemy(5003));
               timetemp = 0;
            }
         }
      }
   }
}

