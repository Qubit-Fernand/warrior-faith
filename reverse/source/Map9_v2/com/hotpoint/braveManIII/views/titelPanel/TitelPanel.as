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
      
      public static function open(pp:Boolean = true) : void
      {
         isPOne = pp;
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
         for(var i:uint = 0; i < 6; i++)
         {
            ttPanel["left" + i].buttonMode = true;
            ttPanel["right" + i].buttonMode = true;
            ttPanel["left" + i].addEventListener(MouseEvent.CLICK,leftOK);
            ttPanel["right" + i].addEventListener(MouseEvent.CLICK,rightOK);
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
         var i:uint = 0;
         var regStr:RegExp = null;
         var j:uint = 0;
         var hp:Boolean = true;
         var mp:Boolean = true;
         var att:Boolean = true;
         var def:Boolean = true;
         var crit:Boolean = true;
         var speed:Boolean = true;
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
            for(i = 0; i < 6; i++)
            {
               if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i))
               {
                  ttPanel["left" + i].visible = true;
                  ttPanel["right" + i].visible = true;
                  ttPanel["titleName" + i].visible = true;
                  ttPanel["dikuang" + i].visible = true;
                  if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i) != null)
                  {
                     if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i) == Main.player1.getTitleSlot().getTitleView())
                     {
                        ttPanel["left" + i].alpha = 100;
                     }
                     else
                     {
                        ttPanel["left" + i].alpha = 0;
                     }
                     if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i) == Main.player1.getTitleSlot().getTitleAttrib())
                     {
                        regStr = /[$]/g;
                        ttPanel["ts_skill"].text = Main.player1.getTitleSlot().getTitleAttrib().getIntroductionSkill().replace(regStr,"\n");
                        ttPanel["right" + i].alpha = 100;
                        ttPanel["jieshao"].text = Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getIntroduction();
                        for(j = 0; j < 6; j++)
                        {
                           ttPanel["sx" + j].text = "";
                           if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getHP() > 0 && hp)
                           {
                              ttPanel["sx" + j].text = "生命+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getHP();
                              hp = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getMP() > 0 && mp)
                           {
                              ttPanel["sx" + j].text = "魔法+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getMP();
                              mp = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getAttack() > 0 && att)
                           {
                              ttPanel["sx" + j].text = "攻击力+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getAttack();
                              att = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getDefense() > 0 && def)
                           {
                              ttPanel["sx" + j].text = "防御力+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getDefense();
                              def = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getCrit() > 0 && crit)
                           {
                              ttPanel["sx" + j].text = "暴击+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getCrit();
                              crit = false;
                           }
                           else if(Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getMoveSpeed() > 0 && speed)
                           {
                              ttPanel["sx" + j].text = "移动+" + Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getMoveSpeed();
                              speed = false;
                           }
                        }
                     }
                     else
                     {
                        ttPanel["right" + i].alpha = 0;
                     }
                  }
                  ttPanel["titleName" + i].text = Main.player1.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getName();
               }
               else
               {
                  ttPanel["left" + i].visible = false;
                  ttPanel["right" + i].visible = false;
                  ttPanel["titleName" + i].visible = false;
                  ttPanel["dikuang" + i].visible = false;
               }
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
            for(i = 0; i < 6; i++)
            {
               if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i))
               {
                  ttPanel["left" + i].visible = true;
                  ttPanel["right" + i].visible = true;
                  ttPanel["titleName" + i].visible = true;
                  ttPanel["dikuang" + i].visible = true;
                  if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i) != null)
                  {
                     if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i) == Main.player2.getTitleSlot().getTitleView())
                     {
                        ttPanel["left" + i].alpha = 100;
                     }
                     else
                     {
                        ttPanel["left" + i].alpha = 0;
                     }
                     if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i) == Main.player2.getTitleSlot().getTitleAttrib())
                     {
                        regStr = /[$]/g;
                        ttPanel["ts_skill"].text = Main.player2.getTitleSlot().getTitleAttrib().getIntroductionSkill().replace(regStr,"\n");
                        ttPanel["right" + i].alpha = 100;
                        ttPanel["jieshao"].text = Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getIntroduction();
                        for(j = 0; j < 6; j++)
                        {
                           ttPanel["sx" + j].text = "";
                           if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getHP() > 0 && hp)
                           {
                              ttPanel["sx" + j].text = "生命+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getHP();
                              hp = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getMP() > 0 && mp)
                           {
                              ttPanel["sx" + j].text = "魔法+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getMP();
                              mp = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getAttack() > 0 && att)
                           {
                              ttPanel["sx" + j].text = "攻击力+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getAttack();
                              att = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getDefense() > 0 && def)
                           {
                              ttPanel["sx" + j].text = "防御力+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getDefense();
                              def = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getCrit() > 0 && crit)
                           {
                              ttPanel["sx" + j].text = "暴击+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getCrit();
                              crit = false;
                           }
                           else if(Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getMoveSpeed() > 0 && speed)
                           {
                              ttPanel["sx" + j].text = "移动+" + Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getMoveSpeed();
                              speed = false;
                           }
                        }
                     }
                     else
                     {
                        ttPanel["right" + i].alpha = 0;
                     }
                  }
                  ttPanel["titleName" + i].text = Main.player2.getTitleSlot().getTitleFromSlot(6 * yeNum + i).getName();
               }
               else
               {
                  ttPanel["left" + i].visible = false;
                  ttPanel["right" + i].visible = false;
                  ttPanel["titleName" + i].visible = false;
                  ttPanel["dikuang" + i].visible = false;
               }
            }
            Main.player_2.cengHao_mc.Show(2);
         }
      }
      
      private static function setTitleViewColor(num:Number) : *
      {
         if(num == 1)
         {
            ColorX(ttPanel["titleView"],"0xffffff");
         }
         if(num == 2)
         {
            ColorX(ttPanel["titleView"],"0x0066ff");
         }
         if(num == 3)
         {
            ColorX(ttPanel["titleView"],"0xFF33FF");
         }
         if(num == 4)
         {
            ColorX(ttPanel["titleView"],"0xFF9900");
         }
      }
      
      private static function setTitleAttribColor(num:Number) : *
      {
         if(num == 1)
         {
            ColorX(ttPanel["titleAttrib"],"0xffffff");
         }
         if(num == 2)
         {
            ColorX(ttPanel["titleAttrib"],"0x0066ff");
         }
         if(num == 3)
         {
            ColorX(ttPanel["titleAttrib"],"0xFF33FF");
         }
         if(num == 4)
         {
            ColorX(ttPanel["titleAttrib"],"0xFF9900");
         }
      }
      
      private static function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      public static function removeListenerP1() : *
      {
         for(var i:uint = 0; i < 6; i++)
         {
            ttPanel["left" + i].removeEventListener(MouseEvent.CLICK,leftOK);
            ttPanel["right" + i].removeEventListener(MouseEvent.CLICK,rightOK);
         }
         ttPanel["shang"].removeEventListener(MouseEvent.CLICK,shangDo);
         ttPanel["xia"].removeEventListener(MouseEvent.CLICK,xiaDo);
         ttPanel["makesure"].removeEventListener(MouseEvent.CLICK,makesure);
         ttPanel["cancel"].removeEventListener(MouseEvent.CLICK,cancel);
      }
      
      public static function makesure(e:*) : *
      {
         close();
         ItemsPanel.open();
      }
      
      public static function cancel(e:*) : *
      {
         close();
         ItemsPanel.open();
      }
      
      public static function shangDo(e:*) : *
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
      
      public static function xiaDo(e:*) : *
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
      
      public static function leftOK(e:*) : *
      {
         var i:uint = 0;
         var temp:Number = NaN;
         if((e.target as MovieClip).alpha == 100)
         {
            (e.target as MovieClip).alpha = 0;
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
            for(i = 0; i < 6; i++)
            {
               ttPanel["left" + i].alpha = 0;
            }
            (e.target as MovieClip).alpha = 100;
            temp = Number((e.target as MovieClip).name.substr(4,1));
            if(isPOne)
            {
               Main.player1.getTitleSlot().setTitleView(Main.player1.getTitleSlot().getTitleFromSlot(temp + yeNum * 6));
            }
            else
            {
               Main.player2.getTitleSlot().setTitleView(Main.player2.getTitleSlot().getTitleFromSlot(temp + yeNum * 6));
            }
         }
         showTitleList();
      }
      
      public static function rightOK(e:*) : *
      {
         var i:uint = 0;
         var temp:Number = NaN;
         if((e.target as MovieClip).alpha == 100)
         {
            (e.target as MovieClip).alpha = 0;
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
            for(i = 0; i < 6; i++)
            {
               ttPanel["right" + i].alpha = 0;
            }
            (e.target as MovieClip).alpha = 100;
            temp = Number((e.target as MovieClip).name.substr(5,1));
            if(isPOne)
            {
               Main.player1.getTitleSlot().setTitleAttrib(Main.player1.getTitleSlot().getTitleFromSlot(temp + yeNum * 6));
            }
            else
            {
               Main.player2.getTitleSlot().setTitleAttrib(Main.player2.getTitleSlot().getTitleFromSlot(temp + yeNum * 6));
            }
         }
         showTitleList();
      }
      
      public static function setTitleTime() : *
      {
         var i:int = 0;
         if(isPOne)
         {
            for(i = 0; i < 20; i++)
            {
               if(Main.player1.getTitleSlot().getTitleFromSlot(i) != null)
               {
                  Main.player1.getTitleSlot().getTitleFromSlot(i).setRemainingTime(Main.serverTime);
               }
            }
         }
         else
         {
            for(i = 0; i < 20; i++)
            {
               if(Main.player2.getTitleSlot().getTitleFromSlot(i) != null)
               {
                  Main.player2.getTitleSlot().getTitleFromSlot(i).setRemainingTime(Main.serverTime);
               }
            }
         }
      }
      
      public static function testTitleTime() : *
      {
         var i:* = 0;
         setTitleTime();
         if(isPOne)
         {
            for(i = 0; i < 20; i++)
            {
               if(Main.player1.getTitleSlot().getTitleFromSlot(i) != null && Main.player1.getTitleSlot().getTitleFromSlot(i).getRemainingTime() == 0)
               {
                  Main.player1.getTitleSlot().delFromSlot(i);
                  i--;
               }
            }
         }
         else
         {
            for(i = 0; i < 20; i++)
            {
               if(Main.player2.getTitleSlot().getTitleFromSlot(i) != null && Main.player2.getTitleSlot().getTitleFromSlot(i).getRemainingTime() == 0)
               {
                  Main.player2.getTitleSlot().delFromSlot(i);
                  i--;
               }
            }
         }
      }
      
      public static function testTitleVIP() : *
      {
         var j:int = 0;
         var i:int = 0;
         if(Main.P1P2)
         {
            for(j = 0; j < Main.player1.getTitleSlot().getListLength(); j++)
            {
               if(Main.player1.getTitleSlot().getTitleFromSlot(j).getId() == 25)
               {
                  Main.player2.getTitleSlot().addToSlot(Main.player1.getTitleSlot().getTitleFromSlot(j));
               }
            }
            for(i = 0; i < Main.player2.getTitleSlot().getListLength(); i++)
            {
               if(Main.player2.getTitleSlot().getTitleFromSlot(i).getId() == 25)
               {
                  Main.player1.getTitleSlot().addToSlot(Main.player2.getTitleSlot().getTitleFromSlot(i));
               }
            }
         }
      }
      
      public static function lianjie(e:*) : *
      {
         var request:URLRequest = new URLRequest("http://my.4399.com/forums-thread-tagid-81127-id-31797852.html");
         navigateToURL(request,"_blank");
      }
   }
}

