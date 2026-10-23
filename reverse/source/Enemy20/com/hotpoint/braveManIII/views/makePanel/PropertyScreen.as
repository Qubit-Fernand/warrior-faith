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
      
      public static function open(ob:Object = null, state:Boolean = false, _x:Number = 0, _y:Number = 0, str:String = null) : void
      {
         if(PropertyScreen._instance == null)
         {
            PropertyScreen._instance = new PropertyScreen();
         }
         Main._stage.addChild(PropertyScreen._instance);
         PropertyScreen._instance.init(ob,state,str);
         PropertyScreen._instance.visible = true;
         PropertyScreen._instance.x = _x;
         PropertyScreen._instance.y = _y;
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
      
      public function init(ob:Object = null, state:Boolean = false, str:String = null) : void
      {
         if(ob != null)
         {
            this._name.text = ob.getName().toString();
            if(!state)
            {
               this._propety.text = str;
            }
            else
            {
               trace("读取装备属性");
            }
         }
         else
         {
            this._name.text = "小提示:";
            this._propety.text = str;
         }
      }
   }
}

