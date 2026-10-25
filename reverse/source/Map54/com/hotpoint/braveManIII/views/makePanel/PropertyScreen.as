package com.hotpoint.braveManIII.views.makePanel
{
   import flash.display.MovieClip;
   import src.*;
   
   public class PropertyScreen extends MovieClip
   {
      
      private static var _instance:PropertyScreen;
      
      public function PropertyScreen()
      {
         super();
      }
      
      public static function open(param1:Object = null, param2:Boolean = false, param3:Number = 0, param4:Number = 0, param5:String = null) : void
      {
         if(PropertyScreen._instance == null)
         {
            PropertyScreen._instance = new PropertyScreen();
         }
         Main._stage.addChild(PropertyScreen._instance);
         PropertyScreen._instance.init(param1,param2,param5);
         PropertyScreen._instance.visible = true;
         PropertyScreen._instance.x = param3;
         PropertyScreen._instance.y = param4;
      }
      
      public static function close() : void
      {
         if(PropertyScreen._instance != null)
         {
            if(PropertyScreen._instance.visible = true)
            {
               PropertyScreen._instance.visible = false;
            }
         }
      }
      
      public function init(param1:Object = null, param2:Boolean = false, param3:String = null) : void
      {
         if(param1 != null)
         {
            this._name.text = param1.getName().toString();
            if(!param2)
            {
               this._propety.text = param3;
            }
            else
            {
               trace("读取装备属性");
            }
         }
         else
         {
            this._name.text = "小提示:";
            this._propety.text = param3;
         }
      }
   }
}

