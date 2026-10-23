package com.hotpoint.braveManIII.models.achievement
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.models.quest.Quest;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.repository.achievement.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import src.*;
   
   public class Achievement
   {
      
      private var _id:VT;
      
      private var _tzTime:VT;
      
      private var _time:VT;
      
      private var _skillTime:VT;
      
      private var _ptSkill:VT;
      
      private var _baojiTime:VT;
      
      private var _tg:Boolean;
      
      private var _miss:VT;
      
      private var _lianJi:VT;
      
      private var _bettJi:VT;
      
      private var _map:VT;
      
      private var _star:VT;
      
      private var _hpNum:VT;
      
      private var _mpNum:VT;
      
      private var _goodsTime1:Array = [];
      
      private var _goodsTime2:Array = [];
      
      private var _enemyed:VT;
      
      private var _state:VT;
      
      private var _overTimer:VT;
      
      private var _cs:VT;
      
      public function Achievement()
      {
         super();
      }
      
      public static function creatAchForNum(id:Number) : Achievement
      {
         var data:Achievement = new Achievement();
         data._id = VT.createVT(id);
         data._tzTime = VT.createVT();
         data._time = VT.createVT();
         data._skillTime = VT.createVT();
         data._ptSkill = VT.createVT();
         data._tg = false;
         data._baojiTime = VT.createVT();
         data._miss = VT.createVT();
         data._lianJi = VT.createVT();
         data._bettJi = VT.createVT();
         data._map = VT.createVT();
         data._star = VT.createVT();
         data._hpNum = VT.createVT();
         data._mpNum = VT.createVT();
         data.initGoodsTime();
         data._enemyed = VT.createVT();
         data._state = VT.createVT(0);
         data._overTimer = VT.createVT(0);
         data._cs = VT.createVT();
         return data;
      }
      
      private function initGoodsTime() : void
      {
         var num:Number = this.getGoodsId().length;
         for(var i:uint = 0; i < num; i++)
         {
            this._goodsTime1[i] = 0;
            this._goodsTime2[i] = 0;
         }
      }
      
      public function isOk() : Boolean
      {
         var type:Number = this.getSmallType();
         switch(type)
         {
            case 1:
               return this.playerlevelOk();
            case 2:
               return this.goldOk();
            case 5:
               return this.jsPointOk();
            case 7:
               return this.edAcOk();
            case 8:
               return this.gAcOk();
            case 9:
               return this.onLineTime();
            case 10:
               return this.AcNumOk();
            case 11:
               return this.cwNumOk();
            case 12:
               return this.skillNumOk();
            case 13:
               return this.xqOk();
            case 14:
               return this.zfOk();
            case 15:
               return this.makeOk();
            case 16:
               return this.hcOk();
            case 17:
               return this.getZxOk();
            case 18:
               return this.getRcOk();
            case 20:
               return this.strOk();
            case 21:
               return this.strLostOk();
            case 22:
               return this.strNumXXOk();
            case 23:
               return this.strRyOk();
            case 24:
               return this.getCwlevelOk();
            case 25:
               return this.getCwJh();
            case 26:
               return this.getCwSkillOk();
            case 27:
               return this.getZzOk();
            case 28:
               return this.getSkillLevelOk();
            case 29:
               return this.getAllSkill();
            case 30:
               return this.GemColorOk();
            case 31:
               return this.getMapStarOk();
            case 32:
               return this.getMapIdOk();
            case 33:
               return this.getTzGkOk();
            case 34:
               return this.tgTimeOk();
            case 35:
               return this.tgByIdAndTimeOk();
            case 36:
               return this.getNoSkillOk();
            case 37:
               return this.getNoPtOk();
            case 38:
               return this.getBaoJiOk();
            case 39:
               return this.getMissOk();
            case 40:
               return this.getBetoK();
            case 41:
               return this.getLjOk();
            case 42:
               return this.getHpOk();
            case 43:
               return this.getMpOk();
            case 44:
               return this.goodsOk();
            case 45:
               return this.enemyOk();
            case 46:
               return this.pkPhok();
            default:
               return;
         }
      }
      
      private function pkPhok() : Boolean
      {
         if(PK_UI.whoNum != 0 && PK_UI.whoNum <= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      public function goodsOk() : Boolean
      {
         var b1:Boolean = false;
         var b2:Boolean = false;
         var i:uint = 0;
         var gId:Array = this.getGoodsId();
         var ts:Number = this.getFinishNum();
         if(gId[0].getValue() == -1)
         {
            return this.mdFunction();
         }
         if(!this.isRy())
         {
            return this.mdFunction();
         }
         b1 = true;
         b2 = true;
         for(i = 0; i < gId.length; i++)
         {
            if(this._goodsTime1[i] < ts)
            {
               b1 = false;
            }
            if(Main.P1P2)
            {
               if(this._goodsTime2[i] < ts)
               {
                  b2 = false;
               }
            }
         }
         if(b1)
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(b2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setMd(type:Number = 1, id:Number = 1, p:Number = 1, num:Number = 0) : void
      {
         var gId:Array = null;
         var i:uint = 0;
         if(this.getStata() == 0 && this.getSmallType() == 44)
         {
            if(type == this.getFs())
            {
               if(type != 1)
               {
                  this.getNumForBag();
                  gId = this.getGoodsId();
                  if(gId[0].getValue() == -1)
                  {
                     if(p == 1)
                     {
                        this._goodsTime1[0] += num;
                     }
                     else if(p == 2)
                     {
                        this._goodsTime2[0] += num;
                     }
                  }
                  else
                  {
                     for(i = 0; i < gId.length; i++)
                     {
                        if(gId[i].getValue() == id)
                        {
                           if(p == 1)
                           {
                              this._goodsTime1[i] += num;
                           }
                           else if(p == 2)
                           {
                              this._goodsTime2[i] += num;
                           }
                           break;
                        }
                     }
                  }
               }
               else
               {
                  this.setGoodsNum();
               }
            }
         }
      }
      
      private function mdFunction() : Boolean
      {
         var ts:Number = this.getFinishNum();
         var num1:Number = 0;
         var num2:Number = 0;
         for(var i:uint = 0; i < this._goodsTime1.length; i++)
         {
            num1 += this._goodsTime1[i];
            if(Main.P1P2)
            {
               num2 += this._goodsTime2[i];
            }
         }
         if(num1 >= ts)
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(num2 >= ts)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return AchNumFactory.getName(this._id.getValue());
      }
      
      public function getFrame() : Number
      {
         return AchNumFactory.getFrame(this._id.getValue());
      }
      
      public function getSm() : String
      {
         return AchNumFactory.getSm(this._id.getValue());
      }
      
      public function isEveryDady() : Boolean
      {
         return AchNumFactory.isEveryDady(this._id.getValue());
      }
      
      public function getType() : Number
      {
         return AchNumFactory.getType(this._id.getValue());
      }
      
      public function getRewardAc() : Number
      {
         return AchNumFactory.getRewardAc(this._id.getValue());
      }
      
      public function getStata() : Number
      {
         return this._state.getValue();
      }
      
      public function setStata(num:Number) : void
      {
         this._state.setValue(num);
      }
      
      public function getOverTimer() : Number
      {
         return this._overTimer.getValue();
      }
      
      public function setOverTimer(t:Number) : void
      {
         this._overTimer.setValue(t);
      }
      
      public function getSmallType() : Number
      {
         return AchNumFactory.getSmallType(this._id.getValue());
      }
      
      public function getGoodsId() : Array
      {
         return AchNumFactory.getGoodId(this._id.getValue());
      }
      
      public function getFinishNum() : Number
      {
         return AchNumFactory.getFinishNum(this._id.getValue());
      }
      
      public function getTs() : Number
      {
         return AchNumFactory.getTs(this._id.getValue());
      }
      
      public function isRy() : Boolean
      {
         return AchNumFactory.isRy(this._id.getValue());
      }
      
      private function getFs() : Number
      {
         return AchNumFactory.getNeedType(this._id.getValue());
      }
      
      private function getGoodsType() : Array
      {
         return AchNumFactory.getGoodsType(this._id.getValue());
      }
      
      private function playerlevelOk() : Boolean
      {
         if(Main.player1.getLevel() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getLevel() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function goldOk() : Boolean
      {
         if(Main.player1.getGold() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getGold() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function playGoldOk() : Boolean
      {
         if(AchData.p1Gold.getValue() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.p2Gold.getValue() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function jsPointOk() : Boolean
      {
         if(Main.player1.getKillPoint() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player1.getKillPoint() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function payJsPointOk() : Boolean
      {
         if(AchData.payJs1.getValue() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.payjs2.getValue() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function edAcOk() : Boolean
      {
         if(AchData.cjPoint_1.getValue() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function gAcOk() : Boolean
      {
         if(AchData.cjPoint_2.getValue() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function onLineTime() : Boolean
      {
      }
      
      private function AcNumOk() : Boolean
      {
         if(AchData.getGaAcNum() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function cwNumOk() : Boolean
      {
         if(Main.player1.getPetSlot().backPetNum() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getPetSlot().backPetNum() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function skillNumOk() : Boolean
      {
         if(Main.player1.getSkillNum() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getSkillNum() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function xqOk() : Boolean
      {
         if(AchData.xq1.getValue() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.xq2.getValue() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function zfOk() : Boolean
      {
         if(AchData.zf1.getValue() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.zf2.getValue() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function hcOk() : Boolean
      {
         if(AchData.hc1.getValue() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.hc2.getValue() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function makeOk() : Boolean
      {
         if(AchData.m1.getValue() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.m2.getValue() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function strOk() : Boolean
      {
         if(AchData.strOk1.getValue() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.strok2.getValue() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function strLostOk() : Boolean
      {
         if(AchData.strLost1.getValue() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.strLost2.getValue() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function strNumXXOk() : Boolean
      {
         var num:Number = 0;
         var num2:Number = 0;
         num = this.getStrEquipNum(Main.player1);
         if(Main.P1P2)
         {
            num2 = this.getStrEquipNum(Main.player2);
         }
         if(num >= this.getFinishNum() || num2 >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function strRyOk() : Boolean
      {
         if(Main.player1.getEquipSlot().getSuitStrength() >= this.getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getEquipSlot().getSuitStrength() >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function getZxOk() : Boolean
      {
         if(TaskData.getZxInOld() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function getRcOk() : Boolean
      {
         if(AchData.rcTask.getValue() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function getCwlevelOk() : Boolean
      {
         if(this.getCwMaxLeve() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      public function getCwMaxLeve() : Number
      {
         var arr1:Array = [];
         var arr2:Array = [];
         var num1:Number = 0;
         var num2:Number = 0;
         for(var i:uint = 0; i < 3; i++)
         {
            if(Main.player1.getPetSlot().getPetFromSlot(i) != null)
            {
               arr1.push(Main.player1.getPetSlot().getPetFromSlot(i).getLv());
            }
         }
         if(arr1.length != 0)
         {
            arr1.sort(Array.NUMERIC);
            num1 = Number(arr1[arr1.length - 1]);
         }
         if(Main.P1P2)
         {
            for(i = 0; i < 3; i++)
            {
               if(Main.player2.getPetSlot().getPetFromSlot(i) != null)
               {
                  arr2.push(Main.player2.getPetSlot().getPetFromSlot(i).getLv());
               }
            }
            if(arr2.length != 0)
            {
               arr2.sort(Array.NUMERIC);
               num2 = Number(arr2[arr2.length - 1]);
            }
         }
         if(num2 >= num1)
         {
            return num2;
         }
         return num1;
      }
      
      private function getCwJh() : Boolean
      {
      }
      
      private function getCwSkillOk() : Boolean
      {
         var arr:Array = null;
         var j:uint = 0;
         var arr1:Array = null;
         var b1:Number = 0;
         for(var i:uint = 0; i < 3; i++)
         {
            b1 = 0;
            if(Main.player1.getPetSlot().getPetFromSlot(i) != null)
            {
               arr = Main.player1.getPetSlot().getPetFromSlot(i).getPetSkill();
               for(j = 0; j < arr.length; j++)
               {
                  if(arr[j] > 0)
                  {
                     b1++;
                  }
               }
               if(b1 == 4)
               {
                  return true;
               }
            }
         }
         if(Main.P1P2)
         {
            for(i = 0; i < 3; i++)
            {
               b1 = 0;
               if(Main.player2.getPetSlot().getPetFromSlot(i) != null)
               {
                  arr1 = Main.player2.getPetSlot().getPetFromSlot(i).getPetSkill();
                  for(j = 0; j < arr1.length; j++)
                  {
                     if(arr1[j] > 0)
                     {
                        b1++;
                     }
                  }
                  if(b1 == 4)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      private function getZzOk() : Boolean
      {
         if(Main.player1.isTransferOk())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.isTransferOk())
            {
               return true;
            }
         }
         return false;
      }
      
      private function getSkillLevelOk() : Boolean
      {
         var i:uint = 0;
         var arr:Array = [];
         arr = Main.player1.getSkillArr();
         for(i = 7; i < arr.length; i++)
         {
            if(arr[i][1] >= this.getFinishNum())
            {
               return true;
            }
         }
         if(Main.P1P2)
         {
            arr = Main.player2.getSkillArr();
            for(i = 7; i < arr.length; i++)
            {
               if(arr[i][1] >= this.getFinishNum())
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function getAllSkill() : Boolean
      {
         if(this.getSkillxx(Main.player1))
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(this.getSkillxx(Main.player2))
            {
               return true;
            }
         }
         return false;
      }
      
      private function GemColorOk() : Boolean
      {
         if(this.getGemColor(Main.player1))
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(this.getGemColor(Main.player2))
            {
               return true;
            }
         }
         return false;
      }
      
      private function getMapStarOk() : Boolean
      {
         if(this.getGkStar() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      public function getGkStar() : Number
      {
         var num:Number = 0;
         for(var i:uint = 1; i <= 16; i++)
         {
            if(Main.guanKa[i] >= this.getTs())
            {
               num++;
            }
         }
         return num;
      }
      
      private function getMapIdOk() : Boolean
      {
         var mapId:Number = Number((this.getGoodsId() as Array)[0].getValue());
         if(Main.guanKa[mapId] > 0)
         {
            return true;
         }
         return false;
      }
      
      private function getTzGkOk() : Boolean
      {
         if(this._tzTime.getValue() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function tgTimeOk() : Boolean
      {
         if(AchData.tgTime.getValue() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function tgByIdAndTimeOk() : Boolean
      {
         return this.getIddo(this._time.getValue());
      }
      
      private function getNoPtOk() : Boolean
      {
         return this.getIddo(this._ptSkill.getValue());
      }
      
      private function getNoSkillOk() : Boolean
      {
         return this.getIddo(this._skillTime.getValue());
      }
      
      private function getIddo(duNum:Number, type:Number = 1) : Boolean
      {
         var i:uint = 0;
         var nmapId:Array = this.getGoodsId() as Array;
         var nstr:Number = this.getTs();
         if(nmapId.length != 1)
         {
            i = 0;
            while(true)
            {
               if(i < nmapId.length)
               {
                  if(nmapId[i].getValue() == this._map.getValue())
                  {
                     if(nstr == this._star.getValue())
                     {
                        if(this.isRy())
                        {
                           break;
                        }
                        if(this._tg)
                        {
                           return this.dbNum(type,duNum);
                        }
                     }
                  }
                  continue;
               }
               i++;
            }
            return this.dbNum(type,duNum);
         }
         if(nmapId[0].getValue() == -1)
         {
            if(nstr == -1)
            {
               if(this.isRy())
               {
                  return this.dbNum(type,duNum);
               }
               if(this._tg)
               {
                  return this.dbNum(type,duNum);
               }
            }
            else if(nstr == this._star.getValue())
            {
               if(this.isRy())
               {
                  return this.dbNum(type,duNum);
               }
               if(this._tg)
               {
                  return this.dbNum(type,duNum);
               }
            }
         }
         else if(nmapId[0].getValue() == this._map.getValue() && nstr == this._star.getValue())
         {
            if(this.isRy())
            {
               return this.dbNum(type,duNum);
            }
            if(this._tg)
            {
               return this.dbNum(type,duNum);
            }
         }
         return false;
      }
      
      private function dbNum(type:Number, duNum:Number) : Boolean
      {
         if(type == 1)
         {
            if(duNum <= this.getFinishNum())
            {
               return true;
            }
         }
         else if(type == 2)
         {
            if(duNum >= this.getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function getBaoJiOk() : Boolean
      {
         return this.getIddo(this._baojiTime.getValue(),2);
      }
      
      private function getMissOk() : Boolean
      {
         return this.getIddo(this._miss.getValue(),2);
      }
      
      private function getLjOk() : Boolean
      {
         return this.getIddo(this._lianJi.getValue(),2);
      }
      
      private function getBetoK() : Boolean
      {
         return this.getIddo(this._bettJi.getValue());
      }
      
      private function getHpOk() : Boolean
      {
         return this.getIddo(this._hpNum.getValue());
      }
      
      private function getMpOk() : Boolean
      {
         return this.getIddo(this._mpNum.getValue());
      }
      
      private function enemyOk() : Boolean
      {
         if(this._enemyed.getValue() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      public function setTg() : void
      {
         if(this.getStata() == 0)
         {
            this._tg = true;
         }
      }
      
      public function setLj(num:Number) : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 41)
         {
            this._lianJi.setValue(num);
         }
      }
      
      public function setBj(num:Number) : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 40)
         {
            this._bettJi.setValue(num);
         }
      }
      
      public function setMiss() : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 39)
         {
            this._miss.setValue(this._miss.getValue() + 1);
         }
      }
      
      public function setPtSkillTime() : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 37)
         {
            this._ptSkill.setValue(this._ptSkill.getValue() + 1);
         }
      }
      
      public function setSkillTime() : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 36)
         {
            this._skillTime.setValue(this._skillTime.getValue() + 1);
         }
      }
      
      public function setBaojiTime() : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 38)
         {
            this._baojiTime.setValue(this._baojiTime.getValue() + 1);
         }
      }
      
      public function setTimeTg(num:Number) : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 35)
         {
            this._time.setValue(num);
         }
      }
      
      public function setTzGkTime() : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 33)
         {
            if((this.getGoodsId() as Array)[0].getValue() == this._map.getValue())
            {
               if(this.getTs() != 20)
               {
                  if(this._cs.getValue() == this.getTs() + 1)
                  {
                     this._tzTime.setValue(this._tzTime.getValue() + 1);
                  }
               }
               else if(this.getTs() == 20)
               {
                  if(this._cs.getValue() == this.getTs())
                  {
                     this._tzTime.setValue(this._tzTime.getValue() + 1);
                  }
               }
            }
         }
      }
      
      public function getGemColor(player:PlayerData) : Boolean
      {
         var eq:Equip = null;
         var gem:Gem = null;
         for(var i:uint = 0; i < 8; i++)
         {
            if(player.getEquipSlot().getEquipFromSlot(i) == null)
            {
               return false;
            }
            eq = player.getEquipSlot().getEquipFromSlot(i);
            if(eq.getGrid() != 0)
            {
               return false;
            }
            gem = eq.getGemSlot();
            if(gem.getColor() < this.getFinishNum())
            {
               return false;
            }
         }
         return true;
      }
      
      private function getSkillxx(player:PlayerData) : Boolean
      {
         var j:uint = 0;
         var arr1:Array = ["a8","a9","a10","a11","a12","a13","a14","a15"];
         var arr2:Array = ["b8","b9","b10","b11","b12","b13","b14","b15"];
         var arr3:Array = ["c8","c9","c10","c11","c12","c13","c14","c15"];
         var arr4:Array = [0,0,0];
         var p1Arr:Array = player.getSkillArr();
         for(var i:uint = 0; i < p1Arr.length; i++)
         {
            for(j = 0; j < 8; j++)
            {
               if(p1Arr[i][0] == arr1[j])
               {
                  if(p1Arr[i][1] < 1)
                  {
                     arr4[0] = 1;
                  }
               }
               if(p1Arr[i][0] == arr2[j])
               {
                  if(p1Arr[i][1] < 1)
                  {
                     arr4[1] = 1;
                  }
               }
               if(p1Arr[i][0] == arr3[j])
               {
                  if(p1Arr[i][1] < 1)
                  {
                     arr4[2] = 1;
                  }
               }
            }
         }
         for(i = 0; i < arr4.length; i++)
         {
            if(arr4[i] == 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getStrEquipNum(data:PlayerData) : Number
      {
         var equip:Equip = null;
         var num:Number = 0;
         for(var i:uint = 0; i < 8; i++)
         {
            if(data.getEquipSlot().getEquipFromSlot(i) != null)
            {
               equip = data.getEquipSlot().getEquipFromSlot(i);
               if(equip.getReinforceLevel() >= this.getTs())
               {
                  num++;
                  break;
               }
            }
         }
         for(i = 0; i < 24; i++)
         {
            if(data.getBag().getEquipFromBag(i) != null)
            {
               equip = data.getBag().getEquipFromBag(i);
               if(equip.getReinforceLevel() >= this.getTs())
               {
                  num++;
                  break;
               }
            }
         }
         for(i = 0; i < 35; i++)
         {
            if(StoragePanel.storage.getEquipFromStorage(i) != null)
            {
               equip = StoragePanel.storage.getEquipFromStorage(i);
               if(equip.getReinforceLevel() >= this.getTs())
               {
                  num++;
                  break;
               }
            }
         }
         return num;
      }
      
      public function setMapId(id:Number) : void
      {
         if(this.getStata() == 0 && id != 0)
         {
            this._map.setValue(id);
         }
      }
      
      public function setStarId(id:Number) : void
      {
         if(this.getStata() == 0)
         {
            this._star.setValue(id);
         }
      }
      
      public function setHpTime() : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 42)
         {
            this._hpNum.setValue(this._hpNum.getValue() + 1);
         }
      }
      
      public function setMpTime() : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 43)
         {
            this._mpNum.setValue(this._mpNum.getValue() + 1);
         }
      }
      
      public function setGoodsNum() : *
      {
         if(this.getStata() == 0 && this.getSmallType() == 44)
         {
            this.getNumForBag();
         }
      }
      
      public function getNumForBag() : void
      {
         var type:Number = NaN;
         var id:Number = NaN;
         var gId:Array = this.getGoodsId();
         var gty:Array = this.getGoodsType();
         if(gId.length == 0 && gId[0].getValue() == -1)
         {
            return this.initGoodsTime();
         }
         for(var i:uint = 0; i < gId.length; i++)
         {
            type = Number(gty[i].getValue());
            id = Number(gId[i].getValue());
            this._goodsTime1[i] = this.getNumByType(Main.player1,id,type);
            if(Main.P1P2)
            {
               this._goodsTime2[i] = this.getNumByType(Main.player2,id,type);
            }
         }
      }
      
      private function getNumByType(player:PlayerData, id:Number, type:Number) : Number
      {
         var equip:Equip = null;
         var i:uint = 0;
         var supArr:Array = null;
         var s:Supplies = null;
         var gemArr:Array = null;
         var gem:Gem = null;
         var g:Gem = null;
         var othArr:Array = null;
         var oth:Otherobj = null;
         var ot:Otherobj = null;
         var taskArr:Array = null;
         var ts:Quest = null;
         var num:Number = 0;
         switch(type)
         {
            case 0:
               if(player.getBag().getEquipById(id) != null)
               {
                  num = Number(player.getBag().getEquipById(id)[0].length);
               }
               for(i = 0; i < 8; i++)
               {
                  if(player.getEquipSlot().getEquipFromSlot(i) != null)
                  {
                     equip = player.getEquipSlot().getEquipFromSlot(i);
                     if(id == equip.getId())
                     {
                        num++;
                     }
                  }
               }
               for(i = 0; i < 35; i++)
               {
                  if(StoragePanel.storage.getEquipFromStorage(i) != null)
                  {
                     equip = StoragePanel.storage.getEquipFromStorage(i);
                     if(id == equip.getId())
                     {
                        num++;
                     }
                  }
               }
               break;
            case 1:
               if(player.getBag().getSupById(id) != null)
               {
                  supArr = player.getBag().getSupById(id)[0];
                  for(i = 0; i < supArr.length; i++)
                  {
                     s = supArr[i];
                     num += s.getTimes();
                  }
               }
               break;
            case 2:
               if(player.getBag().getGemById(id) != null)
               {
                  gemArr = player.getBag().getGemById(id)[0];
                  gem = gemArr[0];
                  if(!gem.getIsPile())
                  {
                     num = gemArr.length;
                  }
                  else
                  {
                     for(i = 0; i < gemArr.length; i++)
                     {
                        gem = gemArr[i];
                        num += gem.getTimes();
                     }
                  }
               }
               for(i = 0; i < 35; i++)
               {
                  if(StoragePanel.storage.getGemFromStorage(i) != null)
                  {
                     g = StoragePanel.storage.getGemFromStorage(i);
                     if(id == g.getId())
                     {
                        if(g.getIsPile())
                        {
                           num += g.getTimes();
                        }
                        else
                        {
                           num++;
                        }
                     }
                  }
               }
               break;
            case 3:
               if(player.getBag().getOtherobjById(id) != null)
               {
                  othArr = player.getBag().getOtherobjById(id)[0];
                  oth = othArr[0];
                  if(!oth.isMany())
                  {
                     num = othArr.length;
                  }
                  else
                  {
                     for(i = 0; i < othArr.length; i++)
                     {
                        oth = othArr[i];
                        num += oth.getTimes();
                     }
                  }
               }
               for(i = 0; i < 35; i++)
               {
                  if(StoragePanel.storage.getOtherobjFromStorage(i) != null)
                  {
                     ot = StoragePanel.storage.getOtherobjFromStorage(i);
                     if(id == ot.getId())
                     {
                        if(!ot.isMany())
                        {
                           num++;
                        }
                        else
                        {
                           num += ot.getTimes();
                        }
                     }
                  }
               }
               break;
            case 4:
               if(player.getBag().getQuestById(id) != null)
               {
                  taskArr = player.getBag().getQuestById(id)[0];
                  ts = taskArr[0];
                  if(!ts.isMany())
                  {
                     num = taskArr.length;
                  }
                  else
                  {
                     for(i = 0; i < taskArr.length; i++)
                     {
                        ts = taskArr[i];
                        num += ts.getTimes();
                     }
                  }
               }
               else if(id == 84110)
               {
                  if(Main.getQuest(84110))
                  {
                     num++;
                  }
               }
               else if(id == 84111)
               {
                  if(Main.getQuest(84111))
                  {
                     num++;
                  }
               }
               else if(id == 84112)
               {
                  if(Main.getQuest(84112))
                  {
                     num++;
                  }
               }
               else if(id == 84113)
               {
                  if(Main.getQuest(84113))
                  {
                     num++;
                  }
               }
               else if(id == 84114)
               {
                  if(Main.getQuest(84114))
                  {
                     num++;
                  }
               }
         }
         return num;
      }
      
      public function setEnemyed(id:Number) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(this.getStata() == 0 && this.getSmallType() == 45)
         {
            arr = this.getGoodsId();
            if(arr[0].getValue() == -1)
            {
               if(this._enemyed.getValue() < this.getFinishNum())
               {
                  this._enemyed.setValue(this._enemyed.getValue() + 1);
               }
            }
            else if(this.getTs() == -1)
            {
               for(i = 0; i < arr.length; i++)
               {
                  if(id == arr[i].getValue())
                  {
                     if(this._enemyed.getValue() < this.getFinishNum())
                     {
                        this._enemyed.setValue(this._enemyed.getValue() + 1);
                        break;
                     }
                  }
               }
            }
            else if(this._map.getValue() == this.getTs())
            {
               for(i = 0; i < arr.length; i++)
               {
                  if(id == arr[i].getValue())
                  {
                     if(this._enemyed.getValue() < this.getFinishNum())
                     {
                        this._enemyed.setValue(this._enemyed.getValue() + 1);
                        break;
                     }
                  }
               }
            }
         }
      }
      
      public function setCs(num:Number) : void
      {
         if(this.getSmallType() == 33)
         {
            this._cs.setValue(num);
         }
      }
      
      public function getCsNum() : Number
      {
         return this._cs.getValue();
      }
      
      public function getTgCs() : Number
      {
         return this._tzTime.getValue();
      }
      
      public function getEnemyNum() : Number
      {
         return this._enemyed.getValue();
      }
      
      public function getGoodsNumed1() : Array
      {
         return this._goodsTime1;
      }
      
      public function getGoodsNumed2() : Array
      {
         return this._goodsTime2;
      }
      
      public function DuGoods(arr1:Array, arr2:Array) : void
      {
         this._goodsTime1 = arr1;
         this._goodsTime2 = arr2;
      }
      
      public function DutzTime(num:Number) : void
      {
         this._tzTime.setValue(num);
      }
      
      public function DuEnemy(num:Number) : void
      {
         this._enemyed.setValue(num);
      }
      
      public function getGoodsNum(type:Number = 1) : Number
      {
         var arr:Array = null;
         var i:uint = 0;
         var j:uint = 0;
         var num:Number = 0;
         if(type == 1)
         {
            arr = this._goodsTime1;
         }
         else if(type == 2)
         {
            arr = this._goodsTime2;
         }
         if(this.isRy())
         {
            for(i = 0; i < arr.length - 1; i++)
            {
               for(j = 1; j < arr.length; j++)
               {
                  if(arr[i] == arr[j])
                  {
                     num = Number(arr[i]);
                  }
               }
            }
         }
         else
         {
            for(i = 0; i < arr.length; i++)
            {
               num += arr[i];
            }
         }
         return num;
      }
      
      public function getEnemyed() : Number
      {
         return this._enemyed.getValue();
      }
      
      public function initSj() : void
      {
         this._tg = false;
         this._time.setValue(0);
         this._lianJi.setValue(0);
         this._baojiTime.setValue(0);
         this._miss.setValue(0);
         this._bettJi.setValue(0);
         this._ptSkill.setValue(0);
         this._skillTime.setValue(0);
         this._mpNum.setValue(0);
         this._hpNum.setValue(0);
      }
      
      public function clearAcData() : void
      {
         this.initSj();
         this._tzTime.setValue(0);
         this._enemyed.setValue(0);
         this._goodsTime1 = [];
         this._goodsTime2 = [];
      }
   }
}

