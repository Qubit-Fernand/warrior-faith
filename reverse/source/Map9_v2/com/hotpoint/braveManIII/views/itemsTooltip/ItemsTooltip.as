package com.hotpoint.braveManIII.views.itemsTooltip
{
   import com.hotpoint.braveManIII.models.container.EquipSlot;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.quest.Quest;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.repository.equip.*;
   import flash.display.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class ItemsTooltip extends MovieClip
   {
      
      private var tooltip:MovieClip = new TooltipShow();
      
      private var newItemsTool:NewItemsTool = new NewItemsTool();
      
      public function ItemsTooltip()
      {
         super();
         this.tooltip.x = this.x = 0;
         this.tooltip.y = this.y = 0;
         this.addChild(tooltip);
         this.addChild(newItemsTool);
         newItemsTool.visible = false;
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
            case 10:
               return "头部";
            case 11:
               return "战甲";
            case 12:
               return "项链";
            case 13:
               return "戒指";
            default:
               return "未知";
         }
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
      
      private function setPosition() : *
      {
         tooltip["star_0"].y = 25;
         tooltip["star_1"].y = 25;
         tooltip["star_2"].y = 25;
         tooltip["star_3"].y = 25;
         tooltip["star_4"].y = 25;
         tooltip["star_5"].y = 25;
         tooltip["type_txt"].y = 54;
         tooltip["lv2_txt"].y = 72;
         tooltip["lv_txt"].y = 72;
         tooltip["line0"].y = 95;
         tooltip["line1"].y = 268;
         tooltip["txt_1"].y = 100;
         tooltip["txt_2"].y = 118;
         tooltip["txt_3"].y = 136;
         tooltip["txt_4"].y = 154;
         tooltip["txt_5"].y = 172;
         tooltip["txt_6"].y = 172;
         tooltip["txt_7"].y = 190;
         tooltip["txt_88"].y = 190;
         tooltip["txt_8"].y = 208;
         tooltip["txt_9"].y = 226;
         tooltip["txt_10"].y = 244;
         tooltip["txt_11"].y = 278;
         tooltip["txt_12"].y = 298;
         tooltip["txt_13"].y = 298;
         tooltip["txt_14"].y = 316;
         tooltip["txt_15"].y = 316;
         tooltip["explain"].y = 335;
         tooltip["price"].y = 383;
         tooltip["down_mc"].y = 389.7;
         tooltip["middle_mc"].y = 20;
         tooltip["gemslot_mc"].y = 277;
         tooltip["down_mc"].visible = true;
         tooltip["middle_mc"].visible = true;
         tooltip["middle_mc"].height = 370;
         tooltip["price"].visible = true;
         tooltip["explain"].visible = true;
         tooltip["gemslot_mc"].visible = true;
         tooltip["line1"].visible = true;
         tooltip["line0"].visible = true;
         tooltip["lv_txt"].visible = true;
         tooltip["lv2_txt"].visible = true;
         for(var i:int = 1; i < 15; i++)
         {
            tooltip["txt_" + i].visible = true;
         }
         for(i = 0; i < 6; i++)
         {
            tooltip["star_" + i].visible = false;
         }
         tooltip["txt_" + 88].visible = false;
         tooltip["txt_" + 15].visible = false;
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
         if(equip.getColor() == 6)
         {
            ColorX(tooltip["name_txt"],"0xCC3300");
         }
      }
      
      public function suitTooltip(id:uint, equip:Equip) : void
      {
         var suitarr:Array = EquipFactory.getAllSuitEquipPostionAddName(id);
         for(var i:uint = 0; i < suitarr.length; i++)
         {
            tooltip["right_mc"]["name" + i].text = suitarr[i][1];
         }
         var pos:Number = equip.getPosition();
         ColorX(tooltip["right_mc"]["name" + (pos - 1)],"0x00ff00");
         tooltip["right_mc"]["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(id);
      }
      
      public function gemAttribShow(equip:Equip) : Number
      {
         tooltip["txt_12"].visible = false;
         tooltip["txt_13"].visible = false;
         tooltip["txt_14"].visible = false;
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
            tooltip["txt_" + (12 + i)].text = arr[i];
            tooltip["txt_" + (12 + i)].visible = true;
         }
         if(arr.length >= 3)
         {
            temp = 0;
         }
         return temp;
      }
      
      public function equipTooltip(eq:Equip, role:Number = 1) : void
      {
         var equip:Equip = eq;
         if(equip.getPosition() > 7 && equip.getPosition() < 10)
         {
            tooltip.visible = false;
            newItemsTool.visible = true;
            newItemsTool.equipTooltip(equip);
         }
         else
         {
            tooltip.visible = true;
            newItemsTool.visible = false;
         }
         setPosition();
         tooltip["name_txt"].text = equip.getName();
         tooltip["type_txt"].text = "部位：" + getParts(equip.getPosition());
         if(equip.getDressLevel() == 100)
         {
            tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            tooltip["lv_txt"].text = equip.getDressLevel();
         }
         if(role == 1)
         {
            if(equip.getDressLevel() <= Main.player1.getLevel() || equip.getDressLevel() == 100)
            {
               ColorX(tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               ColorX(tooltip["lv_txt"],"0xFF0000");
            }
         }
         else if(role == 2)
         {
            if(equip.getDressLevel() <= Main.player2.getLevel() || equip.getDressLevel() == 100)
            {
               ColorX(tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               ColorX(tooltip["lv_txt"],"0xFF0000");
            }
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
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         tooltip["txt_13"].visible = false;
         tooltip["txt_14"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(equip.getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_11"].visible = true;
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
            tooltip["txt_10"].visible = false;
            zengfuTemp = 18;
         }
         else
         {
            tooltip["txt_10"].visible = true;
            tooltip["txt_10"].text = equip.getEquipNewSkill();
         }
         if(equip.getSkillAttrib() == 0)
         {
            tooltip["txt_9"].visible = false;
            characterTemp = 18;
         }
         else
         {
            tooltip["txt_9"].visible = true;
            tooltip["txt_9"].text = equip.getEquipSkillAttrib();
         }
         if(equip.getSuitId() == 0)
         {
            tooltip["right_mc"].visible = false;
         }
         else
         {
            tooltip["right_mc"].visible = true;
            suitTooltip(equip.getSuitId(),equip);
         }
         if(equip.getReinforceLevel() == 0)
         {
            tooltip["txt_8"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + equip.getReinforceLevel();
            tooltip["txt_8"].text = "强化：" + equip.showReinforceAttrib();
            tooltip["txt_8"].visible = true;
         }
         if(equip.getBlessAttrib())
         {
            tooltip["txt_88"].visible = true;
            tooltip["txt_88"].text = equip.showBlessAttrib();
         }
         else
         {
            tooltip["txt_88"].visible = false;
         }
         for(var k:uint = 1; k < 8; k++)
         {
            tooltip["txt_" + k].visible = true;
         }
         var Attribarr:Array = equip.showBaseAttrib();
         var temp1:uint = 0;
         var temp2:uint = 4;
         for(var i:uint = 0; i < Attribarr.length; i++)
         {
            if(Attribarr[i][0] == 1)
            {
               temp1++;
               tooltip["txt_" + temp1].text = Attribarr[i][1];
            }
            else
            {
               temp2++;
               tooltip["txt_" + temp2].text = Attribarr[i][1];
            }
         }
         for(var j:uint = temp1 + 1; j < 5; j++)
         {
            tooltip["txt_" + j].visible = false;
            baseTemp += 18;
         }
         if(temp2 == 6)
         {
            tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 5)
         {
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 4)
         {
            tooltip["txt_5"].visible = false;
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            appendTemp += 36;
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
         tooltip["price"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["explain"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["middle_mc"].height -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["down_mc"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_14"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_13"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_12"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_11"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["line1"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["gemslot_mc"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_10"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_9"].y -= strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_88"].y -= baseTemp + appendTemp + starTemp;
         tooltip["txt_8"].y -= baseTemp + appendTemp + starTemp;
         tooltip["txt_7"].y -= baseTemp + appendTemp + starTemp;
         tooltip["txt_6"].y -= baseTemp + starTemp;
         tooltip["txt_5"].y -= baseTemp + starTemp;
         tooltip["txt_4"].y -= starTemp;
         tooltip["txt_3"].y -= starTemp;
         tooltip["txt_2"].y -= starTemp;
         tooltip["txt_1"].y -= starTemp;
         tooltip["line0"].y -= starTemp;
         tooltip["lv_txt"].y -= starTemp;
         tooltip["lv2_txt"].y -= starTemp;
         tooltip["type_txt"].y -= starTemp;
         setEquipColor(equip);
      }
      
      public function equipTooltipSP(eq:Equip, role:Number = 1) : void
      {
         var equip:Equip = eq;
         if(equip.getPosition() > 7 && equip.getPosition() < 10)
         {
            tooltip.visible = false;
            newItemsTool.visible = true;
            newItemsTool.equipTooltip(equip);
         }
         else
         {
            tooltip.visible = true;
            newItemsTool.visible = false;
         }
         setPosition();
         tooltip["name_txt"].text = equip.getName();
         tooltip["type_txt"].text = "部位：" + getParts(equip.getPosition());
         if(equip.getDressLevel() == 100)
         {
            tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            tooltip["lv_txt"].text = equip.getDressLevel();
         }
         if(role == 1)
         {
            if(equip.getDressLevel() <= Main.player1.getLevel() || equip.getDressLevel() == 100)
            {
               ColorX(tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               ColorX(tooltip["lv_txt"],"0xFF0000");
            }
         }
         else if(role == 2)
         {
            if(equip.getDressLevel() <= Main.player2.getLevel() || equip.getDressLevel() == 100)
            {
               ColorX(tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               ColorX(tooltip["lv_txt"],"0xFF0000");
            }
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
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         tooltip["txt_13"].visible = false;
         tooltip["txt_14"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(equip.getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_11"].visible = true;
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
            tooltip["txt_10"].visible = false;
            zengfuTemp = 18;
         }
         else
         {
            tooltip["txt_10"].visible = true;
            tooltip["txt_10"].text = equip.getEquipNewSkill();
         }
         if(equip.getSkillAttrib() == 0)
         {
            tooltip["txt_9"].visible = false;
            characterTemp = 18;
         }
         else
         {
            tooltip["txt_9"].visible = true;
            tooltip["txt_9"].text = equip.getEquipSkillAttrib();
         }
         tooltip["right_mc"].visible = false;
         if(equip.getReinforceLevel() == 0)
         {
            tooltip["txt_8"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + equip.getReinforceLevel();
            tooltip["txt_8"].text = "强化：" + equip.showReinforceAttrib();
            tooltip["txt_8"].visible = true;
         }
         if(equip.getBlessAttrib())
         {
            tooltip["txt_88"].visible = true;
            tooltip["txt_88"].text = equip.showBlessAttrib();
         }
         else
         {
            tooltip["txt_88"].visible = false;
         }
         for(var k:uint = 1; k < 8; k++)
         {
            tooltip["txt_" + k].visible = true;
         }
         var Attribarr:Array = equip.showBaseAttrib();
         var temp1:uint = 0;
         var temp2:uint = 4;
         for(var i:uint = 0; i < Attribarr.length; i++)
         {
            if(Attribarr[i][0] == 1)
            {
               temp1++;
               tooltip["txt_" + temp1].text = Attribarr[i][1];
            }
            else
            {
               temp2++;
               tooltip["txt_" + temp2].text = Attribarr[i][1];
            }
         }
         for(var j:uint = temp1 + 1; j < 5; j++)
         {
            tooltip["txt_" + j].visible = false;
            baseTemp += 18;
         }
         if(temp2 == 6)
         {
            tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 5)
         {
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 4)
         {
            tooltip["txt_5"].visible = false;
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            appendTemp += 36;
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
         tooltip["price"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["explain"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["middle_mc"].height -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["down_mc"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_14"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_13"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_12"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_11"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["line1"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["gemslot_mc"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_10"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_9"].y -= strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_88"].y -= baseTemp + appendTemp + starTemp;
         tooltip["txt_8"].y -= baseTemp + appendTemp + starTemp;
         tooltip["txt_7"].y -= baseTemp + appendTemp + starTemp;
         tooltip["txt_6"].y -= baseTemp + starTemp;
         tooltip["txt_5"].y -= baseTemp + starTemp;
         tooltip["txt_4"].y -= starTemp;
         tooltip["txt_3"].y -= starTemp;
         tooltip["txt_2"].y -= starTemp;
         tooltip["txt_1"].y -= starTemp;
         tooltip["line0"].y -= starTemp;
         tooltip["lv_txt"].y -= starTemp;
         tooltip["lv2_txt"].y -= starTemp;
         tooltip["type_txt"].y -= starTemp;
         setEquipColor(equip);
      }
      
      private function setSuppliesColor(supplies:Supplies) : *
      {
         if(supplies.getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(supplies.getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(supplies.getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
      }
      
      public function suppliesTooltip(su:Supplies, role:Number = 1) : void
      {
         tooltip.visible = true;
         newItemsTool.visible = false;
         var supplies:Supplies = su;
         setPosition();
         tooltip["name_txt"].text = supplies.getName();
         tooltip["lv_txt"].text = supplies.getUseLevel();
         if(role == 1)
         {
            if(supplies.getUseLevel() <= Main.player1.getLevel())
            {
               ColorX(tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               ColorX(tooltip["lv_txt"],"0xFF0000");
            }
         }
         else if(role == 2)
         {
            if(supplies.getUseLevel() <= Main.player2.getLevel())
            {
               ColorX(tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               ColorX(tooltip["lv_txt"],"0xFF0000");
            }
         }
         else
         {
            ColorX(tooltip["lv_txt"],"0xFF0000");
         }
         tooltip["price"].text = "出售价：" + supplies.getPrice();
         tooltip["explain"].text = supplies.getDescript();
         tooltip["line0"].visible = false;
         tooltip["line1"].visible = false;
         tooltip["type_txt"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         tooltip["right_mc"].visible = false;
         for(var i:uint = 1; i < 16; i++)
         {
            tooltip["txt_" + i].visible = false;
         }
         tooltip["lv_txt"].y -= 36;
         tooltip["lv2_txt"].y -= 36;
         tooltip["price"].y -= 270;
         tooltip["explain"].y -= 270;
         tooltip["middle_mc"].height -= 270;
         tooltip["down_mc"].y -= 270;
         setSuppliesColor(supplies);
      }
      
      private function setGemColor(gem:Gem) : *
      {
         if(gem.getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(gem.getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(gem.getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
         if(gem.getColor() == 4)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
      }
      
      public function gemTooltip(gg:Gem, role:Number = 1) : void
      {
         var arr:Array = null;
         tooltip.visible = true;
         newItemsTool.visible = false;
         var gem:Gem = gg;
         setPosition();
         if(gem.getIsStrengthen() == true)
         {
            if(gem.getStrengthenLevel() >= 1)
            {
               tooltip["name_txt"].text = gem.getName() + "+" + gem.getStrengthenLevel();
            }
            else
            {
               tooltip["name_txt"].text = gem.getName();
            }
         }
         else
         {
            tooltip["name_txt"].text = gem.getName();
         }
         tooltip["lv_txt"].text = gem.getUseLevel();
         tooltip["price"].text = "出售价：" + gem.getPrice();
         tooltip["explain"].text = gem.getDescript();
         tooltip["line0"].visible = false;
         tooltip["line1"].visible = false;
         tooltip["type_txt"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         tooltip["right_mc"].visible = false;
         for(var i:uint = 1; i < 16; i++)
         {
            tooltip["txt_" + i].visible = false;
         }
         var temp:int = 1;
         var temp_lv:* = 0;
         if(gem.getType() == GemTypeConst.ATTRIBSTONE)
         {
            arr = [];
            arr = gem.showGemAttrib();
            for(i = 0; i < arr.length; i++)
            {
               tooltip["txt_" + (12 + i)].text = arr[i];
               tooltip["txt_" + (12 + i)].visible = true;
            }
            if(arr.length >= 3)
            {
               temp = 0;
            }
            ColorX(tooltip["lv_txt"],"0xffffff");
         }
         if(gem.getType() == GemTypeConst.FRAGMENT || gem.getType() == GemTypeConst.LUCKSTONE || gem.getType() == GemTypeConst.STRENGTHENSTONE)
         {
            tooltip["lv2_txt"].visible = false;
            tooltip["lv_txt"].visible = false;
            temp_lv = 20;
         }
         else if(gem.getType() == GemTypeConst.SKILLSTONE)
         {
            if(role == 1)
            {
               if(gem.getUseLevel() <= Main.player1.getLevel())
               {
                  ColorX(tooltip["lv_txt"],"0xffffff");
               }
               else
               {
                  ColorX(tooltip["lv_txt"],"0xFF0000");
               }
            }
            else if(role == 2)
            {
               if(gem.getUseLevel() <= Main.player2.getLevel())
               {
                  ColorX(tooltip["lv_txt"],"0xffffff");
               }
               else
               {
                  ColorX(tooltip["lv_txt"],"0xFF0000");
               }
            }
            else
            {
               ColorX(tooltip["lv_txt"],"0xFF0000");
            }
         }
         tooltip["lv_txt"].y -= 40;
         tooltip["lv2_txt"].y -= 40;
         tooltip["txt_12"].y -= 248;
         tooltip["txt_13"].y -= 248;
         tooltip["txt_14"].y -= 248;
         tooltip["price"].y -= 248 + 18 * temp + temp_lv;
         tooltip["explain"].y -= 248 + 18 * temp + temp_lv;
         tooltip["middle_mc"].height -= 248 + 18 * temp + temp_lv;
         tooltip["down_mc"].y -= 248 + 18 * temp + temp_lv;
         setGemColor(gem);
      }
      
      private function setEquipSlotColor(overNum:uint, equipSlot:EquipSlot) : *
      {
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 4)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 5)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 6)
         {
            ColorX(tooltip["name_txt"],"0xCC3300");
         }
      }
      
      public function slotSuitTooltip(id:uint, overNum:uint, equipSlot:EquipSlot) : void
      {
         tooltip.visible = true;
         newItemsTool.visible = false;
         var temp:uint = 0;
         var suitarr:Array = EquipFactory.getAllSuitEquipPostionAddName(id);
         for(var i:uint = 0; i < suitarr.length; i++)
         {
            tooltip["right_mc"]["name" + i].text = suitarr[i][1];
         }
         for(var j:uint = 0; j < 5; j++)
         {
            if(equipSlot.getEquipFromSlot(j) != null)
            {
               if(equipSlot.getEquipFromSlot(j).getSuitId() == id)
               {
                  if(j > 2)
                  {
                     j--;
                     ColorX(tooltip["right_mc"]["name" + j],"0x00ff00");
                     temp++;
                     j++;
                  }
                  else
                  {
                     ColorX(tooltip["right_mc"]["name" + j],"0x00ff00");
                     temp++;
                  }
               }
            }
         }
         tooltip["right_mc"]["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(id);
         if(temp == 4)
         {
            ColorX(tooltip["right_mc"]["append_txt"],"0x00CCFF");
         }
      }
      
      public function slotTooltip(overNum:uint, equipSlot:EquipSlot) : void
      {
         if(Main.water.getValue() != 1 && (overNum == 0 || overNum == 1 || overNum == 3 || overNum == 4))
         {
            overNum += 8;
         }
         if(equipSlot.getEquipFromSlot(overNum).getPosition() > 7 && equipSlot.getEquipFromSlot(overNum).getPosition() < 10)
         {
            tooltip.visible = false;
            newItemsTool.visible = true;
            newItemsTool.equipTooltip(equipSlot.getEquipFromSlot(overNum));
         }
         else
         {
            tooltip.visible = true;
            newItemsTool.visible = false;
         }
         setPosition();
         tooltip["name_txt"].text = equipSlot.getEquipFromSlot(overNum).getName();
         tooltip["type_txt"].text = "部位：" + getParts(equipSlot.getEquipFromSlot(overNum).getPosition());
         if(equipSlot.getEquipFromSlot(overNum).getDressLevel() == 100)
         {
            tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            tooltip["lv_txt"].text = equipSlot.getEquipFromSlot(overNum).getDressLevel();
         }
         ColorX(tooltip["lv_txt"],"0xffffff");
         tooltip["explain"].text = equipSlot.getEquipFromSlot(overNum).getDescript();
         tooltip["price"].text = "出售价:" + equipSlot.getEquipFromSlot(overNum).getPrice();
         tooltip["type_txt"].visible = true;
         var starTemp:* = 0;
         var zengfuTemp:* = 0;
         var gemTemp:* = 0;
         var characterTemp:* = 0;
         var strengthenTemp:* = 0;
         var baseTemp:* = 0;
         var appendTemp:* = 0;
         tooltip["line1"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         tooltip["txt_13"].visible = false;
         tooltip["txt_14"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(equipSlot.getEquipFromSlot(overNum).getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_11"].visible = true;
            tooltip["gemslot_mc"].visible = true;
            if(equipSlot.getEquipFromSlot(overNum).getGrid() == 0)
            {
               gemTemp = slotGemAttribShow(overNum,equipSlot) * 18;
            }
            else
            {
               tooltip["gemslot_mc"].gotoAndStop(1);
               gemTemp = 36;
            }
         }
         if(equipSlot.getEquipFromSlot(overNum).getSkillAttrib() == 0)
         {
            tooltip["txt_9"].visible = false;
            characterTemp = 18;
         }
         else
         {
            tooltip["txt_9"].visible = true;
            tooltip["txt_9"].text = equipSlot.getEquipFromSlot(overNum).getEquipSkillAttrib();
         }
         if(equipSlot.getEquipFromSlot(overNum).getNewSkill() == 0)
         {
            tooltip["txt_10"].visible = false;
            zengfuTemp = 18;
         }
         else
         {
            tooltip["txt_10"].visible = true;
            tooltip["txt_10"].text = equipSlot.getEquipFromSlot(overNum).getEquipNewSkill();
         }
         if(equipSlot.getEquipFromSlot(overNum).getSuitId() == 0)
         {
            tooltip["right_mc"].visible = false;
         }
         else
         {
            tooltip["right_mc"].visible = true;
            slotSuitTooltip(equipSlot.getEquipFromSlot(overNum).getSuitId(),overNum,equipSlot);
         }
         if(equipSlot.getEquipFromSlot(overNum).getReinforceLevel() == 0)
         {
            tooltip["txt_8"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + equipSlot.getEquipFromSlot(overNum).getReinforceLevel();
            tooltip["txt_8"].text = "强化：" + equipSlot.getEquipFromSlot(overNum).showReinforceAttrib();
            tooltip["txt_8"].visible = true;
         }
         if(equipSlot.getEquipFromSlot(overNum).getBlessAttrib())
         {
            tooltip["txt_88"].visible = true;
            tooltip["txt_88"].text = equipSlot.getEquipFromSlot(overNum).showBlessAttrib();
         }
         else
         {
            tooltip["txt_88"].visible = false;
         }
         for(var k:uint = 1; k < 8; k++)
         {
            tooltip["txt_" + k].visible = true;
         }
         var Attribarr:Array = equipSlot.getEquipFromSlot(overNum).showBaseAttrib();
         var temp1:uint = 0;
         var temp2:uint = 4;
         for(var i:uint = 0; i < Attribarr.length; i++)
         {
            if(Attribarr[i][0] == 1)
            {
               temp1++;
               tooltip["txt_" + temp1].text = Attribarr[i][1];
            }
            else
            {
               temp2++;
               tooltip["txt_" + temp2].text = Attribarr[i][1];
            }
         }
         for(var j:uint = temp1 + 1; j < 5; j++)
         {
            tooltip["txt_" + j].visible = false;
            baseTemp += 18;
         }
         if(temp2 == 6)
         {
            tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 5)
         {
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 4)
         {
            tooltip["txt_5"].visible = false;
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            appendTemp += 36;
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() < 5)
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
            switch(equipSlot.getEquipFromSlot(overNum).getStar())
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
         tooltip["price"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["explain"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["middle_mc"].height -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["down_mc"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_14"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_13"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_12"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_11"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["line1"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["gemslot_mc"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_10"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_9"].y -= strengthenTemp + baseTemp + appendTemp + starTemp;
         tooltip["txt_88"].y -= baseTemp + appendTemp + starTemp;
         tooltip["txt_8"].y -= baseTemp + appendTemp + starTemp;
         tooltip["txt_7"].y -= baseTemp + appendTemp + starTemp;
         tooltip["txt_6"].y -= baseTemp + starTemp;
         tooltip["txt_5"].y -= baseTemp + starTemp;
         tooltip["txt_4"].y -= starTemp;
         tooltip["txt_3"].y -= starTemp;
         tooltip["txt_2"].y -= starTemp;
         tooltip["txt_1"].y -= starTemp;
         tooltip["line0"].y -= starTemp;
         tooltip["lv_txt"].y -= starTemp;
         tooltip["lv2_txt"].y -= starTemp;
         tooltip["type_txt"].y -= starTemp;
         setEquipSlotColor(overNum,equipSlot);
      }
      
      public function slotGemAttribShow(overNum:uint, equipSlot:EquipSlot) : Number
      {
         tooltip["txt_12"].visible = false;
         tooltip["txt_13"].visible = false;
         tooltip["txt_14"].visible = false;
         var temp:uint = 1;
         var arr:Array = [];
         arr = equipSlot.getEquipFromSlot(overNum).getGemAttrib();
         if(equipSlot.getEquipFromSlot(overNum).getGemSlot().getType() == 3)
         {
            switch(equipSlot.getEquipFromSlot(overNum).getGemSlot().getColor())
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
            tooltip["txt_" + (12 + i)].text = arr[i];
            tooltip["txt_" + (12 + i)].visible = true;
         }
         if(arr.length >= 3)
         {
            temp = 0;
         }
         return temp;
      }
      
      public function questTooltip(que:Quest) : void
      {
         tooltip.visible = true;
         newItemsTool.visible = false;
         var quest:Quest = que;
         setPosition();
         tooltip["name_txt"].text = quest.getName();
         tooltip["lv_txt"].visible = false;
         tooltip["lv2_txt"].visible = false;
         tooltip["price"].text = "出售价：" + quest.getGold();
         tooltip["explain"].text = quest.getIntroduction();
         tooltip["line0"].visible = false;
         tooltip["line1"].visible = false;
         tooltip["type_txt"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         tooltip["right_mc"].visible = false;
         for(var i:uint = 1; i < 16; i++)
         {
            tooltip["txt_" + i].visible = false;
         }
         tooltip["price"].y -= 290;
         tooltip["explain"].y -= 290;
         tooltip["middle_mc"].height -= 290;
         tooltip["down_mc"].y -= 290;
      }
      
      public function otherTooltip(oobj:Otherobj) : void
      {
         tooltip.visible = true;
         newItemsTool.visible = false;
         setPosition();
         tooltip["name_txt"].text = oobj.getName();
         tooltip["lv_txt"].visible = false;
         tooltip["lv2_txt"].visible = false;
         tooltip["price"].text = "出售价：" + oobj.getGold();
         tooltip["explain"].text = oobj.getIntroduction();
         tooltip["line0"].visible = false;
         tooltip["line1"].visible = false;
         tooltip["type_txt"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         tooltip["right_mc"].visible = false;
         for(var i:uint = 1; i < 16; i++)
         {
            tooltip["txt_" + i].visible = false;
         }
         tooltip["price"].y -= 290;
         tooltip["explain"].y -= 290;
         tooltip["middle_mc"].height -= 290;
         tooltip["down_mc"].y -= 290;
         setOtherColor(oobj);
      }
      
      private function setOtherColor(oobj:Otherobj) : void
      {
         if(oobj.getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(oobj.getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(oobj.getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
         if(oobj.getColor() == 4)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
      }
   }
}

