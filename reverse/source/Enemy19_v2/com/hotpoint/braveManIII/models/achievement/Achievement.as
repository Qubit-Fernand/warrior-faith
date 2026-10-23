package com.hotpoint.braveManIII.models.achievement
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.models.quest.Quest;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.achievement.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
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
         var num:Number = getGoodsId().length;
         for(var i:uint = 0; i < num; i++)
         {
            _goodsTime1[i] = 0;
            _goodsTime2[i] = 0;
         }
      }
      
      public function isOk() : Boolean
      {
         var type:Number = getSmallType();
         switch(type)
         {
            case 1:
               return playerlevelOk();
            case 2:
               return goldOk();
            case 5:
               return jsPointOk();
            case 7:
               return edAcOk();
            case 8:
               return gAcOk();
            case 9:
               return onLineTime();
            case 10:
               return AcNumOk();
            case 11:
               return cwNumOk();
            case 12:
               return skillNumOk();
            case 13:
               return xqOk();
            case 14:
               return zfOk();
            case 15:
               return makeOk();
            case 16:
               return hcOk();
            case 17:
               return getZxOk();
            case 18:
               return getRcOk();
            case 19:
               return getCwOk();
            case 20:
               return strOk();
            case 21:
               return strLostOk();
            case 22:
               return strNumXXOk();
            case 23:
               return strRyOk();
            case 24:
               return getCwlevelOk();
            case 25:
               return getCwJh();
            case 26:
               return getCwSkillOk();
            case 27:
               return getZzOk();
            case 28:
               return getSkillLevelOk();
            case 29:
               return getAllSkill();
            case 30:
               return GemColorOk();
            case 31:
               return getMapStarOk();
            case 32:
               return getMapIdOk();
            case 33:
               return getTzGkOk();
            case 34:
               return tgTimeOk();
            case 35:
               return tgByIdAndTimeOk();
            case 36:
               return getNoSkillOk();
            case 37:
               return getNoPtOk();
            case 38:
               return getBaoJiOk();
            case 39:
               return getMissOk();
            case 40:
               return getBetoK();
            case 41:
               return getLjOk();
            case 42:
               return getHpOk();
            case 43:
               return getMpOk();
            case 44:
               return goodsOk();
            case 45:
               return enemyOk();
            default:
               return;
         }
      }
      
      public function goodsOk() : Boolean
      {
         var b1:Boolean = false;
         var b2:Boolean = false;
         var i:uint = 0;
         var gId:Array = getGoodsId();
         var ts:Number = getFinishNum();
         if(gId[0].getValue() == -1)
         {
            return mdFunction();
         }
         if(!isRy())
         {
            return mdFunction();
         }
         b1 = true;
         b2 = true;
         for(i = 0; i < gId.length; i++)
         {
            if(_goodsTime1[i] < ts)
            {
               b1 = false;
            }
            if(Main.P1P2)
            {
               if(_goodsTime2[i] < ts)
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
      
      public function setMd(type:Number = 1, id:Number = 1, p:Number = 1, num:Number = 1) : void
      {
         var gId:Array = null;
         var i:uint = 0;
         if(getStata() == 0 && getSmallType() == 44)
         {
            if(type == getFs())
            {
               if(type != 1)
               {
                  gId = getGoodsId();
                  if(gId[0].getValue() == -1)
                  {
                     if(p == 1)
                     {
                        _goodsTime1[0] += num;
                     }
                     else if(p == 2)
                     {
                        _goodsTime2[0] += num;
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
                              _goodsTime1[i] += num;
                           }
                           else if(p == 2)
                           {
                              _goodsTime2[i] += num;
                           }
                           break;
                        }
                     }
                  }
               }
               else
               {
                  setGoodsNum();
               }
            }
         }
      }
      
      private function mdFunction() : Boolean
      {
         var ts:Number = getFinishNum();
         for(var i:uint = 0; i < _goodsTime1.length; i++)
         {
            if(_goodsTime1[i] >= ts)
            {
               return true;
            }
            if(Main.P1P2)
            {
               if(_goodsTime2[i] >= ts)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return AchNumFactory.getName(_id.getValue());
      }
      
      public function getFrame() : Number
      {
         return AchNumFactory.getFrame(_id.getValue());
      }
      
      public function getSm() : String
      {
         return AchNumFactory.getSm(_id.getValue());
      }
      
      public function isEveryDady() : Boolean
      {
         return AchNumFactory.isEveryDady(_id.getValue());
      }
      
      public function getType() : Number
      {
         return AchNumFactory.getType(_id.getValue());
      }
      
      public function getRewardAc() : Number
      {
         return AchNumFactory.getRewardAc(_id.getValue());
      }
      
      public function getStata() : Number
      {
         return _state.getValue();
      }
      
      public function setStata(num:Number) : void
      {
         _state.setValue(num);
      }
      
      public function getOverTimer() : Number
      {
         return _overTimer.getValue();
      }
      
      public function setOverTimer(t:Number) : void
      {
         _overTimer.setValue(t);
      }
      
      public function getSmallType() : Number
      {
         return AchNumFactory.getSmallType(_id.getValue());
      }
      
      public function getGoodsId() : Array
      {
         return AchNumFactory.getGoodId(_id.getValue());
      }
      
      public function getFinishNum() : Number
      {
         return AchNumFactory.getFinishNum(_id.getValue());
      }
      
      public function getTs() : Number
      {
         return AchNumFactory.getTs(_id.getValue());
      }
      
      public function isRy() : Boolean
      {
         return AchNumFactory.isRy(_id.getValue());
      }
      
      private function getFs() : Number
      {
         return AchNumFactory.getNeedType(_id.getValue());
      }
      
      private function getGoodsType() : Array
      {
         return AchNumFactory.getGoodsType(_id.getValue());
      }
      
      private function playerlevelOk() : Boolean
      {
         if(Main.player1.getLevel() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getLevel() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function goldOk() : Boolean
      {
         if(Main.player1.getGold() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getGold() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function playGoldOk() : Boolean
      {
         if(AchData.p1Gold.getValue() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.p2Gold.getValue() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function jsPointOk() : Boolean
      {
         if(Main.player1.getKillPoint() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player1.getKillPoint() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function payJsPointOk() : Boolean
      {
         if(AchData.payJs1.getValue() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.payjs2.getValue() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function edAcOk() : Boolean
      {
         if(AchData.cjPoint_1.getValue() >= getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function gAcOk() : Boolean
      {
         if(AchData.cjPoint_2.getValue() >= getFinishNum())
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
         if(AchData.getGaAcNum() > getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function cwNumOk() : Boolean
      {
         if(Main.player1.getPetSlot().backPetNum() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getPetSlot().backPetNum() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function skillNumOk() : Boolean
      {
         if(Main.player1.getSkillNum() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getSkillNum() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function xqOk() : Boolean
      {
         if(AchData.xq1.getValue() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.xq2.getValue() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function zfOk() : Boolean
      {
         if(AchData.zf1.getValue() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.zf2.getValue() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function hcOk() : Boolean
      {
         if(AchData.hc1.getValue() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.hc2.getValue() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function makeOk() : Boolean
      {
         if(AchData.m1.getValue() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.m2.getValue() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function strOk() : Boolean
      {
         if(AchData.strOk1.getValue() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.strok2.getValue() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function strLostOk() : Boolean
      {
         if(AchData.strLost1.getValue() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(AchData.strLost2.getValue() >= getFinishNum())
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
         num = getStrEquipNum(Main.player1);
         if(Main.P1P2)
         {
            num2 = getStrEquipNum(Main.player2);
         }
         if(num >= getFinishNum() || num2 >= getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function strRyOk() : Boolean
      {
         if(Main.player1.getEquipSlot().getSuitStrength() >= getFinishNum())
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player2.getEquipSlot().getSuitStrength() >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function getZxOk() : Boolean
      {
         if(NpcListData.getZxInOld() >= getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function getRcOk() : Boolean
      {
         if(AchData.rcTask.getValue() >= getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function getCwlevelOk() : Boolean
      {
         if(getCwMaxLeve() >= getFinishNum())
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
      
      private function getCwOk() : Boolean
      {
         if(NpcListData.getCwInOld() >= getFinishNum())
         {
            return true;
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
            if(arr[i][1] >= getFinishNum())
            {
               return true;
            }
         }
         if(Main.P1P2)
         {
            arr = Main.player2.getSkillArr();
            for(i = 7; i < arr.length; i++)
            {
               if(arr[i][1] >= getFinishNum())
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function getAllSkill() : Boolean
      {
         if(getSkillxx(Main.player1))
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(getSkillxx(Main.player2))
            {
               return true;
            }
         }
         return false;
      }
      
      private function GemColorOk() : Boolean
      {
         if(getGemColor(Main.player1))
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(getGemColor(Main.player2))
            {
               return true;
            }
         }
         return false;
      }
      
      private function getMapStarOk() : Boolean
      {
         if(getGkStar() >= getFinishNum())
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
            if(Main.guanKa[i] >= getTs())
            {
               num++;
            }
         }
         return num;
      }
      
      private function getMapIdOk() : Boolean
      {
         var mapId:Number = Number((getGoodsId() as Array)[0].getValue());
         if(Main.guanKa[mapId] > 0)
         {
            return true;
         }
         return false;
      }
      
      private function getTzGkOk() : Boolean
      {
         if(_tzTime.getValue() >= getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function tgTimeOk() : Boolean
      {
         if(AchData.tgTime.getValue() >= getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      private function tgByIdAndTimeOk() : Boolean
      {
         return getIddo(_time.getValue());
      }
      
      private function getNoPtOk() : Boolean
      {
         return getIddo(_ptSkill.getValue());
      }
      
      private function getNoSkillOk() : Boolean
      {
         return getIddo(_skillTime.getValue());
      }
      
      private function getIddo(duNum:Number, type:Number = 1) : Boolean
      {
         var i:uint = 0;
         var nmapId:Array = getGoodsId() as Array;
         var nstr:Number = getTs();
         if(nmapId.length != 1)
         {
            i = 0;
            while(true)
            {
               if(i < nmapId.length)
               {
                  if(nmapId[i].getValue() == _map.getValue())
                  {
                     if(nstr == _star.getValue())
                     {
                        if(isRy())
                        {
                           break;
                        }
                        if(_tg)
                        {
                           return dbNum(type,duNum);
                        }
                     }
                  }
                  continue;
               }
               i++;
            }
            return dbNum(type,duNum);
         }
         if(nmapId[0].getValue() == -1)
         {
            if(nstr == _star.getValue())
            {
               if(isRy())
               {
                  return dbNum(type,duNum);
               }
               if(_tg)
               {
                  return dbNum(type,duNum);
               }
            }
         }
         else if(nmapId[0].getValue() == _map.getValue() && nstr == _star.getValue())
         {
            if(isRy())
            {
               return dbNum(type,duNum);
            }
            if(_tg)
            {
               return dbNum(type,duNum);
            }
         }
         return false;
      }
      
      private function dbNum(type:Number, duNum:Number) : Boolean
      {
         if(type == 1)
         {
            if(duNum <= getFinishNum())
            {
               return true;
            }
         }
         else if(type == 2)
         {
            if(duNum >= getFinishNum())
            {
               return true;
            }
         }
         return false;
      }
      
      private function getBaoJiOk() : Boolean
      {
         return getIddo(_baojiTime.getValue(),2);
      }
      
      private function getMissOk() : Boolean
      {
         return getIddo(_miss.getValue(),2);
      }
      
      private function getLjOk() : Boolean
      {
         return getIddo(_lianJi.getValue(),2);
      }
      
      private function getBetoK() : Boolean
      {
         return getIddo(_bettJi.getValue());
      }
      
      private function getHpOk() : Boolean
      {
         return getIddo(_hpNum.getValue());
      }
      
      private function getMpOk() : Boolean
      {
         return getIddo(_mpNum.getValue());
      }
      
      private function enemyOk() : Boolean
      {
         if(_enemyed.getValue() >= getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      public function setTg() : void
      {
         if(getStata() == 0)
         {
            _tg = true;
         }
      }
      
      public function setLj(num:Number) : void
      {
         if(getStata() == 0 && getSmallType() == 41)
         {
            _lianJi.setValue(num);
         }
      }
      
      public function setBj(num:Number) : void
      {
         if(getStata() == 0 && getSmallType() == 40)
         {
            _bettJi.setValue(num);
         }
      }
      
      public function setMiss() : void
      {
         if(getStata() == 0 && getSmallType() == 39)
         {
            _miss.setValue(_miss.getValue() + 1);
         }
      }
      
      public function setPtSkillTime() : void
      {
         if(getStata() == 0 && getSmallType() == 37)
         {
            _ptSkill.setValue(_ptSkill.getValue() + 1);
         }
      }
      
      public function setSkillTime() : void
      {
         if(getStata() == 0 && getSmallType() == 36)
         {
            _skillTime.setValue(_skillTime.getValue() + 1);
         }
      }
      
      public function setBaojiTime() : void
      {
         if(getStata() == 0 && getSmallType() == 38)
         {
            _baojiTime.setValue(_baojiTime.getValue() + 1);
         }
      }
      
      public function setTimeTg(num:Number) : void
      {
         if(getStata() == 0 && getSmallType() == 35)
         {
            _time.setValue(num);
         }
      }
      
      public function setTzGkTime() : void
      {
         if(getStata() == 0 && getSmallType() == 33)
         {
            if((getGoodsId() as Array)[0].getValue() == _map.getValue() && _cs.getValue() == getTs() + 1)
            {
               _tzTime.setValue(_tzTime.getValue() + 1);
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
            if(gem.getColor() < getFinishNum())
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
               if(equip.getReinforceLevel() >= getTs())
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
               if(equip.getReinforceLevel() >= getTs())
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
               if(equip.getReinforceLevel() >= getTs())
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
         if(getStata() == 0 && id != 0)
         {
            _map.setValue(id);
         }
      }
      
      public function setStarId(id:Number) : void
      {
         if(getStata() == 0)
         {
            _star.setValue(id);
         }
      }
      
      public function setHpTime() : void
      {
         if(getStata() == 0 && getSmallType() == 42)
         {
            _hpNum.setValue(_hpNum.getValue() + 1);
         }
      }
      
      public function setMpTime() : void
      {
         if(getStata() == 0 && getSmallType() == 43)
         {
            _mpNum.setValue(_mpNum.getValue() + 1);
         }
      }
      
      public function setGoodsNum() : *
      {
         if(getStata() == 0 && getSmallType() == 44)
         {
            getNumForBag();
         }
      }
      
      public function getNumForBag() : void
      {
         var type:Number = NaN;
         var id:Number = NaN;
         var gId:Array = getGoodsId();
         var gty:Array = getGoodsType();
         if(gId.length == 0 && gId[0].getValue() == -1)
         {
            return initGoodsTime();
         }
         for(var i:uint = 0; i < gId.length; i++)
         {
            type = Number(gty[i].getValue());
            id = Number(gId[i].getValue());
            _goodsTime1[i] = getNumByType(Main.player1,id,type);
            if(Main.P1P2)
            {
               _goodsTime2[i] = getNumByType(Main.player2,id,type);
            }
         }
      }
      
      private function getNumByType(player:PlayerData, id:Number, type:Number) : Number
      {
         var supArr:Array = null;
         var i:uint = 0;
         var s:Supplies = null;
         var gemArr:Array = null;
         var gem:Gem = null;
         var othArr:Array = null;
         var oth:Otherobj = null;
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
               else if(id == 41100)
               {
                  if(Main.getQuest(41100))
                  {
                     num++;
                  }
               }
               else if(id == 41101)
               {
                  if(Main.getQuest(41101))
                  {
                     num++;
                  }
               }
               else if(id == 41102)
               {
                  if(Main.getQuest(41102))
                  {
                     num++;
                  }
               }
               else if(id == 41103)
               {
                  if(Main.getQuest(41103))
                  {
                     num++;
                  }
               }
               else if(id == 41104)
               {
                  if(Main.getQuest(41104))
                  {
                     num++;
                  }
               }
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
         }
         return num;
      }
      
      public function setEnemyed(id:Number) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(getStata() == 0 && getSmallType() == 45)
         {
            arr = getGoodsId();
            if(arr[0].getValue() == -1)
            {
               if(_enemyed.getValue() < getFinishNum())
               {
                  _enemyed.setValue(_enemyed.getValue() + 1);
               }
            }
            else if(getTs() == -1)
            {
               for(i = 0; i < arr.length; i++)
               {
                  if(id == arr[i].getValue())
                  {
                     if(_enemyed.getValue() < getFinishNum())
                     {
                        _enemyed.setValue(_enemyed.getValue() + 1);
                        break;
                     }
                  }
               }
            }
            else if(_map.getValue() == getTs())
            {
               for(i = 0; i < arr.length; i++)
               {
                  if(id == arr[i].getValue())
                  {
                     if(_enemyed.getValue() < getFinishNum())
                     {
                        _enemyed.setValue(_enemyed.getValue() + 1);
                        break;
                     }
                  }
               }
            }
         }
      }
      
      public function setCs(num:Number) : void
      {
         if(getSmallType() == 33)
         {
            _cs.setValue(num);
         }
      }
      
      public function getCsNum() : Number
      {
         return _cs.getValue();
      }
      
      public function getTgCs() : Number
      {
         return _tzTime.getValue();
      }
      
      public function getEnemyNum() : Number
      {
         return _enemyed.getValue();
      }
      
      public function getGoodsNumed1() : Array
      {
         return _goodsTime1;
      }
      
      public function getGoodsNumed2() : Array
      {
         return _goodsTime2;
      }
      
      public function DuGoods(arr1:Array, arr2:Array) : void
      {
         _goodsTime1 = arr1;
         _goodsTime2 = arr2;
      }
      
      public function DutzTime(num:Number) : void
      {
         _tzTime.setValue(num);
      }
      
      public function DuEnemy(num:Number) : void
      {
         _enemyed.setValue(num);
      }
      
      public function getGoodsNum(type:Number = 1) : Number
      {
         var arr:Array = null;
         var i:uint = 0;
         var j:uint = 0;
         var xxx:Array = null;
         var num:Number = 0;
         if(type == 1)
         {
            arr = _goodsTime1;
         }
         else if(type == 2)
         {
            arr = _goodsTime2;
         }
         if(isRy())
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
            xxx = DeepCopyUtil.clone(arr);
            xxx.sort(Array.NUMERIC);
            num = Number(xxx[arr.length - 1]);
         }
         return num;
      }
      
      public function getEnemyed() : Number
      {
         return _enemyed.getValue();
      }
      
      public function initSj() : void
      {
         _tg = false;
         _time.setValue(0);
         _lianJi.setValue(0);
         _baojiTime.setValue(0);
         _miss.setValue(0);
         _bettJi.setValue(0);
         _ptSkill.setValue(0);
         _skillTime.setValue(0);
         _mpNum.setValue(0);
         _hpNum.setValue(0);
      }
      
      public function clearAcData() : void
      {
         initSj();
         _tzTime.setValue(0);
         _enemyed.setValue(0);
         _goodsTime1 = [];
         _goodsTime2 = [];
      }
   }
}

