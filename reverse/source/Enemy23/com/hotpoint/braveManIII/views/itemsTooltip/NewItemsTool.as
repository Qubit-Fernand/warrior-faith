package com.hotpoint.braveManIII.views.itemsTooltip
{
   import com.hotpoint.braveManIII.models.equip.Equip;
   import flash.display.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class NewItemsTool extends MovieClip
   {
      
      private var tooltip:MovieClip = new NewTooltip();
      
      public function NewItemsTool()
      {
         super();
         this.tooltip.x = this.x = 0;
         this.tooltip.y = this.y = 0;
         this.addChild(tooltip);
      }
      
      public function setTooltipPoint() : *
      {
         var myPoint:Point = new Point(0,0);
         myPoint = this.localToGlobal(myPoint);
         if(myPoint.y + this.height > 580)
         {
            this.y = 580 - this.height;
         }
         if(myPoint.y < 0)
         {
            this.y = 0;
         }
      }
      
      private function getParts(num:Number) : String
      {
         switch(num)
         {
            case 1:
               return "头部";
            case 2:
               return "战甲";
            case 3:
               return "项链";
            case 4:
               return "戒指";
            case 5:
               return "武器";
            case 6:
               return "法杖";
            case 7:
               return "拳套";
            case 8:
               return "时装";
            case 9:
               return "翅膀";
            default:
               return "未知";
         }
      }
      
      private function setPosition() : *
      {
         tooltip["star_0"].y = 25;
         tooltip["star_1"].y = 25;
         tooltip["star_2"].y = 25;
         tooltip["star_3"].y = 25;
         tooltip["star_4"].y = 25;
         tooltip["star_5"].y = 25;
         tooltip["time_txt"].y = 54;
         tooltip["type_txt"].y = 72;
         tooltip["lv2_txt"].y = 90;
         tooltip["lv_txt"].y = 90;
         tooltip["line0"].y = 113;
         tooltip["line1"].y = 216;
         tooltip["txt_1"].y = 120;
         tooltip["txt_2"].y = 175;
         tooltip["txt_3"].y = 193;
         tooltip["txt_4"].y = 226;
         tooltip["txt_5"].y = 248;
         tooltip["txt_6"].y = 248;
         tooltip["txt_7"].y = 266;
         tooltip["txt_8"].y = 266;
         tooltip["explain"].y = 285;
         tooltip["price"].y = 332;
         tooltip["down_mc"].y = 335;
         tooltip["middle_mc"].y = 21;
         tooltip["gemslot_mc"].y = 227;
         tooltip["down_mc"].visible = true;
         tooltip["middle_mc"].visible = true;
         tooltip["middle_mc"].height = 315;
         tooltip["price"].visible = true;
         tooltip["explain"].visible = true;
         tooltip["gemslot_mc"].visible = true;
         tooltip["line1"].visible = true;
         tooltip["line0"].visible = true;
         tooltip["lv_txt"].visible = true;
         tooltip["lv2_txt"].visible = true;
         for(var i:int = 1; i < 9; i++)
         {
            tooltip["txt_" + i].visible = true;
         }
         for(i = 0; i < 6; i++)
         {
            tooltip["star_" + i].visible = false;
         }
      }
      
      private function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      private function setEquipColor(equip:Equip) : *
      {
         if(equip.getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(equip.getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(equip.getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
         if(equip.getColor() == 4)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
         if(equip.getColor() == 5)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
      }
      
      public function gemAttribShow(equip:Equip) : Number
      {
         tooltip["txt_5"].visible = false;
         tooltip["txt_6"].visible = false;
         tooltip["txt_7"].visible = false;
         var temp:uint = 1;
         var arr:Array = [];
         arr = equip.getGemAttrib();
         if(equip.getGemSlot().getType() == 3)
         {
            switch(equip.getGemSlot().getColor())
            {
               case 1:
                  tooltip["gemslot_mc"].gotoAndStop(2);
                  break;
               case 2:
                  tooltip["gemslot_mc"].gotoAndStop(3);
                  break;
               case 3:
                  tooltip["gemslot_mc"].gotoAndStop(4);
            }
         }
         for(var i:uint = 0; i < arr.length; i++)
         {
            tooltip["txt_" + (5 + i)].text = arr[i];
            tooltip["txt_" + (5 + i)].visible = true;
         }
         if(arr.length >= 3)
         {
            temp = 0;
         }
         return temp;
      }
      
      public function equipTooltip(eq:Equip) : void
      {
         var str:String = null;
         var regStr:RegExp = null;
         var equip:Equip = eq;
         setPosition();
         tooltip["name_txt"].text = equip.getName();
         if(equip.getColor() >= 4)
         {
            tooltip["time_txt"].text = "剩余时间:永久";
         }
         else
         {
            tooltip["time_txt"].text = "剩余" + equip.getRemainingTime() + "天";
         }
         tooltip["type_txt"].text = "部位：" + getParts(equip.getPosition());
         if(equip.getDressLevel() == 100)
         {
            tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            tooltip["lv_txt"].text = "未知";
         }
         if(equip.getRemainingTime() >= 0)
         {
            ColorX(tooltip["lv_txt"],"0xffffff");
         }
         else
         {
            ColorX(tooltip["lv_txt"],"0xFF0000");
         }
         tooltip["explain"].text = equip.getDescript();
         tooltip["price"].text = "售价:" + equip.getPrice();
         tooltip["type_txt"].visible = true;
         var starTemp:* = 0;
         var gemTemp:* = 0;
         var zengfuTemp:* = 0;
         var characterTemp:* = 0;
         var strengthenTemp:* = 0;
         var baseTemp:* = 0;
         var appendTemp:* = 0;
         tooltip["line1"].visible = false;
         tooltip["txt_4"].visible = false;
         tooltip["txt_5"].visible = false;
         tooltip["txt_6"].visible = false;
         tooltip["txt_7"].visible = false;
         tooltip["txt_8"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(equip.getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_4"].visible = true;
            tooltip["gemslot_mc"].visible = true;
            if(equip.getGrid() == 0)
            {
               gemTemp = gemAttribShow(equip) * 18;
            }
            else
            {
               tooltip["gemslot_mc"].gotoAndStop(1);
               gemTemp = 36;
            }
         }
         if(equip.getNewSkill() == 0)
         {
            tooltip["txt_3"].visible = false;
            zengfuTemp = 18;
         }
         else
         {
            tooltip["txt_3"].visible = true;
            tooltip["txt_3"].text = equip.getEquipNewSkill();
         }
         if(equip.getSkillAttrib() == 0)
         {
            tooltip["txt_1"].visible = false;
            characterTemp = 54;
         }
         else
         {
            tooltip["txt_1"].visible = true;
            str = equip.getEquipSkillAttrib();
            regStr = /[$]/g;
            tooltip["txt_1"].text = str.replace(regStr,"\n");
         }
         if(equip.getReinforceLevel() == 0)
         {
            tooltip["txt_2"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + equip.getReinforceLevel();
            tooltip["txt_2"].text = "强化：" + equip.showReinforceAttrib();
            tooltip["txt_2"].visible = true;
         }
         if(equip.getBlessAttrib())
         {
            tooltip["txt_zf"].visible = true;
            tooltip["txt_zf"].text = equip.showBlessAttrib();
            strengthenTemp = 0;
         }
         else
         {
            tooltip["txt_zf"].visible = false;
         }
         if(equip.getColor() < 5)
         {
            starTemp = 25;
         }
         else
         {
            tooltip["star_0"].visible = true;
            tooltip["star_1"].visible = false;
            tooltip["star_2"].visible = false;
            tooltip["star_3"].visible = false;
            tooltip["star_4"].visible = false;
            tooltip["star_5"].visible = false;
            switch(equip.getStar())
            {
               case 0:
                  break;
               case 1:
                  tooltip["star_1"].visible = true;
                  break;
               case 2:
                  tooltip["star_1"].visible = true;
                  tooltip["star_2"].visible = true;
                  break;
               case 3:
                  tooltip["star_1"].visible = true;
                  tooltip["star_2"].visible = true;
                  tooltip["star_3"].visible = true;
                  break;
               case 4:
                  tooltip["star_1"].visible = true;
                  tooltip["star_2"].visible = true;
                  tooltip["star_3"].visible = true;
                  tooltip["star_4"].visible = true;
                  break;
               case 5:
                  tooltip["star_1"].visible = true;
                  tooltip["star_2"].visible = true;
                  tooltip["star_3"].visible = true;
                  tooltip["star_4"].visible = true;
                  tooltip["star_5"].visible = true;
            }
         }
         tooltip["price"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["explain"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["middle_mc"].height -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["down_mc"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["txt_8"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["txt_7"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["txt_6"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["txt_5"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["txt_4"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["line1"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["gemslot_mc"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         tooltip["txt_3"].y -= characterTemp + strengthenTemp + starTemp;
         tooltip["txt_2"].y -= characterTemp + starTemp;
         tooltip["txt_1"].y -= starTemp;
         tooltip["line0"].y -= starTemp;
         tooltip["lv_txt"].y -= starTemp;
         tooltip["lv2_txt"].y -= starTemp;
         tooltip["type_txt"].y -= starTemp;
         tooltip["time_txt"].y -= starTemp;
         setEquipColor(equip);
      }
   }
}

