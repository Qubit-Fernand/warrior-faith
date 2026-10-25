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
      
      private function getParts(param1:Number) : String
      {
         switch(param1)
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
      
      public function setTooltipPoint() : *
      {
         var _loc1_:Point = new Point(0,0);
         _loc1_ = this.localToGlobal(_loc1_);
         if(_loc1_.y + this.height > 580)
         {
            this.y = 580 - this.height;
         }
         if(_loc1_.y < 0)
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
         var _loc1_:int = 1;
         while(_loc1_ < 15)
         {
            tooltip["txt_" + _loc1_].visible = true;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            tooltip["star_" + _loc1_].visible = false;
            _loc1_++;
         }
         tooltip["txt_" + 88].visible = false;
         tooltip["txt_" + 15].visible = false;
      }
      
      private function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      private function setEquipColor(param1:Equip) : *
      {
         if(param1.getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(param1.getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(param1.getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
         if(param1.getColor() == 4)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
         if(param1.getColor() == 5)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
      }
      
      public function suitTooltip(param1:uint, param2:Equip) : void
      {
         var _loc3_:Array = EquipFactory.getAllSuitEquipPostionAddName(param1);
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            tooltip["right_mc"]["name" + _loc4_].text = _loc3_[_loc4_][1];
            _loc4_++;
         }
         var _loc5_:Number = param2.getPosition();
         ColorX(tooltip["right_mc"]["name" + (_loc5_ - 1)],"0x00ff00");
         tooltip["right_mc"]["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(param1);
      }
      
      public function gemAttribShow(param1:Equip) : Number
      {
         tooltip["txt_12"].visible = false;
         tooltip["txt_13"].visible = false;
         tooltip["txt_14"].visible = false;
         var _loc2_:uint = 1;
         var _loc3_:Array = [];
         _loc3_ = param1.getGemAttrib();
         if(param1.getGemSlot().getType() == 3)
         {
            switch(param1.getGemSlot().getColor())
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
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            tooltip["txt_" + (12 + _loc4_)].text = _loc3_[_loc4_];
            tooltip["txt_" + (12 + _loc4_)].visible = true;
            _loc4_++;
         }
         if(_loc3_.length >= 3)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function equipTooltip(param1:Equip, param2:Number = 1) : void
      {
         var _loc3_:Equip = param1;
         if(_loc3_.getPosition() > 7)
         {
            tooltip.visible = false;
            newItemsTool.visible = true;
            newItemsTool.equipTooltip(_loc3_);
         }
         else
         {
            tooltip.visible = true;
            newItemsTool.visible = false;
         }
         setPosition();
         tooltip["name_txt"].text = _loc3_.getName();
         tooltip["type_txt"].text = "部位：" + getParts(_loc3_.getPosition());
         if(_loc3_.getDressLevel() == 100)
         {
            tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            tooltip["lv_txt"].text = _loc3_.getDressLevel();
         }
         if(param2 == 1)
         {
            if(_loc3_.getDressLevel() <= Main.player1.getLevel() || _loc3_.getDressLevel() == 100)
            {
               ColorX(tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               ColorX(tooltip["lv_txt"],"0xFF0000");
            }
         }
         else if(param2 == 2)
         {
            if(_loc3_.getDressLevel() <= Main.player2.getLevel() || _loc3_.getDressLevel() == 100)
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
         tooltip["explain"].text = _loc3_.getDescript();
         tooltip["price"].text = "售价:" + _loc3_.getPrice();
         tooltip["type_txt"].visible = true;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         tooltip["line1"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         tooltip["txt_13"].visible = false;
         tooltip["txt_14"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(_loc3_.getGrid() == -1)
         {
            _loc5_ = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_11"].visible = true;
            tooltip["gemslot_mc"].visible = true;
            if(_loc3_.getGrid() == 0)
            {
               _loc5_ = gemAttribShow(_loc3_) * 18;
            }
            else
            {
               tooltip["gemslot_mc"].gotoAndStop(1);
               _loc5_ = 36;
            }
         }
         if(_loc3_.getNewSkill() == 0)
         {
            tooltip["txt_10"].visible = false;
            _loc6_ = 18;
         }
         else
         {
            tooltip["txt_10"].visible = true;
            tooltip["txt_10"].text = _loc3_.getEquipNewSkill();
         }
         if(_loc3_.getSkillAttrib() == 0)
         {
            tooltip["txt_9"].visible = false;
            _loc7_ = 18;
         }
         else
         {
            tooltip["txt_9"].visible = true;
            tooltip["txt_9"].text = _loc3_.getEquipSkillAttrib();
         }
         if(_loc3_.getSuitId() == 0)
         {
            tooltip["right_mc"].visible = false;
         }
         else
         {
            tooltip["right_mc"].visible = true;
            suitTooltip(_loc3_.getSuitId(),_loc3_);
         }
         if(_loc3_.getReinforceLevel() == 0)
         {
            tooltip["txt_8"].visible = false;
            _loc8_ = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + _loc3_.getReinforceLevel();
            tooltip["txt_8"].text = "强化：" + _loc3_.showReinforceAttrib();
            tooltip["txt_8"].visible = true;
         }
         if(_loc3_.getBlessAttrib())
         {
            tooltip["txt_88"].visible = true;
            tooltip["txt_88"].text = _loc3_.showBlessAttrib();
         }
         else
         {
            tooltip["txt_88"].visible = false;
         }
         var _loc11_:uint = 1;
         while(_loc11_ < 8)
         {
            tooltip["txt_" + _loc11_].visible = true;
            _loc11_++;
         }
         var _loc12_:Array = _loc3_.showBaseAttrib();
         var _loc13_:uint = 0;
         var _loc14_:uint = 4;
         var _loc15_:uint = 0;
         while(_loc15_ < _loc12_.length)
         {
            if(_loc12_[_loc15_][0] == 1)
            {
               _loc13_++;
               tooltip["txt_" + _loc13_].text = _loc12_[_loc15_][1];
            }
            else
            {
               _loc14_++;
               tooltip["txt_" + _loc14_].text = _loc12_[_loc15_][1];
            }
            _loc15_++;
         }
         var _loc16_:uint = _loc13_ + 1;
         while(_loc16_ < 5)
         {
            tooltip["txt_" + _loc16_].visible = false;
            _loc9_ += 18;
            _loc16_++;
         }
         if(_loc14_ == 6)
         {
            tooltip["txt_7"].visible = false;
            _loc10_ += 18;
         }
         else if(_loc14_ == 5)
         {
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            _loc10_ += 18;
         }
         else if(_loc14_ == 4)
         {
            tooltip["txt_5"].visible = false;
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            _loc10_ += 36;
         }
         if(_loc3_.getColor() < 5)
         {
            _loc4_ = 25;
         }
         else
         {
            tooltip["star_0"].visible = true;
            tooltip["star_1"].visible = false;
            tooltip["star_2"].visible = false;
            tooltip["star_3"].visible = false;
            tooltip["star_4"].visible = false;
            tooltip["star_5"].visible = false;
            switch(_loc3_.getStar())
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
         tooltip["price"].y -= _loc5_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["explain"].y -= _loc5_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["middle_mc"].height -= _loc5_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["down_mc"].y -= _loc5_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_14"].y -= _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_13"].y -= _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_12"].y -= _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_11"].y -= _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["line1"].y -= _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["gemslot_mc"].y -= _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_10"].y -= _loc7_ + _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_9"].y -= _loc8_ + _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_88"].y -= _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_8"].y -= _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_7"].y -= _loc9_ + _loc10_ + _loc4_;
         tooltip["txt_6"].y -= _loc9_ + _loc4_;
         tooltip["txt_5"].y -= _loc9_ + _loc4_;
         tooltip["txt_4"].y -= _loc4_;
         tooltip["txt_3"].y -= _loc4_;
         tooltip["txt_2"].y -= _loc4_;
         tooltip["txt_1"].y -= _loc4_;
         tooltip["line0"].y -= _loc4_;
         tooltip["lv_txt"].y -= _loc4_;
         tooltip["lv2_txt"].y -= _loc4_;
         tooltip["type_txt"].y -= _loc4_;
         setEquipColor(_loc3_);
      }
      
      private function setSuppliesColor(param1:Supplies) : *
      {
         if(param1.getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(param1.getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(param1.getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
      }
      
      public function suppliesTooltip(param1:Supplies, param2:Number = 1) : void
      {
         tooltip.visible = true;
         newItemsTool.visible = false;
         var _loc3_:Supplies = param1;
         setPosition();
         tooltip["name_txt"].text = _loc3_.getName();
         tooltip["lv_txt"].text = _loc3_.getUseLevel();
         if(param2 == 1)
         {
            if(_loc3_.getUseLevel() <= Main.player1.getLevel())
            {
               ColorX(tooltip["lv_txt"],"0xffffff");
            }
            else
            {
               ColorX(tooltip["lv_txt"],"0xFF0000");
            }
         }
         else if(param2 == 2)
         {
            if(_loc3_.getUseLevel() <= Main.player2.getLevel())
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
         tooltip["price"].text = "出售价：" + _loc3_.getPrice();
         tooltip["explain"].text = _loc3_.getDescript();
         tooltip["line0"].visible = false;
         tooltip["line1"].visible = false;
         tooltip["type_txt"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         tooltip["right_mc"].visible = false;
         var _loc4_:uint = 1;
         while(_loc4_ < 16)
         {
            tooltip["txt_" + _loc4_].visible = false;
            _loc4_++;
         }
         tooltip["lv_txt"].y -= 36;
         tooltip["lv2_txt"].y -= 36;
         tooltip["price"].y -= 270;
         tooltip["explain"].y -= 270;
         tooltip["middle_mc"].height -= 270;
         tooltip["down_mc"].y -= 270;
         setSuppliesColor(_loc3_);
      }
      
      private function setGemColor(param1:Gem) : *
      {
         if(param1.getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(param1.getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(param1.getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
         if(param1.getColor() == 4)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
      }
      
      public function gemTooltip(param1:Gem, param2:Number = 1) : void
      {
         var _loc7_:Array = null;
         tooltip.visible = true;
         newItemsTool.visible = false;
         var _loc3_:Gem = param1;
         setPosition();
         if(_loc3_.getIsStrengthen() == true)
         {
            if(_loc3_.getStrengthenLevel() >= 1)
            {
               tooltip["name_txt"].text = _loc3_.getName() + "+" + _loc3_.getStrengthenLevel();
            }
            else
            {
               tooltip["name_txt"].text = _loc3_.getName();
            }
         }
         else
         {
            tooltip["name_txt"].text = _loc3_.getName();
         }
         tooltip["lv_txt"].text = _loc3_.getUseLevel();
         tooltip["price"].text = "出售价：" + _loc3_.getPrice();
         tooltip["explain"].text = _loc3_.getDescript();
         tooltip["line0"].visible = false;
         tooltip["line1"].visible = false;
         tooltip["type_txt"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         tooltip["right_mc"].visible = false;
         var _loc4_:uint = 1;
         while(_loc4_ < 16)
         {
            tooltip["txt_" + _loc4_].visible = false;
            _loc4_++;
         }
         var _loc5_:int = 1;
         var _loc6_:* = 0;
         if(_loc3_.getType() == GemTypeConst.ATTRIBSTONE)
         {
            _loc7_ = [];
            _loc7_ = _loc3_.showGemAttrib();
            _loc4_ = 0;
            while(_loc4_ < _loc7_.length)
            {
               tooltip["txt_" + (12 + _loc4_)].text = _loc7_[_loc4_];
               tooltip["txt_" + (12 + _loc4_)].visible = true;
               _loc4_++;
            }
            if(_loc7_.length >= 3)
            {
               _loc5_ = 0;
            }
            ColorX(tooltip["lv_txt"],"0xffffff");
         }
         if(_loc3_.getType() == GemTypeConst.FRAGMENT || _loc3_.getType() == GemTypeConst.LUCKSTONE || _loc3_.getType() == GemTypeConst.STRENGTHENSTONE)
         {
            tooltip["lv2_txt"].visible = false;
            tooltip["lv_txt"].visible = false;
            _loc6_ = 20;
         }
         else if(_loc3_.getType() == GemTypeConst.SKILLSTONE)
         {
            if(param2 == 1)
            {
               if(_loc3_.getUseLevel() <= Main.player1.getLevel())
               {
                  ColorX(tooltip["lv_txt"],"0xffffff");
               }
               else
               {
                  ColorX(tooltip["lv_txt"],"0xFF0000");
               }
            }
            else if(param2 == 2)
            {
               if(_loc3_.getUseLevel() <= Main.player2.getLevel())
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
         tooltip["price"].y -= 248 + 18 * _loc5_ + _loc6_;
         tooltip["explain"].y -= 248 + 18 * _loc5_ + _loc6_;
         tooltip["middle_mc"].height -= 248 + 18 * _loc5_ + _loc6_;
         tooltip["down_mc"].y -= 248 + 18 * _loc5_ + _loc6_;
         setGemColor(_loc3_);
      }
      
      private function setEquipSlotColor(param1:uint, param2:EquipSlot) : *
      {
         if(param2.getEquipFromSlot(param1).getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(param2.getEquipFromSlot(param1).getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(param2.getEquipFromSlot(param1).getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
         if(param2.getEquipFromSlot(param1).getColor() == 4)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
         if(param2.getEquipFromSlot(param1).getColor() == 5)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
      }
      
      public function slotSuitTooltip(param1:uint, param2:uint, param3:EquipSlot) : void
      {
         tooltip.visible = true;
         newItemsTool.visible = false;
         var _loc4_:uint = 0;
         var _loc5_:Array = EquipFactory.getAllSuitEquipPostionAddName(param1);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_.length)
         {
            tooltip["right_mc"]["name" + _loc6_].text = _loc5_[_loc6_][1];
            _loc6_++;
         }
         var _loc7_:uint = 0;
         while(_loc7_ < 5)
         {
            if(param3.getEquipFromSlot(_loc7_) != null)
            {
               if(param3.getEquipFromSlot(_loc7_).getSuitId() == param1)
               {
                  if(_loc7_ > 2)
                  {
                     _loc7_--;
                     ColorX(tooltip["right_mc"]["name" + _loc7_],"0x00ff00");
                     _loc4_++;
                     _loc7_++;
                  }
                  else
                  {
                     ColorX(tooltip["right_mc"]["name" + _loc7_],"0x00ff00");
                     _loc4_++;
                  }
               }
            }
            _loc7_++;
         }
         tooltip["right_mc"]["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(param1);
         if(_loc4_ == 4)
         {
            ColorX(tooltip["right_mc"]["append_txt"],"0x00CCFF");
         }
      }
      
      public function slotTooltip(param1:uint, param2:EquipSlot) : void
      {
         if(param2.getEquipFromSlot(param1).getPosition() > 7)
         {
            tooltip.visible = false;
            newItemsTool.visible = true;
            newItemsTool.equipTooltip(param2.getEquipFromSlot(param1));
         }
         else
         {
            tooltip.visible = true;
            newItemsTool.visible = false;
         }
         setPosition();
         tooltip["name_txt"].text = param2.getEquipFromSlot(param1).getName();
         tooltip["type_txt"].text = "部位：" + getParts(param2.getEquipFromSlot(param1).getPosition());
         if(param2.getEquipFromSlot(param1).getDressLevel() == 100)
         {
            tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            tooltip["lv_txt"].text = param2.getEquipFromSlot(param1).getDressLevel();
         }
         ColorX(tooltip["lv_txt"],"0xffffff");
         tooltip["explain"].text = param2.getEquipFromSlot(param1).getDescript();
         tooltip["price"].text = "出售价:" + param2.getEquipFromSlot(param1).getPrice();
         tooltip["type_txt"].visible = true;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         tooltip["line1"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         tooltip["txt_13"].visible = false;
         tooltip["txt_14"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(param2.getEquipFromSlot(param1).getGrid() == -1)
         {
            _loc5_ = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_11"].visible = true;
            tooltip["gemslot_mc"].visible = true;
            if(param2.getEquipFromSlot(param1).getGrid() == 0)
            {
               _loc5_ = slotGemAttribShow(param1,param2) * 18;
            }
            else
            {
               tooltip["gemslot_mc"].gotoAndStop(1);
               _loc5_ = 36;
            }
         }
         if(param2.getEquipFromSlot(param1).getSkillAttrib() == 0)
         {
            tooltip["txt_9"].visible = false;
            _loc6_ = 18;
         }
         else
         {
            tooltip["txt_9"].visible = true;
            tooltip["txt_9"].text = param2.getEquipFromSlot(param1).getEquipSkillAttrib();
         }
         if(param2.getEquipFromSlot(param1).getNewSkill() == 0)
         {
            tooltip["txt_10"].visible = false;
            _loc4_ = 18;
         }
         else
         {
            tooltip["txt_10"].visible = true;
            tooltip["txt_10"].text = param2.getEquipFromSlot(param1).getEquipNewSkill();
         }
         if(param2.getEquipFromSlot(param1).getSuitId() == 0)
         {
            tooltip["right_mc"].visible = false;
         }
         else
         {
            tooltip["right_mc"].visible = true;
            slotSuitTooltip(param2.getEquipFromSlot(param1).getSuitId(),param1,param2);
         }
         if(param2.getEquipFromSlot(param1).getReinforceLevel() == 0)
         {
            tooltip["txt_8"].visible = false;
            _loc7_ = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + param2.getEquipFromSlot(param1).getReinforceLevel();
            tooltip["txt_8"].text = "强化：" + param2.getEquipFromSlot(param1).showReinforceAttrib();
            tooltip["txt_8"].visible = true;
         }
         if(param2.getEquipFromSlot(param1).getBlessAttrib())
         {
            tooltip["txt_88"].visible = true;
            tooltip["txt_88"].text = param2.getEquipFromSlot(param1).showBlessAttrib();
         }
         else
         {
            tooltip["txt_88"].visible = false;
         }
         var _loc10_:uint = 1;
         while(_loc10_ < 8)
         {
            tooltip["txt_" + _loc10_].visible = true;
            _loc10_++;
         }
         var _loc11_:Array = param2.getEquipFromSlot(param1).showBaseAttrib();
         var _loc12_:uint = 0;
         var _loc13_:uint = 4;
         var _loc14_:uint = 0;
         while(_loc14_ < _loc11_.length)
         {
            if(_loc11_[_loc14_][0] == 1)
            {
               _loc12_++;
               tooltip["txt_" + _loc12_].text = _loc11_[_loc14_][1];
            }
            else
            {
               _loc13_++;
               tooltip["txt_" + _loc13_].text = _loc11_[_loc14_][1];
            }
            _loc14_++;
         }
         var _loc15_:uint = _loc12_ + 1;
         while(_loc15_ < 5)
         {
            tooltip["txt_" + _loc15_].visible = false;
            _loc8_ += 18;
            _loc15_++;
         }
         if(_loc13_ == 6)
         {
            tooltip["txt_7"].visible = false;
            _loc9_ += 18;
         }
         else if(_loc13_ == 5)
         {
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            _loc9_ += 18;
         }
         else if(_loc13_ == 4)
         {
            tooltip["txt_5"].visible = false;
            tooltip["txt_6"].visible = false;
            tooltip["txt_7"].visible = false;
            _loc9_ += 36;
         }
         if(param2.getEquipFromSlot(param1).getColor() < 5)
         {
            _loc3_ = 25;
         }
         else
         {
            tooltip["star_0"].visible = true;
            tooltip["star_1"].visible = false;
            tooltip["star_2"].visible = false;
            tooltip["star_3"].visible = false;
            tooltip["star_4"].visible = false;
            tooltip["star_5"].visible = false;
            switch(param2.getEquipFromSlot(param1).getStar())
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
         tooltip["price"].y -= _loc5_ + _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["explain"].y -= _loc5_ + _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["middle_mc"].height -= _loc5_ + _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["down_mc"].y -= _loc5_ + _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_14"].y -= _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_13"].y -= _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_12"].y -= _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_11"].y -= _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["line1"].y -= _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["gemslot_mc"].y -= _loc4_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_10"].y -= _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_9"].y -= _loc7_ + _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_88"].y -= _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_8"].y -= _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_7"].y -= _loc8_ + _loc9_ + _loc3_;
         tooltip["txt_6"].y -= _loc8_ + _loc3_;
         tooltip["txt_5"].y -= _loc8_ + _loc3_;
         tooltip["txt_4"].y -= _loc3_;
         tooltip["txt_3"].y -= _loc3_;
         tooltip["txt_2"].y -= _loc3_;
         tooltip["txt_1"].y -= _loc3_;
         tooltip["line0"].y -= _loc3_;
         tooltip["lv_txt"].y -= _loc3_;
         tooltip["lv2_txt"].y -= _loc3_;
         tooltip["type_txt"].y -= _loc3_;
         setEquipSlotColor(param1,param2);
      }
      
      public function slotGemAttribShow(param1:uint, param2:EquipSlot) : Number
      {
         tooltip["txt_12"].visible = false;
         tooltip["txt_13"].visible = false;
         tooltip["txt_14"].visible = false;
         var _loc3_:uint = 1;
         var _loc4_:Array = [];
         _loc4_ = param2.getEquipFromSlot(param1).getGemAttrib();
         if(param2.getEquipFromSlot(param1).getGemSlot().getType() == 3)
         {
            switch(param2.getEquipFromSlot(param1).getGemSlot().getColor())
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
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_.length)
         {
            tooltip["txt_" + (12 + _loc5_)].text = _loc4_[_loc5_];
            tooltip["txt_" + (12 + _loc5_)].visible = true;
            _loc5_++;
         }
         if(_loc4_.length >= 3)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      public function questTooltip(param1:Quest) : void
      {
         tooltip.visible = true;
         newItemsTool.visible = false;
         var _loc2_:Quest = param1;
         setPosition();
         tooltip["name_txt"].text = _loc2_.getName();
         tooltip["lv_txt"].visible = false;
         tooltip["lv2_txt"].visible = false;
         tooltip["price"].text = "出售价：" + _loc2_.getGold();
         tooltip["explain"].text = _loc2_.getIntroduction();
         tooltip["line0"].visible = false;
         tooltip["line1"].visible = false;
         tooltip["type_txt"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         tooltip["right_mc"].visible = false;
         var _loc3_:uint = 1;
         while(_loc3_ < 16)
         {
            tooltip["txt_" + _loc3_].visible = false;
            _loc3_++;
         }
         tooltip["price"].y -= 290;
         tooltip["explain"].y -= 290;
         tooltip["middle_mc"].height -= 290;
         tooltip["down_mc"].y -= 290;
      }
      
      public function otherTooltip(param1:Otherobj) : void
      {
         tooltip.visible = true;
         newItemsTool.visible = false;
         setPosition();
         tooltip["name_txt"].text = param1.getName();
         tooltip["lv_txt"].visible = false;
         tooltip["lv2_txt"].visible = false;
         tooltip["price"].text = "出售价：" + param1.getGold();
         tooltip["explain"].text = param1.getIntroduction();
         tooltip["line0"].visible = false;
         tooltip["line1"].visible = false;
         tooltip["type_txt"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         tooltip["right_mc"].visible = false;
         var _loc2_:uint = 1;
         while(_loc2_ < 16)
         {
            tooltip["txt_" + _loc2_].visible = false;
            _loc2_++;
         }
         tooltip["price"].y -= 290;
         tooltip["explain"].y -= 290;
         tooltip["middle_mc"].height -= 290;
         tooltip["down_mc"].y -= 290;
         setOtherColor(param1);
      }
      
      private function setOtherColor(param1:Otherobj) : void
      {
         if(param1.getColor() == 1)
         {
            ColorX(tooltip["name_txt"],"0xffffff");
         }
         if(param1.getColor() == 2)
         {
            ColorX(tooltip["name_txt"],"0x0066ff");
         }
         if(param1.getColor() == 3)
         {
            ColorX(tooltip["name_txt"],"0xFF33FF");
         }
         if(param1.getColor() == 4)
         {
            ColorX(tooltip["name_txt"],"0xFF9900");
         }
      }
   }
}

