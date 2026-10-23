package com.hotpoint.braveManIII.views.titelPanel
{
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   
   public class TitelPanel extends MovieClip
   {
      
      public static var ttp:TitelPanel;
      
      public static var isPOne:Boolean;
      
      public static var ttPanel:MovieClip = new TitleShow();
      
      public static var yeNum:Number = 0;
      
      public function TitelPanel()
      {
         super();
         this.addChild(ttPanel);
      }
      
      public static function CengHaoShow() : *
      {
         Main.player_1.cengHao_mc.Show(1);
         if(Main.P1P2)
         {
            Main.player_2.cengHao_mc.Show(2);
         }
      }
      
      public static function open(param1:Boolean = true) : void
      {
         isPOne = param1;
         Main.allClosePanel();
         if(ttp == null)
         {
            ttp = new TitelPanel();
         }
         Main.player1.getTitleSlot().debugTitle();
         if(Main.P1P2)
         {
            Main.player2.getTitleSlot().debugTitle();
         }
         testTitleVIP();
         testTitleTime();
         Main.stopXX = true;
         ttp.x = 0;
         ttp.y = 0;
         yeNum = 0;
         addListenerP1();
         Main._stage.addChild(ttp);
         ttp.visible = true;
      }
      
      public static function close() : void
      {
         if(ttp == null)
         {
            ttp = new TitelPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         ttp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            ttPanel["left" + _loc1_].buttonMode = true;
            ttPanel["right" + _loc1_].buttonMode = true;
            ttPanel["left" + _loc1_].addEventListener(MouseEvent.CLICK,leftOK);
            ttPanel["right" + _loc1_].addEventListener(MouseEvent.CLICK,rightOK);
            _loc1_++;
         }
         ttPanel["lianjie_btn"].addEventListener(MouseEvent.CLICK,lianjie);
         ttPanel["shang"].addEventListener(MouseEvent.CLICK,shangDo);
         ttPanel["xia"].addEventListener(MouseEvent.CLICK,xiaDo);
         ttPanel["makesure"].addEventListener(MouseEvent.CLICK,makesure);
         ttPanel["cancel"].addEventListener(MouseEvent.CLICK,cancel);
         showTitleList();
      }
      
      private static function showTitleList() : *
      {
         var _loc7_:uint = 0;
         var _loc8_:RegExp = null;
         var _loc9_:uint = 0;
         var _loc1_:Boolean = true;
         var _loc2_:Boolean = true;
         var _loc3_:Boolean = true;
         var _loc4_:Boolean = true;
         var _loc5_:Boolean = true;
         var _loc6_:Boolean = true;
         if(isPOne)
         {
            if(Main.player1.getTitleSlot().getTitleView())
            {
               if(Main.player1.getTitleSlot().getTitleView().getDefaultTime() > 90)
               {
                  ttPanel["titleView"].text = Main.player1.getTitleSlot().getTitleView().getName();
               }
               else
               {
                  ttPanel["titleView"].text = Main.player1.getTitleSlot().getTitleView().getName() + "(剩余" + Main.player1.getTitleSlot().getTitleView().getRemainingTime() + "天)";
               }
               setTitleViewColor(Main.player1.getTitleSlot().getTitleView().getColor());
            }
            else
            {
               ttPanel["titleView"].text = "";
            }
            if(Main.player1.getTitleSlot().getTitleAttrib())
            {
               if(Main.player1.getTitleSlot().getTitleAttrib().getDefaultTime() > 90)
               {
                  ttPanel["titleAttrib"].text = Main.player1.getTitleSlot().getTitleAttrib().getName();
               }
               else
               {
                  ttPanel["titleAttrib"].text = Main.player1.getTitleSlot().getTitleAttrib().getName() + "(剩余" + Main.player1.getTitleSlot().getTitleAttrib().getRemainingTime() + "天)";
               }
               setTitleAttribColor(Main.player1.getTitleSlot().getTitleAttrib().getColor());
            }
            else
            {
               ttPanel["titleAttrib"].text = "";
            }
            _loc7_ = 0;
            while(_loc7_ < 6)
            {
               if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_))
               {
                  ttPanel["left" + _loc7_].visible = true;
                  ttPanel["right" + _loc7_].visible = true;
                  ttPanel["titleName" + _loc7_].visible = true;
                  ttPanel["dikuang" + _loc7_].visible = true;
                  if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_) != null)
                  {
                     if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_) == Main.player1.getTitleSlot().getTitleView())
                     {
                        ttPanel["left" + _loc7_].alpha = 100;
                     }
                     else
                     {
                        ttPanel["left" + _loc7_].alpha = 0;
                     }
                     if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_) == Main.player1.getTitleSlot().getTitleAttrib())
                     {
                        _loc8_ = /[$]/g;
                        ttPanel["ts_skill"].text = Main.player1.getTitleSlot().getTitleAttrib().getIntroductionSkill().replace(_loc8_,"\n");
                        ttPanel["right" + _loc7_].alpha = 100;
                        ttPanel["jieshao"].text = Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getIntroduction();
                        _loc9_ = 0;
                        while(_loc9_ < 6)
                        {
                           ttPanel["sx" + _loc9_].text = "";
                           if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getHP() > 0 && _loc1_)
                           {
                              ttPanel["sx" + _loc9_].text = "生命+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getHP();
                              _loc1_ = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getMP() > 0 && _loc2_)
                           {
                              ttPanel["sx" + _loc9_].text = "魔法+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getMP();
                              _loc2_ = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getAttack() > 0 && _loc3_)
                           {
                              ttPanel["sx" + _loc9_].text = "攻击力+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getAttack();
                              _loc3_ = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getDefense() > 0 && _loc4_)
                           {
                              ttPanel["sx" + _loc9_].text = "防御力+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getDefense();
                              _loc4_ = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getCrit() > 0 && _loc5_)
                           {
                              ttPanel["sx" + _loc9_].text = "暴击+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getCrit();
                              _loc5_ = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getMoveSpeed() > 0 && _loc6_)
                           {
                              ttPanel["sx" + _loc9_].text = "移动+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getMoveSpeed();
                              _loc6_ = false;
                           }
                           _loc9_++;
                        }
                     }
                     else
                     {
                        ttPanel["right" + _loc7_].alpha = 0;
                     }
                  }
                  ttPanel["titleName" + _loc7_].text = Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getName();
               }
               else
               {
                  ttPanel["left" + _loc7_].visible = false;
                  ttPanel["right" + _loc7_].visible = false;
                  ttPanel["titleName" + _loc7_].visible = false;
                  ttPanel["dikuang" + _loc7_].visible = false;
               }
               _loc7_++;
            }
            Main.player_1.cengHao_mc.Show(1);
         }
         else
         {
            if(Main.player2.getTitleSlot().getTitleView())
            {
               if(Main.player2.getTitleSlot().getTitleView().getDefaultTime() > 90)
               {
                  ttPanel["titleView"].text = Main.player2.getTitleSlot().getTitleView().getName();
               }
               else
               {
                  ttPanel["titleView"].text = Main.player2.getTitleSlot().getTitleView().getName() + "(剩余" + Main.player2.getTitleSlot().getTitleView().getRemainingTime() + "天)";
               }
               setTitleViewColor(Main.player2.getTitleSlot().getTitleView().getColor());
            }
            else
            {
               ttPanel["titleView"].text = "";
            }
            if(Main.player2.getTitleSlot().getTitleAttrib())
            {
               if(Main.player2.getTitleSlot().getTitleAttrib().getDefaultTime() > 90)
               {
                  ttPanel["titleAttrib"].text = Main.player2.getTitleSlot().getTitleAttrib().getName();
               }
               else
               {
                  ttPanel["titleAttrib"].text = Main.player2.getTitleSlot().getTitleAttrib().getName() + "(剩余" + Main.player2.getTitleSlot().getTitleAttrib().getRemainingTime() + "天)";
               }
               setTitleAttribColor(Main.player2.getTitleSlot().getTitleAttrib().getColor());
            }
            else
            {
               ttPanel["titleAttrib"].text = "";
            }
            _loc7_ = 0;
            while(_loc7_ < 6)
            {
               if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_))
               {
                  ttPanel["left" + _loc7_].visible = true;
                  ttPanel["right" + _loc7_].visible = true;
                  ttPanel["titleName" + _loc7_].visible = true;
                  ttPanel["dikuang" + _loc7_].visible = true;
                  if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_) != null)
                  {
                     if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_) == Main.player2.getTitleSlot().getTitleView())
                     {
                        ttPanel["left" + _loc7_].alpha = 100;
                     }
                     else
                     {
                        ttPanel["left" + _loc7_].alpha = 0;
                     }
                     if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_) == Main.player2.getTitleSlot().getTitleAttrib())
                     {
                        _loc8_ = /[$]/g;
                        ttPanel["ts_skill"].text = Main.player2.getTitleSlot().getTitleAttrib().getIntroductionSkill().replace(_loc8_,"\n");
                        ttPanel["right" + _loc7_].alpha = 100;
                        ttPanel["jieshao"].text = Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getIntroduction();
                        _loc9_ = 0;
                        while(_loc9_ < 6)
                        {
                           ttPanel["sx" + _loc9_].text = "";
                           if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getHP() > 0 && _loc1_)
                           {
                              ttPanel["sx" + _loc9_].text = "生命+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getHP();
                              _loc1_ = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getMP() > 0 && _loc2_)
                           {
                              ttPanel["sx" + _loc9_].text = "魔法+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getMP();
                              _loc2_ = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getAttack() > 0 && _loc3_)
                           {
                              ttPanel["sx" + _loc9_].text = "攻击力+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getAttack();
                              _loc3_ = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getDefense() > 0 && _loc4_)
                           {
                              ttPanel["sx" + _loc9_].text = "防御力+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getDefense();
                              _loc4_ = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getCrit() > 0 && _loc5_)
                           {
                              ttPanel["sx" + _loc9_].text = "暴击+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getCrit();
                              _loc5_ = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getMoveSpeed() > 0 && _loc6_)
                           {
                              ttPanel["sx" + _loc9_].text = "移动+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getMoveSpeed();
                              _loc6_ = false;
                           }
                           _loc9_++;
                        }
                     }
                     else
                     {
                        ttPanel["right" + _loc7_].alpha = 0;
                     }
                  }
                  ttPanel["titleName" + _loc7_].text = Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + _loc7_).getName();
               }
               else
               {
                  ttPanel["left" + _loc7_].visible = false;
                  ttPanel["right" + _loc7_].visible = false;
                  ttPanel["titleName" + _loc7_].visible = false;
                  ttPanel["dikuang" + _loc7_].visible = false;
               }
               _loc7_++;
            }
            Main.player_2.cengHao_mc.Show(2);
         }
      }
      
      private static function setTitleViewColor(param1:Number) : *
      {
         if(param1 == 1)
         {
            ColorX(ttPanel["titleView"],"0xffffff");
         }
         if(param1 == 2)
         {
            ColorX(ttPanel["titleView"],"0x0066ff");
         }
         if(param1 == 3)
         {
            ColorX(ttPanel["titleView"],"0xFF33FF");
         }
         if(param1 == 4)
         {
            ColorX(ttPanel["titleView"],"0xFF9900");
         }
      }
      
      private static function setTitleAttribColor(param1:Number) : *
      {
         if(param1 == 1)
         {
            ColorX(ttPanel["titleAttrib"],"0xffffff");
         }
         if(param1 == 2)
         {
            ColorX(ttPanel["titleAttrib"],"0x0066ff");
         }
         if(param1 == 3)
         {
            ColorX(ttPanel["titleAttrib"],"0xFF33FF");
         }
         if(param1 == 4)
         {
            ColorX(ttPanel["titleAttrib"],"0xFF9900");
         }
      }
      
      private static function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            ttPanel["left" + _loc1_].removeEventListener(MouseEvent.CLICK,leftOK);
            ttPanel["right" + _loc1_].removeEventListener(MouseEvent.CLICK,rightOK);
            _loc1_++;
         }
         ttPanel["shang"].removeEventListener(MouseEvent.CLICK,shangDo);
         ttPanel["xia"].removeEventListener(MouseEvent.CLICK,xiaDo);
         ttPanel["makesure"].removeEventListener(MouseEvent.CLICK,makesure);
         ttPanel["cancel"].removeEventListener(MouseEvent.CLICK,cancel);
      }
      
      public static function makesure(param1:*) : *
      {
         close();
         ItemsPanel.open();
      }
      
      public static function cancel(param1:*) : *
      {
         close();
         ItemsPanel.open();
      }
      
      public static function shangDo(param1:*) : *
      {
         if(isPOne)
         {
            if(yeNum > 0)
            {
               --yeNum;
               ttPanel["yeshu"].text = yeNum + 1 + "/" + (Math.floor(Main.player1.getTitleSlot().getListLength() / 6) + 1);
            }
         }
         else if(yeNum > 0)
         {
            --yeNum;
            ttPanel["yeshu"].text = yeNum + 1 + "/" + (Math.floor(Main.player2.getTitleSlot().getListLength() / 6) + 1);
         }
         showTitleList();
      }
      
      public static function xiaDo(param1:*) : *
      {
         if(isPOne)
         {
            if(yeNum < Math.floor(Main.player1.getTitleSlot().getListLength() / 6))
            {
               ++yeNum;
               ttPanel["yeshu"].text = yeNum + 1 + "/" + (Math.floor(Main.player1.getTitleSlot().getListLength() / 6) + 1);
            }
         }
         else if(yeNum < Math.floor(Main.player2.getTitleSlot().getListLength() / 6))
         {
            ++yeNum;
            ttPanel["yeshu"].text = yeNum + 1 + "/" + (Math.floor(Main.player2.getTitleSlot().getListLength() / 6) + 1);
         }
         showTitleList();
      }
      
      public static function leftOK(param1:*) : *
      {
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         if((param1.target as MovieClip).alpha == 100)
         {
            (param1.target as MovieClip).alpha = 0;
            if(isPOne)
            {
               Main.player1.getTitleSlot().delTitleView();
            }
            else
            {
               Main.player2.getTitleSlot().delTitleView();
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 6)
            {
               ttPanel["left" + _loc2_].alpha = 0;
               _loc2_++;
            }
            (param1.target as MovieClip).alpha = 100;
            _loc3_ = Number((param1.target as MovieClip).name.substr(4,1));
            if(isPOne)
            {
               Main.player1.getTitleSlot().setTitleView(Main.player1.getTitleSlot().getTitleFromSlot(_loc3_ + yeNum * 6));
            }
            else
            {
               Main.player2.getTitleSlot().setTitleView(Main.player2.getTitleSlot().getTitleFromSlot(_loc3_ + yeNum * 6));
            }
         }
         showTitleList();
      }
      
      public static function rightOK(param1:*) : *
      {
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         if((param1.target as MovieClip).alpha == 100)
         {
            (param1.target as MovieClip).alpha = 0;
            if(isPOne)
            {
               Main.player1.getTitleSlot().delTitleAttrib();
            }
            else
            {
               Main.player2.getTitleSlot().delTitleAttrib();
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 6)
            {
               ttPanel["right" + _loc2_].alpha = 0;
               _loc2_++;
            }
            (param1.target as MovieClip).alpha = 100;
            _loc3_ = Number((param1.target as MovieClip).name.substr(5,1));
            if(isPOne)
            {
               Main.player1.getTitleSlot().setTitleAttrib(Main.player1.getTitleSlot().getTitleFromSlot(_loc3_ + yeNum * 6));
            }
            else
            {
               Main.player2.getTitleSlot().setTitleAttrib(Main.player2.getTitleSlot().getTitleFromSlot(_loc3_ + yeNum * 6));
            }
         }
         showTitleList();
      }
      
      public static function setTitleTime() : *
      {
         var _loc1_:int = 0;
         if(isPOne)
         {
            _loc1_ = 0;
            while(_loc1_ < 20)
            {
               if(Main.player1.getTitleSlot().getTitleFromSlot(_loc1_) != null)
               {
                  Main.player1.getTitleSlot().getTitleFromSlot(_loc1_).setRemainingTime(Main.serverTime);
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 20)
            {
               if(Main.player2.getTitleSlot().getTitleFromSlot(_loc1_) != null)
               {
                  Main.player2.getTitleSlot().getTitleFromSlot(_loc1_).setRemainingTime(Main.serverTime);
               }
               _loc1_++;
            }
         }
      }
      
      public static function testTitleTime() : *
      {
         var _loc1_:* = 0;
         setTitleTime();
         if(isPOne)
         {
            _loc1_ = 0;
            while(_loc1_ < 20)
            {
               if(Main.player1.getTitleSlot().getTitleFromSlot(_loc1_) != null && Main.player1.getTitleSlot().getTitleFromSlot(_loc1_).getRemainingTime() == 0)
               {
                  Main.player1.getTitleSlot().delFromSlot(_loc1_);
                  _loc1_--;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 20)
            {
               if(Main.player2.getTitleSlot().getTitleFromSlot(_loc1_) != null && Main.player2.getTitleSlot().getTitleFromSlot(_loc1_).getRemainingTime() == 0)
               {
                  Main.player2.getTitleSlot().delFromSlot(_loc1_);
                  _loc1_--;
               }
               _loc1_++;
            }
         }
      }
      
      public static function testTitleVIP() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(Main.P1P2)
         {
            _loc1_ = 0;
            while(_loc1_ < Main.player1.getTitleSlot().getListLength())
            {
               if(Main.player1.getTitleSlot().getTitleFromSlot(_loc1_).getId() == 25)
               {
                  Main.player2.getTitleSlot().addToSlot(Main.player1.getTitleSlot().getTitleFromSlot(_loc1_));
               }
               _loc1_++;
            }
            _loc2_ = 0;
            while(_loc2_ < Main.player2.getTitleSlot().getListLength())
            {
               if(Main.player2.getTitleSlot().getTitleFromSlot(_loc2_).getId() == 25)
               {
                  Main.player1.getTitleSlot().addToSlot(Main.player2.getTitleSlot().getTitleFromSlot(_loc2_));
               }
               _loc2_++;
            }
         }
      }
      
      public static function lianjie(param1:*) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://my.4399.com/forums-thread-tagid-81127-id-31797852.html");
         navigateToURL(_loc2_,"_blank");
      }
   }
}

