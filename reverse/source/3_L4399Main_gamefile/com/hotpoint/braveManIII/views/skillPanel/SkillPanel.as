package com.hotpoint.braveManIII.views.skillPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.repository.skillCondition.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import flash.display.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol6695")]
   public class SkillPanel extends MovieClip
   {
      
      private static var _instance:SkillPanel;
      
      private static var aginNum:Number;
      
      public var p2_1:skill_mc;
      
      public var p1_4:skill_mc;
      
      public var s1_1:MovieClip;
      
      public var b2_0:剑技_1;
      
      public var b1_3:通用_4;
      
      public var py2_SetKey:设置快捷键;
      
      public var t2_5:TextField;
      
      public var p2_2:skill_mc;
      
      public var p1_5:skill_mc;
      
      public var s1_2:MovieClip;
      
      public var xs_mc1:MovieClip;
      
      public var b2_1:法术_2;
      
      public var t2_6:TextField;
      
      public var p2_3:skill_mc;
      
      public var p1_6:skill_mc;
      
      public var xs_mc2:MovieClip;
      
      public var s2_0:MovieClip;
      
      public var s1_3:MovieClip;
      
      public var b2_2:拳法_3;
      
      public var t2_7:TextField;
      
      public var mast_mc:MovieClip;
      
      public var p2_4:skill_mc;
      
      public var p1_7:skill_mc;
      
      public var s2_1:MovieClip;
      
      public var s1_4:MovieClip;
      
      public var b2_3:通用_4;
      
      public var a1_7:button3;
      
      public var p2_5:skill_mc;
      
      public var s2_2:MovieClip;
      
      public var s1_5:MovieClip;
      
      public var p2Skill_mc:MovieClip;
      
      public var p2_6:skill_mc;
      
      public var s2_3:MovieClip;
      
      public var s1_6:MovieClip;
      
      public var p2_7:skill_mc;
      
      public var s2_4:MovieClip;
      
      public var s1_7:MovieClip;
      
      public var a2_7:button3;
      
      public var s2_5:MovieClip;
      
      public var s2_6:MovieClip;
      
      public var p1_j:MovieClip;
      
      public var s2_7:MovieClip;
      
      public var skillPointMc:MovieClip;
      
      public var t1_0:TextField;
      
      public var prompt_btn:MovieClip;
      
      public var t1_1:TextField;
      
      public var t1_2:TextField;
      
      public var p2_j:MovieClip;
      
      public var t2_0:TextField;
      
      public var t1_3:TextField;
      
      public var prompt_btn3:MovieClip;
      
      public var p1_0:skill_mc;
      
      public var mack1:MovieClip;
      
      public var t2_1:TextField;
      
      public var t1_4:TextField;
      
      public var prompt_btn2:MovieClip;
      
      public var p1_1:skill_mc;
      
      public var mack2:MovieClip;
      
      public var b1_0:剑技_1;
      
      public var py1_SetKey:设置快捷键;
      
      public var t2_2:TextField;
      
      public var t1_5:TextField;
      
      public var p1_2:skill_mc;
      
      public var b1_1:法术_2;
      
      public var t2_3:TextField;
      
      public var t1_6:TextField;
      
      public var point1:TextField;
      
      public var p2_0:skill_mc;
      
      public var p1_3:skill_mc;
      
      public var s1_0:MovieClip;
      
      public var b1_2:拳法_3;
      
      public var t2_4:TextField;
      
      public var point2:TextField;
      
      public var t1_7:TextField;
      
      private var idArrOne:Array = ["a8","a9","a10","a11","a12","a13","a14","a15"];
      
      private var idArrTow:Array = ["b8","b9","b10","b11","b12","b13","b14","b15"];
      
      private var idArrThree:Array = ["c8","c9","c10","c11","c12","c13","c14","c15"];
      
      private var idArrFoure:Array = ["d1","d2","d3","d4","d5","d6","d7","d8"];
      
      private var idArrFive:Array = ["d9","d10","d11","d12","d13","d14","d15","d16"];
      
      private var p1condArr:Array = [];
      
      private var p2condArr:Array = [];
      
      private var p1finishCondArr:* = [];
      
      private var p2finishCondArr:* = [];
      
      private var p1BtnfinishCondArr:* = [];
      
      private var p2BtnfinishCondArr:* = [];
      
      private var targetId:uint = 0;
      
      private var playerStata:Boolean = false;
      
      private var PlayerDataOneArr:Array = [];
      
      private var playerTowArr:Array = [];
      
      private var bagStata:Array = [1,1];
      
      private var arrowArr:Array = [0,1];
      
      private var arrowrightNum1:* = 0;
      
      private var arrowrightNum2:* = 0;
      
      private var player1:PlayerData;
      
      private var player2:PlayerData;
      
      private var _textFormat:TextFormat;
      
      private var _textFormat1:TextFormat;
      
      private var oldSkillLevel:Number;
      
      private var oldPlayerData:PlayerData;
      
      private var oldSkill:String;
      
      private var oldPoint:Number;
      
      private var oldGold:Number;
      
      private var oldArr:Array;
      
      private var oldStataNum:Number;
      
      private var targetTypeId:String;
      
      private var aginBo:Boolean = true;
      
      private var pickNum:Number;
      
      public function SkillPanel(param1:PrivateClass)
      {
         super();
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(SkillPanel._instance == null)
         {
            SkillPanel._instance = new SkillPanel(new PrivateClass());
            SkillPanel._instance.addMc();
            SkillPanel._instance.initSkill();
         }
         SkillPanel._instance.setXY();
         Main._stage.addChild(SkillPanel._instance);
         SkillPanel._instance.updateSkill();
         SkillPanel._instance.visible = true;
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(SkillPanel._instance != null)
         {
            if(SkillPanel._instance.visible == true)
            {
               SkillPanel._instance.visible = false;
               SkillPanel._instance.closeMc();
            }
         }
      }
      
      public function closeMc() : void
      {
         this.prompt_btn.visible = false;
         this.prompt_btn2.visible = false;
         this.prompt_btn3.visible = false;
      }
      
      private function setXY() : void
      {
         var _loc1_:Number = Main._stage.stageWidth / 2;
         var _loc2_:Number = Main._stage.stageHeight / 2;
         this.x = _loc1_ - this.width / 2;
         this.y = 50;
      }
      
      public function initSkill() : void
      {
         if(Main.player2 != null)
         {
            playerStata = true;
         }
         else
         {
            playerStata = false;
         }
         initPlayerData();
         addEvent();
      }
      
      private function addMc() : void
      {
         this.prompt_btn.visible = false;
         this.prompt_btn2.visible = false;
         this.prompt_btn3.visible = false;
         _textFormat = new TextFormat();
         _textFormat.color = 16711680;
         _textFormat1 = new TextFormat();
         _textFormat1.color = 16777215;
         explain = new Explain();
         this.addChild(explain);
         explain.visible = false;
         explainTow = new Explain_Tow();
         this.addChild(explainTow);
         explainTow.visible = false;
      }
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_OVER,overHandle);
         this.addEventListener(BtnEvent.DO_OUT,outHandle);
         this.addEventListener(BtnEvent.DO_CHANGE,changeHandle);
         this.addEventListener(BtnEvent.DO_CLICK,clickHandle);
         this.addEventListener(BtnEvent.DO_CLOSE,closeHanle);
      }
      
      private function initPlayerData() : void
      {
         if(!playerStata)
         {
            player1 = Main.player1;
            PlayerDataOneArr = player1.getPickSkill();
            this.mast_mc.visible = true;
            p2AllBtnfalse();
            plBtnfalse();
            p2TextVisible();
            p2StuBtnVisible();
            textinitp1();
            initSkillFrame1();
            p1GoldText();
         }
         else
         {
            player1 = Main.player1;
            PlayerDataOneArr = player1.getPickSkill();
            player2 = Main.player2;
            playerTowArr = player2.getPickSkill();
            this.mast_mc.visible = false;
            plBtnfalse();
            p2Btnfalse();
            textinitp2();
            textinitp1();
            initSkillFrame1();
            initSkillFrame2();
            p1GoldText();
            p2GoldText();
         }
      }
      
      public function updateSkill() : void
      {
         plBtnfalse();
         initSkillFrame1();
         p1GoldText();
         if(Main.player_2 != null)
         {
            p2Btnfalse();
            p2GoldText();
            initSkillFrame2();
         }
      }
      
      private function initSkillFrame1() : void
      {
         p1_j.visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < PlayerDataOneArr.length)
         {
            if(PlayerDataOneArr[_loc1_])
            {
               if(_loc1_ == 0)
               {
                  dotext("t1_",idArrOne,player1);
                  cionFrame("p1_",idArrOne);
                  doCond(player1,idArrOne,p1condArr,p1finishCondArr,p1BtnfinishCondArr,1);
                  stuGoto(player1,"s1_",idArrOne,p1BtnfinishCondArr);
                  cionVisible(player1,"p1_",idArrOne);
                  return;
               }
               if(_loc1_ == 1)
               {
                  dotext("t1_",idArrTow,player1);
                  cionFrame("p1_",idArrTow);
                  doCond(player1,idArrTow,p1condArr,p1finishCondArr,p1BtnfinishCondArr,2);
                  stuGoto(player1,"s1_",idArrTow,p1BtnfinishCondArr);
                  cionVisible(player1,"p1_",idArrTow);
                  return;
               }
               if(_loc1_ == 2)
               {
                  dotext("t1_",idArrThree,player1);
                  cionFrame("p1_",idArrThree);
                  doCond(player1,idArrThree,p1condArr,p1finishCondArr,p1BtnfinishCondArr,3);
                  stuGoto(player1,"s1_",idArrThree,p1BtnfinishCondArr);
                  cionVisible(player1,"p1_",idArrThree);
                  return;
               }
            }
            _loc1_++;
         }
      }
      
      private function initSkillFrame2() : void
      {
         p2_j.visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < playerTowArr.length)
         {
            if(playerTowArr[_loc1_])
            {
               if(_loc1_ == 0)
               {
                  dotext("t2_",idArrOne,player2);
                  cionFrame("p2_",idArrOne);
                  doCond(player2,idArrOne,p2condArr,p2finishCondArr,p2BtnfinishCondArr,1);
                  stuGoto(player2,"s2_",idArrOne,p2BtnfinishCondArr);
                  cionVisible(player2,"p2_",idArrOne);
                  return;
               }
               if(_loc1_ == 1)
               {
                  dotext("t2_",idArrTow,player2);
                  cionFrame("p2_",idArrTow);
                  doCond(player2,idArrTow,p2condArr,p2finishCondArr,p2BtnfinishCondArr,2);
                  stuGoto(player2,"s2_",idArrTow,p2BtnfinishCondArr);
                  cionVisible(player2,"p2_",idArrTow);
                  return;
               }
               if(_loc1_ == 2)
               {
                  dotext("t2_",idArrThree,player2);
                  cionFrame("p2_",idArrThree);
                  doCond(player2,idArrThree,p2condArr,p2finishCondArr,p2BtnfinishCondArr,3);
                  stuGoto(player2,"s2_",idArrThree,p2BtnfinishCondArr);
                  cionVisible(player2,"p2_",idArrThree);
                  return;
               }
            }
            _loc1_++;
         }
      }
      
      private function textinitp1() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            this["t1_" + _loc1_].text = "未学习";
            this["p1_" + _loc1_].gotoAndStop(1);
            p1condArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      private function textinitp2() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            this["t2_" + _loc1_].text = "未学习";
            this["p2_" + _loc1_].gotoAndStop(1);
            p2condArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      private function clickHandle(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:* = _loc2_.name;
         var _loc4_:String = _loc2_.parent.name.substr(1,1);
         var _loc5_:String = _loc2_.parent.name.substr(3,1);
         var _loc6_:String = _loc2_.name.substr(3,1);
         var _loc7_:String = _loc2_.name.substr(1,1);
         if(_loc3_ == "py1_SetKey")
         {
            SetKeyPanel.open();
            SkillPanel.close();
         }
         if(_loc3_ == "py2_SetKey")
         {
            SetKeyPanel.open(2);
            SkillPanel.close();
         }
         if(_loc4_ == "1")
         {
            if(prompt_btn.visible == false)
            {
               switch(bagStata[0])
               {
                  case 1:
                     addSkill(player1,idArrOne,1,_loc5_);
                     break;
                  case 2:
                     addSkill(player1,idArrTow,2,_loc5_);
                     break;
                  case 3:
                     addSkill(player1,idArrThree,3,_loc5_);
                     break;
                  case 4:
                     addSkill(player1,idArrFoure,4,_loc5_);
                     break;
                  case 5:
                     if(arrowrightNum1 == 0)
                     {
                        addSkill(player1,idArrFoure,5,_loc5_);
                     }
                  case 6:
                     if(arrowrightNum1 == 1)
                     {
                        addSkill(player1,idArrFive,6,_loc5_);
                     }
                     break;
                  case 7:
               }
            }
         }
         if(_loc4_ == "2")
         {
            if(prompt_btn.visible == false)
            {
               switch(bagStata[1])
               {
                  case 1:
                     addSkill(player2,idArrOne,1,_loc5_);
                     break;
                  case 2:
                     addSkill(player2,idArrTow,2,_loc5_);
                     break;
                  case 3:
                     addSkill(player2,idArrThree,3,_loc5_);
                     break;
                  case 4:
                     addSkill(player2,idArrFoure,4,_loc5_);
                     break;
                  case 5:
                     if(arrowrightNum2 == 0)
                     {
                        addSkill(player2,idArrFoure,5,_loc5_);
                     }
                  case 6:
                     if(arrowrightNum2 == 1)
                     {
                        addSkill(player2,idArrFive,6,_loc5_);
                     }
               }
            }
         }
         if(_loc7_ == "1")
         {
            if(anginOk1())
            {
               if(player1.getBag().isHaveOtherobj(63101))
               {
                  aginNum = 1;
                  aginBasic();
               }
               else
               {
                  prompt_btn2.visible = true;
               }
            }
            else
            {
               NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"您未消耗技能点，无法重置");
            }
         }
         if(_loc7_ == "2")
         {
            if(anginOk2())
            {
               if(player2.getBag().isHaveOtherobj(63101))
               {
                  aginNum = 2;
                  aginBasic();
               }
               else
               {
                  prompt_btn2.visible = true;
               }
            }
            else
            {
               NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"您未消耗技能点，无法重置");
            }
         }
      }
      
      public function aginBasic() : void
      {
         this.prompt_btn3.visible = true;
      }
      
      public function aginP1() : void
      {
         var _loc1_:uint = aginGold(player1,idArrOne) + aginGold(player1,idArrTow) + aginGold(player1,idArrThree) + aginGold(player1,idArrFoure);
         player1.addGold(_loc1_);
         player1.addPoint(aginPoint(player1));
         p1GoldText();
         switch(bagStata[0])
         {
            case 1:
               dotext("t1_",idArrOne,player1);
               doCond(player1,idArrOne,p1condArr,p1finishCondArr,p1BtnfinishCondArr,1);
               cionVisible(player1,"p1_",idArrOne);
               stuGoto(player1,"s1_",idArrOne,p1BtnfinishCondArr);
               break;
            case 2:
               dotext("t1_",idArrTow,player1);
               doCond(player1,idArrTow,p1condArr,p1finishCondArr,p1BtnfinishCondArr,2);
               cionVisible(player1,"p1_",idArrTow);
               stuGoto(player1,"s1_",idArrTow,p1BtnfinishCondArr);
               break;
            case 3:
               dotext("t1_",idArrThree,player1);
               doCond(player1,idArrThree,p1condArr,p1finishCondArr,p1BtnfinishCondArr,3);
               cionVisible(player1,"p1_",idArrThree);
               stuGoto(player1,"s1_",idArrThree,p1BtnfinishCondArr);
               break;
            case 4:
               dotext("t1_",idArrFoure,player1);
               doCond(player1,idArrFoure,p1condArr,p1finishCondArr,p1BtnfinishCondArr,4);
               cionVisible(player1,"p1_",idArrFoure);
               stuGoto(player1,"s1_",idArrFoure,p1BtnfinishCondArr);
               p1tlStu();
               break;
            case 5:
               dotext("t1_",idArrFoure,player1);
               doCond(player1,idArrFoure,p1condArr,p1finishCondArr,p1BtnfinishCondArr,5);
               cionVisible(player1,"p1_",idArrFoure);
               stuGoto(player1,"s1_",idArrFoure,p1BtnfinishCondArr);
               p1tlStu();
               break;
            case 6:
               dotext("t1_",idArrFive,player1);
               doCond(player1,idArrFive,p1condArr,p1finishCondArr,p1BtnfinishCondArr,6);
               cionVisible(player1,"p1_",idArrFive);
               stuGoto(player1,"s1_",idArrFive,p1BtnfinishCondArr);
               p1tlStu();
         }
      }
      
      public function aginP2() : void
      {
         oldAllGod = aginGold(player2,idArrOne) + aginGold(player2,idArrTow) + aginGold(player2,idArrThree) + aginGold(player2,idArrFoure);
         player2.addGold(oldAllGod);
         player2.addPoint(aginPoint(player2));
         p2GoldText();
         switch(bagStata[1])
         {
            case 1:
               dotext("t2_",idArrOne,player2);
               doCond(player2,idArrOne,p2condArr,p2finishCondArr,p2BtnfinishCondArr,1);
               cionVisible(player2,"p2_",idArrOne);
               stuGoto(player2,"s2_",idArrOne,p2BtnfinishCondArr);
               break;
            case 2:
               dotext("t2_",idArrTow,player2);
               doCond(player2,idArrTow,p2condArr,p2finishCondArr,p2BtnfinishCondArr,2);
               cionVisible(player2,"p2_",idArrTow);
               stuGoto(player2,"s2_",idArrTow,p2BtnfinishCondArr);
               break;
            case 3:
               dotext("t2_",idArrThree,player2);
               doCond(player2,idArrThree,p2condArr,p2finishCondArr,p2BtnfinishCondArr,3);
               cionVisible(player2,"p2_",idArrThree);
               stuGoto(player2,"s2_",idArrThree,p2BtnfinishCondArr);
               break;
            case 4:
               dotext("t2_",idArrFoure,player2);
               doCond(player2,idArrFoure,p2condArr,p2finishCondArr,p2BtnfinishCondArr,4);
               cionVisible(player2,"p2_",idArrFoure);
               stuGoto(player2,"s2_",idArrFoure,p2BtnfinishCondArr);
               p2tlStu();
               break;
            case 5:
               dotext("t2_",idArrFoure,player2);
               doCond(player2,idArrFoure,p2condArr,p2finishCondArr,p2BtnfinishCondArr,5);
               cionVisible(player2,"p2_",idArrFoure);
               stuGoto(player2,"s2_",idArrFoure,p2BtnfinishCondArr);
               p2tlStu();
               break;
            case 6:
               dotext("t2_",idArrFive,player2);
               doCond(player2,idArrFive,p2condArr,p2finishCondArr,p2BtnfinishCondArr,6);
               cionVisible(player2,"p2_",idArrFive);
               stuGoto(player2,"s2_",idArrFive,p2BtnfinishCondArr);
               p2tlStu();
         }
      }
      
      private function anginOk1() : Boolean
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            if(player1.getSkillLevel(idArrOne[_loc1_]) > 0)
            {
               return true;
            }
            if(player1.getSkillLevel(idArrTow[_loc1_]) > 0)
            {
               return true;
            }
            if(player1.getSkillLevel(idArrThree[_loc1_]) > 0)
            {
               return true;
            }
            if(player1.getSkillLevel(idArrFoure[_loc1_]) > 0)
            {
               return true;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            if(player1.getSkillLevel(idArrFive[_loc1_]) > 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      private function anginOk2() : Boolean
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            if(player2.getSkillLevel(idArrOne[_loc1_]) > 0)
            {
               return true;
            }
            if(player2.getSkillLevel(idArrTow[_loc1_]) > 0)
            {
               return true;
            }
            if(player2.getSkillLevel(idArrThree[_loc1_]) > 0)
            {
               return true;
            }
            if(player2.getSkillLevel(idArrFoure[_loc1_]) > 0)
            {
               return true;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            if(player2.getSkillLevel(idArrFive[_loc1_]) > 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      private function aginPoint(param1:PlayerData) : Number
      {
         var _loc7_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc8_:uint = 0;
         while(_loc8_ < 8)
         {
            _loc2_ += Number(param1.getSkillLevel(idArrOne[_loc8_])) * SkillConditionFactory.getPoints(idArrOne[_loc8_]);
            _loc3_ += Number(param1.getSkillLevel(idArrTow[_loc8_])) * SkillConditionFactory.getPoints(idArrTow[_loc8_]);
            _loc4_ += Number(param1.getSkillLevel(idArrThree[_loc8_])) * SkillConditionFactory.getPoints(idArrThree[_loc8_]);
            _loc5_ += Number(param1.getSkillLevel(idArrFoure[_loc8_])) * SkillConditionFactory.getPoints(idArrFoure[_loc8_]);
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 7)
         {
            _loc6_ += Number(param1.getSkillLevel(idArrFive[_loc8_])) * SkillConditionFactory.getPoints(idArrFive[_loc8_]);
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 8)
         {
            param1.aginSkillLevel(idArrOne[_loc8_]);
            param1.aginSkillLevel(idArrTow[_loc8_]);
            param1.aginSkillLevel(idArrThree[_loc8_]);
            param1.aginSkillLevel(idArrFoure[_loc8_]);
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 7)
         {
            param1.aginSkillLevel(idArrFive[_loc8_]);
            _loc8_++;
         }
         return _loc2_ + _loc3_ + _loc4_ + _loc5_ + _loc6_;
      }
      
      private function aginGold(param1:PlayerData, param2:Array) : Number
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:Number = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            _loc5_ = param1.getSkillLevel(param2[_loc4_]);
            _loc6_ = 1;
            while(_loc6_ <= _loc5_)
            {
               _loc3_ += SkillConditionFactory.getGold(param2[_loc4_],_loc6_);
               _loc6_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function addSkill(param1:PlayerData, param2:Array, param3:Number, param4:String) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(param1.getSkillLevel(param2[param4]) < SkillFactory.getSkillByTypeIAndLevel(param2[param4]).getskillLevelUp())
         {
            _loc5_ = param1.getSkillLevel(param2[param4]) + 1;
            _loc6_ = Number(SkillConditionFactory.getGold(param2[param4],_loc5_));
            _loc7_ = Number(SkillConditionFactory.getPoints(param2[param4],_loc5_));
            oldPlayerData = param1;
            oldPoint = _loc7_;
            oldGold = _loc6_;
            oldStataNum = param3;
            targetTypeId = param2[param4];
            oldArr = param2;
            prompt_btn.visible = true;
            prompt_btn.gotoAndStop(1);
            _loc8_ = _loc6_.toString();
            _loc9_ = _loc7_.toString();
            mban(_loc8_,_loc9_);
         }
      }
      
      private function mban(param1:String, param2:String) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         if(prompt_btn)
         {
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               if(this.prompt_btn.num_mc)
               {
                  this.prompt_btn.num_mc["num_" + _loc3_].visible = false;
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < 3)
            {
               if(this.prompt_btn.num_mc2)
               {
                  this.prompt_btn.num_mc2["num_" + _loc3_].visible = false;
               }
               _loc3_++;
            }
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               if(this.prompt_btn.num_mc)
               {
                  this.prompt_btn.num_mc["num_" + _loc4_].visible = true;
                  if(param1.charAt(_loc4_) != "0")
                  {
                     this.prompt_btn.num_mc["num_" + _loc4_].gotoAndStop(param1.charAt(_loc4_));
                  }
                  else
                  {
                     this.prompt_btn.num_mc["num_" + _loc4_].gotoAndStop(10);
                  }
               }
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < param2.length)
            {
               if(this.prompt_btn.num_mc2)
               {
                  this.prompt_btn.num_mc2["num_" + _loc4_].visible = true;
                  if(param2.charAt(_loc4_) != "0")
                  {
                     this.prompt_btn.num_mc2["num_" + _loc4_].gotoAndStop(param2.charAt(_loc4_));
                  }
                  else
                  {
                     this.prompt_btn.num_mc2["num_" + _loc4_].gotoAndStop(10);
                  }
               }
               _loc4_++;
            }
         }
      }
      
      private function closeHanle(param1:BtnEvent) : void
      {
         prompt_btn.visible = false;
         prompt_btn2.visible = false;
         if(param1.target.id == 1)
         {
            if(oldPlayerData.getPoints() >= oldPoint)
            {
               if(oldPlayerData.getGold() >= oldGold)
               {
                  oldPlayerData.addSkillLevel(targetTypeId);
                  oldPlayerData.delPoints(oldPoint);
                  oldPlayerData.payGold(oldGold);
                  if(oldPlayerData == player1)
                  {
                     p1GoldText();
                     Main.player_1.GetAllSkillCD();
                     Main.player_1.LoadPlayerLvData();
                     if(oldStataNum < 6)
                     {
                        dotext("t1_",oldArr,player1);
                        doCond(player1,oldArr,p1condArr,p1finishCondArr,p1BtnfinishCondArr,oldStataNum);
                        cionVisible(player1,"p1_",oldArr);
                        stuGoto(player1,"s1_",oldArr,p1BtnfinishCondArr);
                        if(oldStataNum == 4 || oldStataNum == 5)
                        {
                           p1tlStu();
                        }
                     }
                     else
                     {
                        dotext("t1_",oldArr,player1);
                        doCond(player1,oldArr,p1condArr,p1finishCondArr,p1BtnfinishCondArr,oldStataNum);
                        cionVisible(player1,"p1_",oldArr);
                        stuGoto(player1,"s1_",oldArr,p1BtnfinishCondArr);
                        p1tlStu();
                     }
                  }
                  if(oldPlayerData == player2)
                  {
                     p2GoldText();
                     Main.player_2.GetAllSkillCD();
                     Main.player_2.LoadPlayerLvData();
                     if(oldStataNum < 6)
                     {
                        dotext("t2_",oldArr,player2);
                        doCond(player2,oldArr,p2condArr,p2finishCondArr,p2BtnfinishCondArr,oldStataNum);
                        cionVisible(player2,"p2_",oldArr);
                        stuGoto(player2,"s2_",oldArr,p2BtnfinishCondArr);
                        if(oldStataNum == 4 || oldStataNum == 5)
                        {
                           p2tlStu();
                        }
                     }
                     else
                     {
                        dotext("t2_",oldArr,player2);
                        doCond(player2,oldArr,p2condArr,p2finishCondArr,p2BtnfinishCondArr,oldStataNum);
                        cionVisible(player2,"p2_",oldArr);
                        stuGoto(player2,"s2_",oldArr,p2BtnfinishCondArr);
                        p2tlStu();
                     }
                  }
               }
               else
               {
                  NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"金币不足");
               }
            }
            else
            {
               NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"技能点数不足");
            }
         }
         if(param1.target.id == 3)
         {
            Shop4399.Open();
         }
         if(param1.target.id == 4)
         {
            close();
         }
         if(param1.target.id == 5)
         {
            if(aginNum == 1)
            {
               aginP1();
               player1.getBag().getAndUseOtherobj(63101);
               Main.player_1.GetAllSkillCD();
            }
            else if(aginNum == 2)
            {
               aginP2();
               player2.getBag().getAndUseOtherobj(63101);
               Main.player_2.GetAllSkillCD();
            }
            prompt_btn3.visible = false;
            Main.Save();
         }
         if(param1.target.id == 6)
         {
            prompt_btn3.visible = false;
         }
      }
      
      private function p1GoldText() : void
      {
         point1.text = String(player1.getPoints());
      }
      
      private function p2GoldText() : void
      {
         point2.text = String(player2.getPoints());
      }
      
      public function cionVisible(param1:PlayerData, param2:String, param3:Array) : void
      {
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            if(param1.getSkillLevel(param3[_loc4_]) == 0)
            {
               this[param2 + _loc4_].cion_mast.gotoAndStop(1);
            }
            else
            {
               this[param2 + _loc4_].cion_mast.gotoAndStop(2);
            }
            _loc4_++;
         }
      }
      
      public function p2StuBtnVisible() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            this["s2_" + _loc1_].gotoAndStop(2);
            _loc1_++;
         }
         p2_j.visible = false;
         p2Skill_mc.gotoAndStop(2);
      }
      
      private function stuGoto(param1:PlayerData, param2:String, param3:Array, param4:Array) : void
      {
         var _loc5_:uint = 0;
         while(_loc5_ < 8)
         {
            if(param1.getSkillLevel(param3[_loc5_]) < SkillFactory.getSkillByTypeIAndLevel(param3[_loc5_]).getskillLevelUp())
            {
               if(param4[_loc5_])
               {
                  this[param2 + _loc5_].gotoAndStop(1);
               }
               else
               {
                  this[param2 + _loc5_].gotoAndStop(2);
               }
            }
            else
            {
               this[param2 + _loc5_].gotoAndStop(2);
            }
            _loc5_++;
         }
      }
      
      private function doCond(param1:PlayerData, param2:Array, param3:Array, param4:Array, param5:Array, param6:Number) : void
      {
         var _loc7_:uint = 0;
         while(_loc7_ < 8)
         {
            if(param1.getSkillLevel(param2[_loc7_]) < SkillFactory.getSkillByTypeIAndLevel(param2[_loc7_]).getskillLevelUp())
            {
               param3[_loc7_] = SkillConditionFactory.getCondition(param2[_loc7_],param1.getSkillLevel(param2[_loc7_]) + 1);
            }
            else
            {
               param3[_loc7_] = SkillConditionFactory.getCondition(param2[_loc7_],param1.getSkillLevel(param2[_loc7_]));
            }
            param4[_loc7_] = contrast(param1,param3[_loc7_],param6 - 1);
            param5[_loc7_] = contrast(param1,param3[_loc7_],param6 - 1,"btn");
            _loc7_++;
         }
      }
      
      private function p2TextVisible() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            this["t2_" + _loc1_].text = "";
            _loc1_++;
         }
      }
      
      private function dotext(param1:String, param2:Array, param3:PlayerData) : *
      {
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            if(param3.getSkillLevel(param2[_loc4_]) == 0)
            {
               this[param1 + _loc4_].text = "未学习";
            }
            else
            {
               this[param1 + _loc4_].text = "LV." + param3.getSkillLevel(param2[_loc4_]).toString();
               if(param3.getSkillLevel(param2[_loc4_]) == SkillFactory.getSkillByTypeIAndLevel(param2[_loc4_]).getskillLevelUp())
               {
                  this[param1 + _loc4_].setTextFormat(_textFormat);
               }
            }
            _loc4_++;
         }
      }
      
      private function cionFrame(param1:String, param2:Array) : void
      {
         var _loc3_:uint = 0;
         while(_loc3_ < 8)
         {
            this[param1 + _loc3_].gotoAndStop(SkillFactory.getSkillByTypeIAndLevel(param2[_loc3_]).getFrame());
            _loc3_++;
         }
      }
      
      private function arrFalse(param1:Number) : void
      {
         if(param1 == 1 || param1 == 2 || param1 == 3)
         {
            this.p1_j.visible = false;
            this.xs_mc1.visible = true;
            this.p1_7.visible = true;
            this.s1_7.visible = true;
         }
         if(param1 == 4)
         {
            this.xs_mc1.visible = false;
            this.p1_j.visible = true;
            this.p1_7.visible = true;
            this.s1_7.visible = true;
         }
         if(param1 == 5)
         {
            this.p1_7.visible = true;
            this.s1_7.visible = true;
         }
      }
      
      private function arrFalse2(param1:Number) : void
      {
         if(param1 == 1 || param1 == 2 || param1 == 3)
         {
            this.p2_j.visible = false;
            this.xs_mc2.visible = true;
            this.p2_7.visible = true;
            this.s2_7.visible = true;
         }
         if(param1 == 4)
         {
            this.xs_mc2.visible = false;
            this.p2_j.visible = true;
            this.p2_7.visible = true;
            this.s2_7.visible = true;
         }
         if(param1 == 5)
         {
            this.p2_7.visible = true;
            this.s2_7.visible = true;
         }
      }
      
      private function contrast(param1:PlayerData, param2:Array, param3:Number, param4:String = "all") : Boolean
      {
         var _loc5_:Number = param1.getLevel();
         var _loc6_:Number = param1.getPoints();
         var _loc7_:Number = param1.getGold();
         var _loc8_:Boolean = param1.isRebirth();
         var _loc9_:Boolean = param1.isTransfer(param3);
         var _loc10_:Array = [];
         if(param4 == "all")
         {
            if(_loc5_ >= param2[0] && _loc6_ >= param2[1] && _loc7_ >= param2[2])
            {
               _loc10_[0] = true;
            }
            else
            {
               _loc10_[0] = false;
            }
         }
         if(param4 == "btn")
         {
            if(_loc5_ >= param2[0])
            {
               _loc10_[0] = true;
            }
            else
            {
               _loc10_[0] = false;
            }
         }
         if(param2[3] != false)
         {
            if(_loc8_ == true)
            {
               _loc10_[1] = true;
            }
            else
            {
               _loc10_[1] = false;
            }
         }
         else
         {
            _loc10_[1] = true;
         }
         if(param2[4] != false)
         {
            if(_loc9_ == true)
            {
               _loc10_[2] = true;
            }
            else
            {
               _loc10_[2] = false;
            }
         }
         else
         {
            _loc10_[2] = true;
         }
         if(param2[5] != "null")
         {
            if(param1.getSkillLevel(param2[5]) >= param2[6])
            {
               _loc10_[3] = true;
            }
            else
            {
               _loc10_[3] = false;
            }
         }
         else
         {
            _loc10_[3] = true;
         }
         if(Boolean(_loc10_[0]) && Boolean(_loc10_[1]) && Boolean(_loc10_[2]) && Boolean(_loc10_[3]))
         {
            return true;
         }
         return false;
      }
      
      private function changeHandle(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:String = _loc2_.name.substr(1,1);
         if(_loc3_ == "1")
         {
            arrFalse(param1.id);
            bagStata[0] = _loc2_.id;
            if(param1.id == 1)
            {
               this.b1_1.isClick = false;
               this.b1_2.isClick = false;
               this.b1_3.isClick = false;
               arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(1);
               cionFrame("p1_",idArrOne);
               dotext("t1_",idArrOne,player1);
               doCond(player1,idArrOne,p1condArr,p1finishCondArr,p1BtnfinishCondArr,param1.id);
               cionVisible(player1,"p1_",idArrOne);
               stuGoto(player1,"s1_",idArrOne,p1BtnfinishCondArr);
            }
            if(param1.id == 2)
            {
               this.b1_0.isClick = false;
               this.b1_2.isClick = false;
               this.b1_3.isClick = false;
               arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(2);
               cionFrame("p1_",idArrTow);
               dotext("t1_",idArrTow,player1);
               doCond(player1,idArrTow,p1condArr,p1finishCondArr,p1BtnfinishCondArr,param1.id);
               cionVisible(player1,"p1_",idArrTow);
               stuGoto(player1,"s1_",idArrTow,p1BtnfinishCondArr);
            }
            if(param1.id == 3)
            {
               this.b1_0.isClick = false;
               this.b1_1.isClick = false;
               this.b1_3.isClick = false;
               arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(3);
               cionFrame("p1_",idArrThree);
               dotext("t1_",idArrThree,player1);
               doCond(player1,idArrThree,p1condArr,p1finishCondArr,p1BtnfinishCondArr,param1.id);
               cionVisible(player1,"p1_",idArrThree);
               stuGoto(player1,"s1_",idArrThree,p1BtnfinishCondArr);
            }
            if(param1.id == 4)
            {
               this.b1_0.isClick = false;
               this.b1_1.isClick = false;
               this.b1_2.isClick = false;
               arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               cionFrame("p1_",idArrFoure);
               dotext("t1_",idArrFoure,player1);
               doCond(player1,idArrFoure,p1condArr,p1finishCondArr,p1BtnfinishCondArr,param1.id);
               cionVisible(player1,"p1_",idArrFoure);
               stuGoto(player1,"s1_",idArrFoure,p1BtnfinishCondArr);
               p1tlStu();
            }
            if(param1.id == 5)
            {
               if(arrowrightNum1 > arrowArr[0])
               {
                  --arrowrightNum1;
                  if(arrowrightNum1 < arrowArr[arrowArr.length - 1])
                  {
                     this.p1_j.b1_5.isClick = true;
                  }
                  cionFrame("p1_",idArrFoure);
                  dotext("t1_",idArrFoure,player1);
                  doCond(player1,idArrFoure,p1condArr,p1finishCondArr,p1BtnfinishCondArr,param1.id);
                  cionVisible(player1,"p1_",idArrFoure);
                  stuGoto(player1,"s1_",idArrFoure,p1BtnfinishCondArr);
                  p1tlStu();
               }
               if(arrowrightNum1 == arrowArr[0])
               {
               }
            }
            if(param1.id == 6)
            {
               if(arrowrightNum1 < arrowArr[arrowArr.length - 1])
               {
                  ++arrowrightNum1;
                  if(arrowrightNum1 > arrowArr[0])
                  {
                     this.p1_j.b1_4.isClick = true;
                  }
                  cionFrame("p1_",idArrFive);
                  dotext("t1_",idArrFive,player1);
                  doCond(player1,idArrFive,p1condArr,p1finishCondArr,p1BtnfinishCondArr,param1.id);
                  cionVisible(player1,"p1_",idArrFive);
                  stuGoto(player1,"s1_",idArrFive,p1BtnfinishCondArr);
                  p1tlStu();
               }
               if(arrowrightNum1 == arrowArr[arrowArr.length - 1])
               {
               }
            }
         }
         if(_loc3_ == "2")
         {
            arrFalse2(param1.id);
            bagStata[1] = _loc2_.id;
            if(param1.id == 1)
            {
               this.b2_1.isClick = false;
               this.b2_2.isClick = false;
               this.b2_3.isClick = false;
               arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(1);
               cionFrame("p2_",idArrOne);
               dotext("t2_",idArrOne,player2);
               doCond(player2,idArrOne,p2condArr,p2finishCondArr,p2BtnfinishCondArr,param1.id);
               cionVisible(player2,"p2_",idArrOne);
               stuGoto(player2,"s2_",idArrOne,p2BtnfinishCondArr);
            }
            if(param1.id == 2)
            {
               this.b2_0.isClick = false;
               this.b2_2.isClick = false;
               this.b2_3.isClick = false;
               arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(2);
               cionFrame("p2_",idArrTow);
               dotext("t2_",idArrTow,player2);
               doCond(player2,idArrTow,p2condArr,p2finishCondArr,p2BtnfinishCondArr,param1.id);
               cionVisible(player2,"p2_",idArrTow);
               stuGoto(player2,"s2_",idArrTow,p2BtnfinishCondArr);
            }
            if(param1.id == 3)
            {
               this.b2_0.isClick = false;
               this.b2_1.isClick = false;
               this.b2_3.isClick = false;
               arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(3);
               cionFrame("p2_",idArrThree);
               dotext("t2_",idArrThree,player2);
               doCond(player2,idArrThree,p2condArr,p2finishCondArr,p2BtnfinishCondArr,param1.id);
               cionVisible(player2,"p2_",idArrThree);
               stuGoto(player2,"s2_",idArrThree,p2BtnfinishCondArr);
            }
            if(param1.id == 4)
            {
               this.b2_0.isClick = false;
               this.b2_1.isClick = false;
               this.b2_2.isClick = false;
               arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               cionFrame("p2_",idArrFoure);
               dotext("t2_",idArrFoure,player2);
               doCond(player2,idArrFoure,p2condArr,p2finishCondArr,p2BtnfinishCondArr,param1.id);
               cionVisible(player2,"p2_",idArrFoure);
               stuGoto(player2,"s2_",idArrFoure,p2BtnfinishCondArr);
               p2tlStu();
            }
            if(param1.id == 5)
            {
               if(arrowrightNum2 > arrowArr[0])
               {
                  --arrowrightNum2;
                  if(arrowrightNum2 < arrowArr[arrowArr.length - 1])
                  {
                     this.p2_j.b2_5.isClick = true;
                  }
                  cionFrame("p2_",idArrFoure);
                  dotext("t2_",idArrFoure,player2);
                  doCond(player2,idArrFoure,p2condArr,p2finishCondArr,p2BtnfinishCondArr,param1.id);
                  cionVisible(player2,"p2_",idArrFoure);
                  stuGoto(player2,"s2_",idArrFoure,p2BtnfinishCondArr);
                  p2tlStu();
               }
               if(arrowrightNum2 == arrowArr[0])
               {
               }
            }
            if(param1.id == 6)
            {
               if(arrowrightNum2 < arrowArr[arrowArr.length - 1])
               {
                  ++arrowrightNum2;
                  if(arrowrightNum2 > arrowArr[0])
                  {
                     this.p2_j.b2_4.isClick = true;
                  }
                  cionFrame("p2_",idArrFive);
                  dotext("t2_",idArrFive,player2);
                  doCond(player2,idArrFive,p2condArr,p2finishCondArr,p2BtnfinishCondArr,param1.id);
                  cionVisible(player2,"p2_",idArrFive);
                  stuGoto(player2,"s2_",idArrFive,p2BtnfinishCondArr);
                  p2tlStu();
               }
               if(arrowrightNum2 == arrowArr[arrowArr.length - 1])
               {
               }
            }
         }
      }
      
      private function p1tlStu() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            if(PlayerDataOneArr[_loc1_] == false)
            {
               this["s1_" + (_loc1_ + 5)].gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      private function p2tlStu() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            if(playerTowArr[_loc1_] == false)
            {
               this["s2_" + (_loc1_ + 5)].gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      private function p2Btnfalse() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this["b2_" + _loc1_].isClick = false;
            _loc1_++;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < 3)
         {
            if(playerTowArr[_loc2_] == false)
            {
               this["b2_" + _loc2_].gotoAndStop(4);
               this.mack2.x = this["b2_" + _loc2_].x;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            if(playerTowArr[_loc2_] == true)
            {
               this["b2_" + _loc2_].isClick = true;
               bagStata[1] = _loc2_ + 1;
               xs_mc2.visible = true;
               xs_mc2.gotoAndStop(_loc2_ + 1);
               break;
            }
            _loc2_++;
         }
      }
      
      private function plBtnfalse() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this["b1_" + _loc1_].isClick = false;
            _loc1_++;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < 3)
         {
            this["b1_" + _loc2_].isClick = false;
            if(PlayerDataOneArr[_loc2_] == false)
            {
               this["b1_" + _loc2_].gotoAndStop(4);
               this["b1_" + _loc2_].isClick = false;
               this.mack1.x = this["b1_" + _loc2_].x;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            if(PlayerDataOneArr[_loc2_] == true)
            {
               this["b1_" + _loc2_].isClick = true;
               bagStata[0] = _loc2_ + 1;
               xs_mc1.visible = true;
               xs_mc1.gotoAndStop(_loc2_ + 1);
               break;
            }
            _loc2_++;
         }
      }
      
      private function p2AllBtnfalse() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this["b2_" + _loc1_].gotoAndStop(4);
            _loc1_++;
         }
         xs_mc2.visible = false;
         py2_SetKey.gotoAndStop(4);
         a2_7.gotoAndStop(4);
         point2.text = "";
         skillPointMc.gotoAndStop(2);
      }
      
      private function pointY(param1:MovieClip) : void
      {
         var _loc2_:Point = new Point(param1.x,param1.y);
         _loc2_ = this.localToGlobal(_loc2_);
         if(_loc2_.y + param1.height > 580)
         {
            param1.y = 580 - param1.height - 80;
         }
         if(_loc2_.y < 0)
         {
            param1.y = 0;
         }
      }
      
      private function initExplain(param1:PlayerData, param2:Array, param3:String, param4:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Number = NaN;
         if(param1.getSkillLevel(param2[param3]) == 0 || param1.getSkillLevel(param2[param3]) == SkillFactory.getSkillByTypeIAndLevel(param2[param3]).getskillLevelUp())
         {
            if(param1.getSkillLevel(param2[param3]) == 0)
            {
               _loc5_ = param1.getSkillLevel(param2[param3]) + 1;
            }
            if(param1.getSkillLevel(param2[param3]) == SkillFactory.getSkillByTypeIAndLevel(param2[param3]).getskillLevelUp())
            {
               _loc5_ = param1.getSkillLevel(param2[param3]);
            }
            explain.visible = true;
            if(param4 == 1)
            {
               explain.x = mouseX + 10;
               if(p1BtnfinishCondArr[param3])
               {
                  explain.beforeSkillName.setTextFormat(_textFormat1);
               }
               else
               {
                  explain.beforeSkillName.setTextFormat(_textFormat);
               }
            }
            if(param4 == 2)
            {
               explain.x = mouseX - explain.width - 10;
            }
            explain.y = mouseY;
            pointY(explain);
            exText(param2,param3,_loc5_,param1);
         }
         else
         {
            _loc5_ = param1.getSkillLevel(param2[param3]);
            explainTow.visible = true;
            if(param4 == 1)
            {
               explainTow.x = mouseX + 10;
            }
            if(param4 == 2)
            {
               explainTow.x = mouseX - explain.width - 10;
            }
            explainTow.y = mouseY;
            pointY(explainTow);
            if(SkillFactory.getSkillByTypeIAndLevel(param2[param3]).getProfessional() != "无")
            {
               explainTow.skillName.text = SkillFactory.getSkillByTypeIAndLevel(param2[param3]).getSkillName() + " (" + SkillFactory.getSkillByTypeIAndLevel(param2[param3]).getProfessional() + ")";
            }
            else
            {
               explainTow.skillName.text = SkillFactory.getSkillByTypeIAndLevel(param2[param3]).getSkillName();
            }
            explainTow.typName.text = SkillFactory.getSkillByTypeIAndLevel(param2[param3]).getSkillTouchOff();
            explainTow.nowLevel.text = "技能等级:LV." + _loc5_ + "/";
            explainTow.maxLevel.text = "LV." + SkillFactory.getSkillByTypeIAndLevel(param2[param3]).getskillLevelUp();
            explainTow.playerLevel.text = "需求人物等级:LV." + SkillConditionFactory.getPlayerDataLevel(param2[param3],_loc5_);
            if(SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_).getSkillCd() != 0)
            {
               explainTow.nowCd.text = "冷却时间:" + int(SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_).getSkillCd() / Main.fps) + "秒";
            }
            else
            {
               explainTow.nowCd.text = "";
            }
            if(SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_).getMp() != 0)
            {
               explainTow.mpNumber.text = "消耗MP:" + SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_).getMp();
            }
            else if(SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_).getWeapon() != "无")
            {
               explainTow.mpNumber.text = "武器限制:" + SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_).getWeapon();
            }
            else
            {
               explainTow.mpNumber.text = "";
            }
            explainTow.pointNumber.text = "需求技能点数:" + SkillConditionFactory.getPoints(param2[param3],_loc5_);
            explainTow.nowEx.text = SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_).getIntroduction();
            _loc6_ = SkillConditionFactory.getBeforeLevelId(param2[param3],_loc5_);
            if(_loc6_ != "null")
            {
               _loc9_ = SkillFactory.getSkillByTypeIAndLevel(_loc6_).getSkillName();
               _loc10_ = SkillConditionFactory.getBeforeLevel(param2[param3],_loc5_).toString();
               explainTow.beforeSkillName.text = _loc9_ + " " + "LV." + _loc10_.toString();
            }
            else
            {
               explainTow.beforeSkillName.text = "无";
            }
            explainTow.nextLevel.text = "技能等级:LV." + (_loc5_ + 1) + "/";
            explainTow.nextMaxLevel.text = "LV." + SkillFactory.getSkillByTypeIAndLevel(param2[param3]).getskillLevelUp();
            explainTow.nextPlayerLevel.text = "LV." + SkillConditionFactory.getPlayerDataLevel(param2[param3],_loc5_ + 1);
            explainTow.nextPoint.text = SkillConditionFactory.getPoints(param2[param3],_loc5_ + 1);
            if(SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_ + 1).getMp() != -1)
            {
               explainTow.nextmpNumber.text = "消耗MP:" + int(SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_ + 1).getMp());
            }
            else
            {
               explainTow.nextmpNumber.text = "";
            }
            if(SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_ + 1).getSkillCd() != -1)
            {
               explainTow.nextCd.text = "冷却时间:" + int(SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_ + 1).getSkillCd() / Main.fps) + "秒";
            }
            else
            {
               explainTow.nextCd.text = "";
            }
            _loc7_ = SkillConditionFactory.getBeforeLevelId(param2[param3],_loc5_ + 1);
            if(_loc7_ != "null")
            {
               _loc11_ = SkillFactory.getSkillByTypeIAndLevel(_loc7_).getSkillName();
               _loc12_ = Number(SkillConditionFactory.getBeforeLevel(param2[param3],_loc5_ + 1));
               explainTow.nexLevelbeforeSkillName.text = "前置技能:" + _loc11_ + " " + "LV." + _loc12_;
            }
            else
            {
               explainTow.nexLevelbeforeSkillName.text = "前置技能:无";
            }
            explainTow.nextEx.text = SkillFactory.getSkillByTypeIAndLevel(param2[param3],_loc5_ + 1).getIntroduction();
            _loc8_ = Number(param3);
         }
      }
      
      public function exText(param1:Array, param2:String, param3:Number, param4:PlayerData) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(SkillFactory.getSkillByTypeIAndLevel(param1[param2]).getProfessional() != "无")
         {
            explain.skillName.text = SkillFactory.getSkillByTypeIAndLevel(param1[param2]).getSkillName() + " (" + SkillFactory.getSkillByTypeIAndLevel(param1[param2]).getProfessional() + ")";
         }
         else
         {
            explain.skillName.text = SkillFactory.getSkillByTypeIAndLevel(param1[param2]).getSkillName();
         }
         explain.typName.text = SkillFactory.getSkillByTypeIAndLevel(param1[param2]).getSkillTouchOff();
         explain.nowLevel.text = "技能等级:LV." + param3 + "/";
         explain.maxLevel.text = "LV." + SkillFactory.getSkillByTypeIAndLevel(param1[param2]).getskillLevelUp();
         explain.playerLevel.text = "LV." + SkillConditionFactory.getPlayerDataLevel(param1[param2],param3);
         if(SkillFactory.getSkillByTypeIAndLevel(param1[param2],param3).getSkillCd() != 0)
         {
            explain.nowCd.text = "冷却时间:" + int(SkillFactory.getSkillByTypeIAndLevel(param1[param2],param3).getSkillCd() / Main.fps) + "秒";
         }
         else
         {
            explain.nowCd.text = "";
         }
         if(SkillFactory.getSkillByTypeIAndLevel(param1[param2],param3).getMp() != 0)
         {
            explain.mpNumber.text = "消耗MP:" + int(SkillFactory.getSkillByTypeIAndLevel(param1[param2],param3).getMp());
         }
         else if(SkillFactory.getSkillByTypeIAndLevel(param1[param2],param3).getWeapon() != "无")
         {
            explain.mpNumber.text = "武器限制:" + SkillFactory.getSkillByTypeIAndLevel(param1[param2],param3).getWeapon();
         }
         else
         {
            explain.mpNumber.text = "";
         }
         explain.pointNumber.text = SkillConditionFactory.getPoints(param1[param2],param3);
         explain.nowEx.text = SkillFactory.getSkillByTypeIAndLevel(param1[param2],param3).getIntroduction();
         var _loc5_:String = SkillConditionFactory.getBeforeLevelId(param1[param2],param3);
         if(_loc5_ != "null")
         {
            _loc6_ = SkillFactory.getSkillByTypeIAndLevel(_loc5_).getSkillName();
            _loc7_ = SkillConditionFactory.getBeforeLevel(param1[param2],param3).toString();
            explain.beforeSkillName.text = _loc6_ + " " + "LV." + _loc7_.toString();
         }
         else
         {
            explain.beforeSkillName.text = "无";
         }
      }
      
      private function setKeyFunction(param1:MovieClip, param2:Number, param3:Array, param4:* = 1) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         if(param4 == 1)
         {
            if(param2 < 4)
            {
               keyMcVible(param1);
               _loc5_ = Number(param3[param2 + 7]);
               _loc6_ = "k" + String(_loc5_);
               param1.skillKey.gotoAndStop(_loc6_);
            }
            else if(param2 == 4)
            {
               keyMcVible(param1,1);
               param1.skillKey.gotoAndStop("k" + String(param3[14]));
            }
            else if(param2 == 5)
            {
               keyMcVible(param1,2);
               param1.skillKey1.gotoAndStop("k" + String(param3[14]));
               param1.skillKey.gotoAndStop("k" + String(param3[0]));
            }
            else if(param2 == 6)
            {
               keyMcVible(param1,2);
               param1.skillKey1.gotoAndStop("k" + String(param3[14]));
               param1.skillKey.gotoAndStop("k" + String(param3[1]));
            }
            else if(param2 == 7)
            {
               keyMcVible(param1,3);
               param1.skillKey.gotoAndStop("k" + String(param3[0]));
               param1.skillKey1.gotoAndStop("k" + String(param3[0]));
               param1.skillKey2.gotoAndStop("k" + String(param3[14]));
            }
         }
         else if(param4 == 2)
         {
            param1.add1.text = "";
            param1.add2.text = "";
            if(param1.skillKey1)
            {
               param1.skillKey1.visible = false;
            }
            if(param1.skillKey2)
            {
               param1.skillKey2.visible = false;
            }
            if(param1.skillKey)
            {
               param1.skillKey.gotoAndStop("kx");
            }
         }
      }
      
      private function keyMcVible(param1:MovieClip, param2:Number = 1) : void
      {
         if(param1.skillKey)
         {
            param1.skillKey.visible = true;
         }
         if(param2 == 1)
         {
            param1.add1.text = "";
            param1.add2.text = "";
            if(param1.skillKey1)
            {
               param1.skillKey1.visible = false;
            }
            if(param1.skillKey2)
            {
               param1.skillKey2.visible = false;
            }
         }
         else if(param2 == 2)
         {
            param1.add1.text = "+";
            param1.add2.text = "";
            if(param1.skillKey2)
            {
               param1.skillKey2.visible = false;
            }
            if(param1.skillKey1)
            {
               param1.skillKey1.visible = true;
            }
         }
         else if(param2 == 3)
         {
            param1.add1.text = "+";
            param1.add2.text = "+";
            if(param1.skillKey1)
            {
               param1.skillKey1.visible = true;
            }
            if(param1.skillKey2)
            {
               param1.skillKey2.visible = true;
            }
         }
      }
      
      private function redText(param1:Array, param2:String, param3:Number = 1) : void
      {
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc5_:Number = 1;
         var _loc6_:Number = Number(param2);
         var _loc7_:Number = Number(SkillFactory.getSkillByTypeIAndLevel(param1[_loc6_]).getskillLevelUp());
         if(param3 == 1)
         {
            _loc4_ = Number(player1.getSkillLevel(param1[_loc6_]));
            if(_loc4_ == 0)
            {
               _loc4_ = 1;
            }
            else
            {
               _loc4_ = Number(player1.getSkillLevel(param1[_loc6_]));
               if(_loc4_ < _loc7_)
               {
                  _loc5_ = _loc4_ + 1;
               }
               else
               {
                  _loc5_ = _loc7_;
               }
            }
            if(player1.getLevel() >= SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc4_))
            {
               explain.playerLevel.setTextFormat(_textFormat1);
            }
            else
            {
               explain.playerLevel.setTextFormat(_textFormat);
            }
            if(player1.getPoints() >= SkillConditionFactory.getPoints(param1[_loc6_],_loc4_))
            {
               explain.pointNumber.setTextFormat(_textFormat1);
            }
            else
            {
               explain.pointNumber.setTextFormat(_textFormat);
            }
            _loc8_ = Number(SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc5_));
            if(player1.getLevel() >= SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc5_))
            {
               explainTow.nextPlayerLevel.setTextFormat(_textFormat1);
            }
            else
            {
               explainTow.nextPlayerLevel.setTextFormat(_textFormat);
            }
            if(player1.getPoints() >= SkillConditionFactory.getPoints(param1[_loc6_],_loc5_))
            {
               explainTow.nextPoint.setTextFormat(_textFormat1);
            }
            else
            {
               explainTow.nextPoint.setTextFormat(_textFormat);
            }
         }
         else if(param3 == 2)
         {
            _loc4_ = Number(player2.getSkillLevel(param1[_loc6_]));
            if(_loc4_ == 0)
            {
               _loc4_ = 1;
            }
            else
            {
               _loc4_ = Number(player2.getSkillLevel(param1[_loc6_]));
               if(_loc4_ < _loc7_)
               {
                  _loc5_ = _loc4_ + 1;
               }
               else
               {
                  _loc5_ = _loc7_;
               }
            }
            if(player2.getLevel() >= SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc4_))
            {
               explain.playerLevel.setTextFormat(_textFormat1);
            }
            else
            {
               explain.playerLevel.setTextFormat(_textFormat);
            }
            if(player2.getPoints() >= SkillConditionFactory.getPoints(param1[_loc6_],_loc4_))
            {
               explain.pointNumber.setTextFormat(_textFormat1);
            }
            else
            {
               explain.pointNumber.setTextFormat(_textFormat);
            }
            if(player2.getLevel() >= SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc5_))
            {
               explainTow.nextPlayerLevel.setTextFormat(_textFormat1);
            }
            else
            {
               explainTow.nextPlayerLevel.setTextFormat(_textFormat);
            }
            if(player2.getPoints() >= SkillConditionFactory.getPoints(param1[_loc6_],_loc5_))
            {
               explainTow.nextPoint.setTextFormat(_textFormat1);
            }
            else
            {
               explainTow.nextPoint.setTextFormat(_textFormat);
            }
         }
      }
      
      public function overHandle(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:String = _loc2_.name.substr(1,1);
         var _loc4_:String = _loc2_.name.substr(3,1);
         var _loc5_:Number = Number(_loc4_);
         if(_loc3_ == "1")
         {
            switch(bagStata[0])
            {
               case 1:
                  initExplain(player1,idArrOne,_loc4_,1);
                  redText(idArrOne,_loc4_);
                  setKeyFunction(explain,_loc5_,player1._keyArr);
                  setKeyFunction(explainTow,_loc5_,player1._keyArr);
                  break;
               case 2:
                  initExplain(player1,idArrTow,_loc4_,1);
                  redText(idArrTow,_loc4_);
                  setKeyFunction(explain,_loc5_,player1._keyArr);
                  setKeyFunction(explainTow,_loc5_,player1._keyArr);
                  break;
               case 3:
                  initExplain(player1,idArrThree,_loc4_,1);
                  redText(idArrThree,_loc4_);
                  setKeyFunction(explain,_loc5_,player1._keyArr);
                  setKeyFunction(explainTow,_loc5_,player1._keyArr);
                  break;
               case 4:
                  initExplain(player1,idArrFoure,_loc4_,1);
                  redText(idArrFoure,_loc4_);
                  setKeyFunction(explain,_loc5_,player1._keyArr,2);
                  setKeyFunction(explainTow,_loc5_,player1._keyArr,2);
                  break;
               case 5:
                  if(arrowrightNum1 == 0)
                  {
                     initExplain(player1,idArrFoure,_loc4_,1);
                     redText(idArrFoure,_loc4_);
                     setKeyFunction(explain,_loc5_,player1._keyArr,2);
                     setKeyFunction(explainTow,_loc5_,player1._keyArr,2);
                  }
                  break;
               case 6:
                  if(arrowrightNum1 == 1)
                  {
                     initExplain(player1,idArrFive,_loc4_,1);
                     redText(idArrFive,_loc4_);
                     setKeyFunction(explain,_loc5_,player1._keyArr,2);
                     setKeyFunction(explainTow,_loc5_,player1._keyArr,2);
                  }
            }
         }
         if(_loc3_ == "2")
         {
            switch(bagStata[1])
            {
               case 1:
                  initExplain(player2,idArrOne,_loc4_,2);
                  redText(idArrOne,_loc4_,2);
                  setKeyFunction(explain,_loc5_,player2._keyArr);
                  setKeyFunction(explainTow,_loc5_,player2._keyArr);
                  break;
               case 2:
                  initExplain(player2,idArrTow,_loc4_,2);
                  redText(idArrTow,_loc4_,2);
                  setKeyFunction(explain,_loc5_,player2._keyArr);
                  setKeyFunction(explainTow,_loc5_,player2._keyArr);
                  break;
               case 3:
                  initExplain(player2,idArrThree,_loc4_,2);
                  redText(idArrThree,_loc4_,2);
                  setKeyFunction(explain,_loc5_,player2._keyArr);
                  setKeyFunction(explainTow,_loc5_,player2._keyArr);
                  break;
               case 4:
                  initExplain(player2,idArrFoure,_loc4_,2);
                  redText(idArrFoure,_loc4_,2);
                  setKeyFunction(explain,_loc5_,player2._keyArr,2);
                  setKeyFunction(explainTow,_loc5_,player2._keyArr,2);
                  break;
               case 5:
                  if(arrowrightNum2 == 0)
                  {
                     initExplain(player2,idArrFoure,_loc4_,2);
                     redText(idArrFoure,_loc4_,2);
                     setKeyFunction(explain,_loc5_,player2._keyArr,2);
                     setKeyFunction(explainTow,_loc5_,player2._keyArr,2);
                  }
                  break;
               case 6:
                  if(arrowrightNum2 == 1)
                  {
                     initExplain(player2,idArrFive,_loc4_,2);
                     redText(idArrFive,_loc4_,2);
                     setKeyFunction(explain,_loc5_,player2._keyArr,2);
                     setKeyFunction(explainTow,_loc5_,player2._keyArr,2);
                  }
            }
         }
      }
      
      private function outHandle(param1:BtnEvent) : void
      {
         if(explain.visible)
         {
            explain.visible = false;
         }
         if(explainTow.visible)
         {
            explainTow.visible = false;
         }
      }
   }
}

class PrivateClass
{
   
   public function PrivateClass()
   {
      super();
   }
}
