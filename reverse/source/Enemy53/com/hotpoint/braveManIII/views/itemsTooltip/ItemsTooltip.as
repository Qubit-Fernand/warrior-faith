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
         this.addChild(this.tooltip);
         this.addChild(this.newItemsTool);
         this.newItemsTool.visible = false;
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
         this.tooltip["star_0"].y = 25;
         this.tooltip["star_1"].y = 25;
         this.tooltip["star_2"].y = 25;
         this.tooltip["star_3"].y = 25;
         this.tooltip["star_4"].y = 25;
         this.tooltip["star_5"].y = 25;
         this.tooltip["type_txt"].y = 54;
         this.tooltip["lv2_txt"].y = 72;
         this.tooltip["lv_txt"].y = 72;
         this.tooltip["line0"].y = 95;
         this.tooltip["line1"].y = 268;
         this.tooltip["txt_1"].y = 100;
         this.tooltip["txt_2"].y = 118;
         this.tooltip["txt_3"].y = 136;
         this.tooltip["txt_4"].y = 154;
         this.tooltip["txt_5"].y = 172;
         this.tooltip["txt_6"].y = 172;
         this.tooltip["txt_7"].y = 190;
         this.tooltip["txt_88"].y = 190;
         this.tooltip["txt_8"].y = 208;
         this.tooltip["txt_9"].y = 226;
         this.tooltip["txt_10"].y = 244;
         this.tooltip["txt_11"].y = 278;
         this.tooltip["txt_12"].y = 298;
         this.tooltip["txt_13"].y = 298;
         this.tooltip["txt_14"].y = 316;
         this.tooltip["txt_15"].y = 316;
         this.tooltip["explain"].y = 335;
         this.tooltip["price"].y = 383;
         this.tooltip["down_mc"].y = 389.7;
         this.tooltip["middle_mc"].y = 20;
         this.tooltip["gemslot_mc"].y = 277;
         this.tooltip["down_mc"].visible = true;
         this.tooltip["middle_mc"].visible = true;
         this.tooltip["middle_mc"].height = 370;
         this.tooltip["price"].visible = true;
         this.tooltip["explain"].visible = true;
         this.tooltip["gemslot_mc"].visible = true;
         this.tooltip["line1"].visible = true;
         this.tooltip["line0"].visible = true;
         this.tooltip["lv_txt"].visible = true;
         this.tooltip["lv2_txt"].visible = true;
         for(var i:int = 1; i < 15; i++)
         {
            this.tooltip["txt_" + i].visible = true;
         }
         for(i = 0; i < 6; i++)
         {
            this.tooltip["star_" + i].visible = false;
         }
         this.tooltip["txt_" + 88].visible = false;
         this.tooltip["txt_" + 15].visible = false;
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
         if(equip.getColor() == 6)
         {
            this.ColorX(this.tooltip["name_txt"],"0xCC3300");
         }
      }
      
      public function suitTooltip(id:uint, equip:Equip) : void
      {
         var suitarr:Array = EquipFactory.getAllSuitEquipPostionAddName(id);
         for(var i:uint = 0; i < suitarr.length; i++)
         {
            this.tooltip["right_mc"]["name" + i].text = suitarr[i][1];
         }
         var pos:Number = equip.getPosition();
         this.ColorX(this.tooltip["right_mc"]["name" + (pos - 1)],"0x00ff00");
         this.tooltip["right_mc"]["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(id);
      }
      
      public function gemAttribShow(equip:Equip) : Number
      {
         this.tooltip["txt_12"].visible = false;
         this.tooltip["txt_13"].visible = false;
         this.tooltip["txt_14"].visible = false;
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
            this.tooltip["txt_" + (12 + i)].text = arr[i];
            this.tooltip["txt_" + (12 + i)].visible = true;
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
            this.tooltip.visible = false;
            this.newItemsTool.visible = true;
            this.newItemsTool.equipTooltip(equip);
         }
         else
         {
            this.tooltip.visible = true;
            this.newItemsTool.visible = false;
         }
         this.setPosition();
         this.tooltip["name_txt"].text = equip.getName();
         this.tooltip["type_txt"].text = "部位：" + this.getParts(equip.getPosition());
         if(equip.getDressLevel() == 100)
         {
            this.tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            this.tooltip["lv_txt"].text = equip.getDressLevel();
         }
         if(role == 1)
         {
            if(equip.getDressLevel() <= Main.player1.getLevel() || equip.getDressLevel() == 100)
            {
               this.ColorX(this.tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
            }
         }
         else if(role == 2)
         {
            if(equip.getDressLevel() <= Main.player2.getLevel() || equip.getDressLevel() == 100)
            {
               this.ColorX(this.tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
            }
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
         this.tooltip["txt_11"].visible = false;
         this.tooltip["txt_12"].visible = false;
         this.tooltip["txt_13"].visible = false;
         this.tooltip["txt_14"].visible = false;
         this.tooltip["gemslot_mc"].visible = false;
         if(equip.getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            this.tooltip["line1"].visible = true;
            this.tooltip["txt_11"].visible = true;
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
            this.tooltip["txt_10"].visible = false;
            zengfuTemp = 18;
         }
         else
         {
            this.tooltip["txt_10"].visible = true;
            this.tooltip["txt_10"].text = equip.getEquipNewSkill();
         }
         if(equip.getSkillAttrib() == 0)
         {
            this.tooltip["txt_9"].visible = false;
            characterTemp = 18;
         }
         else
         {
            this.tooltip["txt_9"].visible = true;
            this.tooltip["txt_9"].text = equip.getEquipSkillAttrib();
         }
         if(equip.getSuitId() == 0)
         {
            this.tooltip["right_mc"].visible = false;
         }
         else
         {
            this.tooltip["right_mc"].visible = true;
            this.suitTooltip(equip.getSuitId(),equip);
         }
         if(equip.getReinforceLevel() == 0)
         {
            this.tooltip["txt_8"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            this.tooltip["name_txt"].text += "+" + equip.getReinforceLevel();
            this.tooltip["txt_8"].text = "强化：" + equip.showReinforceAttrib();
            this.tooltip["txt_8"].visible = true;
         }
         if(equip.getBlessAttrib())
         {
            this.tooltip["txt_88"].visible = true;
            this.tooltip["txt_88"].text = equip.showBlessAttrib();
         }
         else
         {
            this.tooltip["txt_88"].visible = false;
         }
         for(var k:uint = 1; k < 8; k++)
         {
            this.tooltip["txt_" + k].visible = true;
         }
         var Attribarr:Array = equip.showBaseAttrib();
         var temp1:uint = 0;
         var temp2:uint = 4;
         for(var i:uint = 0; i < Attribarr.length; i++)
         {
            if(Attribarr[i][0] == 1)
            {
               temp1++;
               this.tooltip["txt_" + temp1].text = Attribarr[i][1];
            }
            else
            {
               temp2++;
               this.tooltip["txt_" + temp2].text = Attribarr[i][1];
            }
         }
         for(var j:uint = temp1 + 1; j < 5; j++)
         {
            this.tooltip["txt_" + j].visible = false;
            baseTemp += 18;
         }
         if(temp2 == 6)
         {
            this.tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 5)
         {
            this.tooltip["txt_6"].visible = false;
            this.tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 4)
         {
            this.tooltip["txt_5"].visible = false;
            this.tooltip["txt_6"].visible = false;
            this.tooltip["txt_7"].visible = false;
            appendTemp += 36;
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
         this.tooltip["price"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["explain"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["middle_mc"].height -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["down_mc"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_14"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_13"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_12"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_11"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["line1"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["gemslot_mc"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_10"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_9"].y -= strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_88"].y -= baseTemp + appendTemp + starTemp;
         this.tooltip["txt_8"].y -= baseTemp + appendTemp + starTemp;
         this.tooltip["txt_7"].y -= baseTemp + appendTemp + starTemp;
         this.tooltip["txt_6"].y -= baseTemp + starTemp;
         this.tooltip["txt_5"].y -= baseTemp + starTemp;
         this.tooltip["txt_4"].y -= starTemp;
         this.tooltip["txt_3"].y -= starTemp;
         this.tooltip["txt_2"].y -= starTemp;
         this.tooltip["txt_1"].y -= starTemp;
         this.tooltip["line0"].y -= starTemp;
         this.tooltip["lv_txt"].y -= starTemp;
         this.tooltip["lv2_txt"].y -= starTemp;
         this.tooltip["type_txt"].y -= starTemp;
         this.setEquipColor(equip);
      }
      
      public function equipTooltipSP(eq:Equip, role:Number = 1) : void
      {
         var equip:Equip = eq;
         if(equip.getPosition() > 7 && equip.getPosition() < 10)
         {
            this.tooltip.visible = false;
            this.newItemsTool.visible = true;
            this.newItemsTool.equipTooltip(equip);
         }
         else
         {
            this.tooltip.visible = true;
            this.newItemsTool.visible = false;
         }
         this.setPosition();
         this.tooltip["name_txt"].text = equip.getName();
         this.tooltip["type_txt"].text = "部位：" + this.getParts(equip.getPosition());
         if(equip.getDressLevel() == 100)
         {
            this.tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            this.tooltip["lv_txt"].text = equip.getDressLevel();
         }
         if(role == 1)
         {
            if(equip.getDressLevel() <= Main.player1.getLevel() || equip.getDressLevel() == 100)
            {
               this.ColorX(this.tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
            }
         }
         else if(role == 2)
         {
            if(equip.getDressLevel() <= Main.player2.getLevel() || equip.getDressLevel() == 100)
            {
               this.ColorX(this.tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
            }
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
         this.tooltip["txt_11"].visible = false;
         this.tooltip["txt_12"].visible = false;
         this.tooltip["txt_13"].visible = false;
         this.tooltip["txt_14"].visible = false;
         this.tooltip["gemslot_mc"].visible = false;
         if(equip.getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            this.tooltip["line1"].visible = true;
            this.tooltip["txt_11"].visible = true;
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
            this.tooltip["txt_10"].visible = false;
            zengfuTemp = 18;
         }
         else
         {
            this.tooltip["txt_10"].visible = true;
            this.tooltip["txt_10"].text = equip.getEquipNewSkill();
         }
         if(equip.getSkillAttrib() == 0)
         {
            this.tooltip["txt_9"].visible = false;
            characterTemp = 18;
         }
         else
         {
            this.tooltip["txt_9"].visible = true;
            this.tooltip["txt_9"].text = equip.getEquipSkillAttrib();
         }
         this.tooltip["right_mc"].visible = false;
         if(equip.getReinforceLevel() == 0)
         {
            this.tooltip["txt_8"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            this.tooltip["name_txt"].text += "+" + equip.getReinforceLevel();
            this.tooltip["txt_8"].text = "强化：" + equip.showReinforceAttrib();
            this.tooltip["txt_8"].visible = true;
         }
         if(equip.getBlessAttrib())
         {
            this.tooltip["txt_88"].visible = true;
            this.tooltip["txt_88"].text = equip.showBlessAttrib();
         }
         else
         {
            this.tooltip["txt_88"].visible = false;
         }
         for(var k:uint = 1; k < 8; k++)
         {
            this.tooltip["txt_" + k].visible = true;
         }
         var Attribarr:Array = equip.showBaseAttrib();
         var temp1:uint = 0;
         var temp2:uint = 4;
         for(var i:uint = 0; i < Attribarr.length; i++)
         {
            if(Attribarr[i][0] == 1)
            {
               temp1++;
               this.tooltip["txt_" + temp1].text = Attribarr[i][1];
            }
            else
            {
               temp2++;
               this.tooltip["txt_" + temp2].text = Attribarr[i][1];
            }
         }
         for(var j:uint = temp1 + 1; j < 5; j++)
         {
            this.tooltip["txt_" + j].visible = false;
            baseTemp += 18;
         }
         if(temp2 == 6)
         {
            this.tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 5)
         {
            this.tooltip["txt_6"].visible = false;
            this.tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 4)
         {
            this.tooltip["txt_5"].visible = false;
            this.tooltip["txt_6"].visible = false;
            this.tooltip["txt_7"].visible = false;
            appendTemp += 36;
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
         this.tooltip["price"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["explain"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["middle_mc"].height -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["down_mc"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_14"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_13"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_12"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_11"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["line1"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["gemslot_mc"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_10"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_9"].y -= strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_88"].y -= baseTemp + appendTemp + starTemp;
         this.tooltip["txt_8"].y -= baseTemp + appendTemp + starTemp;
         this.tooltip["txt_7"].y -= baseTemp + appendTemp + starTemp;
         this.tooltip["txt_6"].y -= baseTemp + starTemp;
         this.tooltip["txt_5"].y -= baseTemp + starTemp;
         this.tooltip["txt_4"].y -= starTemp;
         this.tooltip["txt_3"].y -= starTemp;
         this.tooltip["txt_2"].y -= starTemp;
         this.tooltip["txt_1"].y -= starTemp;
         this.tooltip["line0"].y -= starTemp;
         this.tooltip["lv_txt"].y -= starTemp;
         this.tooltip["lv2_txt"].y -= starTemp;
         this.tooltip["type_txt"].y -= starTemp;
         this.setEquipColor(equip);
      }
      
      private function setSuppliesColor(supplies:Supplies) : *
      {
         if(supplies.getColor() == 1)
         {
            this.ColorX(this.tooltip["name_txt"],"0xffffff");
         }
         if(supplies.getColor() == 2)
         {
            this.ColorX(this.tooltip["name_txt"],"0x0066ff");
         }
         if(supplies.getColor() == 3)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF33FF");
         }
      }
      
      public function suppliesTooltip(su:Supplies, role:Number = 1) : void
      {
         this.tooltip.visible = true;
         this.newItemsTool.visible = false;
         var supplies:Supplies = su;
         this.setPosition();
         this.tooltip["name_txt"].text = supplies.getName();
         this.tooltip["lv_txt"].text = supplies.getUseLevel();
         if(role == 1)
         {
            if(supplies.getUseLevel() <= Main.player1.getLevel())
            {
               this.ColorX(this.tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
            }
         }
         else if(role == 2)
         {
            if(supplies.getUseLevel() <= Main.player2.getLevel())
            {
               this.ColorX(this.tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
            }
         }
         else
         {
            this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
         }
         this.tooltip["price"].text = "出售价：" + supplies.getPrice();
         this.tooltip["explain"].text = supplies.getDescript();
         this.tooltip["line0"].visible = false;
         this.tooltip["line1"].visible = false;
         this.tooltip["type_txt"].visible = false;
         this.tooltip["gemslot_mc"].visible = false;
         this.tooltip["right_mc"].visible = false;
         for(var i:uint = 1; i < 16; i++)
         {
            this.tooltip["txt_" + i].visible = false;
         }
         this.tooltip["lv_txt"].y -= 36;
         this.tooltip["lv2_txt"].y -= 36;
         this.tooltip["price"].y -= 270;
         this.tooltip["explain"].y -= 270;
         this.tooltip["middle_mc"].height -= 270;
         this.tooltip["down_mc"].y -= 270;
         this.setSuppliesColor(supplies);
      }
      
      private function setGemColor(gem:Gem) : *
      {
         if(gem.getColor() == 1)
         {
            this.ColorX(this.tooltip["name_txt"],"0xffffff");
         }
         if(gem.getColor() == 2)
         {
            this.ColorX(this.tooltip["name_txt"],"0x0066ff");
         }
         if(gem.getColor() == 3)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF33FF");
         }
         if(gem.getColor() == 4)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF9900");
         }
      }
      
      public function gemTooltip(gg:Gem, role:Number = 1) : void
      {
         var arr:Array = null;
         this.tooltip.visible = true;
         this.newItemsTool.visible = false;
         var gem:Gem = gg;
         this.setPosition();
         if(gem.getIsStrengthen() == true)
         {
            if(gem.getStrengthenLevel() >= 1)
            {
               this.tooltip["name_txt"].text = gem.getName() + "+" + gem.getStrengthenLevel();
            }
            else
            {
               this.tooltip["name_txt"].text = gem.getName();
            }
         }
         else
         {
            this.tooltip["name_txt"].text = gem.getName();
         }
         this.tooltip["lv_txt"].text = gem.getUseLevel();
         this.tooltip["price"].text = "出售价：" + gem.getPrice();
         this.tooltip["explain"].text = gem.getDescript();
         this.tooltip["line0"].visible = false;
         this.tooltip["line1"].visible = false;
         this.tooltip["type_txt"].visible = false;
         this.tooltip["gemslot_mc"].visible = false;
         this.tooltip["right_mc"].visible = false;
         for(var i:uint = 1; i < 16; i++)
         {
            this.tooltip["txt_" + i].visible = false;
         }
         var temp:int = 1;
         var temp_lv:* = 0;
         if(gem.getType() == GemTypeConst.ATTRIBSTONE)
         {
            arr = [];
            arr = gem.showGemAttrib();
            for(i = 0; i < arr.length; i++)
            {
               this.tooltip["txt_" + (12 + i)].text = arr[i];
               this.tooltip["txt_" + (12 + i)].visible = true;
            }
            if(arr.length >= 3)
            {
               temp = 0;
            }
            this.ColorX(this.tooltip["lv_txt"],"0xffffff");
         }
         if(gem.getType() == GemTypeConst.FRAGMENT || gem.getType() == GemTypeConst.LUCKSTONE || gem.getType() == GemTypeConst.STRENGTHENSTONE)
         {
            this.tooltip["lv2_txt"].visible = false;
            this.tooltip["lv_txt"].visible = false;
            temp_lv = 20;
         }
         else if(gem.getType() == GemTypeConst.SKILLSTONE)
         {
            if(role == 1)
            {
               if(gem.getUseLevel() <= Main.player1.getLevel())
               {
                  this.ColorX(this.tooltip["lv_txt"],"0xffffff");
               }
               else
               {
                  this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
               }
            }
            else if(role == 2)
            {
               if(gem.getUseLevel() <= Main.player2.getLevel())
               {
                  this.ColorX(this.tooltip["lv_txt"],"0xffffff");
               }
               else
               {
                  this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
               }
            }
            else
            {
               this.ColorX(this.tooltip["lv_txt"],"0xFF0000");
            }
         }
         this.tooltip["lv_txt"].y -= 40;
         this.tooltip["lv2_txt"].y -= 40;
         this.tooltip["txt_12"].y -= 248;
         this.tooltip["txt_13"].y -= 248;
         this.tooltip["txt_14"].y -= 248;
         this.tooltip["price"].y -= 248 + 18 * temp + temp_lv;
         this.tooltip["explain"].y -= 248 + 18 * temp + temp_lv;
         this.tooltip["middle_mc"].height -= 248 + 18 * temp + temp_lv;
         this.tooltip["down_mc"].y -= 248 + 18 * temp + temp_lv;
         this.setGemColor(gem);
      }
      
      private function setEquipSlotColor(overNum:uint, equipSlot:EquipSlot) : *
      {
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 1)
         {
            this.ColorX(this.tooltip["name_txt"],"0xffffff");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 2)
         {
            this.ColorX(this.tooltip["name_txt"],"0x0066ff");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 3)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF33FF");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 4)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF9900");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 5)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF9900");
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() == 6)
         {
            this.ColorX(this.tooltip["name_txt"],"0xCC3300");
         }
      }
      
      public function slotSuitTooltip(id:uint, overNum:uint, equipSlot:EquipSlot) : void
      {
         this.tooltip.visible = true;
         this.newItemsTool.visible = false;
         var temp:uint = 0;
         var suitarr:Array = EquipFactory.getAllSuitEquipPostionAddName(id);
         for(var i:uint = 0; i < suitarr.length; i++)
         {
            this.tooltip["right_mc"]["name" + i].text = suitarr[i][1];
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
                     this.ColorX(this.tooltip["right_mc"]["name" + j],"0x00ff00");
                     temp++;
                     j++;
                  }
                  else
                  {
                     this.ColorX(this.tooltip["right_mc"]["name" + j],"0x00ff00");
                     temp++;
                  }
               }
            }
         }
         this.tooltip["right_mc"]["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(id);
         if(temp == 4)
         {
            this.ColorX(this.tooltip["right_mc"]["append_txt"],"0x00CCFF");
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
            this.tooltip.visible = false;
            this.newItemsTool.visible = true;
            this.newItemsTool.equipTooltip(equipSlot.getEquipFromSlot(overNum));
         }
         else
         {
            this.tooltip.visible = true;
            this.newItemsTool.visible = false;
         }
         this.setPosition();
         this.tooltip["name_txt"].text = equipSlot.getEquipFromSlot(overNum).getName();
         this.tooltip["type_txt"].text = "部位：" + this.getParts(equipSlot.getEquipFromSlot(overNum).getPosition());
         if(equipSlot.getEquipFromSlot(overNum).getDressLevel() == 100)
         {
            this.tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            this.tooltip["lv_txt"].text = equipSlot.getEquipFromSlot(overNum).getDressLevel();
         }
         this.ColorX(this.tooltip["lv_txt"],"0xffffff");
         this.tooltip["explain"].text = equipSlot.getEquipFromSlot(overNum).getDescript();
         this.tooltip["price"].text = "出售价:" + equipSlot.getEquipFromSlot(overNum).getPrice();
         this.tooltip["type_txt"].visible = true;
         var starTemp:* = 0;
         var zengfuTemp:* = 0;
         var gemTemp:* = 0;
         var characterTemp:* = 0;
         var strengthenTemp:* = 0;
         var baseTemp:* = 0;
         var appendTemp:* = 0;
         this.tooltip["line1"].visible = false;
         this.tooltip["txt_11"].visible = false;
         this.tooltip["txt_12"].visible = false;
         this.tooltip["txt_13"].visible = false;
         this.tooltip["txt_14"].visible = false;
         this.tooltip["gemslot_mc"].visible = false;
         if(equipSlot.getEquipFromSlot(overNum).getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            this.tooltip["line1"].visible = true;
            this.tooltip["txt_11"].visible = true;
            this.tooltip["gemslot_mc"].visible = true;
            if(equipSlot.getEquipFromSlot(overNum).getGrid() == 0)
            {
               gemTemp = this.slotGemAttribShow(overNum,equipSlot) * 18;
            }
            else
            {
               this.tooltip["gemslot_mc"].gotoAndStop(1);
               gemTemp = 36;
            }
         }
         if(equipSlot.getEquipFromSlot(overNum).getSkillAttrib() == 0)
         {
            this.tooltip["txt_9"].visible = false;
            characterTemp = 18;
         }
         else
         {
            this.tooltip["txt_9"].visible = true;
            this.tooltip["txt_9"].text = equipSlot.getEquipFromSlot(overNum).getEquipSkillAttrib();
         }
         if(equipSlot.getEquipFromSlot(overNum).getNewSkill() == 0)
         {
            this.tooltip["txt_10"].visible = false;
            zengfuTemp = 18;
         }
         else
         {
            this.tooltip["txt_10"].visible = true;
            this.tooltip["txt_10"].text = equipSlot.getEquipFromSlot(overNum).getEquipNewSkill();
         }
         if(equipSlot.getEquipFromSlot(overNum).getSuitId() == 0)
         {
            this.tooltip["right_mc"].visible = false;
         }
         else
         {
            this.tooltip["right_mc"].visible = true;
            this.slotSuitTooltip(equipSlot.getEquipFromSlot(overNum).getSuitId(),overNum,equipSlot);
         }
         if(equipSlot.getEquipFromSlot(overNum).getReinforceLevel() == 0)
         {
            this.tooltip["txt_8"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            this.tooltip["name_txt"].text += "+" + equipSlot.getEquipFromSlot(overNum).getReinforceLevel();
            this.tooltip["txt_8"].text = "强化：" + equipSlot.getEquipFromSlot(overNum).showReinforceAttrib();
            this.tooltip["txt_8"].visible = true;
         }
         if(equipSlot.getEquipFromSlot(overNum).getBlessAttrib())
         {
            this.tooltip["txt_88"].visible = true;
            this.tooltip["txt_88"].text = equipSlot.getEquipFromSlot(overNum).showBlessAttrib();
         }
         else
         {
            this.tooltip["txt_88"].visible = false;
         }
         for(var k:uint = 1; k < 8; k++)
         {
            this.tooltip["txt_" + k].visible = true;
         }
         var Attribarr:Array = equipSlot.getEquipFromSlot(overNum).showBaseAttrib();
         var temp1:uint = 0;
         var temp2:uint = 4;
         for(var i:uint = 0; i < Attribarr.length; i++)
         {
            if(Attribarr[i][0] == 1)
            {
               temp1++;
               this.tooltip["txt_" + temp1].text = Attribarr[i][1];
            }
            else
            {
               temp2++;
               this.tooltip["txt_" + temp2].text = Attribarr[i][1];
            }
         }
         for(var j:uint = temp1 + 1; j < 5; j++)
         {
            this.tooltip["txt_" + j].visible = false;
            baseTemp += 18;
         }
         if(temp2 == 6)
         {
            this.tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 5)
         {
            this.tooltip["txt_6"].visible = false;
            this.tooltip["txt_7"].visible = false;
            appendTemp += 18;
         }
         else if(temp2 == 4)
         {
            this.tooltip["txt_5"].visible = false;
            this.tooltip["txt_6"].visible = false;
            this.tooltip["txt_7"].visible = false;
            appendTemp += 36;
         }
         if(equipSlot.getEquipFromSlot(overNum).getColor() < 5)
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
            switch(equipSlot.getEquipFromSlot(overNum).getStar())
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
         this.tooltip["price"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["explain"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["middle_mc"].height -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["down_mc"].y -= gemTemp + zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_14"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_13"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_12"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_11"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["line1"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["gemslot_mc"].y -= zengfuTemp + characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_10"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_9"].y -= strengthenTemp + baseTemp + appendTemp + starTemp;
         this.tooltip["txt_88"].y -= baseTemp + appendTemp + starTemp;
         this.tooltip["txt_8"].y -= baseTemp + appendTemp + starTemp;
         this.tooltip["txt_7"].y -= baseTemp + appendTemp + starTemp;
         this.tooltip["txt_6"].y -= baseTemp + starTemp;
         this.tooltip["txt_5"].y -= baseTemp + starTemp;
         this.tooltip["txt_4"].y -= starTemp;
         this.tooltip["txt_3"].y -= starTemp;
         this.tooltip["txt_2"].y -= starTemp;
         this.tooltip["txt_1"].y -= starTemp;
         this.tooltip["line0"].y -= starTemp;
         this.tooltip["lv_txt"].y -= starTemp;
         this.tooltip["lv2_txt"].y -= starTemp;
         this.tooltip["type_txt"].y -= starTemp;
         this.setEquipSlotColor(overNum,equipSlot);
      }
      
      public function slotGemAttribShow(overNum:uint, equipSlot:EquipSlot) : Number
      {
         this.tooltip["txt_12"].visible = false;
         this.tooltip["txt_13"].visible = false;
         this.tooltip["txt_14"].visible = false;
         var temp:uint = 1;
         var arr:Array = [];
         arr = equipSlot.getEquipFromSlot(overNum).getGemAttrib();
         if(equipSlot.getEquipFromSlot(overNum).getGemSlot().getType() == 3)
         {
            switch(equipSlot.getEquipFromSlot(overNum).getGemSlot().getColor())
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
            this.tooltip["txt_" + (12 + i)].text = arr[i];
            this.tooltip["txt_" + (12 + i)].visible = true;
         }
         if(arr.length >= 3)
         {
            temp = 0;
         }
         return temp;
      }
      
      public function questTooltip(que:Quest) : void
      {
         this.tooltip.visible = true;
         this.newItemsTool.visible = false;
         var quest:Quest = que;
         this.setPosition();
         this.tooltip["name_txt"].text = quest.getName();
         this.tooltip["lv_txt"].visible = false;
         this.tooltip["lv2_txt"].visible = false;
         this.tooltip["price"].text = "出售价：" + quest.getGold();
         this.tooltip["explain"].text = quest.getIntroduction();
         this.tooltip["line0"].visible = false;
         this.tooltip["line1"].visible = false;
         this.tooltip["type_txt"].visible = false;
         this.tooltip["gemslot_mc"].visible = false;
         this.tooltip["right_mc"].visible = false;
         for(var i:uint = 1; i < 16; i++)
         {
            this.tooltip["txt_" + i].visible = false;
         }
         this.tooltip["price"].y -= 290;
         this.tooltip["explain"].y -= 290;
         this.tooltip["middle_mc"].height -= 290;
         this.tooltip["down_mc"].y -= 290;
      }
      
      public function otherTooltip(oobj:Otherobj) : void
      {
         this.tooltip.visible = true;
         this.newItemsTool.visible = false;
         this.setPosition();
         this.tooltip["name_txt"].text = oobj.getName();
         this.tooltip["lv_txt"].visible = false;
         this.tooltip["lv2_txt"].visible = false;
         this.tooltip["price"].text = "出售价：" + oobj.getGold();
         this.tooltip["explain"].text = oobj.getIntroduction();
         this.tooltip["line0"].visible = false;
         this.tooltip["line1"].visible = false;
         this.tooltip["type_txt"].visible = false;
         this.tooltip["gemslot_mc"].visible = false;
         this.tooltip["right_mc"].visible = false;
         for(var i:uint = 1; i < 16; i++)
         {
            this.tooltip["txt_" + i].visible = false;
         }
         this.tooltip["price"].y -= 290;
         this.tooltip["explain"].y -= 290;
         this.tooltip["middle_mc"].height -= 290;
         this.tooltip["down_mc"].y -= 290;
         this.setOtherColor(oobj);
      }
      
      private function setOtherColor(oobj:Otherobj) : void
      {
         if(oobj.getColor() == 1)
         {
            this.ColorX(this.tooltip["name_txt"],"0xffffff");
         }
         if(oobj.getColor() == 2)
         {
            this.ColorX(this.tooltip["name_txt"],"0x0066ff");
         }
         if(oobj.getColor() == 3)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF33FF");
         }
         if(oobj.getColor() == 4)
         {
            this.ColorX(this.tooltip["name_txt"],"0xFF9900");
         }
      }
   }
}

