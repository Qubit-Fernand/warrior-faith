package com.hotpoint.braveManIII.views.skillPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.repository.skillCondition.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class SkillPanel extends MovieClip
   {
      
      private static var _instance:SkillPanel;
      
      private static var aginNum:Number;
      
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
            this.playerStata = true;
         }
         else
         {
            this.playerStata = false;
         }
         this.initPlayerData();
         this.addEvent();
      }
      
      private function addMc() : void
      {
         this.prompt_btn.visible = false;
         this.prompt_btn2.visible = false;
         this.prompt_btn3.visible = false;
         this._textFormat = new TextFormat();
         this._textFormat.color = 16711680;
         this._textFormat1 = new TextFormat();
         this._textFormat1.color = 16777215;
         explain = new Explain();
         this.addChild(explain);
         explain.visible = false;
         explainTow = new Explain_Tow();
         this.addChild(explainTow);
         explainTow.visible = false;
      }
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_OVER,this.overHandle);
         this.addEventListener(BtnEvent.DO_OUT,this.outHandle);
         this.addEventListener(BtnEvent.DO_CHANGE,this.changeHandle);
         this.addEventListener(BtnEvent.DO_CLICK,this.clickHandle);
         this.addEventListener(BtnEvent.DO_CLOSE,this.closeHanle);
      }
      
      private function initPlayerData() : void
      {
         if(!this.playerStata)
         {
            this.player1 = Main.player1;
            this.PlayerDataOneArr = this.player1.getPickSkill();
            this.mast_mc.visible = true;
            this.p2AllBtnfalse();
            this.plBtnfalse();
            this.p2TextVisible();
            this.p2StuBtnVisible();
            this.textinitp1();
            this.initSkillFrame1();
            this.p1GoldText();
         }
         else
         {
            this.player1 = Main.player1;
            this.PlayerDataOneArr = this.player1.getPickSkill();
            this.player2 = Main.player2;
            this.playerTowArr = this.player2.getPickSkill();
            this.mast_mc.visible = false;
            this.plBtnfalse();
            this.p2Btnfalse();
            this.textinitp2();
            this.textinitp1();
            this.initSkillFrame1();
            this.initSkillFrame2();
            this.p1GoldText();
            this.p2GoldText();
         }
      }
      
      public function updateSkill() : void
      {
         this.plBtnfalse();
         this.initSkillFrame1();
         this.p1GoldText();
         if(Main.player_2 != null)
         {
            this.p2Btnfalse();
            this.p2GoldText();
            this.initSkillFrame2();
         }
      }
      
      private function initSkillFrame1() : void
      {
         p1_j.visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < this.PlayerDataOneArr.length)
         {
            if(this.PlayerDataOneArr[_loc1_])
            {
               if(_loc1_ == 0)
               {
                  this.dotext("t1_",this.idArrOne,this.player1);
                  this.cionFrame("p1_",this.idArrOne);
                  this.doCond(this.player1,this.idArrOne,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,1);
                  this.stuGoto(this.player1,"s1_",this.idArrOne,this.p1BtnfinishCondArr);
                  this.cionVisible(this.player1,"p1_",this.idArrOne);
                  return;
               }
               if(_loc1_ == 1)
               {
                  this.dotext("t1_",this.idArrTow,this.player1);
                  this.cionFrame("p1_",this.idArrTow);
                  this.doCond(this.player1,this.idArrTow,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,2);
                  this.stuGoto(this.player1,"s1_",this.idArrTow,this.p1BtnfinishCondArr);
                  this.cionVisible(this.player1,"p1_",this.idArrTow);
                  return;
               }
               if(_loc1_ == 2)
               {
                  this.dotext("t1_",this.idArrThree,this.player1);
                  this.cionFrame("p1_",this.idArrThree);
                  this.doCond(this.player1,this.idArrThree,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,3);
                  this.stuGoto(this.player1,"s1_",this.idArrThree,this.p1BtnfinishCondArr);
                  this.cionVisible(this.player1,"p1_",this.idArrThree);
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
         while(_loc1_ < this.playerTowArr.length)
         {
            if(this.playerTowArr[_loc1_])
            {
               if(_loc1_ == 0)
               {
                  this.dotext("t2_",this.idArrOne,this.player2);
                  this.cionFrame("p2_",this.idArrOne);
                  this.doCond(this.player2,this.idArrOne,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,1);
                  this.stuGoto(this.player2,"s2_",this.idArrOne,this.p2BtnfinishCondArr);
                  this.cionVisible(this.player2,"p2_",this.idArrOne);
                  return;
               }
               if(_loc1_ == 1)
               {
                  this.dotext("t2_",this.idArrTow,this.player2);
                  this.cionFrame("p2_",this.idArrTow);
                  this.doCond(this.player2,this.idArrTow,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,2);
                  this.stuGoto(this.player2,"s2_",this.idArrTow,this.p2BtnfinishCondArr);
                  this.cionVisible(this.player2,"p2_",this.idArrTow);
                  return;
               }
               if(_loc1_ == 2)
               {
                  this.dotext("t2_",this.idArrThree,this.player2);
                  this.cionFrame("p2_",this.idArrThree);
                  this.doCond(this.player2,this.idArrThree,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,3);
                  this.stuGoto(this.player2,"s2_",this.idArrThree,this.p2BtnfinishCondArr);
                  this.cionVisible(this.player2,"p2_",this.idArrThree);
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
            this.p1condArr[_loc1_] = -1;
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
            this.p2condArr[_loc1_] = -1;
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
               switch(this.bagStata[0])
               {
                  case 1:
                     this.addSkill(this.player1,this.idArrOne,1,_loc5_);
                     break;
                  case 2:
                     this.addSkill(this.player1,this.idArrTow,2,_loc5_);
                     break;
                  case 3:
                     this.addSkill(this.player1,this.idArrThree,3,_loc5_);
                     break;
                  case 4:
                     this.addSkill(this.player1,this.idArrFoure,4,_loc5_);
                     break;
                  case 5:
                     if(this.arrowrightNum1 == 0)
                     {
                        this.addSkill(this.player1,this.idArrFoure,5,_loc5_);
                     }
                  case 6:
                     if(this.arrowrightNum1 == 1)
                     {
                        this.addSkill(this.player1,this.idArrFive,6,_loc5_);
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
               switch(this.bagStata[1])
               {
                  case 1:
                     this.addSkill(this.player2,this.idArrOne,1,_loc5_);
                     break;
                  case 2:
                     this.addSkill(this.player2,this.idArrTow,2,_loc5_);
                     break;
                  case 3:
                     this.addSkill(this.player2,this.idArrThree,3,_loc5_);
                     break;
                  case 4:
                     this.addSkill(this.player2,this.idArrFoure,4,_loc5_);
                     break;
                  case 5:
                     if(this.arrowrightNum2 == 0)
                     {
                        this.addSkill(this.player2,this.idArrFoure,5,_loc5_);
                     }
                  case 6:
                     if(this.arrowrightNum2 == 1)
                     {
                        this.addSkill(this.player2,this.idArrFive,6,_loc5_);
                     }
               }
            }
         }
         if(_loc7_ == "1")
         {
            if(this.anginOk1())
            {
               if(this.player1.getBag().isHaveOtherobj(63101))
               {
                  aginNum = 1;
                  this.aginBasic();
               }
               else
               {
                  prompt_btn2.visible = true;
               }
            }
            else
            {
               trace("无法重置");
               ShortTip.open(13);
            }
         }
         if(_loc7_ == "2")
         {
            if(this.anginOk2())
            {
               if(this.player2.getBag().isHaveOtherobj(63101))
               {
                  aginNum = 2;
                  this.aginBasic();
               }
               else
               {
                  trace("没有道具");
                  prompt_btn2.visible = true;
               }
            }
            else
            {
               trace("没加过点无法重置");
               ShortTip.open(13);
            }
         }
      }
      
      public function aginBasic() : void
      {
         this.prompt_btn3.visible = true;
      }
      
      public function aginP1() : void
      {
         trace("重置P1");
         var _loc1_:uint = this.aginGold(this.player1,this.idArrOne) + this.aginGold(this.player1,this.idArrTow) + this.aginGold(this.player1,this.idArrThree) + this.aginGold(this.player1,this.idArrFoure);
         this.player1.addGold(_loc1_);
         trace("返回:" + _loc1_);
         this.player1.addPoint(this.aginPoint(this.player1));
         trace("重置后的金币" + this.player1.getGold());
         this.p1GoldText();
         switch(this.bagStata[0])
         {
            case 1:
               this.dotext("t1_",this.idArrOne,this.player1);
               this.doCond(this.player1,this.idArrOne,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,1);
               this.cionVisible(this.player1,"p1_",this.idArrOne);
               this.stuGoto(this.player1,"s1_",this.idArrOne,this.p1BtnfinishCondArr);
               break;
            case 2:
               this.dotext("t1_",this.idArrTow,this.player1);
               this.doCond(this.player1,this.idArrTow,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,2);
               this.cionVisible(this.player1,"p1_",this.idArrTow);
               this.stuGoto(this.player1,"s1_",this.idArrTow,this.p1BtnfinishCondArr);
               break;
            case 3:
               this.dotext("t1_",this.idArrThree,this.player1);
               this.doCond(this.player1,this.idArrThree,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,3);
               this.cionVisible(this.player1,"p1_",this.idArrThree);
               this.stuGoto(this.player1,"s1_",this.idArrThree,this.p1BtnfinishCondArr);
               break;
            case 4:
               this.dotext("t1_",this.idArrFoure,this.player1);
               this.doCond(this.player1,this.idArrFoure,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,4);
               this.cionVisible(this.player1,"p1_",this.idArrFoure);
               this.stuGoto(this.player1,"s1_",this.idArrFoure,this.p1BtnfinishCondArr);
               this.p1tlStu();
               break;
            case 5:
               this.dotext("t1_",this.idArrFoure,this.player1);
               this.doCond(this.player1,this.idArrFoure,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,5);
               this.cionVisible(this.player1,"p1_",this.idArrFoure);
               this.stuGoto(this.player1,"s1_",this.idArrFoure,this.p1BtnfinishCondArr);
               this.p1tlStu();
               break;
            case 6:
               this.dotext("t1_",this.idArrFive,this.player1);
               this.doCond(this.player1,this.idArrFive,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,6);
               this.cionVisible(this.player1,"p1_",this.idArrFive);
               this.stuGoto(this.player1,"s1_",this.idArrFive,this.p1BtnfinishCondArr);
               this.p1tlStu();
         }
      }
      
      public function aginP2() : void
      {
         oldAllGod = this.aginGold(this.player2,this.idArrOne) + this.aginGold(this.player2,this.idArrTow) + this.aginGold(this.player2,this.idArrThree) + this.aginGold(this.player2,this.idArrFoure);
         this.player2.addGold(oldAllGod);
         this.player2.addPoint(this.aginPoint(this.player2));
         this.p2GoldText();
         switch(this.bagStata[1])
         {
            case 1:
               this.dotext("t2_",this.idArrOne,this.player2);
               this.doCond(this.player2,this.idArrOne,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,1);
               this.cionVisible(this.player2,"p2_",this.idArrOne);
               this.stuGoto(this.player2,"s2_",this.idArrOne,this.p2BtnfinishCondArr);
               break;
            case 2:
               this.dotext("t2_",this.idArrTow,this.player2);
               this.doCond(this.player2,this.idArrTow,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,2);
               this.cionVisible(this.player2,"p2_",this.idArrTow);
               this.stuGoto(this.player2,"s2_",this.idArrTow,this.p2BtnfinishCondArr);
               break;
            case 3:
               this.dotext("t2_",this.idArrThree,this.player2);
               this.doCond(this.player2,this.idArrThree,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,3);
               this.cionVisible(this.player2,"p2_",this.idArrThree);
               this.stuGoto(this.player2,"s2_",this.idArrThree,this.p2BtnfinishCondArr);
               break;
            case 4:
               this.dotext("t2_",this.idArrFoure,this.player2);
               this.doCond(this.player2,this.idArrFoure,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,4);
               this.cionVisible(this.player2,"p2_",this.idArrFoure);
               this.stuGoto(this.player2,"s2_",this.idArrFoure,this.p2BtnfinishCondArr);
               this.p2tlStu();
               break;
            case 5:
               this.dotext("t2_",this.idArrFoure,this.player2);
               this.doCond(this.player2,this.idArrFoure,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,5);
               this.cionVisible(this.player2,"p2_",this.idArrFoure);
               this.stuGoto(this.player2,"s2_",this.idArrFoure,this.p2BtnfinishCondArr);
               this.p2tlStu();
               break;
            case 6:
               this.dotext("t2_",this.idArrFive,this.player2);
               this.doCond(this.player2,this.idArrFive,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,6);
               this.cionVisible(this.player2,"p2_",this.idArrFive);
               this.stuGoto(this.player2,"s2_",this.idArrFive,this.p2BtnfinishCondArr);
               this.p2tlStu();
         }
      }
      
      private function anginOk1() : Boolean
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            if(this.player1.getSkillLevel(this.idArrOne[_loc1_]) > 0)
            {
               return true;
            }
            if(this.player1.getSkillLevel(this.idArrTow[_loc1_]) > 0)
            {
               return true;
            }
            if(this.player1.getSkillLevel(this.idArrThree[_loc1_]) > 0)
            {
               return true;
            }
            if(this.player1.getSkillLevel(this.idArrFoure[_loc1_]) > 0)
            {
               return true;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            if(this.player1.getSkillLevel(this.idArrFive[_loc1_]) > 0)
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
            if(this.player2.getSkillLevel(this.idArrOne[_loc1_]) > 0)
            {
               return true;
            }
            if(this.player2.getSkillLevel(this.idArrTow[_loc1_]) > 0)
            {
               return true;
            }
            if(this.player2.getSkillLevel(this.idArrThree[_loc1_]) > 0)
            {
               return true;
            }
            if(this.player2.getSkillLevel(this.idArrFoure[_loc1_]) > 0)
            {
               return true;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            if(this.player2.getSkillLevel(this.idArrFive[_loc1_]) > 0)
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
            _loc2_ += Number(param1.getSkillLevel(this.idArrOne[_loc8_])) * SkillConditionFactory.getPoints(this.idArrOne[_loc8_]);
            _loc3_ += Number(param1.getSkillLevel(this.idArrTow[_loc8_])) * SkillConditionFactory.getPoints(this.idArrTow[_loc8_]);
            _loc4_ += Number(param1.getSkillLevel(this.idArrThree[_loc8_])) * SkillConditionFactory.getPoints(this.idArrThree[_loc8_]);
            _loc5_ += Number(param1.getSkillLevel(this.idArrFoure[_loc8_])) * SkillConditionFactory.getPoints(this.idArrFoure[_loc8_]);
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 7)
         {
            _loc6_ += Number(param1.getSkillLevel(this.idArrFive[_loc8_])) * SkillConditionFactory.getPoints(this.idArrFive[_loc8_]);
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 8)
         {
            param1.aginSkillLevel(this.idArrOne[_loc8_]);
            param1.aginSkillLevel(this.idArrTow[_loc8_]);
            param1.aginSkillLevel(this.idArrThree[_loc8_]);
            param1.aginSkillLevel(this.idArrFoure[_loc8_]);
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 7)
         {
            param1.aginSkillLevel(this.idArrFive[_loc8_]);
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
            trace("要花的技能点_________________" + _loc7_);
            this.oldPlayerData = param1;
            this.oldPoint = _loc7_;
            this.oldGold = _loc6_;
            this.oldStataNum = param3;
            this.targetTypeId = param2[param4];
            this.oldArr = param2;
            prompt_btn.visible = true;
            prompt_btn.gotoAndStop(1);
            _loc8_ = _loc6_.toString();
            _loc9_ = _loc7_.toString();
            this.mban(_loc8_,_loc9_);
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
            if(this.oldPlayerData.getPoints() >= this.oldPoint)
            {
               if(this.oldPlayerData.getGold() >= this.oldGold)
               {
                  this.oldPlayerData.addSkillLevel(this.targetTypeId);
                  this.oldPlayerData.delPoints(this.oldPoint);
                  this.oldPlayerData.payGold(this.oldGold);
                  if(this.oldPlayerData == this.player1)
                  {
                     this.p1GoldText();
                     Main.player_1.GetAllSkillCD();
                     Main.player_1.LoadPlayerLvData();
                     if(this.oldStataNum < 6)
                     {
                        this.dotext("t1_",this.oldArr,this.player1);
                        this.doCond(this.player1,this.oldArr,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,this.oldStataNum);
                        this.cionVisible(this.player1,"p1_",this.oldArr);
                        this.stuGoto(this.player1,"s1_",this.oldArr,this.p1BtnfinishCondArr);
                        if(this.oldStataNum == 4 || this.oldStataNum == 5)
                        {
                           this.p1tlStu();
                        }
                     }
                     else
                     {
                        this.dotext("t1_",this.oldArr,this.player1);
                        this.doCond(this.player1,this.oldArr,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,this.oldStataNum);
                        this.cionVisible(this.player1,"p1_",this.oldArr);
                        this.stuGoto(this.player1,"s1_",this.oldArr,this.p1BtnfinishCondArr);
                        this.p1tlStu();
                     }
                  }
                  if(this.oldPlayerData == this.player2)
                  {
                     this.p2GoldText();
                     Main.player_2.GetAllSkillCD();
                     Main.player_2.LoadPlayerLvData();
                     if(this.oldStataNum < 6)
                     {
                        this.dotext("t2_",this.oldArr,this.player2);
                        this.doCond(this.player2,this.oldArr,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,this.oldStataNum);
                        this.cionVisible(this.player2,"p2_",this.oldArr);
                        this.stuGoto(this.player2,"s2_",this.oldArr,this.p2BtnfinishCondArr);
                        if(this.oldStataNum == 4 || this.oldStataNum == 5)
                        {
                           this.p2tlStu();
                        }
                     }
                     else
                     {
                        this.dotext("t2_",this.oldArr,this.player2);
                        this.doCond(this.player2,this.oldArr,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,this.oldStataNum);
                        this.cionVisible(this.player2,"p2_",this.oldArr);
                        this.stuGoto(this.player2,"s2_",this.oldArr,this.p2BtnfinishCondArr);
                        this.p2tlStu();
                     }
                  }
               }
               else
               {
                  trace("金币不足");
                  ShortTip.open(16);
               }
            }
            else
            {
               trace("技能点数不足");
               ShortTip.open(20);
            }
         }
         if(param1.target.id == 3)
         {
            trace("请到商城");
            Shop4399.Open();
         }
         if(param1.target.id == 4)
         {
            trace("关闭");
            close();
         }
         if(param1.target.id == 5)
         {
            if(aginNum == 1)
            {
               this.aginP1();
               this.player1.getBag().getAndUseOtherobj(63101);
               Main.player_1.GetAllSkillCD();
            }
            else if(aginNum == 2)
            {
               this.aginP2();
               this.player2.getBag().getAndUseOtherobj(63101);
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
         point1.text = String(this.player1.getPoints());
      }
      
      private function p2GoldText() : void
      {
         point2.text = String(this.player2.getPoints());
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
            param4[_loc7_] = this.contrast(param1,param3[_loc7_],param6 - 1);
            param5[_loc7_] = this.contrast(param1,param3[_loc7_],param6 - 1,"btn");
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
                  this[param1 + _loc4_].setTextFormat(this._textFormat);
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
            this.arrFalse(param1.id);
            this.bagStata[0] = _loc2_.id;
            if(param1.id == 1)
            {
               this.b1_1.isClick = false;
               this.b1_2.isClick = false;
               this.b1_3.isClick = false;
               this.arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(1);
               this.cionFrame("p1_",this.idArrOne);
               this.dotext("t1_",this.idArrOne,this.player1);
               this.doCond(this.player1,this.idArrOne,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,param1.id);
               this.cionVisible(this.player1,"p1_",this.idArrOne);
               this.stuGoto(this.player1,"s1_",this.idArrOne,this.p1BtnfinishCondArr);
            }
            if(param1.id == 2)
            {
               this.b1_0.isClick = false;
               this.b1_2.isClick = false;
               this.b1_3.isClick = false;
               this.arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(2);
               this.cionFrame("p1_",this.idArrTow);
               this.dotext("t1_",this.idArrTow,this.player1);
               this.doCond(this.player1,this.idArrTow,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,param1.id);
               this.cionVisible(this.player1,"p1_",this.idArrTow);
               this.stuGoto(this.player1,"s1_",this.idArrTow,this.p1BtnfinishCondArr);
            }
            if(param1.id == 3)
            {
               this.b1_0.isClick = false;
               this.b1_1.isClick = false;
               this.b1_3.isClick = false;
               this.arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(3);
               this.cionFrame("p1_",this.idArrThree);
               this.dotext("t1_",this.idArrThree,this.player1);
               this.doCond(this.player1,this.idArrThree,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,param1.id);
               this.cionVisible(this.player1,"p1_",this.idArrThree);
               this.stuGoto(this.player1,"s1_",this.idArrThree,this.p1BtnfinishCondArr);
            }
            if(param1.id == 4)
            {
               this.b1_0.isClick = false;
               this.b1_1.isClick = false;
               this.b1_2.isClick = false;
               this.arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               this.cionFrame("p1_",this.idArrFoure);
               this.dotext("t1_",this.idArrFoure,this.player1);
               this.doCond(this.player1,this.idArrFoure,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,param1.id);
               this.cionVisible(this.player1,"p1_",this.idArrFoure);
               this.stuGoto(this.player1,"s1_",this.idArrFoure,this.p1BtnfinishCondArr);
               this.p1tlStu();
            }
            if(param1.id == 5)
            {
               if(this.arrowrightNum1 > this.arrowArr[0])
               {
                  --this.arrowrightNum1;
                  if(this.arrowrightNum1 < this.arrowArr[this.arrowArr.length - 1])
                  {
                     this.p1_j.b1_5.isClick = true;
                  }
                  this.cionFrame("p1_",this.idArrFoure);
                  this.dotext("t1_",this.idArrFoure,this.player1);
                  this.doCond(this.player1,this.idArrFoure,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,param1.id);
                  this.cionVisible(this.player1,"p1_",this.idArrFoure);
                  this.stuGoto(this.player1,"s1_",this.idArrFoure,this.p1BtnfinishCondArr);
                  this.p1tlStu();
               }
               if(this.arrowrightNum1 == this.arrowArr[0])
               {
               }
            }
            if(param1.id == 6)
            {
               if(this.arrowrightNum1 < this.arrowArr[this.arrowArr.length - 1])
               {
                  ++this.arrowrightNum1;
                  if(this.arrowrightNum1 > this.arrowArr[0])
                  {
                     this.p1_j.b1_4.isClick = true;
                  }
                  this.cionFrame("p1_",this.idArrFive);
                  this.dotext("t1_",this.idArrFive,this.player1);
                  this.doCond(this.player1,this.idArrFive,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,param1.id);
                  this.cionVisible(this.player1,"p1_",this.idArrFive);
                  this.stuGoto(this.player1,"s1_",this.idArrFive,this.p1BtnfinishCondArr);
                  this.p1tlStu();
               }
               if(this.arrowrightNum1 == this.arrowArr[this.arrowArr.length - 1])
               {
               }
            }
         }
         if(_loc3_ == "2")
         {
            this.arrFalse2(param1.id);
            this.bagStata[1] = _loc2_.id;
            if(param1.id == 1)
            {
               this.b2_1.isClick = false;
               this.b2_2.isClick = false;
               this.b2_3.isClick = false;
               this.arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(1);
               this.cionFrame("p2_",this.idArrOne);
               this.dotext("t2_",this.idArrOne,this.player2);
               this.doCond(this.player2,this.idArrOne,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,param1.id);
               this.cionVisible(this.player2,"p2_",this.idArrOne);
               this.stuGoto(this.player2,"s2_",this.idArrOne,this.p2BtnfinishCondArr);
            }
            if(param1.id == 2)
            {
               this.b2_0.isClick = false;
               this.b2_2.isClick = false;
               this.b2_3.isClick = false;
               this.arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(2);
               this.cionFrame("p2_",this.idArrTow);
               this.dotext("t2_",this.idArrTow,this.player2);
               this.doCond(this.player2,this.idArrTow,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,param1.id);
               this.cionVisible(this.player2,"p2_",this.idArrTow);
               this.stuGoto(this.player2,"s2_",this.idArrTow,this.p2BtnfinishCondArr);
            }
            if(param1.id == 3)
            {
               this.b2_0.isClick = false;
               this.b2_1.isClick = false;
               this.b2_3.isClick = false;
               this.arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(3);
               this.cionFrame("p2_",this.idArrThree);
               this.dotext("t2_",this.idArrThree,this.player2);
               this.doCond(this.player2,this.idArrThree,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,param1.id);
               this.cionVisible(this.player2,"p2_",this.idArrThree);
               this.stuGoto(this.player2,"s2_",this.idArrThree,this.p2BtnfinishCondArr);
            }
            if(param1.id == 4)
            {
               this.b2_0.isClick = false;
               this.b2_1.isClick = false;
               this.b2_2.isClick = false;
               this.arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               this.cionFrame("p2_",this.idArrFoure);
               this.dotext("t2_",this.idArrFoure,this.player2);
               this.doCond(this.player2,this.idArrFoure,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,param1.id);
               this.cionVisible(this.player2,"p2_",this.idArrFoure);
               this.stuGoto(this.player2,"s2_",this.idArrFoure,this.p2BtnfinishCondArr);
               this.p2tlStu();
            }
            if(param1.id == 5)
            {
               if(this.arrowrightNum2 > this.arrowArr[0])
               {
                  --this.arrowrightNum2;
                  if(this.arrowrightNum2 < this.arrowArr[this.arrowArr.length - 1])
                  {
                     this.p2_j.b2_5.isClick = true;
                  }
                  this.cionFrame("p2_",this.idArrFoure);
                  this.dotext("t2_",this.idArrFoure,this.player2);
                  this.doCond(this.player2,this.idArrFoure,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,param1.id);
                  this.cionVisible(this.player2,"p2_",this.idArrFoure);
                  this.stuGoto(this.player2,"s2_",this.idArrFoure,this.p2BtnfinishCondArr);
                  this.p2tlStu();
               }
               if(this.arrowrightNum2 == this.arrowArr[0])
               {
               }
            }
            if(param1.id == 6)
            {
               if(this.arrowrightNum2 < this.arrowArr[this.arrowArr.length - 1])
               {
                  ++this.arrowrightNum2;
                  if(this.arrowrightNum2 > this.arrowArr[0])
                  {
                     this.p2_j.b2_4.isClick = true;
                  }
                  this.cionFrame("p2_",this.idArrFive);
                  this.dotext("t2_",this.idArrFive,this.player2);
                  this.doCond(this.player2,this.idArrFive,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,param1.id);
                  this.cionVisible(this.player2,"p2_",this.idArrFive);
                  this.stuGoto(this.player2,"s2_",this.idArrFive,this.p2BtnfinishCondArr);
                  this.p2tlStu();
               }
               if(this.arrowrightNum2 == this.arrowArr[this.arrowArr.length - 1])
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
            if(this.PlayerDataOneArr[_loc1_] == false)
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
            if(this.playerTowArr[_loc1_] == false)
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
            if(this.playerTowArr[_loc2_] == false)
            {
               this["b2_" + _loc2_].gotoAndStop(4);
               this.mack2.x = this["b2_" + _loc2_].x;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            if(this.playerTowArr[_loc2_] == true)
            {
               this["b2_" + _loc2_].isClick = true;
               this.bagStata[1] = _loc2_ + 1;
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
            if(this.PlayerDataOneArr[_loc2_] == false)
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
            if(this.PlayerDataOneArr[_loc2_] == true)
            {
               this["b1_" + _loc2_].isClick = true;
               this.bagStata[0] = _loc2_ + 1;
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
               if(this.p1BtnfinishCondArr[param3])
               {
                  explain.beforeSkillName.setTextFormat(this._textFormat1);
               }
               else
               {
                  explain.beforeSkillName.setTextFormat(this._textFormat);
               }
            }
            if(param4 == 2)
            {
               explain.x = mouseX - explain.width - 10;
            }
            explain.y = mouseY;
            this.pointY(explain);
            this.exText(param2,param3,_loc5_,param1);
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
            this.pointY(explainTow);
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
               this.keyMcVible(param1);
               _loc5_ = Number(param3[param2 + 7]);
               _loc6_ = "k" + String(_loc5_);
               param1.skillKey.gotoAndStop(_loc6_);
            }
            else if(param2 == 4)
            {
               this.keyMcVible(param1,1);
               param1.skillKey.gotoAndStop("k" + String(param3[14]));
            }
            else if(param2 == 5)
            {
               this.keyMcVible(param1,2);
               param1.skillKey1.gotoAndStop("k" + String(param3[14]));
               param1.skillKey.gotoAndStop("k" + String(param3[0]));
            }
            else if(param2 == 6)
            {
               this.keyMcVible(param1,2);
               param1.skillKey1.gotoAndStop("k" + String(param3[14]));
               param1.skillKey.gotoAndStop("k" + String(param3[1]));
            }
            else if(param2 == 7)
            {
               this.keyMcVible(param1,3);
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
            _loc4_ = Number(this.player1.getSkillLevel(param1[_loc6_]));
            if(_loc4_ == 0)
            {
               _loc4_ = 1;
            }
            else
            {
               _loc4_ = Number(this.player1.getSkillLevel(param1[_loc6_]));
               if(_loc4_ < _loc7_)
               {
                  _loc5_ = _loc4_ + 1;
               }
               else
               {
                  _loc5_ = _loc7_;
               }
            }
            if(this.player1.getLevel() >= SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc4_))
            {
               explain.playerLevel.setTextFormat(this._textFormat1);
            }
            else
            {
               explain.playerLevel.setTextFormat(this._textFormat);
            }
            if(this.player1.getPoints() >= SkillConditionFactory.getPoints(param1[_loc6_],_loc4_))
            {
               explain.pointNumber.setTextFormat(this._textFormat1);
            }
            else
            {
               explain.pointNumber.setTextFormat(this._textFormat);
            }
            _loc8_ = Number(SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc5_));
            if(this.player1.getLevel() >= SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc5_))
            {
               explainTow.nextPlayerLevel.setTextFormat(this._textFormat1);
            }
            else
            {
               explainTow.nextPlayerLevel.setTextFormat(this._textFormat);
            }
            if(this.player1.getPoints() >= SkillConditionFactory.getPoints(param1[_loc6_],_loc5_))
            {
               explainTow.nextPoint.setTextFormat(this._textFormat1);
            }
            else
            {
               explainTow.nextPoint.setTextFormat(this._textFormat);
            }
         }
         else if(param3 == 2)
         {
            _loc4_ = Number(this.player2.getSkillLevel(param1[_loc6_]));
            if(_loc4_ == 0)
            {
               _loc4_ = 1;
            }
            else
            {
               _loc4_ = Number(this.player2.getSkillLevel(param1[_loc6_]));
               if(_loc4_ < _loc7_)
               {
                  _loc5_ = _loc4_ + 1;
               }
               else
               {
                  _loc5_ = _loc7_;
               }
            }
            if(this.player2.getLevel() >= SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc4_))
            {
               explain.playerLevel.setTextFormat(this._textFormat1);
            }
            else
            {
               explain.playerLevel.setTextFormat(this._textFormat);
            }
            if(this.player2.getPoints() >= SkillConditionFactory.getPoints(param1[_loc6_],_loc4_))
            {
               explain.pointNumber.setTextFormat(this._textFormat1);
            }
            else
            {
               explain.pointNumber.setTextFormat(this._textFormat);
            }
            if(this.player2.getLevel() >= SkillConditionFactory.getPlayerDataLevel(param1[_loc6_],_loc5_))
            {
               explainTow.nextPlayerLevel.setTextFormat(this._textFormat1);
            }
            else
            {
               explainTow.nextPlayerLevel.setTextFormat(this._textFormat);
            }
            if(this.player2.getPoints() >= SkillConditionFactory.getPoints(param1[_loc6_],_loc5_))
            {
               explainTow.nextPoint.setTextFormat(this._textFormat1);
            }
            else
            {
               explainTow.nextPoint.setTextFormat(this._textFormat);
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
            switch(this.bagStata[0])
            {
               case 1:
                  this.initExplain(this.player1,this.idArrOne,_loc4_,1);
                  this.redText(this.idArrOne,_loc4_);
                  this.setKeyFunction(explain,_loc5_,this.player1._keyArr);
                  this.setKeyFunction(explainTow,_loc5_,this.player1._keyArr);
                  break;
               case 2:
                  this.initExplain(this.player1,this.idArrTow,_loc4_,1);
                  this.redText(this.idArrTow,_loc4_);
                  this.setKeyFunction(explain,_loc5_,this.player1._keyArr);
                  this.setKeyFunction(explainTow,_loc5_,this.player1._keyArr);
                  break;
               case 3:
                  this.initExplain(this.player1,this.idArrThree,_loc4_,1);
                  this.redText(this.idArrThree,_loc4_);
                  this.setKeyFunction(explain,_loc5_,this.player1._keyArr);
                  this.setKeyFunction(explainTow,_loc5_,this.player1._keyArr);
                  break;
               case 4:
                  this.initExplain(this.player1,this.idArrFoure,_loc4_,1);
                  this.redText(this.idArrFoure,_loc4_);
                  this.setKeyFunction(explain,_loc5_,this.player1._keyArr,2);
                  this.setKeyFunction(explainTow,_loc5_,this.player1._keyArr,2);
                  break;
               case 5:
                  if(this.arrowrightNum1 == 0)
                  {
                     this.initExplain(this.player1,this.idArrFoure,_loc4_,1);
                     this.redText(this.idArrFoure,_loc4_);
                     this.setKeyFunction(explain,_loc5_,this.player1._keyArr,2);
                     this.setKeyFunction(explainTow,_loc5_,this.player1._keyArr,2);
                  }
                  break;
               case 6:
                  if(this.arrowrightNum1 == 1)
                  {
                     this.initExplain(this.player1,this.idArrFive,_loc4_,1);
                     this.redText(this.idArrFive,_loc4_);
                     this.setKeyFunction(explain,_loc5_,this.player1._keyArr,2);
                     this.setKeyFunction(explainTow,_loc5_,this.player1._keyArr,2);
                  }
            }
         }
         if(_loc3_ == "2")
         {
            switch(this.bagStata[1])
            {
               case 1:
                  this.initExplain(this.player2,this.idArrOne,_loc4_,2);
                  this.redText(this.idArrOne,_loc4_,2);
                  this.setKeyFunction(explain,_loc5_,this.player2._keyArr);
                  this.setKeyFunction(explainTow,_loc5_,this.player2._keyArr);
                  break;
               case 2:
                  this.initExplain(this.player2,this.idArrTow,_loc4_,2);
                  this.redText(this.idArrTow,_loc4_,2);
                  this.setKeyFunction(explain,_loc5_,this.player2._keyArr);
                  this.setKeyFunction(explainTow,_loc5_,this.player2._keyArr);
                  break;
               case 3:
                  this.initExplain(this.player2,this.idArrThree,_loc4_,2);
                  this.redText(this.idArrThree,_loc4_,2);
                  this.setKeyFunction(explain,_loc5_,this.player2._keyArr);
                  this.setKeyFunction(explainTow,_loc5_,this.player2._keyArr);
                  break;
               case 4:
                  this.initExplain(this.player2,this.idArrFoure,_loc4_,2);
                  this.redText(this.idArrFoure,_loc4_,2);
                  this.setKeyFunction(explain,_loc5_,this.player2._keyArr,2);
                  this.setKeyFunction(explainTow,_loc5_,this.player2._keyArr,2);
                  break;
               case 5:
                  if(this.arrowrightNum2 == 0)
                  {
                     this.initExplain(this.player2,this.idArrFoure,_loc4_,2);
                     this.redText(this.idArrFoure,_loc4_,2);
                     this.setKeyFunction(explain,_loc5_,this.player2._keyArr,2);
                     this.setKeyFunction(explainTow,_loc5_,this.player2._keyArr,2);
                  }
                  break;
               case 6:
                  if(this.arrowrightNum2 == 1)
                  {
                     this.initExplain(this.player2,this.idArrFive,_loc4_,2);
                     this.redText(this.idArrFive,_loc4_,2);
                     this.setKeyFunction(explain,_loc5_,this.player2._keyArr,2);
                     this.setKeyFunction(explainTow,_loc5_,this.player2._keyArr,2);
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
