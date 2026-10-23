package com.hotpoint.braveManIII.views.itemsTooltip
{
   import com.hotpoint.braveManIII.repository.equip.*;
   import flash.display.*;
   import flash.text.*;
   
   public class SuitToolShow extends MovieClip
   {
      
      private var suitTool:MovieClip = new SuitTool();
      
      public function SuitToolShow()
      {
         super();
         this.suitTool.x = this.x = 0;
         this.suitTool.y = this.y = 0;
         this.addChild(suitTool);
      }
      
      public function suitTooltipShow(param1:uint) : void
      {
         suitTool.visible = true;
         var _loc2_:Array = EquipFactory.getAllSuitEquipPostionAddName(param1);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            suitTool["name" + _loc3_].text = _loc2_[_loc3_][1];
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < 4)
         {
            ColorX(suitTool["name" + _loc4_],"0x00ff00");
            _loc4_++;
         }
         suitTool["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(param1);
         ColorX(suitTool["append_txt"],"0x00CCFF");
      }
      
      private function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
   }
}

