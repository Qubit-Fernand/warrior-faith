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
         var _loc1_:int = 1;
         while(_loc1_ < 9)
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
      
      public function gemAttribShow(param1:Equip) : Number
      {
         tooltip["txt_5"].visible = false;
         tooltip["txt_6"].visible = false;
         tooltip["txt_7"].visible = false;
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
            tooltip["txt_" + (5 + _loc4_)].text = _loc3_[_loc4_];
            tooltip["txt_" + (5 + _loc4_)].visible = true;
            _loc4_++;
         }
         if(_loc3_.length >= 3)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function equipTooltip(param1:Equip) : void
      {
         var _loc10_:String = null;
         var _loc11_:RegExp = null;
         var _loc2_:Equip = param1;
         setPosition();
         tooltip["name_txt"].text = _loc2_.getName();
         if(_loc2_.getColor() >= 4)
         {
            tooltip["time_txt"].text = "剩余时间:永久";
         }
         else
         {
            tooltip["time_txt"].text = "剩余" + _loc2_.getRemainingTime() + "天";
         }
         tooltip["type_txt"].text = "部位：" + getParts(_loc2_.getPosition());
         if(_loc2_.getDressLevel() == 100)
         {
            tooltip["lv_txt"].text = "无限制";
         }
         else
         {
            tooltip["lv_txt"].text = "未知";
         }
         if(_loc2_.getRemainingTime() >= 0)
         {
            ColorX(tooltip["lv_txt"],"0xffffff");
         }
         else
         {
            ColorX(tooltip["lv_txt"],"0xFF0000");
         }
         tooltip["explain"].text = _loc2_.getDescript();
         tooltip["price"].text = "售价:" + _loc2_.getPrice();
         tooltip["type_txt"].visible = true;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         tooltip["line1"].visible = false;
         tooltip["txt_4"].visible = false;
         tooltip["txt_5"].visible = false;
         tooltip["txt_6"].visible = false;
         tooltip["txt_7"].visible = false;
         tooltip["txt_8"].visible = false;
         tooltip["gemslot_mc"].visible = false;
         if(_loc2_.getGrid() == -1)
         {
            _loc4_ = 74;
         }
         else
         {
            tooltip["line1"].visible = true;
            tooltip["txt_4"].visible = true;
            tooltip["gemslot_mc"].visible = true;
            if(_loc2_.getGrid() == 0)
            {
               _loc4_ = gemAttribShow(_loc2_) * 18;
            }
            else
            {
               tooltip["gemslot_mc"].gotoAndStop(1);
               _loc4_ = 36;
            }
         }
         if(_loc2_.getNewSkill() == 0)
         {
            tooltip["txt_3"].visible = false;
            _loc5_ = 18;
         }
         else
         {
            tooltip["txt_3"].visible = true;
            tooltip["txt_3"].text = _loc2_.getEquipNewSkill();
         }
         if(_loc2_.getSkillAttrib() == 0)
         {
            tooltip["txt_1"].visible = false;
            _loc6_ = 54;
         }
         else
         {
            tooltip["txt_1"].visible = true;
            _loc10_ = _loc2_.getEquipSkillAttrib();
            _loc11_ = /[$]/g;
            tooltip["txt_1"].text = _loc10_.replace(_loc11_,"\n");
         }
         if(_loc2_.getReinforceLevel() == 0)
         {
            tooltip["txt_2"].visible = false;
            _loc7_ = 18;
         }
         else
         {
            tooltip["name_txt"].text += "+" + _loc2_.getReinforceLevel();
            tooltip["txt_2"].text = "强化：" + _loc2_.showReinforceAttrib();
            tooltip["txt_2"].visible = true;
         }
         if(_loc2_.getBlessAttrib())
         {
            tooltip["txt_zf"].visible = true;
            tooltip["txt_zf"].text = _loc2_.showBlessAttrib();
            _loc7_ = 0;
         }
         else
         {
            tooltip["txt_zf"].visible = false;
         }
         if(_loc2_.getColor() < 5)
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
            switch(_loc2_.getStar())
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
         tooltip["price"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["explain"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["middle_mc"].height -= _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["down_mc"].y -= _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["txt_8"].y -= _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["txt_7"].y -= _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["txt_6"].y -= _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["txt_5"].y -= _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["txt_4"].y -= _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["line1"].y -= _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["gemslot_mc"].y -= _loc5_ + _loc6_ + _loc7_ + _loc3_;
         tooltip["txt_3"].y -= _loc6_ + _loc7_ + _loc3_;
         tooltip["txt_2"].y -= _loc6_ + _loc3_;
         tooltip["txt_1"].y -= _loc3_;
         tooltip["line0"].y -= _loc3_;
         tooltip["lv_txt"].y -= _loc3_;
         tooltip["lv2_txt"].y -= _loc3_;
         tooltip["type_txt"].y -= _loc3_;
         tooltip["time_txt"].y -= _loc3_;
         setEquipColor(_loc2_);
      }
   }
}

