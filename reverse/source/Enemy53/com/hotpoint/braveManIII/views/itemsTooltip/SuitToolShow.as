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
         this.addChild(this.suitTool);
      }
      
      public function suitTooltipShow(id:uint) : void
      {
         this.suitTool.visible = true;
         var suitarr:Array = EquipFactory.getAllSuitEquipPostionAddName(id);
         for(var i:uint = 0; i < suitarr.length; i++)
         {
            this.suitTool["name" + i].text = suitarr[i][1];
         }
         for(var j:uint = 0; j < 4; j++)
         {
            this.ColorX(this.suitTool["name" + j],"0x00ff00");
         }
         this.suitTool["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(id);
         this.ColorX(this.suitTool["append_txt"],"0x00CCFF");
      }
      
      private function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
   }
}

