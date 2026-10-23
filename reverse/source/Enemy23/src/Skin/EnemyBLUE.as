package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBLUE extends EnemySkin
   {
      
      public function EnemyBLUE()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         var i:int = 0;
         if(str == "死亡")
         {
            for(i in Enemy.All)
            {
               if((Enemy.All[i] as Enemy).id == 2006)
               {
                  (Enemy.All[i] as Enemy).防御力.setValue(1000);
                  Enemy.bool_5 = true;
                  Enemy.bool_6 = true;
                  if(EnemyBoss1206.bluebool)
                  {
                     if((Enemy.All[i] as Enemy).getChildByName("蓝"))
                     {
                        (Enemy.All[i] as Enemy).removeChild((Enemy.All[i] as Enemy).skin.blue);
                     }
                  }
                  else
                  {
                     (Enemy.All[i] as Enemy).skin.addChild(new 天罚());
                     if((Enemy.All[i] as Enemy).getChildByName("红"))
                     {
                        (Enemy.All[i] as Enemy).removeChild((Enemy.All[i] as Enemy).skin.red);
                     }
                  }
                  (Enemy.All[i] as Enemy).attack_TimeNum[4] = 0;
                  (Enemy.All[i] as Enemy).attack_TimeNum[5] = 0;
                  EnemyBoss1206.redbool = false;
                  EnemyBoss1206.bluebool = false;
               }
               else
               {
                  (Enemy.All[i] as Enemy).Dead();
               }
            }
         }
      }
   }
}

