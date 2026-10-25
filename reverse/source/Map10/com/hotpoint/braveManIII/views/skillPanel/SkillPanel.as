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
      
      private var playerStata:Boolean = false;
      
      private var idArrTow:Array = ["b8","b9","b10","b11","b12","b13","b14","b15"];
      
      private var PlayerDataOneArr:Array = [];
      
      private var idArrFoure:Array = ["d1","d2","d3","d4","d5","d6","d7","d8"];
      
      private var oldSkill:String;
      
      private var targetId:uint = 0;
      
      private var oldArr:Array;
      
      private var p1BtnfinishCondArr:* = [];
      
      private var p2BtnfinishCondArr:* = [];
      
      private var targetTypeId:String;
      
      private var p1condArr:Array = [];
      
      private var oldStataNum:Number;
      
      private var _textFormat:TextFormat;
      
      private var oldGold:Number;
      
      private var idArrFive:Array = ["d9","d10","d11","d12","d13","d14","d15","d16"];
      
      private var idArrOne:Array = ["a8","a9","a10","a11","a12","a13","a14","a15"];
      
      private var oldSkillLevel:Number;
      
      private var p2finishCondArr:* = [];
      
      private var bagStata:Array = [1,1];
      
      private var _textFormat1:TextFormat;
      
      private var player1:PlayerData;
      
      private var player2:PlayerData;
      
      private var aginBo:Boolean = false;
      
      private var arrowArr:Array = [0,1];
      
      private var playerTowArr:Array = [];
      
      private var oldPoint:Number;
      
      private var pickNum:Number;
      
      private var oldPlayerData:PlayerData;
      
      private var arrowrightNum1:* = 0;
      
      private var p1finishCondArr:* = [];
      
      private var arrowrightNum2:* = 0;
      
      private var p2condArr:Array = [];
      
      private var idArrThree:Array = ["c8","c9","c10","c11","c12","c13","c14","c15"];
      
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
      
      private function addMc() : void
      {
         this.prompt_btn.visible = false;
         this.setChildIndex(prompt_btn,numChildren - 1);
         this.prompt_btn2.visible = false;
         this.setChildIndex(prompt_btn2,numChildren - 1);
         this.addChildAt(mast_mc,numChildren - 3);
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
      
      private function p2tlStu() : void
      {
         var i:uint = 0;
         for(i = 0; i < 3; i++)
         {
            if(playerTowArr[i] == false)
            {
               this["s2_" + (i + 5)].gotoAndStop(2);
            }
         }
      }
      
      public function overHandle(e:BtnEvent) : void
      {
         var mc:MovieClip = null;
         var nameId:String = null;
         var id:String = null;
         var kid:Number = NaN;
         mc = e.target as MovieClip;
         nameId = mc.name.substr(1,1);
         id = mc.name.substr(3,1);
         kid = Number(id);
         if(nameId == "1")
         {
            switch(bagStata[0])
            {
               case 1:
                  initExplain(player1,idArrOne,id,1);
                  redText(idArrOne,id);
                  setKeyFunction(explain,kid,player1._keyArr);
                  setKeyFunction(explainTow,kid,player1._keyArr);
                  break;
               case 2:
                  initExplain(player1,idArrTow,id,1);
                  redText(idArrTow,id);
                  setKeyFunction(explain,kid,player1._keyArr);
                  setKeyFunction(explainTow,kid,player1._keyArr);
                  break;
               case 3:
                  initExplain(player1,idArrThree,id,1);
                  redText(idArrThree,id);
                  setKeyFunction(explain,kid,player1._keyArr);
                  setKeyFunction(explainTow,kid,player1._keyArr);
                  break;
               case 4:
                  initExplain(player1,idArrFoure,id,1);
                  redText(idArrFoure,id);
                  setKeyFunction(explain,kid,player1._keyArr,2);
                  setKeyFunction(explainTow,kid,player1._keyArr,2);
                  break;
               case 5:
                  if(arrowrightNum1 == 0)
                  {
                     initExplain(player1,idArrFoure,id,1);
                     redText(idArrFoure,id);
                     setKeyFunction(explain,kid,player1._keyArr,2);
                     setKeyFunction(explainTow,kid,player1._keyArr,2);
                  }
                  break;
               case 6:
                  if(arrowrightNum1 == 1)
                  {
                     initExplain(player1,idArrFive,id,1);
                     redText(idArrFive,id);
                     setKeyFunction(explain,kid,player1._keyArr,2);
                     setKeyFunction(explainTow,kid,player1._keyArr,2);
                  }
            }
         }
         if(nameId == "2")
         {
            switch(bagStata[1])
            {
               case 1:
                  initExplain(player2,idArrOne,id,2);
                  redText(idArrOne,id,2);
                  setKeyFunction(explain,kid,player2._keyArr);
                  setKeyFunction(explainTow,kid,player2._keyArr);
                  break;
               case 2:
                  initExplain(player2,idArrTow,id,2);
                  redText(idArrTow,id,2);
                  setKeyFunction(explain,kid,player2._keyArr);
                  setKeyFunction(explainTow,kid,player2._keyArr);
                  break;
               case 3:
                  initExplain(player2,idArrThree,id,2);
                  redText(idArrThree,id,2);
                  setKeyFunction(explain,kid,player2._keyArr);
                  setKeyFunction(explainTow,kid,player2._keyArr);
                  break;
               case 4:
                  initExplain(player2,idArrFoure,id,2);
                  redText(idArrFoure,id,2);
                  setKeyFunction(explain,kid,player2._keyArr,2);
                  setKeyFunction(explainTow,kid,player2._keyArr,2);
                  break;
               case 5:
                  if(arrowrightNum2 == 0)
                  {
                     initExplain(player2,idArrFoure,id,2);
                     redText(idArrFoure,id,2);
                     setKeyFunction(explain,kid,player2._keyArr,2);
                     setKeyFunction(explainTow,kid,player2._keyArr,2);
                  }
                  break;
               case 6:
                  if(arrowrightNum2 == 1)
                  {
                     initExplain(player2,idArrFive,id,2);
                     redText(idArrFive,id,2);
                     setKeyFunction(explain,kid,player2._keyArr,2);
                     setKeyFunction(explainTow,kid,player2._keyArr,2);
                  }
            }
         }
      }
      
      private function p2Btnfalse() : void
      {
         var j:uint = 0;
         var i:uint = 0;
         for(j = 0; j < 4; j++)
         {
            this["b2_" + j].isClick = false;
         }
         for(i = 0; i < 3; i++)
         {
            if(playerTowArr[i] == false)
            {
               this["b2_" + i].gotoAndStop(4);
               this.mack2.x = this["b2_" + i].x;
            }
         }
         for(i = 0; i < 3; i++)
         {
            if(playerTowArr[i] == true)
            {
               this["b2_" + i].isClick = true;
               bagStata[1] = i + 1;
               xs_mc2.visible = true;
               xs_mc2.gotoAndStop(i + 1);
               break;
            }
         }
      }
      
      private function addSkill(player:PlayerData, myArr:Array, stataNum:Number, id:String) : void
      {
         var skillLevel:Number = NaN;
         var gold:Number = NaN;
         var point:Number = NaN;
         var goldStr:String = null;
         var pointStr:String = null;
         trace("学习");
         if(player.getSkillLevel(myArr[id]) < SkillFactory.getSkillByTypeIAndLevel(myArr[id]).getskillLevelUp())
         {
            skillLevel = player.getSkillLevel(myArr[id]) + 1;
            gold = Number(SkillConditionFactory.getGold(myArr[id],skillLevel));
            point = Number(SkillConditionFactory.getPoints(myArr[id],skillLevel));
            oldPlayerData = player;
            oldPoint = point;
            oldGold = gold;
            oldStataNum = stataNum;
            targetTypeId = myArr[id];
            oldArr = myArr;
            prompt_btn.visible = true;
            prompt_btn.gotoAndStop(1);
            goldStr = gold.toString();
            pointStr = point.toString();
            mban(goldStr,pointStr);
         }
      }
      
      private function dotext(tmc:String, idArr:Array, player:PlayerData, type:Number = 1) : *
      {
         var i:uint = 0;
         if(type == 1)
         {
            for(i = 0; i < 8; i++)
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
                     this[tmc + i].setTextFormat(_textFormat);
                  }
               }
            }
         }
         else
         {
            for(i = 0; i < 7; i++)
            {
               if(player.getSkillLevel(idArr[i]) == 0)
               {
                  this[tmc + i].text = "未学习";
               }
               else
               {
                  this[tmc + i].text = "LV." + player.getSkillLevel(idArr[i]);
               }
               if(player.getSkillLevel(idArr[i]) == SkillFactory.getSkillByTypeIAndLevel(idArr[i]).getskillLevelUp())
               {
                  this[tmc + i].setTextFormat(_textFormat);
               }
            }
         }
      }
      
      private function textinitp1() : void
      {
         var i:uint = 0;
         for(i = 0; i < 8; i++)
         {
            this["t1_" + i].text = "未学习";
            this["p1_" + i].gotoAndStop(1);
            p1condArr[i] = -1;
         }
      }
      
      private function textinitp2() : void
      {
         var i:uint = 0;
         for(i = 0; i < 8; i++)
         {
            this["t2_" + i].text = "未学习";
            this["p2_" + i].gotoAndStop(1);
            p2condArr[i] = -1;
         }
      }
      
      private function plBtnfalse() : void
      {
         var j:uint = 0;
         var i:uint = 0;
         for(j = 0; j < 4; j++)
         {
            this["b1_" + j].isClick = false;
         }
         for(i = 0; i < 3; i++)
         {
            this["b1_" + i].isClick = false;
            if(PlayerDataOneArr[i] == false)
            {
               this["b1_" + i].gotoAndStop(4);
               this["b1_" + i].isClick = false;
               this.mack1.x = this["b1_" + i].x;
            }
         }
         for(i = 0; i < 3; i++)
         {
            if(PlayerDataOneArr[i] == true)
            {
               this["b1_" + i].isClick = true;
               bagStata[0] = i + 1;
               xs_mc1.visible = true;
               xs_mc1.gotoAndStop(i + 1);
               break;
            }
         }
      }
      
      private function doCond(player:PlayerData, idArr:Array, condArr:Array, finishCondArr:Array, finishBtnArr:Array, bagStataNum:Number, type:uint = 1) : void
      {
         var i:uint = 0;
         if(type == 1)
         {
            for(i = 0; i < 8; i++)
            {
               if(player.getSkillLevel(idArr[i]) < SkillFactory.getSkillByTypeIAndLevel(idArr[i]).getskillLevelUp())
               {
                  condArr[i] = SkillConditionFactory.getCondition(idArr[i],player.getSkillLevel(idArr[i]) + 1);
               }
               else
               {
                  condArr[i] = SkillConditionFactory.getCondition(idArr[i],player.getSkillLevel(idArr[i]));
               }
               finishCondArr[i] = contrast(player,condArr[i],bagStataNum - 1);
               finishBtnArr[i] = contrast(player,condArr[i],bagStataNum - 1,"btn");
            }
         }
         else
         {
            for(i = 0; i < 7; i++)
            {
               if(player.getSkillLevel(idArr[i]) < SkillFactory.getSkillByTypeIAndLevel(idArr[i]).getskillLevelUp())
               {
                  condArr[i] = SkillConditionFactory.getCondition(idArr[i],player.getSkillLevel(idArr[i]) + 1);
               }
               else
               {
                  condArr[i] = SkillConditionFactory.getCondition(idArr[i],player.getSkillLevel(idArr[i]));
               }
               finishCondArr[i] = contrast(player,condArr[i],bagStataNum - 1);
               finishBtnArr[i] = contrast(player,condArr[i],bagStataNum - 1,"btn");
            }
         }
      }
      
      public function exText(my_arr:Array, id:String, nowLevel:Number, player:PlayerData) : void
      {
         var idtype:String = null;
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
         idtype = SkillConditionFactory.getBeforeLevelId(my_arr[id],nowLevel);
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
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_OVER,overHandle);
         this.addEventListener(BtnEvent.DO_OUT,outHandle);
         this.addEventListener(BtnEvent.DO_CHANGE,changeHandle);
         this.addEventListener(BtnEvent.DO_CLICK,clickHandle);
         this.addEventListener(BtnEvent.DO_CLOSE,closeHanle);
      }
      
      private function p1GoldText() : void
      {
         point1.text = String(player1.getPoints());
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
      
      private function aginPoint(player:PlayerData) : Number
      {
         var p1:Number = NaN;
         var p2:Number = NaN;
         var p3:Number = NaN;
         var p4:Number = NaN;
         var p5:Number = NaN;
         var allP:Number = NaN;
         var i:uint = 0;
         p1 = 0;
         p2 = 0;
         p3 = 0;
         p4 = 0;
         p5 = 0;
         for(i = 0; i < 8; i++)
         {
            p1 += Number(player.getSkillLevel(idArrOne[i])) * SkillConditionFactory.getPoints(idArrOne[i]);
            p2 += Number(player.getSkillLevel(idArrTow[i])) * SkillConditionFactory.getPoints(idArrTow[i]);
            p3 += Number(player.getSkillLevel(idArrThree[i])) * SkillConditionFactory.getPoints(idArrThree[i]);
            p4 += Number(player.getSkillLevel(idArrFoure[i])) * SkillConditionFactory.getPoints(idArrFoure[i]);
         }
         for(i = 0; i < 7; i++)
         {
            p5 += Number(player.getSkillLevel(idArrFive[i])) * SkillConditionFactory.getPoints(idArrFive[i]);
         }
         for(i = 0; i < 8; i++)
         {
            player.aginSkillLevel(idArrOne[i]);
            player.aginSkillLevel(idArrTow[i]);
            player.aginSkillLevel(idArrThree[i]);
            player.aginSkillLevel(idArrFoure[i]);
         }
         for(i = 0; i < 7; i++)
         {
            player.aginSkillLevel(idArrFive[i]);
         }
         return p1 + p2 + p3 + p4 + p5;
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
      
      private function pointY(mc:MovieClip) : void
      {
         var myPoint:Point = null;
         myPoint = new Point(mc.x,mc.y);
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
      
      private function aginGold(player:PlayerData, idArr:Array) : Number
      {
         var gold:Number = NaN;
         var j:uint = 0;
         var nowLevel:uint = 0;
         var i:uint = 0;
         gold = 0;
         for(j = 0; j < 8; j++)
         {
            nowLevel = player.getSkillLevel(idArr[j]);
            for(i = 1; i <= nowLevel; i++)
            {
               gold += SkillConditionFactory.getGold(idArr[j],i);
            }
         }
         return gold;
      }
      
      private function anginOk1() : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 8; i++)
         {
            if(player1.getSkillLevel(idArrOne[i]) > 0)
            {
               return true;
            }
            if(player1.getSkillLevel(idArrTow[i]) > 0)
            {
               return true;
            }
            if(player1.getSkillLevel(idArrThree[i]) > 0)
            {
               return true;
            }
            if(player1.getSkillLevel(idArrFoure[i]) > 0)
            {
               return true;
            }
         }
         for(i = 0; i < 8; i++)
         {
            if(player1.getSkillLevel(idArrFive[i]) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function anginOk2() : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 8; i++)
         {
            if(player2.getSkillLevel(idArrOne[i]) > 0)
            {
               return true;
            }
            if(player2.getSkillLevel(idArrTow[i]) > 0)
            {
               return true;
            }
            if(player2.getSkillLevel(idArrThree[i]) > 0)
            {
               return true;
            }
            if(player2.getSkillLevel(idArrFoure[i]) > 0)
            {
               return true;
            }
         }
         for(i = 0; i < 8; i++)
         {
            if(player2.getSkillLevel(idArrFive[i]) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function setXY() : void
      {
         var stageWidth:Number = NaN;
         var stageHeight:Number = NaN;
         stageWidth = Main._stage.stageWidth / 2;
         stageHeight = Main._stage.stageHeight / 2;
         this.x = stageWidth - this.width / 2;
         this.y = 50;
      }
      
      private function initSkillFrame1() : void
      {
         var i:uint = 0;
         p1_j.visible = false;
         for(i = 0; i < PlayerDataOneArr.length; i++)
         {
            if(PlayerDataOneArr[i])
            {
               if(i == 0)
               {
                  dotext("t1_",idArrOne,player1);
                  cionFrame("p1_",idArrOne);
                  doCond(player1,idArrOne,p1condArr,p1finishCondArr,p1BtnfinishCondArr,1);
                  stuGoto(player1,"s1_",idArrOne,p1BtnfinishCondArr);
                  cionVisible(player1,"p1_",idArrOne);
                  return;
               }
               if(i == 1)
               {
                  dotext("t1_",idArrTow,player1);
                  cionFrame("p1_",idArrTow);
                  doCond(player1,idArrTow,p1condArr,p1finishCondArr,p1BtnfinishCondArr,2);
                  stuGoto(player1,"s1_",idArrTow,p1BtnfinishCondArr);
                  cionVisible(player1,"p1_",idArrTow);
                  return;
               }
               if(i == 2)
               {
                  dotext("t1_",idArrThree,player1);
                  cionFrame("p1_",idArrThree);
                  doCond(player1,idArrThree,p1condArr,p1finishCondArr,p1BtnfinishCondArr,3);
                  stuGoto(player1,"s1_",idArrThree,p1BtnfinishCondArr);
                  cionVisible(player1,"p1_",idArrThree);
                  return;
               }
            }
         }
      }
      
      private function initSkillFrame2() : void
      {
         var i:uint = 0;
         p2_j.visible = false;
         for(i = 0; i < playerTowArr.length; i++)
         {
            if(playerTowArr[i])
            {
               if(i == 0)
               {
                  dotext("t2_",idArrOne,player2);
                  cionFrame("p2_",idArrOne);
                  doCond(player2,idArrOne,p2condArr,p2finishCondArr,p2BtnfinishCondArr,1);
                  stuGoto(player2,"s2_",idArrOne,p2BtnfinishCondArr);
                  cionVisible(player2,"p2_",idArrOne);
                  return;
               }
               if(i == 1)
               {
                  dotext("t2_",idArrTow,player2);
                  cionFrame("p2_",idArrTow);
                  doCond(player2,idArrTow,p2condArr,p2finishCondArr,p2BtnfinishCondArr,2);
                  stuGoto(player2,"s2_",idArrTow,p2BtnfinishCondArr);
                  cionVisible(player2,"p2_",idArrTow);
                  return;
               }
               if(i == 2)
               {
                  dotext("t2_",idArrThree,player2);
                  cionFrame("p2_",idArrThree);
                  doCond(player2,idArrThree,p2condArr,p2finishCondArr,p2BtnfinishCondArr,3);
                  stuGoto(player2,"s2_",idArrThree,p2BtnfinishCondArr);
                  cionVisible(player2,"p2_",idArrThree);
                  return;
               }
            }
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
      
      private function contrast(player:PlayerData, skillArr:Array, type:Number, allorBtn:String = "all") : Boolean
      {
         var playerLevel:Number = NaN;
         var points:Number = NaN;
         var gold:Number = NaN;
         var rebirth:Boolean = false;
         var transfer:Boolean = false;
         var sureArr:Array = null;
         playerLevel = player.getLevel();
         points = player.getPoints();
         gold = player.getGold();
         rebirth = player.isRebirth();
         transfer = player.isTransfer(type);
         sureArr = [];
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
      
      public function p2StuBtnVisible() : void
      {
         var i:uint = 0;
         for(i = 0; i < 8; i++)
         {
            this["s2_" + i].gotoAndStop(2);
         }
         p2_j.visible = false;
         p2Skill_mc.gotoAndStop(2);
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
      
      private function p2TextVisible() : void
      {
         var i:uint = 0;
         for(i = 0; i < 8; i++)
         {
            this["t2_" + i].text = "";
         }
      }
      
      private function redText(myArr:Array, strId:String, num:Number = 1) : void
      {
         var nowLevel:Number = NaN;
         var nextLevel:Number = NaN;
         var id:Number = NaN;
         var maxLevel:Number = NaN;
         var skilllevel:Number = NaN;
         nextLevel = 1;
         id = Number(strId);
         maxLevel = Number(SkillFactory.getSkillByTypeIAndLevel(myArr[id]).getskillLevelUp());
         if(num == 1)
         {
            nowLevel = Number(player1.getSkillLevel(myArr[id]));
            if(nowLevel == 0)
            {
               nowLevel = 1;
            }
            else
            {
               nowLevel = Number(player1.getSkillLevel(myArr[id]));
               if(nowLevel < maxLevel)
               {
                  nextLevel = nowLevel + 1;
               }
               else
               {
                  nextLevel = maxLevel;
               }
            }
            if(player1.getLevel() >= SkillConditionFactory.getPlayerDataLevel(myArr[id],nowLevel))
            {
               explain.playerLevel.setTextFormat(_textFormat1);
            }
            else
            {
               explain.playerLevel.setTextFormat(_textFormat);
            }
            if(player1.getPoints() >= SkillConditionFactory.getPoints(myArr[id],nowLevel))
            {
               explain.pointNumber.setTextFormat(_textFormat1);
            }
            else
            {
               explain.pointNumber.setTextFormat(_textFormat);
            }
            skilllevel = Number(SkillConditionFactory.getPlayerDataLevel(myArr[id],nextLevel));
            if(player1.getLevel() >= SkillConditionFactory.getPlayerDataLevel(myArr[id],nextLevel))
            {
               explainTow.nextPlayerLevel.setTextFormat(_textFormat1);
            }
            else
            {
               explainTow.nextPlayerLevel.setTextFormat(_textFormat);
            }
            if(player1.getPoints() >= SkillConditionFactory.getPoints(myArr[id],nextLevel))
            {
               explainTow.nextPoint.setTextFormat(_textFormat1);
            }
            else
            {
               explainTow.nextPoint.setTextFormat(_textFormat);
            }
         }
         else if(num == 2)
         {
            nowLevel = Number(player2.getSkillLevel(myArr[id]));
            if(nowLevel == 0)
            {
               nowLevel = 1;
            }
            else
            {
               nowLevel = Number(player2.getSkillLevel(myArr[id]));
               if(nowLevel < maxLevel)
               {
                  nextLevel = nowLevel + 1;
               }
               else
               {
                  nextLevel = maxLevel;
               }
            }
            if(player2.getLevel() >= SkillConditionFactory.getPlayerDataLevel(myArr[id],nowLevel))
            {
               explain.playerLevel.setTextFormat(_textFormat1);
            }
            else
            {
               explain.playerLevel.setTextFormat(_textFormat);
            }
            if(player2.getPoints() >= SkillConditionFactory.getPoints(myArr[id],nowLevel))
            {
               explain.pointNumber.setTextFormat(_textFormat1);
            }
            else
            {
               explain.pointNumber.setTextFormat(_textFormat);
            }
            if(player2.getLevel() >= SkillConditionFactory.getPlayerDataLevel(myArr[id],nextLevel))
            {
               explainTow.nextPlayerLevel.setTextFormat(_textFormat1);
            }
            else
            {
               explainTow.nextPlayerLevel.setTextFormat(_textFormat);
            }
            if(player2.getPoints() >= SkillConditionFactory.getPoints(myArr[id],nextLevel))
            {
               explainTow.nextPoint.setTextFormat(_textFormat1);
            }
            else
            {
               explainTow.nextPoint.setTextFormat(_textFormat);
            }
         }
      }
      
      private function p1tlStu() : void
      {
         var i:uint = 0;
         for(i = 0; i < 3; i++)
         {
            if(PlayerDataOneArr[i] == false)
            {
               this["s1_" + (i + 5)].gotoAndStop(2);
            }
         }
      }
      
      private function p2GoldText() : void
      {
         point2.text = String(player2.getPoints());
      }
      
      private function setKeyFunction(ex:MovieClip, id:Number, keyArr:Array, type:* = 1) : void
      {
         var xx:Number = NaN;
         var keyNum:String = null;
         if(type == 1)
         {
            if(id < 4)
            {
               keyMcVible(ex);
               xx = Number(keyArr[id + 7]);
               keyNum = "k" + String(xx);
               ex.skillKey.gotoAndStop(keyNum);
            }
            else if(id == 4)
            {
               keyMcVible(ex,1);
               ex.skillKey.gotoAndStop("k" + String(keyArr[14]));
            }
            else if(id == 5)
            {
               keyMcVible(ex,2);
               ex.skillKey1.gotoAndStop("k" + String(keyArr[14]));
               ex.skillKey.gotoAndStop("k" + String(keyArr[0]));
            }
            else if(id == 6)
            {
               keyMcVible(ex,2);
               ex.skillKey1.gotoAndStop("k" + String(keyArr[14]));
               ex.skillKey.gotoAndStop("k" + String(keyArr[1]));
            }
            else if(id == 7)
            {
               keyMcVible(ex,3);
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
      
      private function cionFrame(p_mc:String, idArr:Array, type:uint = 1) : void
      {
         var i:uint = 0;
         if(type == 1)
         {
            for(i = 0; i < 8; i++)
            {
               this[p_mc + i].gotoAndStop(SkillFactory.getSkillByTypeIAndLevel(idArr[i]).getFrame());
            }
         }
         else
         {
            for(i = 0; i < 7; i++)
            {
               this[p_mc + i].gotoAndStop(SkillFactory.getSkillByTypeIAndLevel(idArr[i]).getFrame());
            }
            this[p_mc + 7].gotoAndStop(1);
         }
      }
      
      public function closeMc() : void
      {
         this.prompt_btn.visible = false;
         this.prompt_btn2.visible = false;
      }
      
      private function closeHanle(e:BtnEvent) : void
      {
         prompt_btn.visible = false;
         prompt_btn2.visible = false;
         if(e.target.id == 1)
         {
            if(oldPlayerData.getPoints() >= oldPoint)
            {
               if(oldPlayerData.getGold() >= oldGold)
               {
                  oldPlayerData.addSkillLevel(targetTypeId);
                  oldPlayerData.setPoints(oldPoint);
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
         if(e.target.id == 3)
         {
            trace("请到商城");
         }
         if(e.target.id == 4)
         {
            trace("关闭");
            close();
         }
      }
      
      private function stuGoto(player:PlayerData, stuStr:String, myArr:Array, BtnfinishCondArr:Array, type:Number = 1) : void
      {
         var i:uint = 0;
         if(type == 1)
         {
            for(i = 0; i < 8; i++)
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
         else
         {
            for(i = 0; i < 7; i++)
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
      }
      
      private function clickHandle(e:BtnEvent) : void
      {
         var mc:MovieClip = null;
         var targetMcName:* = undefined;
         var nameId:String = null;
         var id:String = null;
         var aginId:String = null;
         var aginNameId:String = null;
         var oldAllGod:uint = 0;
         mc = e.target as MovieClip;
         targetMcName = mc.name;
         nameId = mc.parent.name.substr(1,1);
         id = mc.parent.name.substr(3,1);
         aginId = mc.name.substr(3,1);
         aginNameId = mc.name.substr(1,1);
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
               switch(bagStata[0])
               {
                  case 1:
                     addSkill(player1,idArrOne,1,id);
                     break;
                  case 2:
                     addSkill(player1,idArrTow,2,id);
                     break;
                  case 3:
                     addSkill(player1,idArrThree,3,id);
                     break;
                  case 4:
                     addSkill(player1,idArrFoure,4,id);
                     break;
                  case 5:
                     if(arrowrightNum1 == 0)
                     {
                        addSkill(player1,idArrFoure,5,id);
                     }
                  case 6:
                     if(arrowrightNum1 == 1)
                     {
                        addSkill(player1,idArrFive,6,id);
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
               switch(bagStata[1])
               {
                  case 1:
                     addSkill(player2,idArrOne,1,id);
                     break;
                  case 2:
                     addSkill(player2,idArrTow,2,id);
                     break;
                  case 3:
                     addSkill(player2,idArrThree,3,id);
                     break;
                  case 4:
                     addSkill(player2,idArrFoure,4,id);
                     break;
                  case 5:
                     if(arrowrightNum2 == 0)
                     {
                        addSkill(player2,idArrFoure,5,id);
                     }
                  case 6:
                     if(arrowrightNum2 == 1)
                     {
                        addSkill(player2,idArrFive,6,id);
                     }
               }
            }
         }
         if(aginNameId == "1")
         {
            if(anginOk1())
            {
               if(aginBo)
               {
                  trace("重置P1");
                  oldAllGod = aginGold(player1,idArrOne) + aginGold(player1,idArrTow) + aginGold(player1,idArrThree) + aginGold(player1,idArrFoure);
                  player1.addGold(oldAllGod);
                  trace("返回:" + oldAllGod);
                  player1.addPoint(aginPoint(player1));
                  trace("重置后的金币" + player1.getGold());
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
                        doCond(player1,idArrFive,p1condArr,p1finishCondArr,p1BtnfinishCondArr,5);
                        cionVisible(player1,"p1_",idArrFive);
                        stuGoto(player1,"s1_",idArrFive,p1BtnfinishCondArr);
                        p1tlStu();
                  }
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
         if(aginNameId == "2")
         {
            if(anginOk2())
            {
               if(aginBo)
               {
                  oldAllGod = aginGold(player2,idArrOne) + aginGold(player2,idArrTow) + aginGold(player2,idArrThree) + aginGold(player2,idArrFoure);
                  player2.addGold(oldAllGod);
                  trace(oldAllGod);
                  trace("重置P2");
                  player2.addPoint(aginPoint(player2));
                  p2GoldText();
                  trace("重置后的金币" + player2.getGold());
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
                        doCond(player2,idArrTow,p2condArr,p2finishCondArr,p2BtnfinishCondArr,1);
                        cionVisible(player2,"p2_",idArrTow);
                        stuGoto(player2,"s2_",idArrTow,p2BtnfinishCondArr);
                        break;
                     case 3:
                        dotext("t2_",idArrThree,player2);
                        doCond(player2,idArrThree,p2condArr,p2finishCondArr,p2BtnfinishCondArr,1);
                        cionVisible(player2,"p2_",idArrThree);
                        stuGoto(player2,"s2_",idArrThree,p2BtnfinishCondArr);
                        break;
                     case 4:
                        dotext("t2_",idArrFoure,player2);
                        doCond(player2,idArrFoure,p2condArr,p2finishCondArr,p2BtnfinishCondArr,1);
                        cionVisible(player2,"p2_",idArrFoure);
                        stuGoto(player2,"s2_",idArrFoure,p2BtnfinishCondArr);
                        p2tlStu();
                        break;
                     case 5:
                        dotext("t2_",idArrFoure,player2);
                        doCond(player2,idArrFoure,p2condArr,p2finishCondArr,p2BtnfinishCondArr,1);
                        cionVisible(player2,"p2_",idArrFoure);
                        stuGoto(player2,"s2_",idArrFoure,p2BtnfinishCondArr);
                        p2tlStu();
                        break;
                     case 6:
                        dotext("t2_",idArrFive,player2);
                        doCond(player2,idArrFive,p2condArr,p2finishCondArr,p2BtnfinishCondArr,1);
                        cionVisible(player2,"p2_",idArrFive);
                        stuGoto(player2,"s2_",idArrFive,p2BtnfinishCondArr);
                        p2tlStu();
                  }
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
               if(p1BtnfinishCondArr[id])
               {
                  explain.beforeSkillName.setTextFormat(_textFormat1);
               }
               else
               {
                  explain.beforeSkillName.setTextFormat(_textFormat);
               }
            }
            if(nameId == 2)
            {
               explain.x = mouseX - explain.width - 10;
            }
            explain.y = mouseY;
            pointY(explain);
            exText(my_arr,id,nowLevel,player);
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
            pointY(explainTow);
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
      
      private function p2AllBtnfalse() : void
      {
         var i:uint = 0;
         for(i = 0; i < 4; i++)
         {
            this["b2_" + i].gotoAndStop(4);
         }
         xs_mc2.visible = false;
         py2_SetKey.gotoAndStop(4);
         a2_7.gotoAndStop(4);
         point2.text = "";
         skillPointMc.gotoAndStop(2);
      }
      
      public function cionVisible(player:PlayerData, pstring:String, myarr:Array, type:Number = 1) : void
      {
         var i:uint = 0;
         if(type == 1)
         {
            for(i = 0; i < 8; i++)
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
         else
         {
            for(i = 0; i < 7; i++)
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
      }
      
      private function changeHandle(e:BtnEvent) : void
      {
         var mc:MovieClip = null;
         var nameId:String = null;
         mc = e.target as MovieClip;
         nameId = mc.name.substr(1,1);
         if(nameId == "1")
         {
            arrFalse(e.id);
            bagStata[0] = mc.id;
            if(e.id == 1)
            {
               this.b1_1.isClick = false;
               this.b1_2.isClick = false;
               this.b1_3.isClick = false;
               arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(1);
               cionFrame("p1_",idArrOne);
               dotext("t1_",idArrOne,player1);
               doCond(player1,idArrOne,p1condArr,p1finishCondArr,p1BtnfinishCondArr,e.id);
               cionVisible(player1,"p1_",idArrOne);
               stuGoto(player1,"s1_",idArrOne,p1BtnfinishCondArr);
            }
            if(e.id == 2)
            {
               this.b1_0.isClick = false;
               this.b1_2.isClick = false;
               this.b1_3.isClick = false;
               arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(2);
               cionFrame("p1_",idArrTow);
               dotext("t1_",idArrTow,player1);
               doCond(player1,idArrTow,p1condArr,p1finishCondArr,p1BtnfinishCondArr,e.id);
               cionVisible(player1,"p1_",idArrTow);
               stuGoto(player1,"s1_",idArrTow,p1BtnfinishCondArr);
            }
            if(e.id == 3)
            {
               this.b1_0.isClick = false;
               this.b1_1.isClick = false;
               this.b1_3.isClick = false;
               arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               xs_mc1.gotoAndStop(3);
               cionFrame("p1_",idArrThree);
               dotext("t1_",idArrThree,player1);
               doCond(player1,idArrThree,p1condArr,p1finishCondArr,p1BtnfinishCondArr,e.id);
               cionVisible(player1,"p1_",idArrThree);
               stuGoto(player1,"s1_",idArrThree,p1BtnfinishCondArr);
            }
            if(e.id == 4)
            {
               this.b1_0.isClick = false;
               this.b1_1.isClick = false;
               this.b1_2.isClick = false;
               arrowrightNum1 = 0;
               this.p1_j.b1_5.isClick = true;
               cionFrame("p1_",idArrFoure);
               dotext("t1_",idArrFoure,player1);
               doCond(player1,idArrFoure,p1condArr,p1finishCondArr,p1BtnfinishCondArr,e.id);
               cionVisible(player1,"p1_",idArrFoure);
               stuGoto(player1,"s1_",idArrFoure,p1BtnfinishCondArr);
               p1tlStu();
            }
            if(e.id == 5)
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
                  doCond(player1,idArrFoure,p1condArr,p1finishCondArr,p1BtnfinishCondArr,e.id);
                  cionVisible(player1,"p1_",idArrFoure);
                  stuGoto(player1,"s1_",idArrFoure,p1BtnfinishCondArr);
                  p1tlStu();
               }
               if(arrowrightNum1 == arrowArr[0])
               {
               }
            }
            if(e.id == 6)
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
                  doCond(player1,idArrFive,p1condArr,p1finishCondArr,p1BtnfinishCondArr,e.id);
                  cionVisible(player1,"p1_",idArrFive);
                  stuGoto(player1,"s1_",idArrFive,p1BtnfinishCondArr);
                  p1tlStu();
               }
               if(arrowrightNum1 == arrowArr[arrowArr.length - 1])
               {
               }
            }
         }
         if(nameId == "2")
         {
            arrFalse2(e.id);
            bagStata[1] = mc.id;
            if(e.id == 1)
            {
               this.b2_1.isClick = false;
               this.b2_2.isClick = false;
               this.b2_3.isClick = false;
               arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(1);
               cionFrame("p2_",idArrOne);
               dotext("t2_",idArrOne,player2);
               doCond(player2,idArrOne,p2condArr,p2finishCondArr,p2BtnfinishCondArr,e.id);
               cionVisible(player2,"p2_",idArrOne);
               stuGoto(player2,"s2_",idArrOne,p2BtnfinishCondArr);
            }
            if(e.id == 2)
            {
               this.b2_0.isClick = false;
               this.b2_2.isClick = false;
               this.b2_3.isClick = false;
               arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(2);
               cionFrame("p2_",idArrTow);
               dotext("t2_",idArrTow,player2);
               doCond(player2,idArrTow,p2condArr,p2finishCondArr,p2BtnfinishCondArr,e.id);
               cionVisible(player2,"p2_",idArrTow);
               stuGoto(player2,"s2_",idArrTow,p2BtnfinishCondArr);
            }
            if(e.id == 3)
            {
               this.b2_0.isClick = false;
               this.b2_1.isClick = false;
               this.b2_3.isClick = false;
               arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               xs_mc2.gotoAndStop(3);
               cionFrame("p2_",idArrThree);
               dotext("t2_",idArrThree,player2);
               doCond(player2,idArrThree,p2condArr,p2finishCondArr,p2BtnfinishCondArr,e.id);
               cionVisible(player2,"p2_",idArrThree);
               stuGoto(player2,"s2_",idArrThree,p2BtnfinishCondArr);
            }
            if(e.id == 4)
            {
               this.b2_0.isClick = false;
               this.b2_1.isClick = false;
               this.b2_2.isClick = false;
               arrowrightNum2 = 0;
               this.p2_j.b2_5.isClick = true;
               cionFrame("p2_",idArrFoure);
               dotext("t2_",idArrFoure,player2);
               doCond(player2,idArrFoure,p2condArr,p2finishCondArr,p2BtnfinishCondArr,e.id);
               cionVisible(player2,"p2_",idArrFoure);
               stuGoto(player2,"s2_",idArrFoure,p2BtnfinishCondArr);
               p2tlStu();
            }
            if(e.id == 5)
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
                  doCond(player2,idArrFoure,p2condArr,p2finishCondArr,p2BtnfinishCondArr,e.id);
                  cionVisible(player2,"p2_",idArrFoure);
                  stuGoto(player2,"s2_",idArrFoure,p2BtnfinishCondArr);
                  p2tlStu();
               }
               if(arrowrightNum2 == arrowArr[0])
               {
               }
            }
            if(e.id == 6)
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
                  doCond(player2,idArrFive,p2condArr,p2finishCondArr,p2BtnfinishCondArr,e.id);
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
   }
}

class PrivateClass
{
   
   public function PrivateClass()
   {
      super();
   }
}
