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
      
      public function SkillPanel(pvt:PrivateClass)
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
         var stageWidth:Number = Main._stage.stageWidth / 2;
         var stageHeight:Number = Main._stage.stageHeight / 2;
         this.x = stageWidth - this.width / 2;
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
         for(var i:uint = 0; i < this.PlayerDataOneArr.length; i++)
         {
            if(this.PlayerDataOneArr[i])
            {
               if(i == 0)
               {
                  this.dotext("t1_",this.idArrOne,this.player1);
                  this.cionFrame("p1_",this.idArrOne);
                  this.doCond(this.player1,this.idArrOne,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,1);
                  this.stuGoto(this.player1,"s1_",this.idArrOne,this.p1BtnfinishCondArr);
                  this.cionVisible(this.player1,"p1_",this.idArrOne);
                  return;
               }
               if(i == 1)
               {
                  this.dotext("t1_",this.idArrTow,this.player1);
                  this.cionFrame("p1_",this.idArrTow);
                  this.doCond(this.player1,this.idArrTow,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,2);
                  this.stuGoto(this.player1,"s1_",this.idArrTow,this.p1BtnfinishCondArr);
                  this.cionVisible(this.player1,"p1_",this.idArrTow);
                  return;
               }
               if(i == 2)
               {
                  this.dotext("t1_",this.idArrThree,this.player1);
                  this.cionFrame("p1_",this.idArrThree);
                  this.doCond(this.player1,this.idArrThree,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,3);
                  this.stuGoto(this.player1,"s1_",this.idArrThree,this.p1BtnfinishCondArr);
                  this.cionVisible(this.player1,"p1_",this.idArrThree);
                  return;
               }
            }
         }
      }
      
      private function initSkillFrame2() : void
      {
         p2_j.visible = false;
         for(var i:uint = 0; i < this.playerTowArr.length; i++)
         {
            if(this.playerTowArr[i])
            {
               if(i == 0)
               {
                  this.dotext("t2_",this.idArrOne,this.player2);
                  this.cionFrame("p2_",this.idArrOne);
                  this.doCond(this.player2,this.idArrOne,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,1);
                  this.stuGoto(this.player2,"s2_",this.idArrOne,this.p2BtnfinishCondArr);
                  this.cionVisible(this.player2,"p2_",this.idArrOne);
                  return;
               }
               if(i == 1)
               {
                  this.dotext("t2_",this.idArrTow,this.player2);
                  this.cionFrame("p2_",this.idArrTow);
                  this.doCond(this.player2,this.idArrTow,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,2);
                  this.stuGoto(this.player2,"s2_",this.idArrTow,this.p2BtnfinishCondArr);
                  this.cionVisible(this.player2,"p2_",this.idArrTow);
                  return;
               }
               if(i == 2)
               {
                  this.dotext("t2_",this.idArrThree,this.player2);
                  this.cionFrame("p2_",this.idArrThree);
                  this.doCond(this.player2,this.idArrThree,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,3);
                  this.stuGoto(this.player2,"s2_",this.idArrThree,this.p2BtnfinishCondArr);
                  this.cionVisible(this.player2,"p2_",this.idArrThree);
                  return;
               }
            }
         }
      }
      
      private function textinitp1() : void
      {
         for(var i:uint = 0; i < 8; i++)
         {
            this["t1_" + i].text = "未学习";
            this["p1_" + i].gotoAndStop(1);
            this.p1condArr[i] = -1;
         }
      }
      
      private function textinitp2() : void
      {
         for(var i:uint = 0; i < 8; i++)
         {
            this["t2_" + i].text = "未学习";
            this["p2_" + i].gotoAndStop(1);
            this.p2condArr[i] = -1;
         }
      }
      
      private function clickHandle(e:BtnEvent) : void
      {
         var mc:MovieClip = e.target as MovieClip;
         var targetMcName:* = mc.name;
         var nameId:String = mc.parent.name.substr(1,1);
         var id:String = mc.parent.name.substr(3,1);
         var aginId:String = mc.name.substr(3,1);
         var aginNameId:String = mc.name.substr(1,1);
         if(targetMcName == "py1_SetKey")
         {
            SetKeyPanel.open();
            SkillPanel.close();
         }
         if(targetMcName == "py2_SetKey")
         {
            SetKeyPanel.open(2);
            SkillPanel.close();
         }
         if(nameId == "1")
         {
            if(prompt_btn.visible == false)
            {
               switch(this.bagStata[0])
               {
                  case 1:
                     this.addSkill(this.player1,this.idArrOne,1,id);
                     break;
                  case 2:
                     this.addSkill(this.player1,this.idArrTow,2,id);
                     break;
                  case 3:
                     this.addSkill(this.player1,this.idArrThree,3,id);
                     break;
                  case 4:
                     this.addSkill(this.player1,this.idArrFoure,4,id);
                     break;
                  case 5:
                     if(this.arrowrightNum1 == 0)
                     {
                        this.addSkill(this.player1,this.idArrFoure,5,id);
                     }
                  case 6:
                     if(this.arrowrightNum1 == 1)
                     {
                        this.addSkill(this.player1,this.idArrFive,6,id);
                     }
                     break;
                  case 7:
               }
            }
         }
         if(nameId == "2")
         {
            if(prompt_btn.visible == false)
            {
               switch(this.bagStata[1])
               {
                  case 1:
                     this.addSkill(this.player2,this.idArrOne,1,id);
                     break;
                  case 2:
                     this.addSkill(this.player2,this.idArrTow,2,id);
                     break;
                  case 3:
                     this.addSkill(this.player2,this.idArrThree,3,id);
                     break;
                  case 4:
                     this.addSkill(this.player2,this.idArrFoure,4,id);
                     break;
                  case 5:
                     if(this.arrowrightNum2 == 0)
                     {
                        this.addSkill(this.player2,this.idArrFoure,5,id);
                     }
                  case 6:
                     if(this.arrowrightNum2 == 1)
                     {
                        this.addSkill(this.player2,this.idArrFive,6,id);
                     }
               }
            }
         }
         if(aginNameId == "1")
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
               ShortTip.open(13);
            }
         }
         if(aginNameId == "2")
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
                  prompt_btn2.visible = true;
               }
            }
            else
            {
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
         var oldAllGod:uint = this.aginGold(this.player1,this.idArrOne) + this.aginGold(this.player1,this.idArrTow) + this.aginGold(this.player1,this.idArrThree) + this.aginGold(this.player1,this.idArrFoure);
         this.player1.addGold(oldAllGod);
         this.player1.addPoint(this.aginPoint(this.player1));
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
         for(var i:uint = 0; i < 8; i++)
         {
            if(this.player1.getSkillLevel(this.idArrOne[i]) > 0)
            {
               return true;
            }
            if(this.player1.getSkillLevel(this.idArrTow[i]) > 0)
            {
               return true;
            }
            if(this.player1.getSkillLevel(this.idArrThree[i]) > 0)
            {
               return true;
            }
            if(this.player1.getSkillLevel(this.idArrFoure[i]) > 0)
            {
               return true;
            }
         }
         for(i = 0; i < 8; i++)
         {
            if(this.player1.getSkillLevel(this.idArrFive[i]) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function anginOk2() : Boolean
      {
         for(var i:uint = 0; i < 8; i++)
         {
            if(this.player2.getSkillLevel(this.idArrOne[i]) > 0)
            {
               return true;
            }
            if(this.player2.getSkillLevel(this.idArrTow[i]) > 0)
            {
               return true;
            }
            if(this.player2.getSkillLevel(this.idArrThree[i]) > 0)
            {
               return true;
            }
            if(this.player2.getSkillLevel(this.idArrFoure[i]) > 0)
            {
               return true;
            }
         }
         for(i = 0; i < 8; i++)
         {
            if(this.player2.getSkillLevel(this.idArrFive[i]) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function aginPoint(player:PlayerData) : Number
      {
         var allP:Number = NaN;
         var p1:Number = 0;
         var p2:Number = 0;
         var p3:Number = 0;
         var p4:Number = 0;
         var p5:Number = 0;
         for(var i:uint = 0; i < 8; i++)
         {
            p1 += Number(player.getSkillLevel(this.idArrOne[i])) * SkillConditionFactory.getPoints(this.idArrOne[i]);
            p2 += Number(player.getSkillLevel(this.idArrTow[i])) * SkillConditionFactory.getPoints(this.idArrTow[i]);
            p3 += Number(player.getSkillLevel(this.idArrThree[i])) * SkillConditionFactory.getPoints(this.idArrThree[i]);
            p4 += Number(player.getSkillLevel(this.idArrFoure[i])) * SkillConditionFactory.getPoints(this.idArrFoure[i]);
         }
         for(i = 0; i < 7; i++)
         {
            p5 += Number(player.getSkillLevel(this.idArrFive[i])) * SkillConditionFactory.getPoints(this.idArrFive[i]);
         }
         for(i = 0; i < 8; i++)
         {
            player.aginSkillLevel(this.idArrOne[i]);
            player.aginSkillLevel(this.idArrTow[i]);
            player.aginSkillLevel(this.idArrThree[i]);
            player.aginSkillLevel(this.idArrFoure[i]);
         }
         for(i = 0; i < 7; i++)
         {
            player.aginSkillLevel(this.idArrFive[i]);
         }
         return p1 + p2 + p3 + p4 + p5;
      }
      
      private function aginGold(player:PlayerData, idArr:Array) : Number
      {
         var nowLevel:uint = 0;
         var i:uint = 0;
         var gold:Number = 0;
         for(var j:uint = 0; j < 8; j++)
         {
            nowLevel = player.getSkillLevel(idArr[j]);
            for(i = 1; i <= nowLevel; i++)
            {
               gold += SkillConditionFactory.getGold(idArr[j],i);
            }
         }
         return gold;
      }
      
      private function addSkill(player:PlayerData, myArr:Array, stataNum:Number, id:String) : void
      {
         var skillLevel:Number = NaN;
         var gold:Number = NaN;
         var point:Number = NaN;
         var goldStr:String = null;
         var pointStr:String = null;
         if(player.getSkillLevel(myArr[id]) < SkillFactory.getSkillByTypeIAndLevel(myArr[id]).getskillLevelUp())
         {
            skillLevel = player.getSkillLevel(myArr[id]) + 1;
            gold = Number(SkillConditionFactory.getGold(myArr[id],skillLevel));
            point = Number(SkillConditionFactory.getPoints(myArr[id],skillLevel));
            this.oldPlayerData = player;
            this.oldPoint = point;
            this.oldGold = gold;
            this.oldStataNum = stataNum;
            this.targetTypeId = myArr[id];
            this.oldArr = myArr;
            prompt_btn.visible = true;
            prompt_btn.gotoAndStop(1);
            goldStr = gold.toString();
            pointStr = point.toString();
            this.mban(goldStr,pointStr);
         }
      }
      
      private function mban(goldStr:String, pointStr:String) : void
      {
         var j:uint = 0;
         var i:int = 0;
         if(prompt_btn)
         {
            for(j = 0; j < 5; j++)
            {
               if(this.prompt_btn.num_mc)
               {
                  this.prompt_btn.num_mc["num_" + j].visible = false;
               }
            }
            for(j = 0; j < 3; j++)
            {
               if(this.prompt_btn.num_mc2)
               {
                  this.prompt_btn.num_mc2["num_" + j].visible = false;
               }
            }
            for(i = 0; i < goldStr.length; i++)
            {
               if(this.prompt_btn.num_mc)
               {
                  this.prompt_btn.num_mc["num_" + i].visible = true;
                  if(goldStr.charAt(i) != "0")
                  {
                     this.prompt_btn.num_mc["num_" + i].gotoAndStop(goldStr.charAt(i));
                  }
                  else
                  {
                     this.prompt_btn.num_mc["num_" + i].gotoAndStop(10);
                  }
               }
            }
            for(i = 0; i < pointStr.length; i++)
            {
               if(this.prompt_btn.num_mc2)
               {
                  this.prompt_btn.num_mc2["num_" + i].visible = true;
                  if(pointStr.charAt(i) != "0")
                  {
                     this.prompt_btn.num_mc2["num_" + i].gotoAndStop(pointStr.charAt(i));
                  }
                  else
                  {
                     this.prompt_btn.num_mc2["num_" + i].gotoAndStop(10);
                  }
               }
            }
         }
      }
      
      private function closeHanle(e:BtnEvent) : void
      {
         prompt_btn.visible = false;
         prompt_btn2.visible = false;
         if(e.target.id == 1)
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
                  ShortTip.open(16);
               }
            }
            else
            {
               ShortTip.open(20);
            }
         }
         if(e.target.id == 3)
         {
            Shop4399.Open();
         }
         if(e.target.id == 4)
         {
            close();
         }
         if(e.target.id == 5)
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
         if(e.target.id == 6)
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
      
      public function cionVisible(player:PlayerData, pstring:String, myarr:Array) : void
      {
         for(var i:uint = 0; i < 8; i++)
         {
            if(player.getSkillLevel(myarr[i]) == 0)
            {
               this[pstring + i].cion_mast.gotoAndStop(1);
            }
            else
            {
               this[pstring + i].cion_mast.gotoAndStop(2);
            }
         }
      }
      
      public function p2StuBtnVisible() : void
      {
         for(var i:uint = 0; i < 8; i++)
         {
            this["s2_" + i].gotoAndStop(2);
         }
         p2_j.visible = false;
         p2Skill_mc.gotoAndStop(2);
      }
      
      private function stuGoto(player:PlayerData, stuStr:String, myArr:Array, BtnfinishCondArr:Array) : void
      {
         for(var i:uint = 0; i < 8; i++)
         {
            if(player.getSkillLevel(myArr[i]) < SkillFactory.getSkillByTypeIAndLevel(myArr[i]).getskillLevelUp())
            {
               if(BtnfinishCondArr[i])
               {
                  this[stuStr + i].gotoAndStop(1);
               }
               else
               {
                  this[stuStr + i].gotoAndStop(2);
               }
            }
            else
            {
               this[stuStr + i].gotoAndStop(2);
            }
         }
      }
      
      private function doCond(player:PlayerData, idArr:Array, condArr:Array, finishCondArr:Array, finishBtnArr:Array, bagStataNum:Number) : void
      {
         for(var i:uint = 0; i < 8; i++)
         {
            if(player.getSkillLevel(idArr[i]) < SkillFactory.getSkillByTypeIAndLevel(idArr[i]).getskillLevelUp())
            {
               condArr[i] = SkillConditionFactory.getCondition(idArr[i],player.getSkillLevel(idArr[i]) + 1);
            }
            else
            {
               condArr[i] = SkillConditionFactory.getCondition(idArr[i],player.getSkillLevel(idArr[i]));
            }
            finishCondArr[i] = this.contrast(player,condArr[i],bagStataNum - 1);
            finishBtnArr[i] = this.contrast(player,condArr[i],bagStataNum - 1,"btn");
         }
      }
      
      private function p2TextVisible() : void
      {
         for(var i:uint = 0; i < 8; i++)
         {
            this["t2_" + i].text = "";
         }
      }
      
      private function dotext(tmc:String, idArr:Array, player:PlayerData) : *
      {
         for(var i:uint = 0; i < 8; i++)
         {
            if(player.getSkillLevel(idArr[i]) == 0)
            {
               this[tmc + i].text = "未学习";
            }
            else
            {
               this[tmc + i].text = "LV." + player.getSkillLevel(idArr[i]).toString();
               if(player.getSkillLevel(idArr[i]) == SkillFactory.getSkillByTypeIAndLevel(idArr[i]).getskillLevelUp())
               {
                  this[tmc + i].setTextFormat(this._textFormat);
               }
            }
         }
      }
      
      private function cionFrame(p_mc:String, idArr:Array) : void
      {
         for(var i:uint = 0; i < 8; i++)
         {
            this[p_mc + i].gotoAndStop(SkillFactory.getSkillByTypeIAndLevel(idArr[i]).getFrame());
         }
      }
      
      private function arrFalse(type:Number) : void
      {
         if(type == 1 || type == 2 || type == 3)
         {
            this.p1_j.visible = false;
            this.xs_mc1.visible = true;
            this.p1_7.visible = true;
            this.s1_7.visible = true;
         }
         if(type == 4)
         {
            this.xs_mc1.visible = false;
            this.p1_j.visible = true;
            this.p1_7.visible = true;
            this.s1_7.visible = true;
         }
         if(type == 5)
         {
            this.p1_7.visible = true;
            this.s1_7.visible = true;
         }
      }
      
      private function arrFalse2(type:Number) : void
      {
         if(type == 1 || type == 2 || type == 3)
         {
            this.p2_j.visible = false;
            this.xs_mc2.visible = true;
            this.p2_7.visible = true;
            this.s2_7.visible = true;
         }
         if(type == 4)
         {
            this.xs_mc2.visible = false;
            this.p2_j.visible = true;
            this.p2_7.visible = true;
            this.s2_7.visible = true;
         }
         if(type == 5)
         {
            this.p2_7.visible = true;
            this.s2_7.visible = true;
         }
      }
      
      private function contrast(player:PlayerData, skillArr:Array, type:Number, allorBtn:String = "all") : Boolean
      {
         var playerLevel:Number = player.getLevel();
         var points:Number = player.getPoints();
         var gold:Number = player.getGold();
         var rebirth:Boolean = player.isRebirth();
         var transfer:Boolean = player.isTransfer(type);
         var sureArr:Array = [];
         if(allorBtn == "all")
         {
            if(playerLevel >= skillArr[0] && points >= skillArr[1] && gold >= skillArr[2])
            {
               sureArr[0] = true;
            }
            else
            {
               sureArr[0] = false;
            }
         }
         if(allorBtn == "btn")
         {
            if(playerLevel >= skillArr[0])
            {
               sureArr[0] = true;
            }
            else
            {
               sureArr[0] = false;
            }
         }
         if(skillArr[3] != false)
         {
            if(rebirth == true)
            {
               sureArr[1] = true;
            }
            else
            {
               sureArr[1] = false;
            }
         }
         else
         {
            sureArr[1] = true;
         }
         if(skillArr[4] != false)
         {
            if(transfer == true)
            {
               sureArr[2] = true;
            }
            else
            {
               sureArr[2] = false;
            }
         }
         else
         {
            sureArr[2] = true;
         }
         if(skillArr[5] != "null")
         {
            if(player.getSkillLevel(skillArr[5]) >= skillArr[6])
            {
               sureArr[3] = true;
            }
            else
            {
               sureArr[3] = false;
            }
         }
         else
         {
            sureArr[3] = true;
         }
         if(Boolean(sureArr[0]) && Boolean(sureArr[1]) && Boolean(sureArr[2]) && Boolean(sureArr[3]))
         {
            return true;
         }
         return false;
      }
      
      private function changeHandle(e:BtnEvent) : void
      {
         var mc:MovieClip = e.target as MovieClip;
         var nameId:String = mc.name.substr(1,1);
         if(nameId == "1")
         {
            this.arrFalse(e.id);
            this.bagStata[0] = mc.id;
            if(e.id == 1)
            {
               this.b1_1.isClick = false;
               this.b1_2.isClick = false;
               this.b1_3.isClick = false;
               this.arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(1);
               this.cionFrame("p1_",this.idArrOne);
               this.dotext("t1_",this.idArrOne,this.player1);
               this.doCond(this.player1,this.idArrOne,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,e.id);
               this.cionVisible(this.player1,"p1_",this.idArrOne);
               this.stuGoto(this.player1,"s1_",this.idArrOne,this.p1BtnfinishCondArr);
            }
            if(e.id == 2)
            {
               this.b1_0.isClick = false;
               this.b1_2.isClick = false;
               this.b1_3.isClick = false;
               this.arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(2);
               this.cionFrame("p1_",this.idArrTow);
               this.dotext("t1_",this.idArrTow,this.player1);
               this.doCond(this.player1,this.idArrTow,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,e.id);
               this.cionVisible(this.player1,"p1_",this.idArrTow);
               this.stuGoto(this.player1,"s1_",this.idArrTow,this.p1BtnfinishCondArr);
            }
            if(e.id == 3)
            {
               this.b1_0.isClick = false;
               this.b1_1.isClick = false;
               this.b1_3.isClick = false;
               this.arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(3);
               this.cionFrame("p1_",this.idArrThree);
               this.dotext("t1_",this.idArrThree,this.player1);
               this.doCond(this.player1,this.idArrThree,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,e.id);
               this.cionVisible(this.player1,"p1_",this.idArrThree);
               this.stuGoto(this.player1,"s1_",this.idArrThree,this.p1BtnfinishCondArr);
            }
            if(e.id == 4)
            {
               this.b1_0.isClick = false;
               this.b1_1.isClick = false;
               this.b1_2.isClick = false;
               this.arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               this.cionFrame("p1_",this.idArrFoure);
               this.dotext("t1_",this.idArrFoure,this.player1);
               this.doCond(this.player1,this.idArrFoure,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,e.id);
               this.cionVisible(this.player1,"p1_",this.idArrFoure);
               this.stuGoto(this.player1,"s1_",this.idArrFoure,this.p1BtnfinishCondArr);
               this.p1tlStu();
            }
            if(e.id == 5)
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
                  this.doCond(this.player1,this.idArrFoure,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,e.id);
                  this.cionVisible(this.player1,"p1_",this.idArrFoure);
                  this.stuGoto(this.player1,"s1_",this.idArrFoure,this.p1BtnfinishCondArr);
                  this.p1tlStu();
               }
               if(this.arrowrightNum1 == this.arrowArr[0])
               {
               }
            }
            if(e.id == 6)
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
                  this.doCond(this.player1,this.idArrFive,this.p1condArr,this.p1finishCondArr,this.p1BtnfinishCondArr,e.id);
                  this.cionVisible(this.player1,"p1_",this.idArrFive);
                  this.stuGoto(this.player1,"s1_",this.idArrFive,this.p1BtnfinishCondArr);
                  this.p1tlStu();
               }
               if(this.arrowrightNum1 == this.arrowArr[this.arrowArr.length - 1])
               {
               }
            }
         }
         if(nameId == "2")
         {
            this.arrFalse2(e.id);
            this.bagStata[1] = mc.id;
            if(e.id == 1)
            {
               this.b2_1.isClick = false;
               this.b2_2.isClick = false;
               this.b2_3.isClick = false;
               this.arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(1);
               this.cionFrame("p2_",this.idArrOne);
               this.dotext("t2_",this.idArrOne,this.player2);
               this.doCond(this.player2,this.idArrOne,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,e.id);
               this.cionVisible(this.player2,"p2_",this.idArrOne);
               this.stuGoto(this.player2,"s2_",this.idArrOne,this.p2BtnfinishCondArr);
            }
            if(e.id == 2)
            {
               this.b2_0.isClick = false;
               this.b2_2.isClick = false;
               this.b2_3.isClick = false;
               this.arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(2);
               this.cionFrame("p2_",this.idArrTow);
               this.dotext("t2_",this.idArrTow,this.player2);
               this.doCond(this.player2,this.idArrTow,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,e.id);
               this.cionVisible(this.player2,"p2_",this.idArrTow);
               this.stuGoto(this.player2,"s2_",this.idArrTow,this.p2BtnfinishCondArr);
            }
            if(e.id == 3)
            {
               this.b2_0.isClick = false;
               this.b2_1.isClick = false;
               this.b2_3.isClick = false;
               this.arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(3);
               this.cionFrame("p2_",this.idArrThree);
               this.dotext("t2_",this.idArrThree,this.player2);
               this.doCond(this.player2,this.idArrThree,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,e.id);
               this.cionVisible(this.player2,"p2_",this.idArrThree);
               this.stuGoto(this.player2,"s2_",this.idArrThree,this.p2BtnfinishCondArr);
            }
            if(e.id == 4)
            {
               this.b2_0.isClick = false;
               this.b2_1.isClick = false;
               this.b2_2.isClick = false;
               this.arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               this.cionFrame("p2_",this.idArrFoure);
               this.dotext("t2_",this.idArrFoure,this.player2);
               this.doCond(this.player2,this.idArrFoure,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,e.id);
               this.cionVisible(this.player2,"p2_",this.idArrFoure);
               this.stuGoto(this.player2,"s2_",this.idArrFoure,this.p2BtnfinishCondArr);
               this.p2tlStu();
            }
            if(e.id == 5)
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
                  this.doCond(this.player2,this.idArrFoure,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,e.id);
                  this.cionVisible(this.player2,"p2_",this.idArrFoure);
                  this.stuGoto(this.player2,"s2_",this.idArrFoure,this.p2BtnfinishCondArr);
                  this.p2tlStu();
               }
               if(this.arrowrightNum2 == this.arrowArr[0])
               {
               }
            }
            if(e.id == 6)
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
                  this.doCond(this.player2,this.idArrFive,this.p2condArr,this.p2finishCondArr,this.p2BtnfinishCondArr,e.id);
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
         for(var i:uint = 0; i < 3; i++)
         {
            if(this.PlayerDataOneArr[i] == false)
            {
               this["s1_" + (i + 5)].gotoAndStop(2);
            }
         }
      }
      
      private function p2tlStu() : void
      {
         for(var i:uint = 0; i < 3; i++)
         {
            if(this.playerTowArr[i] == false)
            {
               this["s2_" + (i + 5)].gotoAndStop(2);
            }
         }
      }
      
      private function p2Btnfalse() : void
      {
         for(var j:uint = 0; j < 4; j++)
         {
            this["b2_" + j].isClick = false;
         }
         for(var i:uint = 0; i < 3; i++)
         {
            if(this.playerTowArr[i] == false)
            {
               this["b2_" + i].gotoAndStop(4);
               this.mack2.x = this["b2_" + i].x;
            }
         }
         for(i = 0; i < 3; i++)
         {
            if(this.playerTowArr[i] == true)
            {
               this["b2_" + i].isClick = true;
               this.bagStata[1] = i + 1;
               xs_mc2.visible = true;
               xs_mc2.gotoAndStop(i + 1);
               break;
            }
         }
      }
      
      private function plBtnfalse() : void
      {
         for(var j:uint = 0; j < 4; j++)
         {
            this["b1_" + j].isClick = false;
         }
         for(var i:uint = 0; i < 3; i++)
         {
            this["b1_" + i].isClick = false;
            if(this.PlayerDataOneArr[i] == false)
            {
               this["b1_" + i].gotoAndStop(4);
               this["b1_" + i].isClick = false;
               this.mack1.x = this["b1_" + i].x;
            }
         }
         for(i = 0; i < 3; i++)
         {
            if(this.PlayerDataOneArr[i] == true)
            {
               this["b1_" + i].isClick = true;
               this.bagStata[0] = i + 1;
               xs_mc1.visible = true;
               xs_mc1.gotoAndStop(i + 1);
               break;
            }
         }
      }
      
      private function p2AllBtnfalse() : void
      {
         for(var i:uint = 0; i < 4; i++)
         {
            this["b2_" + i].gotoAndStop(4);
         }
         xs_mc2.visible = false;
         py2_SetKey.gotoAndStop(4);
         a2_7.gotoAndStop(4);
         point2.text = "";
         skillPointMc.gotoAndStop(2);
      }
      
      private function pointY(mc:MovieClip) : void
      {
         var myPoint:Point = new Point(mc.x,mc.y);
         myPoint = this.localToGlobal(myPoint);
         if(myPoint.y + mc.height > 580)
         {
            mc.y = 580 - mc.height - 80;
         }
         if(myPoint.y < 0)
         {
            mc.y = 0;
         }
      }
      
      private function initExplain(player:PlayerData, my_arr:Array, id:String, nameId:Number) : void
      {
         var nowLevel:Number = NaN;
         var idtype2:String = null;
         var idtype:String = null;
         var kid:Number = NaN;
         var beforeName2:String = null;
         var beforeLevel2:String = null;
         var beforeName:String = null;
         var beforeLevel:Number = NaN;
         if(player.getSkillLevel(my_arr[id]) == 0 || player.getSkillLevel(my_arr[id]) == SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getskillLevelUp())
         {
            if(player.getSkillLevel(my_arr[id]) == 0)
            {
               nowLevel = player.getSkillLevel(my_arr[id]) + 1;
            }
            if(player.getSkillLevel(my_arr[id]) == SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getskillLevelUp())
            {
               nowLevel = player.getSkillLevel(my_arr[id]);
            }
            explain.visible = true;
            if(nameId == 1)
            {
               explain.x = mouseX + 10;
               if(this.p1BtnfinishCondArr[id])
               {
                  explain.beforeSkillName.setTextFormat(this._textFormat1);
               }
               else
               {
                  explain.beforeSkillName.setTextFormat(this._textFormat);
               }
            }
            if(nameId == 2)
            {
               explain.x = mouseX - explain.width - 10;
            }
            explain.y = mouseY;
            this.pointY(explain);
            this.exText(my_arr,id,nowLevel,player);
         }
         else
         {
            nowLevel = player.getSkillLevel(my_arr[id]);
            explainTow.visible = true;
            if(nameId == 1)
            {
               explainTow.x = mouseX + 10;
            }
            if(nameId == 2)
            {
               explainTow.x = mouseX - explain.width - 10;
            }
            explainTow.y = mouseY;
            this.pointY(explainTow);
            if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getProfessional() != "无")
            {
               explainTow.skillName.text = SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getSkillName() + " (" + SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getProfessional() + ")";
            }
            else
            {
               explainTow.skillName.text = SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getSkillName();
            }
            explainTow.typName.text = SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getSkillTouchOff();
            explainTow.nowLevel.text = "技能等级:LV." + nowLevel + "/";
            explainTow.maxLevel.text = "LV." + SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getskillLevelUp();
            explainTow.playerLevel.text = "需求人物等级:LV." + SkillConditionFactory.getPlayerDataLevel(my_arr[id],nowLevel);
            if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getSkillCd() != 0)
            {
               explainTow.nowCd.text = "冷却时间:" + int(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getSkillCd() / Main.fps) + "秒";
            }
            else
            {
               explainTow.nowCd.text = "";
            }
            if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getMp() != 0)
            {
               explainTow.mpNumber.text = "消耗MP:" + SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getMp();
            }
            else if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getWeapon() != "无")
            {
               explainTow.mpNumber.text = "武器限制:" + SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getWeapon();
            }
            else
            {
               explainTow.mpNumber.text = "";
            }
            explainTow.pointNumber.text = "需求技能点数:" + SkillConditionFactory.getPoints(my_arr[id],nowLevel);
            explainTow.nowEx.text = SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getIntroduction();
            idtype2 = SkillConditionFactory.getBeforeLevelId(my_arr[id],nowLevel);
            if(idtype2 != "null")
            {
               beforeName2 = SkillFactory.getSkillByTypeIAndLevel(idtype2).getSkillName();
               beforeLevel2 = SkillConditionFactory.getBeforeLevel(my_arr[id],nowLevel).toString();
               explainTow.beforeSkillName.text = beforeName2 + " " + "LV." + beforeLevel2.toString();
            }
            else
            {
               explainTow.beforeSkillName.text = "无";
            }
            explainTow.nextLevel.text = "技能等级:LV." + (nowLevel + 1) + "/";
            explainTow.nextMaxLevel.text = "LV." + SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getskillLevelUp();
            explainTow.nextPlayerLevel.text = "LV." + SkillConditionFactory.getPlayerDataLevel(my_arr[id],nowLevel + 1);
            explainTow.nextPoint.text = SkillConditionFactory.getPoints(my_arr[id],nowLevel + 1);
            if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel + 1).getMp() != -1)
            {
               explainTow.nextmpNumber.text = "消耗MP:" + int(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel + 1).getMp());
            }
            else
            {
               explainTow.nextmpNumber.text = "";
            }
            if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel + 1).getSkillCd() != -1)
            {
               explainTow.nextCd.text = "冷却时间:" + int(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel + 1).getSkillCd() / Main.fps) + "秒";
            }
            else
            {
               explainTow.nextCd.text = "";
            }
            idtype = SkillConditionFactory.getBeforeLevelId(my_arr[id],nowLevel + 1);
            if(idtype != "null")
            {
               beforeName = SkillFactory.getSkillByTypeIAndLevel(idtype).getSkillName();
               beforeLevel = Number(SkillConditionFactory.getBeforeLevel(my_arr[id],nowLevel + 1));
               explainTow.nexLevelbeforeSkillName.text = "前置技能:" + beforeName + " " + "LV." + beforeLevel;
            }
            else
            {
               explainTow.nexLevelbeforeSkillName.text = "前置技能:无";
            }
            explainTow.nextEx.text = SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel + 1).getIntroduction();
            kid = Number(id);
         }
      }
      
      public function exText(my_arr:Array, id:String, nowLevel:Number, player:PlayerData) : void
      {
         var beforeName:String = null;
         var beforeLevel:String = null;
         if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getProfessional() != "无")
         {
            explain.skillName.text = SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getSkillName() + " (" + SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getProfessional() + ")";
         }
         else
         {
            explain.skillName.text = SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getSkillName();
         }
         explain.typName.text = SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getSkillTouchOff();
         explain.nowLevel.text = "技能等级:LV." + nowLevel + "/";
         explain.maxLevel.text = "LV." + SkillFactory.getSkillByTypeIAndLevel(my_arr[id]).getskillLevelUp();
         explain.playerLevel.text = "LV." + SkillConditionFactory.getPlayerDataLevel(my_arr[id],nowLevel);
         if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getSkillCd() != 0)
         {
            explain.nowCd.text = "冷却时间:" + int(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getSkillCd() / Main.fps) + "秒";
         }
         else
         {
            explain.nowCd.text = "";
         }
         if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getMp() != 0)
         {
            explain.mpNumber.text = "消耗MP:" + int(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getMp());
         }
         else if(SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getWeapon() != "无")
         {
            explain.mpNumber.text = "武器限制:" + SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getWeapon();
         }
         else
         {
            explain.mpNumber.text = "";
         }
         explain.pointNumber.text = SkillConditionFactory.getPoints(my_arr[id],nowLevel);
         explain.nowEx.text = SkillFactory.getSkillByTypeIAndLevel(my_arr[id],nowLevel).getIntroduction();
         var idtype:String = SkillConditionFactory.getBeforeLevelId(my_arr[id],nowLevel);
         if(idtype != "null")
         {
            beforeName = SkillFactory.getSkillByTypeIAndLevel(idtype).getSkillName();
            beforeLevel = SkillConditionFactory.getBeforeLevel(my_arr[id],nowLevel).toString();
            explain.beforeSkillName.text = beforeName + " " + "LV." + beforeLevel.toString();
         }
         else
         {
            explain.beforeSkillName.text = "无";
         }
      }
      
      private function setKeyFunction(ex:MovieClip, id:Number, keyArr:Array, type:* = 1) : void
      {
         var xx:Number = NaN;
         var keyNum:String = null;
         if(type == 1)
         {
            if(id < 4)
            {
               this.keyMcVible(ex);
               xx = Number(keyArr[id + 7]);
               keyNum = "k" + String(xx);
               ex.skillKey.gotoAndStop(keyNum);
            }
            else if(id == 4)
            {
               this.keyMcVible(ex,1);
               ex.skillKey.gotoAndStop("k" + String(keyArr[14]));
            }
            else if(id == 5)
            {
               this.keyMcVible(ex,2);
               ex.skillKey1.gotoAndStop("k" + String(keyArr[14]));
               ex.skillKey.gotoAndStop("k" + String(keyArr[0]));
            }
            else if(id == 6)
            {
               this.keyMcVible(ex,2);
               ex.skillKey1.gotoAndStop("k" + String(keyArr[14]));
               ex.skillKey.gotoAndStop("k" + String(keyArr[1]));
            }
            else if(id == 7)
            {
               this.keyMcVible(ex,3);
               ex.skillKey.gotoAndStop("k" + String(keyArr[0]));
               ex.skillKey1.gotoAndStop("k" + String(keyArr[0]));
               ex.skillKey2.gotoAndStop("k" + String(keyArr[14]));
            }
         }
         else if(type == 2)
         {
            ex.add1.text = "";
            ex.add2.text = "";
            if(ex.skillKey1)
            {
               ex.skillKey1.visible = false;
            }
            if(ex.skillKey2)
            {
               ex.skillKey2.visible = false;
            }
            if(ex.skillKey)
            {
               ex.skillKey.gotoAndStop("kx");
            }
         }
      }
      
      private function keyMcVible(ex:MovieClip, num:Number = 1) : void
      {
         if(ex.skillKey)
         {
            ex.skillKey.visible = true;
         }
         if(num == 1)
         {
            ex.add1.text = "";
            ex.add2.text = "";
            if(ex.skillKey1)
            {
               ex.skillKey1.visible = false;
            }
            if(ex.skillKey2)
            {
               ex.skillKey2.visible = false;
            }
         }
         else if(num == 2)
         {
            ex.add1.text = "+";
            ex.add2.text = "";
            if(ex.skillKey2)
            {
               ex.skillKey2.visible = false;
            }
            if(ex.skillKey1)
            {
               ex.skillKey1.visible = true;
            }
         }
         else if(num == 3)
         {
            ex.add1.text = "+";
            ex.add2.text = "+";
            if(ex.skillKey1)
            {
               ex.skillKey1.visible = true;
            }
            if(ex.skillKey2)
            {
               ex.skillKey2.visible = true;
            }
         }
      }
      
      private function redText(myArr:Array, strId:String, num:Number = 1) : void
      {
         var nowLevel:Number = NaN;
         var skilllevel:Number = NaN;
         var nextLevel:Number = 1;
         var id:Number = Number(strId);
         var maxLevel:Number = Number(SkillFactory.getSkillByTypeIAndLevel(myArr[id]).getskillLevelUp());
         if(num == 1)
         {
            nowLevel = Number(this.player1.getSkillLevel(myArr[id]));
            if(nowLevel == 0)
            {
               nowLevel = 1;
            }
            else
            {
               nowLevel = Number(this.player1.getSkillLevel(myArr[id]));
               if(nowLevel < maxLevel)
               {
                  nextLevel = nowLevel + 1;
               }
               else
               {
                  nextLevel = maxLevel;
               }
            }
            if(this.player1.getLevel() >= SkillConditionFactory.getPlayerDataLevel(myArr[id],nowLevel))
            {
               explain.playerLevel.setTextFormat(this._textFormat1);
            }
            else
            {
               explain.playerLevel.setTextFormat(this._textFormat);
            }
            if(this.player1.getPoints() >= SkillConditionFactory.getPoints(myArr[id],nowLevel))
            {
               explain.pointNumber.setTextFormat(this._textFormat1);
            }
            else
            {
               explain.pointNumber.setTextFormat(this._textFormat);
            }
            skilllevel = Number(SkillConditionFactory.getPlayerDataLevel(myArr[id],nextLevel));
            if(this.player1.getLevel() >= SkillConditionFactory.getPlayerDataLevel(myArr[id],nextLevel))
            {
               explainTow.nextPlayerLevel.setTextFormat(this._textFormat1);
            }
            else
            {
               explainTow.nextPlayerLevel.setTextFormat(this._textFormat);
            }
            if(this.player1.getPoints() >= SkillConditionFactory.getPoints(myArr[id],nextLevel))
            {
               explainTow.nextPoint.setTextFormat(this._textFormat1);
            }
            else
            {
               explainTow.nextPoint.setTextFormat(this._textFormat);
            }
         }
         else if(num == 2)
         {
            nowLevel = Number(this.player2.getSkillLevel(myArr[id]));
            if(nowLevel == 0)
            {
               nowLevel = 1;
            }
            else
            {
               nowLevel = Number(this.player2.getSkillLevel(myArr[id]));
               if(nowLevel < maxLevel)
               {
                  nextLevel = nowLevel + 1;
               }
               else
               {
                  nextLevel = maxLevel;
               }
            }
            if(this.player2.getLevel() >= SkillConditionFactory.getPlayerDataLevel(myArr[id],nowLevel))
            {
               explain.playerLevel.setTextFormat(this._textFormat1);
            }
            else
            {
               explain.playerLevel.setTextFormat(this._textFormat);
            }
            if(this.player2.getPoints() >= SkillConditionFactory.getPoints(myArr[id],nowLevel))
            {
               explain.pointNumber.setTextFormat(this._textFormat1);
            }
            else
            {
               explain.pointNumber.setTextFormat(this._textFormat);
            }
            if(this.player2.getLevel() >= SkillConditionFactory.getPlayerDataLevel(myArr[id],nextLevel))
            {
               explainTow.nextPlayerLevel.setTextFormat(this._textFormat1);
            }
            else
            {
               explainTow.nextPlayerLevel.setTextFormat(this._textFormat);
            }
            if(this.player2.getPoints() >= SkillConditionFactory.getPoints(myArr[id],nextLevel))
            {
               explainTow.nextPoint.setTextFormat(this._textFormat1);
            }
            else
            {
               explainTow.nextPoint.setTextFormat(this._textFormat);
            }
         }
      }
      
      public function overHandle(e:BtnEvent) : void
      {
         var mc:MovieClip = e.target as MovieClip;
         var nameId:String = mc.name.substr(1,1);
         var id:String = mc.name.substr(3,1);
         var kid:Number = Number(id);
         if(nameId == "1")
         {
            switch(this.bagStata[0])
            {
               case 1:
                  this.initExplain(this.player1,this.idArrOne,id,1);
                  this.redText(this.idArrOne,id);
                  this.setKeyFunction(explain,kid,this.player1._keyArr);
                  this.setKeyFunction(explainTow,kid,this.player1._keyArr);
                  break;
               case 2:
                  this.initExplain(this.player1,this.idArrTow,id,1);
                  this.redText(this.idArrTow,id);
                  this.setKeyFunction(explain,kid,this.player1._keyArr);
                  this.setKeyFunction(explainTow,kid,this.player1._keyArr);
                  break;
               case 3:
                  this.initExplain(this.player1,this.idArrThree,id,1);
                  this.redText(this.idArrThree,id);
                  this.setKeyFunction(explain,kid,this.player1._keyArr);
                  this.setKeyFunction(explainTow,kid,this.player1._keyArr);
                  break;
               case 4:
                  this.initExplain(this.player1,this.idArrFoure,id,1);
                  this.redText(this.idArrFoure,id);
                  this.setKeyFunction(explain,kid,this.player1._keyArr,2);
                  this.setKeyFunction(explainTow,kid,this.player1._keyArr,2);
                  break;
               case 5:
                  if(this.arrowrightNum1 == 0)
                  {
                     this.initExplain(this.player1,this.idArrFoure,id,1);
                     this.redText(this.idArrFoure,id);
                     this.setKeyFunction(explain,kid,this.player1._keyArr,2);
                     this.setKeyFunction(explainTow,kid,this.player1._keyArr,2);
                  }
                  break;
               case 6:
                  if(this.arrowrightNum1 == 1)
                  {
                     this.initExplain(this.player1,this.idArrFive,id,1);
                     this.redText(this.idArrFive,id);
                     this.setKeyFunction(explain,kid,this.player1._keyArr,2);
                     this.setKeyFunction(explainTow,kid,this.player1._keyArr,2);
                  }
            }
         }
         if(nameId == "2")
         {
            switch(this.bagStata[1])
            {
               case 1:
                  this.initExplain(this.player2,this.idArrOne,id,2);
                  this.redText(this.idArrOne,id,2);
                  this.setKeyFunction(explain,kid,this.player2._keyArr);
                  this.setKeyFunction(explainTow,kid,this.player2._keyArr);
                  break;
               case 2:
                  this.initExplain(this.player2,this.idArrTow,id,2);
                  this.redText(this.idArrTow,id,2);
                  this.setKeyFunction(explain,kid,this.player2._keyArr);
                  this.setKeyFunction(explainTow,kid,this.player2._keyArr);
                  break;
               case 3:
                  this.initExplain(this.player2,this.idArrThree,id,2);
                  this.redText(this.idArrThree,id,2);
                  this.setKeyFunction(explain,kid,this.player2._keyArr);
                  this.setKeyFunction(explainTow,kid,this.player2._keyArr);
                  break;
               case 4:
                  this.initExplain(this.player2,this.idArrFoure,id,2);
                  this.redText(this.idArrFoure,id,2);
                  this.setKeyFunction(explain,kid,this.player2._keyArr,2);
                  this.setKeyFunction(explainTow,kid,this.player2._keyArr,2);
                  break;
               case 5:
                  if(this.arrowrightNum2 == 0)
                  {
                     this.initExplain(this.player2,this.idArrFoure,id,2);
                     this.redText(this.idArrFoure,id,2);
                     this.setKeyFunction(explain,kid,this.player2._keyArr,2);
                     this.setKeyFunction(explainTow,kid,this.player2._keyArr,2);
                  }
                  break;
               case 6:
                  if(this.arrowrightNum2 == 1)
                  {
                     this.initExplain(this.player2,this.idArrFive,id,2);
                     this.redText(this.idArrFive,id,2);
                     this.setKeyFunction(explain,kid,this.player2._keyArr,2);
                     this.setKeyFunction(explainTow,kid,this.player2._keyArr,2);
                  }
            }
         }
      }
      
      private function outHandle(e:BtnEvent) : void
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
