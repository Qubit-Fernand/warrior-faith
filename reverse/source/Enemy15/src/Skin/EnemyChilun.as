package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyChilun extends EnemySkin
   {
      
      public var mc:MovieClip = new chilun();
      
      public var num:Number = 0;
      
      public var time:Number = 0;
      
      public var bool:Number = 0;
      
      public function EnemyChilun()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(this.parent)
         {
            (this.parent as Enemy).lifeMC.visible = false;
         }
         this.addEventListener(Event.ENTER_FRAME,fanghu);
      }
      
      internal function fanghu(e:*) : *
      {
         var i:* = undefined;
         if(bool == 1)
         {
            ++time;
         }
         if(time > 400)
         {
            bool = 0;
            time = 0;
            this.parent.x = mc.x;
            this.parent.y = mc.y;
            mc.x = 10000;
            for(i in Enemy.All)
            {
               if((Enemy.All[i] as Enemy).id == 50)
               {
                  (Enemy.All[i] as Enemy).skin.wudi.visible = true;
                  (Enemy.All[i] as Enemy).防御力.setValue(9989999);
               }
            }
         }
         if((this.parent as Enemy).life.getValue() < (this.parent as Enemy).lifeMAX.getValue() - 100000)
         {
            (this.parent as Enemy).life.setValue((this.parent as Enemy).lifeMAX.getValue());
            mc.x = this.parent.x;
            mc.y = this.parent.y;
            bool = 1;
            this.parent.x = 10000;
            Main.world.moveChild_Back.addChild(mc);
            for(i in Enemy.All)
            {
               if((Enemy.All[i] as Enemy).id == 50)
               {
                  (Enemy.All[i] as Enemy).skin.wudi.visible = false;
                  (Enemy.All[i] as Enemy).防御力.setValue(800);
               }
            }
         }
      }
   }
}

