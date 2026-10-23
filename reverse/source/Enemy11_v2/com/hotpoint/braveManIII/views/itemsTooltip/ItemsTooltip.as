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
      
      public function ItemsTooltip()
      {
         super();
         this.tooltip.x = this.x = 0;
         this.tooltip.y = this.y = 0;
         this.addChild(tooltip);
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
      }
      
      public function slotTooltip(overNum:uint, equipSlot:EquipSlot) : void
      {
         var gemTemp:* = undefined;
         var characterTemp:* = undefined;
         var strengthenTemp:* = undefined;
         var baseTemp:* = undefined;
         var appendTemp:* = undefined;
         var k:uint = 0;
         var Attribarr:Array = null;
         var temp1:uint = 0;
         var temp2:uint = 0;
         var i:uint = 0;
         var j:uint = 0;
         setPosition();
         tooltip["name_txt"].text = equipSlot.getEquipFromSlot(overNum).getName();
         tooltip["type_txt"].text = "部位：" + getParts(equipSlot.getEquipFromSlot(overNum).getPosition());
         tooltip["lv_txt"].text = equipSlot.getEquipFromSlot(overNum).getDressLevel();
         ColorX(tooltip["lv_txt"],"0xffffff");
         tooltip["explain"].text = equipSlot.getEquipFromSlot(overNum).getDescript();
         tooltip["price"].text = "出售价:" + equipSlot.getEquipFromSlot(overNum).getPrice();
         tooltip["type_txt"].visible = true;
         gemTemp = 0;
         characterTemp = 0;
         strengthenTemp = 0;
         baseTemp = 0;
         appendTemp = 0;
         tooltip["line1"].visible = false;
         tooltip["txt_9"].visible = false;
         tooltip["txt_10"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(equipSlot.getEquipFromSlot(overNum).getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_9"].visible = true;
            tooltip["gemslot_mc"].visible = true;
            if(equipSlot.getEquipFromSlot(overNum).getGrid() == 0)
            {
               gemTemp = slotGemAttribShow(overNum,equipSlot) * 18;
            }
            else
            {
               tooltip["gemslot_mc"].gotoAndStop(1);
               gemTemp = 54;
            }
         }
         if(equipSlot.getEquipFromSlot(overNum).getSkillAttrib() == 0)
         {
            tooltip["txt_8"].visible = false;
            characterTemp = 36;
         }
         else
         {
            tooltip["txt_8"].visible = true;
            tooltip["txt_8"].text = equipSlot.getEquipFromSlot(overNum).getEquipSkillAttrib();
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
            tooltip["txt_7"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + equipSlot.getEquipFromSlot(overNum).getReinforceLevel();
            tooltip["txt_7"].text = "强化：" + equipSlot.getEquipFromSlot(overNum).showReinforceAttrib();
            tooltip["txt_7"].visible = true;
         }
         for(k = 1; k < 7; k++)
         {
            tooltip["txt_" + k].visible = true;
         }
         Attribarr = equipSlot.getEquipFromSlot(overNum).showBaseAttrib();
         temp1 = 0;
         temp2 = 4;
         for(i = 0; i < Attribarr.length; i++)
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
         for(j = temp1 + 1; j < 5; j++)
         {
            tooltip["txt_" + j].visible = false;
            baseTemp += 18;
         }
         for(j = temp2 + 1; j < 7; j++)
         {
            tooltip["txt_" + j].visible = false;
            appendTemp += 18;
         }
         tooltip["price"].y -= gemTemp + characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["explain"].y -= gemTemp + characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["middle_mc"].height -= gemTemp + characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["down_mc"].y -= gemTemp + characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_12"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_11"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_10"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_9"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["line1"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["gemslot_mc"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_8"].y -= strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_7"].y -= baseTemp + appendTemp;
         tooltip["txt_6"].y -= baseTemp + appendTemp;
         tooltip["txt_5"].y -= baseTemp;
         setEquipSlotColor(overNum,equipSlot);
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
            default:
               return "未知";
         }
      }
      
      public function suitTooltip(id:uint, equip:Equip) : void
      {
         var suitarr:Array = null;
         var i:uint = 0;
         var pos:Number = NaN;
         suitarr = EquipFactory.getAllSuitEquipPostionAddName(id);
         for(i = 0; i < suitarr.length; i++)
         {
            tooltip["right_mc"]["name" + i].text = suitarr[i][1];
         }
         pos = equip.getPosition();
         ColorX(tooltip["right_mc"]["name" + (pos - 1)],"0x00ff00");
         tooltip["right_mc"]["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(id);
      }
      
      public function slotGemAttribShow(overNum:uint, equipSlot:EquipSlot) : Number
      {
         var temp:uint = 0;
         var arr:Array = null;
         var i:uint = 0;
         tooltip["txt_10"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         temp = 3;
         arr = [];
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
         for(i = 0; i < arr.length; i++)
         {
            tooltip["txt_" + (10 + i)].text = arr[i];
            tooltip["txt_" + (10 + i)].visible = true;
            temp--;
         }
         if(String(arr[0]).length > 10)
         {
            temp--;
         }
         if(String(arr[0]).length > 20)
         {
            temp--;
         }
         return temp;
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
      
      public function slotSuitTooltip(id:uint, overNum:uint, equipSlot:EquipSlot) : void
      {
         var temp:uint = 0;
         var suitarr:Array = null;
         var i:uint = 0;
         var j:uint = 0;
         temp = 0;
         suitarr = EquipFactory.getAllSuitEquipPostionAddName(id);
         for(i = 0; i < suitarr.length; i++)
         {
            tooltip["right_mc"]["name" + i].text = suitarr[i][1];
         }
         for(j = 0; j < 5; j++)
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
      
      private function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = undefined;
         myTextFormat = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      public function suppliesTooltip(su:Supplies, role:Number = 1) : void
      {
         var supplies:Supplies = null;
         var i:uint = 0;
         supplies = su;
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
         for(i = 1; i < 13; i++)
         {
            tooltip["txt_" + i].visible = false;
         }
         tooltip["lv_txt"].y -= 18;
         tooltip["lv2_txt"].y -= 18;
         tooltip["price"].y -= 270;
         tooltip["explain"].y -= 270;
         tooltip["middle_mc"].height -= 270;
         tooltip["down_mc"].y -= 270;
         setSuppliesColor(supplies);
      }
      
      public function gemAttribShow(equip:Equip) : Number
      {
         var temp:uint = 0;
         var arr:Array = null;
         var i:uint = 0;
         tooltip["txt_10"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         temp = 3;
         arr = [];
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
         for(i = 0; i < arr.length; i++)
         {
            tooltip["txt_" + (10 + i)].text = arr[i];
            tooltip["txt_" + (10 + i)].visible = true;
            temp--;
         }
         if(String(arr[0]).length > 10)
         {
            temp--;
         }
         if(String(arr[0]).length > 20)
         {
            temp--;
         }
         return temp;
      }
      
      public function equipTooltip(eq:Equip, role:Number = 1) : void
      {
         var equip:Equip = null;
         var gemTemp:* = undefined;
         var characterTemp:* = undefined;
         var strengthenTemp:* = undefined;
         var baseTemp:* = undefined;
         var appendTemp:* = undefined;
         var k:uint = 0;
         var Attribarr:Array = null;
         var temp1:uint = 0;
         var temp2:uint = 0;
         var i:uint = 0;
         var j:uint = 0;
         equip = eq;
         setPosition();
         tooltip["name_txt"].text = equip.getName();
         tooltip["type_txt"].text = "部位：" + getParts(equip.getPosition());
         tooltip["lv_txt"].text = equip.getDressLevel();
         if(role == 1)
         {
            if(equip.getDressLevel() <= Main.player1.getLevel())
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
            if(equip.getDressLevel() <= Main.player2.getLevel())
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
         gemTemp = 0;
         characterTemp = 0;
         strengthenTemp = 0;
         baseTemp = 0;
         appendTemp = 0;
         tooltip["line1"].visible = false;
         tooltip["txt_9"].visible = false;
         tooltip["txt_10"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(equip.getGrid() == -1)
         {
            gemTemp = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_9"].visible = true;
            tooltip["gemslot_mc"].visible = true;
            if(equip.getGrid() == 0)
            {
               gemTemp = gemAttribShow(equip) * 18;
            }
            else
            {
               tooltip["gemslot_mc"].gotoAndStop(1);
               gemTemp = 54;
            }
         }
         if(equip.getSkillAttrib() == 0)
         {
            tooltip["txt_8"].visible = false;
            characterTemp = 36;
         }
         else
         {
            tooltip["txt_8"].visible = true;
            tooltip["txt_8"].text = equip.getEquipSkillAttrib();
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
            tooltip["txt_7"].visible = false;
            strengthenTemp = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + equip.getReinforceLevel();
            tooltip["txt_7"].text = "强化：" + equip.showReinforceAttrib();
            tooltip["txt_7"].visible = true;
         }
         for(k = 1; k < 7; k++)
         {
            tooltip["txt_" + k].visible = true;
         }
         Attribarr = equip.showBaseAttrib();
         temp1 = 0;
         temp2 = 4;
         for(i = 0; i < Attribarr.length; i++)
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
         for(j = temp1 + 1; j < 5; j++)
         {
            tooltip["txt_" + j].visible = false;
            baseTemp += 18;
         }
         for(j = temp2 + 1; j < 7; j++)
         {
            tooltip["txt_" + j].visible = false;
            appendTemp += 18;
         }
         tooltip["price"].y -= gemTemp + characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["explain"].y -= gemTemp + characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["middle_mc"].height -= gemTemp + characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["down_mc"].y -= gemTemp + characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_12"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_11"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_10"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_9"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["line1"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["gemslot_mc"].y -= characterTemp + strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_8"].y -= strengthenTemp + baseTemp + appendTemp;
         tooltip["txt_7"].y -= baseTemp + appendTemp;
         tooltip["txt_6"].y -= baseTemp + appendTemp;
         tooltip["txt_5"].y -= baseTemp;
         setEquipColor(equip);
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
      }
      
      private function setPosition() : *
      {
         var i:int = 0;
         tooltip["down_mc"].y = 408.7;
         tooltip["down_mc"].visible = true;
         tooltip["middle_mc"].y = 20;
         tooltip["middle_mc"].visible = true;
         tooltip["middle_mc"].height = 390;
         tooltip["price"].y = 400;
         tooltip["price"].visible = true;
         tooltip["explain"].y = 330;
         tooltip["explain"].visible = true;
         tooltip["txt_12"].y = 312;
         tooltip["txt_11"].y = 294;
         tooltip["txt_10"].y = 276;
         tooltip["gemslot_mc"].y = 251;
         tooltip["gemslot_mc"].visible = true;
         tooltip["txt_9"].y = 253;
         tooltip["line1"].y = 246;
         tooltip["line1"].visible = true;
         tooltip["txt_8"].y = 210;
         tooltip["txt_7"].y = 192;
         tooltip["txt_6"].y = 174;
         tooltip["txt_5"].y = 156;
         tooltip["txt_4"].y = 138;
         tooltip["txt_3"].y = 120;
         tooltip["txt_2"].y = 102;
         tooltip["txt_1"].y = 84;
         tooltip["line0"].y = 79;
         tooltip["line0"].visible = true;
         tooltip["lv_txt"].y = 56;
         tooltip["lv_txt"].visible = true;
         tooltip["lv2_txt"].y = 56;
         tooltip["lv2_txt"].visible = true;
         for(i = 1; i < 13; i++)
         {
            tooltip["txt_" + i].visible = true;
         }
      }
      
      public function gemTooltip(gg:Gem, role:Number = 1) : void
      {
         var gem:Gem = null;
         var i:uint = 0;
         var temp:* = 0;
         var temp_lv:* = undefined;
         var arr:Array = null;
         gem = gg;
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
         for(i = 1; i < 13; i++)
         {
            tooltip["txt_" + i].visible = false;
         }
         temp = 3;
         temp_lv = 0;
         if(gem.getType() == GemTypeConst.ATTRIBSTONE)
         {
            arr = [];
            arr = gem.showGemAttrib();
            for(i = 0; i < arr.length; i++)
            {
               tooltip["txt_" + (10 + i)].text = arr[i];
               tooltip["txt_" + (10 + i)].visible = true;
               temp--;
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
         tooltip["lv_txt"].y -= 18;
         tooltip["lv2_txt"].y -= 18;
         tooltip["txt_10"].y -= 215;
         tooltip["txt_11"].y -= 215;
         tooltip["txt_12"].y -= 215;
         tooltip["price"].y -= 215 + 18 * temp + temp_lv;
         tooltip["explain"].y -= 215 + 18 * temp + temp_lv;
         tooltip["middle_mc"].height -= 215 + 18 * temp + temp_lv;
         tooltip["down_mc"].y -= 215 + 18 * temp + temp_lv;
         setGemColor(gem);
      }
      
      public function questTooltip(que:Quest) : void
      {
         var quest:Quest = null;
         var i:uint = 0;
         quest = que;
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
         for(i = 1; i < 13; i++)
         {
            tooltip["txt_" + i].visible = false;
         }
         tooltip["price"].y -= 290;
         tooltip["explain"].y -= 290;
         tooltip["middle_mc"].height -= 290;
         tooltip["down_mc"].y -= 290;
      }
      
      public function setTooltipPoint() : *
      {
         var myPoint:Point = null;
         myPoint = new Point(0,0);
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
      
      public function otherTooltip(oobj:Otherobj) : void
      {
         var i:uint = 0;
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
         for(i = 1; i < 13; i++)
         {
            tooltip["txt_" + i].visible = false;
         }
         tooltip["price"].y -= 290;
         tooltip["explain"].y -= 290;
         tooltip["middle_mc"].height -= 290;
         tooltip["down_mc"].y -= 290;
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
      }
   }
}

