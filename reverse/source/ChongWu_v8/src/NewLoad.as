package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class NewLoad extends MovieClip
   {
      
      public static var zhuangBeiSkin:Array = [new Array(),new Array(),new Array()];
      
      public static var loadArr:Array = new Array();
      
      private static var loadingYN:Boolean = true;
      
      public function NewLoad()
      {
         super();
      }
      
      public static function Loading(param1:Player) : *
      {
         param1.newSkin_LoadEnd();
      }
      
      private static function LoadGo() : *
      {
         if(loadArr.length > 0)
         {
            TiaoShi.txtShow("loadArr.length = " + loadArr.length);
            if(loadingYN)
            {
               TiaoShi.txtShow("loadArr[0][2] = " + loadArr[0][2]);
               zhuangBeiSkin[loadArr[0][0]][loadArr[0][1]] = new ClassLoader(loadArr[0][2]);
               zhuangBeiSkin[loadArr[0][0]][loadArr[0][1]].addEventListener(Event.COMPLETE,LoadEnd);
               loadingYN = false;
            }
         }
         else
         {
            Main.player_1.newSkin_LoadEnd();
            if(Main.P1P2)
            {
               Main.player_2.newSkin_LoadEnd();
            }
         }
      }
      
      private static function LoadEnd(param1:*) : *
      {
         TiaoShi.txtShow("加载完成 LoadEnd = " + loadArr[0][2] + ", loadArr.length =========== " + loadArr.length);
         loadArr.splice(0,1);
         loadingYN = true;
         LoadGo();
      }
   }
}

