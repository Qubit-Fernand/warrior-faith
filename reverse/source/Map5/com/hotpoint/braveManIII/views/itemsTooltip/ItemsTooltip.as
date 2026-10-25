package com.hotpoint.braveManIII.views.itemsTooltip
{
   import com.hotpoint.braveManIII.models.container.EquipSlot;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.*;
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
      }
      
      public function slotTooltip(param1:uint, param2:EquipSlot) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:uint = 0;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         setPosition();
         tooltip["name_txt"].text = param2.getEquipFromSlot(param1).getName();
         tooltip["type_txt"].text = "部位：" + getParts(param2.getEquipFromSlot(param1).getPosition());
         tooltip["lv_txt"].text = param2.getEquipFromSlot(param1).getDressLevel();
         ColorX(tooltip["lv_txt"],"0xffffff");
         tooltip["explain"].text = param2.getEquipFromSlot(param1).getDescript();
         tooltip["price"].text = "出售价:" + param2.getEquipFromSlot(param1).getPrice();
         tooltip["type_txt"].visible = true;
         _loc3_ = 0;
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 0;
         tooltip["line1"].visible = false;
         tooltip["txt_9"].visible = false;
         tooltip["txt_10"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(param2.getEquipFromSlot(param1).getGrid() == -1)
         {
            _loc3_ = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_9"].visible = true;
            tooltip["gemslot_mc"].visible = true;
            if(param2.getEquipFromSlot(param1).getGrid() == 0)
            {
               _loc3_ = slotGemAttribShow(param1,param2) * 18;
            }
            else
            {
               tooltip["gemslot_mc"].gotoAndStop(1);
               _loc3_ = 54;
            }
         }
         if(param2.getEquipFromSlot(param1).getSkillAttrib() == 0)
         {
            tooltip["txt_8"].visible = false;
            _loc4_ = 36;
         }
         else
         {
            tooltip["txt_8"].visible = true;
            tooltip["txt_8"].text = param2.getEquipFromSlot(param1).getEquipSkillAttrib();
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
            tooltip["txt_7"].visible = false;
            _loc5_ = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + param2.getEquipFromSlot(param1).getReinforceLevel();
            tooltip["txt_7"].text = "强化：" + param2.getEquipFromSlot(param1).showReinforceAttrib();
            tooltip["txt_7"].visible = true;
         }
         _loc8_ = 1;
         while(_loc8_ < 7)
         {
            tooltip["txt_" + _loc8_].visible = true;
            _loc8_++;
         }
         _loc9_ = param2.getEquipFromSlot(param1).showBaseAttrib();
         _loc10_ = 0;
         _loc11_ = 4;
         _loc12_ = 0;
         while(_loc12_ < _loc9_.length)
         {
            if(_loc9_[_loc12_][0] == 1)
            {
               _loc10_++;
               tooltip["txt_" + _loc10_].text = _loc9_[_loc12_][1];
            }
            else
            {
               _loc11_++;
               tooltip["txt_" + _loc11_].text = _loc9_[_loc12_][1];
            }
            _loc12_++;
         }
         _loc13_ = _loc10_ + 1;
         while(_loc13_ < 5)
         {
            tooltip["txt_" + _loc13_].visible = false;
            _loc6_ += 18;
            _loc13_++;
         }
         _loc13_ = _loc11_ + 1;
         while(_loc13_ < 7)
         {
            tooltip["txt_" + _loc13_].visible = false;
            _loc7_ += 18;
            _loc13_++;
         }
         tooltip["price"].y -= _loc3_ + _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["explain"].y -= _loc3_ + _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["middle_mc"].height -= _loc3_ + _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["down_mc"].y -= _loc3_ + _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["txt_12"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["txt_11"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["txt_10"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["txt_9"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["line1"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["gemslot_mc"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_;
         tooltip["txt_8"].y -= _loc5_ + _loc6_ + _loc7_;
         tooltip["txt_7"].y -= _loc6_ + _loc7_;
         tooltip["txt_6"].y -= _loc6_ + _loc7_;
         tooltip["txt_5"].y -= _loc6_;
         setEquipSlotColor(param1,param2);
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
            default:
               return "未知";
         }
      }
      
      public function suitTooltip(param1:uint, param2:Equip) : void
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         _loc3_ = EquipFactory.getAllSuitEquipPostionAddName(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            tooltip["right_mc"]["name" + _loc4_].text = _loc3_[_loc4_][1];
            _loc4_++;
         }
         _loc5_ = param2.getPosition();
         ColorX(tooltip["right_mc"]["name" + (_loc5_ - 1)],"0x00ff00");
         tooltip["right_mc"]["append_txt"].text = EquipFactory.getSuitEquipSkillAttrib(param1);
      }
      
      public function slotGemAttribShow(param1:uint, param2:EquipSlot) : Number
      {
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         tooltip["txt_10"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         _loc3_ = 3;
         _loc4_ = [];
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
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            tooltip["txt_" + (10 + _loc5_)].text = _loc4_[_loc5_];
            tooltip["txt_" + (10 + _loc5_)].visible = true;
            _loc3_--;
            _loc5_++;
         }
         if(String(_loc4_[0]).length > 10)
         {
            _loc3_--;
         }
         if(String(_loc4_[0]).length > 20)
         {
            _loc3_--;
         }
         return _loc3_;
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
      
      public function slotSuitTooltip(param1:uint, param2:uint, param3:EquipSlot) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc4_ = 0;
         _loc5_ = EquipFactory.getAllSuitEquipPostionAddName(param1);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            tooltip["right_mc"]["name" + _loc6_].text = _loc5_[_loc6_][1];
            _loc6_++;
         }
         _loc7_ = 0;
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
      
      private function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = undefined;
         _loc3_ = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      public function suppliesTooltip(param1:Supplies, param2:Number = 1) : void
      {
         var _loc3_:Supplies = null;
         var _loc4_:uint = 0;
         _loc3_ = param1;
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
         _loc4_ = 1;
         while(_loc4_ < 13)
         {
            tooltip["txt_" + _loc4_].visible = false;
            _loc4_++;
         }
         tooltip["lv_txt"].y -= 18;
         tooltip["lv2_txt"].y -= 18;
         tooltip["price"].y -= 270;
         tooltip["explain"].y -= 270;
         tooltip["middle_mc"].height -= 270;
         tooltip["down_mc"].y -= 270;
         setSuppliesColor(_loc3_);
      }
      
      public function gemAttribShow(param1:Equip) : Number
      {
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         tooltip["txt_10"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         _loc2_ = 3;
         _loc3_ = [];
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
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            tooltip["txt_" + (10 + _loc4_)].text = _loc3_[_loc4_];
            tooltip["txt_" + (10 + _loc4_)].visible = true;
            _loc2_--;
            _loc4_++;
         }
         if(String(_loc3_[0]).length > 10)
         {
            _loc2_--;
         }
         if(String(_loc3_[0]).length > 20)
         {
            _loc2_--;
         }
         return _loc2_;
      }
      
      public function equipTooltip(param1:Equip, param2:Number = 1) : void
      {
         var _loc3_:Equip = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:uint = 0;
         var _loc10_:Array = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         _loc3_ = param1;
         setPosition();
         tooltip["name_txt"].text = _loc3_.getName();
         tooltip["type_txt"].text = "部位：" + getParts(_loc3_.getPosition());
         tooltip["lv_txt"].text = _loc3_.getDressLevel();
         if(param2 == 1)
         {
            if(_loc3_.getDressLevel() <= Main.player1.getLevel())
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
            if(_loc3_.getDressLevel() <= Main.player2.getLevel())
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
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 0;
         _loc8_ = 0;
         tooltip["line1"].visible = false;
         tooltip["txt_9"].visible = false;
         tooltip["txt_10"].visible = false;
         tooltip["txt_11"].visible = false;
         tooltip["txt_12"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(_loc3_.getGrid() == -1)
         {
            _loc4_ = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_9"].visible = true;
            tooltip["gemslot_mc"].visible = true;
            if(_loc3_.getGrid() == 0)
            {
               _loc4_ = gemAttribShow(_loc3_) * 18;
            }
            else
            {
               tooltip["gemslot_mc"].gotoAndStop(1);
               _loc4_ = 54;
            }
         }
         if(_loc3_.getSkillAttrib() == 0)
         {
            tooltip["txt_8"].visible = false;
            _loc5_ = 36;
         }
         else
         {
            tooltip["txt_8"].visible = true;
            tooltip["txt_8"].text = _loc3_.getEquipSkillAttrib();
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
            tooltip["txt_7"].visible = false;
            _loc6_ = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + _loc3_.getReinforceLevel();
            tooltip["txt_7"].text = "强化：" + _loc3_.showReinforceAttrib();
            tooltip["txt_7"].visible = true;
         }
         _loc9_ = 1;
         while(_loc9_ < 7)
         {
            tooltip["txt_" + _loc9_].visible = true;
            _loc9_++;
         }
         _loc10_ = _loc3_.showBaseAttrib();
         _loc11_ = 0;
         _loc12_ = 4;
         _loc13_ = 0;
         while(_loc13_ < _loc10_.length)
         {
            if(_loc10_[_loc13_][0] == 1)
            {
               _loc11_++;
               tooltip["txt_" + _loc11_].text = _loc10_[_loc13_][1];
            }
            else
            {
               _loc12_++;
               tooltip["txt_" + _loc12_].text = _loc10_[_loc13_][1];
            }
            _loc13_++;
         }
         _loc14_ = _loc11_ + 1;
         while(_loc14_ < 5)
         {
            tooltip["txt_" + _loc14_].visible = false;
            _loc7_ += 18;
            _loc14_++;
         }
         _loc14_ = _loc12_ + 1;
         while(_loc14_ < 7)
         {
            tooltip["txt_" + _loc14_].visible = false;
            _loc8_ += 18;
            _loc14_++;
         }
         tooltip["price"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["explain"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["middle_mc"].height -= _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["down_mc"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["txt_12"].y -= _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["txt_11"].y -= _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["txt_10"].y -= _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["txt_9"].y -= _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["line1"].y -= _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["gemslot_mc"].y -= _loc5_ + _loc6_ + _loc7_ + _loc8_;
         tooltip["txt_8"].y -= _loc6_ + _loc7_ + _loc8_;
         tooltip["txt_7"].y -= _loc7_ + _loc8_;
         tooltip["txt_6"].y -= _loc7_ + _loc8_;
         tooltip["txt_5"].y -= _loc7_;
         setEquipColor(_loc3_);
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
      }
      
      private function setPosition() : *
      {
         var _loc1_:int = 0;
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
         _loc1_ = 1;
         while(_loc1_ < 13)
         {
            tooltip["txt_" + _loc1_].visible = true;
            _loc1_++;
         }
      }
      
      public function gemTooltip(param1:Gem, param2:Number = 1) : void
      {
         var _loc3_:Gem = null;
         var _loc4_:uint = 0;
         var _loc5_:* = 0;
         var _loc6_:* = undefined;
         var _loc7_:Array = null;
         _loc3_ = param1;
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
         _loc4_ = 1;
         while(_loc4_ < 13)
         {
            tooltip["txt_" + _loc4_].visible = false;
            _loc4_++;
         }
         _loc5_ = 3;
         _loc6_ = 0;
         if(_loc3_.getType() == GemTypeConst.ATTRIBSTONE)
         {
            _loc7_ = [];
            _loc7_ = _loc3_.showGemAttrib();
            _loc4_ = 0;
            while(_loc4_ < _loc7_.length)
            {
               tooltip["txt_" + (10 + _loc4_)].text = _loc7_[_loc4_];
               tooltip["txt_" + (10 + _loc4_)].visible = true;
               _loc5_--;
               _loc4_++;
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
         tooltip["lv_txt"].y -= 18;
         tooltip["lv2_txt"].y -= 18;
         tooltip["txt_10"].y -= 215;
         tooltip["txt_11"].y -= 215;
         tooltip["txt_12"].y -= 215;
         tooltip["price"].y -= 215 + 18 * _loc5_ + _loc6_;
         tooltip["explain"].y -= 215 + 18 * _loc5_ + _loc6_;
         tooltip["middle_mc"].height -= 215 + 18 * _loc5_ + _loc6_;
         tooltip["down_mc"].y -= 215 + 18 * _loc5_ + _loc6_;
         setGemColor(_loc3_);
      }
      
      public function questTooltip(param1:Quest) : void
      {
         var _loc2_:Quest = null;
         var _loc3_:uint = 0;
         _loc2_ = param1;
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
         _loc3_ = 1;
         while(_loc3_ < 13)
         {
            tooltip["txt_" + _loc3_].visible = false;
            _loc3_++;
         }
         tooltip["price"].y -= 290;
         tooltip["explain"].y -= 290;
         tooltip["middle_mc"].height -= 290;
         tooltip["down_mc"].y -= 290;
      }
      
      public function setTooltipPoint() : *
      {
         var _loc1_:Point = null;
         _loc1_ = new Point(0,0);
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
      }
   }
}

