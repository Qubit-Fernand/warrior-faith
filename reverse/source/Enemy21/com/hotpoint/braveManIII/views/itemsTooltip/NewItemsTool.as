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
         this.addChild(this.tooltip);
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
         this.tooltip["star_0"].y = 25;
         this.tooltip["star_1"].y = 25;
         this.tooltip["star_2"].y = 25;
         this.tooltip["star_3"].y = 25;
         this.tooltip["star_4"].y = 25;
         this.tooltip["star_5"].y = 25;
         this.tooltip["time_txt"].y = 54;
         this.tooltip["type_txt"].y = 72;
         this.tooltip["lv2_txt"].y = 90;
         this.tooltip["lv_txt"].y = 90;
         this.tooltip["line0"].y = 113;
         this.tooltip["line1"].y = 216;
         this.tooltip["txt_1"].y = 120;
         this.tooltip["txt_2"].y = 175;
         this.tooltip["txt_3"].y = 193;
         this.tooltip["txt_4"].y = 226;
         this.tooltip["txt_5"].y = 248;
         this.tooltip["txt_6"].y = 248;
         this.tooltip["txt_7"].y = 266;
         this.tooltip["txt_8"].y = 266;
         this.tooltip["explain"].y = 285;
         this.tooltip["price"].y = 332;
         this.tooltip["down_mc"].y = 335;
         this.tooltip["middle_mc"].y = 21;
         this.tooltip["gemslot_mc"].y = 227;
         this.tooltip["down_mc"].visible = true;
         this.tooltip["middle_mc"].visible = true;
         this.tooltip["middle_mc"].height = 315;
         this.tooltip["price"].visible = true;
         this.tooltip["explain"].visible = true;
         this.tooltip["gemslot_mc"].visible = true;
         this.tooltip["line1"].visible = true;
         this.tooltip["line0"].visible = true;
         this.tooltip["lv_txt"].visible = true;
         this.tooltip["lv2_txt"].visible = true;
         for(var i:int = 1; i < 9; i++)
         {
            this.tooltip["txt_" + i].visible = true;
         }
         for(i = 0; i < 6; i++)
         {
            this.tooltip["star_" + i].visible = false;
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
            this.ColorX(this.tooltip["name_txt"],"0xffffff");
         }
         if(equip.getColor() == 2)
         {
            this.ColorX(this.tooltip["name_txt"],"0x0066ff");
         }
         if(equip.getColor() == 3)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF33FF");
         }
         if(equip.getColor() == 4)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF9900");
         }
         if(equip.getColor() == 5)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF9900");
         }
      }
      
      public function gemAttribShow(equip:Equip) : Number
      {
         this.tooltip["txt_5"].visible = false;
         this.tooltip["txt_6"].visible = false;
         this.tooltip["txt_7"].visible = false;
         var temp:uint = 1;
         var arr:Array = [];
         arr = equip.getGemAttrib();
         if(equip.getGemSlot().getType() == 3)
         {
            switch(equip.getGemSlot().getColor())
            {
               case 1:
                  this.tooltip["gemslot_mc"].gotoAndStop(2);
                  break;
               case 2:
                  this.tooltip["gemslot_mc"].gotoAndStop(3);
                  break;
               case 3:
                  this.tooltip["gemslot_mc"].gotoAndStop(4);
            }
         }
         for(var i:uint = 0; i < arr.length; i++)
         {
            this.tooltip["txt_" + (5 + i)].text = arr[i];
            this.tooltip["txt_" + (5 + i)].visible = true;
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
         this.setPosition();
         this.tooltip["name_txt"].text = equip.getName();
         if(equip.getColor() >= 4)
         {
            this.tooltip["time_txt"].text = "剩余时间:永久";
         }
         else
         {
            this.tooltip["time_txt"].text = "剩余" + equip.getRemainingTime() + "天";
         }
         this.tooltip["type_txt"].text = "部位：" + this.getParts(equip.getPosition());
         if(equip.getDressLevel() == 100)
         {
            this.tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            this.tooltip["lv_txt"].text = "未知";
         }
         if(equip.getRemainingTime() >= 0)
         {
            this.ColorX(this.tooltip["lv_txt"],"0xffffff");
         }
         else
         {
            this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
         }
         this.tooltip["explain"].text = equip.getDescript();
         this.tooltip["price"].text = "售价:" + equip.getPrice();
         this.tooltip["type_txt"].visible = true;
         var starTemp:* = 0;
         var gemTemp:* = 0;
         var zengfuTemp:* = 0;
         var characterTemp:* = 0;
         var strengthenTemp:* = 0;
         var baseTemp:* = 0;
         var appendTemp:* = 0;
         this.tooltip["line1"].visible = false;
         this.tooltip["txt_4"].visible = false;
         this.tooltip["txt_5"].visible = false;
         this.tooltip["txt_6"].visible = false;
         this.tooltip["txt_7"].visible = false;
         this.tooltip["txt_8"].visible = false;
         this.tooltip["gemslot_mc"].visible = false;
         if(equip.getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            this.tooltip["line1"].visible = true;
            this.tooltip["txt_4"].visible = true;
            this.tooltip["gemslot_mc"].visible = true;
            if(equip.getGrid() == 0)
            {
               gemTemp = this.gemAttribShow(equip) * 18;
            }
            else
            {
               this.tooltip["gemslot_mc"].gotoAndStop(1);
               gemTemp = 36;
            }
         }
         if(equip.getNewSkill() == 0)
         {
            this.tooltip["txt_3"].visible = false;
            zengfuTemp = 18;
         }
         else
         {
            this.tooltip["txt_3"].visible = true;
            this.tooltip["txt_3"].text = equip.getEquipNewSkill();
         }
         if(equip.getSkillAttrib() == 0)
         {
            this.tooltip["txt_1"].visible = false;
            characterTemp = 54;
         }
         else
         {
            this.tooltip["txt_1"].visible = true;
            str = equip.getEquipSkillAttrib();
            regStr = /[$]/g;
            this.tooltip["txt_1"].text = str.replace(regStr,"\n");
         }
         if(equip.getReinforceLevel() == 0)
         {
            this.tooltip["txt_2"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            this.tooltip["name_txt"].text += "+" + equip.getReinforceLevel();
            this.tooltip["txt_2"].text = "强化：" + equip.showReinforceAttrib();
            this.tooltip["txt_2"].visible = true;
         }
         if(equip.getColor() < 5)
         {
            starTemp = 25;
         }
         else
         {
            this.tooltip["star_0"].visible = true;
            this.tooltip["star_1"].visible = false;
            this.tooltip["star_2"].visible = false;
            this.tooltip["star_3"].visible = false;
            this.tooltip["star_4"].visible = false;
            this.tooltip["star_5"].visible = false;
            switch(equip.getStar())
            {
               case 0:
                  break;
               case 1:
                  this.tooltip["star_1"].visible = true;
                  break;
               case 2:
                  this.tooltip["star_1"].visible = true;
                  this.tooltip["star_2"].visible = true;
                  break;
               case 3:
                  this.tooltip["star_1"].visible = true;
                  this.tooltip["star_2"].visible = true;
                  this.tooltip["star_3"].visible = true;
                  break;
               case 4:
                  this.tooltip["star_1"].visible = true;
                  this.tooltip["star_2"].visible = true;
                  this.tooltip["star_3"].visible = true;
                  this.tooltip["star_4"].visible = true;
                  break;
               case 5:
                  this.tooltip["star_1"].visible = true;
                  this.tooltip["star_2"].visible = true;
                  this.tooltip["star_3"].visible = true;
                  this.tooltip["star_4"].visible = true;
                  this.tooltip["star_5"].visible = true;
            }
         }
         this.tooltip["price"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["explain"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["middle_mc"].height -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["down_mc"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["txt_8"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["txt_7"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["txt_6"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["txt_5"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["txt_4"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["line1"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["gemslot_mc"].y -= zengfuTemp + characterTemp + strengthenTemp + starTemp;
         this.tooltip["txt_3"].y -= characterTemp + strengthenTemp + starTemp;
         this.tooltip["txt_2"].y -= characterTemp + starTemp;
         this.tooltip["txt_1"].y -= starTemp;
         this.tooltip["line0"].y -= starTemp;
         this.tooltip["lv_txt"].y -= starTemp;
         this.tooltip["lv2_txt"].y -= starTemp;
         this.tooltip["type_txt"].y -= starTemp;
         this.tooltip["time_txt"].y -= starTemp;
         this.setEquipColor(equip);
      }
   }
}

