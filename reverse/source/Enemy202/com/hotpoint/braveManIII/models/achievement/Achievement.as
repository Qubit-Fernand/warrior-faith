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
      
      public static function creatAchForNum(param1:Number) : Achievement
      {
         var _loc2_:Achievement = new Achievement();
         _loc2_._id = VT.createVT(param1);
         _loc2_._tzTime = VT.createVT();
         _loc2_._time = VT.createVT();
         _loc2_._skillTime = VT.createVT();
         _loc2_._ptSkill = VT.createVT();
         _loc2_._tg = false;
         _loc2_._baojiTime = VT.createVT();
         _loc2_._miss = VT.createVT();
         _loc2_._lianJi = VT.createVT();
         _loc2_._bettJi = VT.createVT();
         _loc2_._map = VT.createVT();
         _loc2_._star = VT.createVT();
         _loc2_._hpNum = VT.createVT();
         _loc2_._mpNum = VT.createVT();
         _loc2_.initGoodsTime();
         _loc2_._enemyed = VT.createVT();
         _loc2_._state = VT.createVT(0);
         _loc2_._overTimer = VT.createVT(0);
         _loc2_._cs = VT.createVT();
         return _loc2_;
      }
      
      private function initGoodsTime() : void
      {
         var _loc1_:Number = this.getGoodsId().length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            this._goodsTime1[_loc2_] = 0;
            this._goodsTime2[_loc2_] = 0;
            _loc2_++;
         }
      }
      
      public function isOk() : Boolean
      {
         var _loc1_:Number = this.getSmallType();
         switch(_loc1_)
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
            case 19:
               return this.getCwOk();
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
            default:
               return;
         }
      }
      
      public function goodsOk() : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc1_:Array = this.getGoodsId();
         var _loc2_:Number = this.getFinishNum();
         if(_loc1_[0].getValue() == -1)
         {
            return this.mdFunction();
         }
         if(!this.isRy())
         {
            trace("不是同时");
            return this.mdFunction();
         }
         trace("同时");
         _loc3_ = true;
         _loc4_ = true;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            if(this._goodsTime1[_loc5_] < _loc2_)
            {
               _loc3_ = false;
            }
            if(Main.P1P2)
            {
               if(this._goodsTime2[_loc5_] < _loc2_)
               {
                  _loc4_ = false;
               }
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(_loc4_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setMd(param1:Number = 1, param2:Number = 1, param3:Number = 1, param4:Number = 0) : void
      {
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         if(this.getStata() == 0 && this.getSmallType() == 44)
         {
            trace(param1,this.getFs() + "获取方式");
            if(param1 == this.getFs())
            {
               if(param1 != 1)
               {
                  this.getNumForBag();
                  _loc5_ = this.getGoodsId();
                  if(_loc5_[0].getValue() == -1)
                  {
                     if(param3 == 1)
                     {
                        this._goodsTime1[0] += param4;
                     }
                     else if(param3 == 2)
                     {
                        this._goodsTime2[0] += param4;
                     }
                  }
                  else
                  {
                     _loc6_ = 0;
                     while(_loc6_ < _loc5_.length)
                     {
                        if(_loc5_[_loc6_].getValue() == param2)
                        {
                           trace("位置:" + _loc6_);
                           if(param3 == 1)
                           {
                              this._goodsTime1[_loc6_] += param4;
                              trace("_goodsTime1[i]",this._goodsTime1[_loc6_]);
                           }
                           else if(param3 == 2)
                           {
                              this._goodsTime2[_loc6_] += param4;
                           }
                           break;
                        }
                        _loc6_++;
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
         var _loc1_:Number = this.getFinishNum();
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < this._goodsTime1.length)
         {
            _loc2_ += this._goodsTime1[_loc4_];
            if(Main.P1P2)
            {
               _loc3_ += this._goodsTime2[_loc4_];
            }
            _loc4_++;
         }
         if(_loc2_ >= _loc1_)
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(_loc3_ >= _loc1_)
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
      
      public function setStata(param1:Number) : void
      {
         this._state.setValue(param1);
      }
      
      public function getOverTimer() : Number
      {
         return this._overTimer.getValue();
      }
      
      public function setOverTimer(param1:Number) : void
      {
         this._overTimer.setValue(param1);
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
         trace("角色等级:",Main.player1.getLevel(),this.getFinishNum());
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
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         _loc1_ = this.getStrEquipNum(Main.player1);
         if(Main.P1P2)
         {
            _loc2_ = this.getStrEquipNum(Main.player2);
         }
         if(_loc1_ >= this.getFinishNum() || _loc2_ >= this.getFinishNum())
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
         if(NpcListData.getZxInOld() >= this.getFinishNum())
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
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < 3)
         {
            if(Main.player1.getPetSlot().getPetFromSlot(_loc5_) != null)
            {
               _loc1_.push(Main.player1.getPetSlot().getPetFromSlot(_loc5_).getLv());
            }
            _loc5_++;
         }
         if(_loc1_.length != 0)
         {
            _loc1_.sort(Array.NUMERIC);
            _loc3_ = Number(_loc1_[_loc1_.length - 1]);
         }
         if(Main.P1P2)
         {
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               if(Main.player2.getPetSlot().getPetFromSlot(_loc5_) != null)
               {
                  _loc2_.push(Main.player2.getPetSlot().getPetFromSlot(_loc5_).getLv());
               }
               _loc5_++;
            }
            if(_loc2_.length != 0)
            {
               _loc2_.sort(Array.NUMERIC);
               _loc4_ = Number(_loc2_[_loc2_.length - 1]);
            }
         }
         if(_loc4_ >= _loc3_)
         {
            return _loc4_;
         }
         return _loc3_;
      }
      
      private function getCwJh() : Boolean
      {
      }
      
      private function getCwSkillOk() : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc1_:Number = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = 0;
            if(Main.player1.getPetSlot().getPetFromSlot(_loc2_) != null)
            {
               _loc3_ = Main.player1.getPetSlot().getPetFromSlot(_loc2_).getPetSkill();
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  if(_loc3_[_loc4_] > 0)
                  {
                     _loc1_++;
                  }
                  _loc4_++;
               }
               if(_loc1_ == 4)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         if(Main.P1P2)
         {
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc1_ = 0;
               if(Main.player2.getPetSlot().getPetFromSlot(_loc2_) != null)
               {
                  _loc5_ = Main.player2.getPetSlot().getPetFromSlot(_loc2_).getPetSkill();
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_.length)
                  {
                     if(_loc5_[_loc4_] > 0)
                     {
                        _loc1_++;
                     }
                     _loc4_++;
                  }
                  if(_loc1_ == 4)
                  {
                     return true;
                  }
               }
               _loc2_++;
            }
         }
         return false;
      }
      
      private function getCwOk() : Boolean
      {
         if(NpcListData.getCwInOld() >= this.getFinishNum())
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
         var _loc2_:uint = 0;
         var _loc1_:Array = [];
         _loc1_ = Main.player1.getSkillArr();
         _loc2_ = 7;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_][1] >= this.getFinishNum())
            {
               return true;
            }
            _loc2_++;
         }
         if(Main.P1P2)
         {
            _loc1_ = Main.player2.getSkillArr();
            _loc2_ = 7;
            while(_loc2_ < _loc1_.length)
            {
               if(_loc1_[_loc2_][1] >= this.getFinishNum())
               {
                  return true;
               }
               _loc2_++;
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
         trace("当前开启的" + this.getTs() + "星级" + this.getGkStar() + "个");
         if(this.getGkStar() >= this.getFinishNum())
         {
            return true;
         }
         return false;
      }
      
      public function getGkStar() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= 16)
         {
            if(Main.guanKa[_loc2_] >= this.getTs())
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function getMapIdOk() : Boolean
      {
         var _loc1_:Number = Number((this.getGoodsId() as Array)[0].getValue());
         trace("指定的地图ID_:" + _loc1_);
         trace(Main.guanKa[_loc1_]);
         if(Main.guanKa[_loc1_] > 0)
         {
            trace("开启");
            return true;
         }
         trace("未开启");
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
      
      private function getIddo(param1:Number, param2:Number = 1) : Boolean
      {
         var _loc5_:uint = 0;
         var _loc3_:Array = this.getGoodsId() as Array;
         var _loc4_:Number = this.getTs();
         if(_loc3_.length != 1)
         {
            trace("有多个指定地图");
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               if(_loc3_[_loc5_].getValue() == this._map.getValue())
               {
                  if(_loc4_ == this._star.getValue())
                  {
                     if(this.isRy())
                     {
                        return this.dbNum(param2,param1);
                     }
                     if(this._tg)
                     {
                        return this.dbNum(param2,param1);
                     }
                  }
               }
               _loc5_++;
            }
            return false;
         }
         if(_loc3_[0].getValue() == -1)
         {
            trace("没有地图要求");
            if(_loc4_ == -1)
            {
               if(this.isRy())
               {
                  trace("无通关要求");
                  return this.dbNum(param2,param1);
               }
               trace("通关要求YES",this._tg);
               if(this._tg)
               {
                  return this.dbNum(param2,param1);
               }
            }
            else if(_loc4_ == this._star.getValue())
            {
               if(this.isRy())
               {
                  trace("无通关要求");
                  return this.dbNum(param2,param1);
               }
               trace("通关要求YES",this._tg);
               if(this._tg)
               {
                  return this.dbNum(param2,param1);
               }
            }
         }
         else
         {
            trace("有指定地图1个");
            trace("地图要求:" + _loc3_[0].getValue(),"现在的地图:" + this._map.getValue(),"星级要求:" + _loc4_,"现在的星级:" + this._star.getValue());
            if(_loc3_[0].getValue() == this._map.getValue() && _loc4_ == this._star.getValue())
            {
               if(this.isRy())
               {
                  trace("无通关要求");
                  return this.dbNum(param2,param1);
               }
               trace("通关要求YES",this._tg);
               if(this._tg)
               {
                  return this.dbNum(param2,param1);
               }
            }
         }
         return false;
      }
      
      private function dbNum(param1:Number, param2:Number) : Boolean
      {
         trace("数据要求:" + this.getFinishNum(),"现在的数据:" + param2);
         if(param1 == 1)
         {
            if(param2 <= this.getFinishNum())
            {
               trace(this.getName() + "通关");
               return true;
            }
         }
         else if(param1 == 2)
         {
            if(param2 >= this.getFinishNum())
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
      
      public function setLj(param1:Number) : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 41)
         {
            this._lianJi.setValue(param1);
         }
      }
      
      public function setBj(param1:Number) : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 40)
         {
            this._bettJi.setValue(param1);
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
      
      public function setTimeTg(param1:Number) : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 35)
         {
            this._time.setValue(param1);
         }
      }
      
      public function setTzGkTime() : void
      {
         if(this.getStata() == 0 && this.getSmallType() == 33)
         {
            trace("要求关卡:" + (this.getGoodsId() as Array)[0].getValue(),"现在关卡:" + this._map.getValue(),"要求层数:" + this.getTs(),"现在层数:" + this._cs.getValue());
            if((this.getGoodsId() as Array)[0].getValue() == this._map.getValue() && this._cs.getValue() == this.getTs() + 1)
            {
               this._tzTime.setValue(this._tzTime.getValue() + 1);
            }
         }
      }
      
      public function getGemColor(param1:PlayerData) : Boolean
      {
         var _loc3_:Equip = null;
         var _loc4_:Gem = null;
         var _loc2_:uint = 0;
         while(_loc2_ < 8)
         {
            if(param1.getEquipSlot().getEquipFromSlot(_loc2_) == null)
            {
               return false;
            }
            _loc3_ = param1.getEquipSlot().getEquipFromSlot(_loc2_);
            if(_loc3_.getGrid() != 0)
            {
               return false;
            }
            _loc4_ = _loc3_.getGemSlot();
            if(_loc4_.getColor() < this.getFinishNum())
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function getSkillxx(param1:PlayerData) : Boolean
      {
         var _loc8_:uint = 0;
         var _loc2_:Array = ["a8","a9","a10","a11","a12","a13","a14","a15"];
         var _loc3_:Array = ["b8","b9","b10","b11","b12","b13","b14","b15"];
         var _loc4_:Array = ["c8","c9","c10","c11","c12","c13","c14","c15"];
         var _loc5_:Array = [0,0,0];
         var _loc6_:Array = param1.getSkillArr();
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc8_ = 0;
            while(_loc8_ < 8)
            {
               if(_loc6_[_loc7_][0] == _loc2_[_loc8_])
               {
                  if(_loc6_[_loc7_][1] < 1)
                  {
                     _loc5_[0] = 1;
                  }
               }
               if(_loc6_[_loc7_][0] == _loc3_[_loc8_])
               {
                  if(_loc6_[_loc7_][1] < 1)
                  {
                     _loc5_[1] = 1;
                  }
               }
               if(_loc6_[_loc7_][0] == _loc4_[_loc8_])
               {
                  if(_loc6_[_loc7_][1] < 1)
                  {
                     _loc5_[2] = 1;
                  }
               }
               _loc8_++;
            }
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            if(_loc5_[_loc7_] == 0)
            {
               return true;
            }
            _loc7_++;
         }
         return false;
      }
      
      public function getStrEquipNum(param1:PlayerData) : Number
      {
         var _loc3_:Equip = null;
         var _loc2_:Number = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            if(param1.getEquipSlot().getEquipFromSlot(_loc4_) != null)
            {
               _loc3_ = param1.getEquipSlot().getEquipFromSlot(_loc4_);
               if(_loc3_.getReinforceLevel() >= this.getTs())
               {
                  _loc2_++;
                  break;
               }
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 24)
         {
            if(param1.getBag().getEquipFromBag(_loc4_) != null)
            {
               _loc3_ = param1.getBag().getEquipFromBag(_loc4_);
               if(_loc3_.getReinforceLevel() >= this.getTs())
               {
                  _loc2_++;
                  break;
               }
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 35)
         {
            if(StoragePanel.storage.getEquipFromStorage(_loc4_) != null)
            {
               _loc3_ = StoragePanel.storage.getEquipFromStorage(_loc4_);
               if(_loc3_.getReinforceLevel() >= this.getTs())
               {
                  _loc2_++;
                  break;
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function setMapId(param1:Number) : void
      {
         if(this.getStata() == 0 && param1 != 0)
         {
            this._map.setValue(param1);
         }
      }
      
      public function setStarId(param1:Number) : void
      {
         if(this.getStata() == 0)
         {
            this._star.setValue(param1);
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
            trace("判断背包有没_______________");
            this.getNumForBag();
         }
      }
      
      public function getNumForBag() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:Array = this.getGoodsId();
         var _loc2_:Array = this.getGoodsType();
         if(_loc1_.length == 0 && _loc1_[0].getValue() == -1)
         {
            return this.initGoodsTime();
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = Number(_loc2_[_loc3_].getValue());
            _loc5_ = Number(_loc1_[_loc3_].getValue());
            this._goodsTime1[_loc3_] = this.getNumByType(Main.player1,_loc5_,_loc4_);
            if(Main.P1P2)
            {
               this._goodsTime2[_loc3_] = this.getNumByType(Main.player2,_loc5_,_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function getNumByType(param1:PlayerData, param2:Number, param3:Number) : Number
      {
         var _loc5_:Equip = null;
         var _loc6_:uint = 0;
         var _loc7_:Array = null;
         var _loc8_:Supplies = null;
         var _loc9_:Array = null;
         var _loc10_:Gem = null;
         var _loc11_:Gem = null;
         var _loc12_:Array = null;
         var _loc13_:Otherobj = null;
         var _loc14_:Otherobj = null;
         var _loc15_:Array = null;
         var _loc16_:Quest = null;
         var _loc4_:Number = 0;
         switch(param3)
         {
            case 0:
               if(param1.getBag().getEquipById(param2) != null)
               {
                  _loc4_ = Number(param1.getBag().getEquipById(param2)[0].length);
                  trace("背包数量__________________",_loc4_);
               }
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(param1.getEquipSlot().getEquipFromSlot(_loc6_) != null)
                  {
                     _loc5_ = param1.getEquipSlot().getEquipFromSlot(_loc6_);
                     if(param2 == _loc5_.getId())
                     {
                        _loc4_++;
                     }
                  }
                  _loc6_++;
               }
               trace("身上数量+++++++++++++++++",_loc4_);
               _loc6_ = 0;
               while(_loc6_ < 35)
               {
                  if(StoragePanel.storage.getEquipFromStorage(_loc6_) != null)
                  {
                     _loc5_ = StoragePanel.storage.getEquipFromStorage(_loc6_);
                     if(param2 == _loc5_.getId())
                     {
                        _loc4_++;
                     }
                  }
                  _loc6_++;
               }
               trace("仓库数量__________________",_loc4_);
               break;
            case 1:
               if(param1.getBag().getSupById(param2) != null)
               {
                  _loc7_ = param1.getBag().getSupById(param2)[0];
                  _loc6_ = 0;
                  while(_loc6_ < _loc7_.length)
                  {
                     _loc8_ = _loc7_[_loc6_];
                     _loc4_ += _loc8_.getTimes();
                     _loc6_++;
                  }
               }
               break;
            case 2:
               if(param1.getBag().getGemById(param2) != null)
               {
                  _loc9_ = param1.getBag().getGemById(param2)[0];
                  _loc10_ = _loc9_[0];
                  if(!_loc10_.getIsPile())
                  {
                     _loc4_ = _loc9_.length;
                  }
                  else
                  {
                     _loc6_ = 0;
                     while(_loc6_ < _loc9_.length)
                     {
                        _loc10_ = _loc9_[_loc6_];
                        _loc4_ += _loc10_.getTimes();
                        _loc6_++;
                     }
                  }
               }
               _loc6_ = 0;
               while(_loc6_ < 35)
               {
                  if(StoragePanel.storage.getGemFromStorage(_loc6_) != null)
                  {
                     _loc11_ = StoragePanel.storage.getGemFromStorage(_loc6_);
                     if(param2 == _loc11_.getId())
                     {
                        if(_loc11_.getIsPile())
                        {
                           _loc4_ += _loc11_.getTimes();
                        }
                        else
                        {
                           _loc4_++;
                        }
                     }
                  }
                  _loc6_++;
               }
               break;
            case 3:
               if(param1.getBag().getOtherobjById(param2) != null)
               {
                  _loc12_ = param1.getBag().getOtherobjById(param2)[0];
                  _loc13_ = _loc12_[0];
                  if(!_loc13_.isMany())
                  {
                     _loc4_ = _loc12_.length;
                  }
                  else
                  {
                     _loc6_ = 0;
                     while(_loc6_ < _loc12_.length)
                     {
                        _loc13_ = _loc12_[_loc6_];
                        _loc4_ += _loc13_.getTimes();
                        _loc6_++;
                     }
                  }
               }
               _loc6_ = 0;
               while(_loc6_ < 35)
               {
                  if(StoragePanel.storage.getOtherobjFromStorage(_loc6_) != null)
                  {
                     _loc14_ = StoragePanel.storage.getOtherobjFromStorage(_loc6_);
                     if(param2 == _loc14_.getId())
                     {
                        if(!_loc14_.isMany())
                        {
                           _loc4_++;
                        }
                        else
                        {
                           _loc4_ += _loc14_.getTimes();
                        }
                     }
                  }
                  _loc6_++;
               }
               break;
            case 4:
               if(param1.getBag().getQuestById(param2) != null)
               {
                  _loc15_ = param1.getBag().getQuestById(param2)[0];
                  _loc16_ = _loc15_[0];
                  if(!_loc16_.isMany())
                  {
                     _loc4_ = _loc15_.length;
                  }
                  else
                  {
                     _loc6_ = 0;
                     while(_loc6_ < _loc15_.length)
                     {
                        _loc16_ = _loc15_[_loc6_];
                        _loc4_ += _loc16_.getTimes();
                        _loc6_++;
                     }
                  }
               }
               else if(param2 == 84110)
               {
                  if(Main.getQuest(84110))
                  {
                     _loc4_++;
                  }
               }
               else if(param2 == 84111)
               {
                  if(Main.getQuest(84111))
                  {
                     _loc4_++;
                  }
               }
               else if(param2 == 84112)
               {
                  if(Main.getQuest(84112))
                  {
                     _loc4_++;
                  }
               }
               else if(param2 == 84113)
               {
                  if(Main.getQuest(84113))
                  {
                     _loc4_++;
                  }
               }
               else if(param2 == 84114)
               {
                  if(Main.getQuest(84114))
                  {
                     _loc4_++;
                  }
               }
         }
         return _loc4_;
      }
      
      public function setEnemyed(param1:Number) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         if(this.getStata() == 0 && this.getSmallType() == 45)
         {
            _loc2_ = this.getGoodsId();
            if(_loc2_[0].getValue() == -1)
            {
               if(this._enemyed.getValue() < this.getFinishNum())
               {
                  this._enemyed.setValue(this._enemyed.getValue() + 1);
               }
            }
            else if(this.getTs() == -1)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  if(param1 == _loc2_[_loc3_].getValue())
                  {
                     if(this._enemyed.getValue() < this.getFinishNum())
                     {
                        this._enemyed.setValue(this._enemyed.getValue() + 1);
                        break;
                     }
                  }
                  _loc3_++;
               }
            }
            else if(this._map.getValue() == this.getTs())
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  if(param1 == _loc2_[_loc3_].getValue())
                  {
                     if(this._enemyed.getValue() < this.getFinishNum())
                     {
                        this._enemyed.setValue(this._enemyed.getValue() + 1);
                        break;
                     }
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      public function setCs(param1:Number) : void
      {
         if(this.getSmallType() == 33)
         {
            this._cs.setValue(param1);
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
      
      public function DuGoods(param1:Array, param2:Array) : void
      {
         this._goodsTime1 = param1;
         this._goodsTime2 = param2;
      }
      
      public function DutzTime(param1:Number) : void
      {
         this._tzTime.setValue(param1);
      }
      
      public function DuEnemy(param1:Number) : void
      {
         this._enemyed.setValue(param1);
      }
      
      public function getGoodsNum(param1:Number = 1) : Number
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc2_:Number = 0;
         if(param1 == 1)
         {
            _loc3_ = this._goodsTime1;
         }
         else if(param1 == 2)
         {
            _loc3_ = this._goodsTime2;
         }
         if(this.isRy())
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length - 1)
            {
               _loc5_ = 1;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc3_[_loc4_] == _loc3_[_loc5_])
                  {
                     _loc2_ = Number(_loc3_[_loc4_]);
                  }
                  _loc5_++;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ += _loc3_[_loc4_];
               _loc4_++;
            }
         }
         return _loc2_;
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

