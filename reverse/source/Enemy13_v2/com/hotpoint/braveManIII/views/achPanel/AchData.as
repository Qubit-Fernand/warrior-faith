package com.hotpoint.braveManIII.views.achPanel
{
   import com.hotpoint.braveManIII.models.achievement.Achievement;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.achievement.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import src.*;
   
   public class AchData
   {
      
      public static var allDataArr:Array = [];
      
      public static var xxx:Array = [];
      
      public static var everyAll:Array = [];
      
      public static var everyNoAll:Array = [];
      
      public static var gameAll:Array = [];
      
      public static var gameNoAll:Array = [];
      
      public static var edArr:Array = [];
      
      public static var gaArr:Array = [];
      
      public static var cjPointSave:Array = new Array();
      
      public static var cjPoint_1:VT = VT.createVT();
      
      public static var cjPoint_2:VT = VT.createVT();
      
      public static var cjPoint_RiQi:VT = VT.createVT();
      
      public static var xq1:VT = VT.createVT();
      
      public static var xq2:VT = VT.createVT();
      
      public static var hc1:VT = VT.createVT();
      
      public static var hc2:VT = VT.createVT();
      
      public static var zf1:VT = VT.createVT();
      
      public static var zf2:VT = VT.createVT();
      
      public static var m1:VT = VT.createVT();
      
      public static var m2:VT = VT.createVT();
      
      public static var strOk1:VT = VT.createVT();
      
      public static var strok2:VT = VT.createVT();
      
      public static var strLost1:VT = VT.createVT();
      
      public static var strLost2:VT = VT.createVT();
      
      public static var rcTask:VT = VT.createVT();
      
      public static var tgTime:VT = VT.createVT();
      
      public function AchData()
      {
         super();
      }
      
      public static function initAllAc() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            _loc1_.setStata(0);
            _loc1_.clearAcData();
         }
         xq1.setValue(0);
         xq2.setValue(0);
         hc1.setValue(0);
         hc2.setValue(0);
         zf1.setValue(0);
         zf2.setValue(0);
         m1.setValue(0);
         m2.setValue(0);
         strOk1.setValue(0);
         strok2.setValue(0);
         strLost1.setValue(0);
         strLost2.setValue(0);
         rcTask.setValue(0);
         tgTime.setValue(0);
      }
      
      public static function getAllAch() : Array
      {
         if(allDataArr.length == 0)
         {
            allDataArr = AchNumFactory.allAc;
            duAc();
            cjPointSave = [cjPoint_1,cjPoint_2,cjPoint_RiQi,xq1,xq2,hc1,hc2,zf1,zf2,m1,m2,strOk1,strok2,strLost1,strLost2,rcTask,tgTime];
            getEveryOrGame();
            getSmallEveryType();
            getSmallGameType();
         }
         return allDataArr;
      }
      
      public static function setMadeById(param1:Number = 0, param2:Number = 1, param3:Number = 1, param4:Number = 0) : void
      {
         var _loc5_:Achievement = null;
         for each(_loc5_ in gameAll)
         {
            _loc5_.setMd(param1,param2,param3,param4);
         }
      }
      
      public static function initXq() : void
      {
         if(xq1.getValue() == 0)
         {
            xq1.setValue(getNumGem(Main.player1));
         }
         if(Main.P1P2)
         {
            if(xq2.getValue() == 0)
            {
               xq2.setValue(getNumGem(Main.player2));
            }
         }
      }
      
      public static function initStr() : void
      {
         if(strOk1.getValue() == 0)
         {
            strOk1.setValue(strNum(Main.player1));
         }
         if(Main.P1P2)
         {
            if(strok2.getValue() == 0)
            {
               strok2.setValue(strNum(Main.player2));
            }
         }
      }
      
      public static function strNum(param1:PlayerData) : Number
      {
         var _loc3_:Equip = null;
         var _loc2_:Number = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            if(param1.getEquipSlot().getEquipFromSlot(_loc4_) != null)
            {
               _loc3_ = param1.getEquipSlot().getEquipFromSlot(_loc4_);
               _loc2_ += _loc3_.getReinforceLevel();
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 24)
         {
            if(param1.getBag().getEquipFromBag(_loc4_) != null)
            {
               _loc3_ = param1.getBag().getEquipFromBag(_loc4_);
               _loc2_ += _loc3_.getReinforceLevel();
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function setXqNum(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            xq1.setValue(xq1.getValue() + 1);
         }
         else if(param1 == 2)
         {
            xq2.setValue(xq1.getValue() + 1);
         }
      }
      
      private static function getNumGem(param1:PlayerData) : Number
      {
         var _loc3_:Equip = null;
         var _loc2_:Number = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            if(param1.getEquipSlot().getEquipFromSlot(_loc4_) != null)
            {
               _loc3_ = param1.getEquipSlot().getEquipFromSlot(_loc4_);
               if(_loc3_.getGrid() == 0)
               {
                  _loc2_++;
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
               if(_loc3_.getGrid() == 0)
               {
                  _loc2_++;
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
               if(_loc3_.getGrid() == 0)
               {
                  _loc2_++;
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function setHcNum(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            hc1.setValue(hc1.getValue() + 1);
         }
         else if(param1 == 2)
         {
            hc2.setValue(hc2.getValue() + 1);
         }
      }
      
      public static function setStrOkNum(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            strOk1.setValue(strOk1.getValue() + 1);
         }
         else if(param1 == 2)
         {
            strOk1.setValue(strOk1.getValue() + 1);
         }
      }
      
      public static function setStrLostNum(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            strLost1.setValue(strLost1.getValue() + 1);
         }
         else if(param1 == 2)
         {
            strLost1.setValue(strLost1.getValue() + 1);
         }
      }
      
      public static function setZfNum(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            zf1.setValue(zf1.getValue() + 1);
         }
         else if(param1 == 2)
         {
            zf2.setValue(zf2.getValue() + 1);
         }
      }
      
      public static function setMakeNum(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            m1.setValue(m1.getValue() + 1);
         }
         else if(param1 == 2)
         {
            m2.setValue(m2.getValue() + 1);
         }
      }
      
      public static function setRcTask() : void
      {
         rcTask.setValue(rcTask.getValue() + 1);
      }
      
      public static function setTgTimeNum() : void
      {
         tgTime.setValue(tgTime.getValue() + 1);
      }
      
      public static function getEveryOrGame() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            if(_loc1_.isEveryDady())
            {
               everyAll.push(_loc1_);
            }
            else
            {
               gameAll.push(_loc1_);
            }
         }
      }
      
      public static function getEveryType() : Array
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Achievement = null;
         var _loc1_:Array = [];
         if(everyAll.length != 0)
         {
            _loc2_ = 0;
            while(_loc2_ < 24)
            {
               if(_loc1_[_loc2_] == null)
               {
                  _loc1_[_loc2_] = [];
               }
               _loc3_ = 0;
               while(_loc3_ < everyAll.length)
               {
                  _loc4_ = everyAll[_loc3_];
                  if(_loc4_.getType() == _loc2_)
                  {
                     _loc1_[_loc2_].push(_loc4_);
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         if(_loc1_.length < 0)
         {
            return null;
         }
         return _loc1_;
      }
      
      public static function getGameType() : Array
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Achievement = null;
         var _loc1_:Array = [];
         if(gameAll.length != 0)
         {
            _loc2_ = 0;
            while(_loc2_ < 24)
            {
               if(_loc1_[_loc2_] == null)
               {
                  _loc1_[_loc2_] = [];
               }
               _loc3_ = 0;
               while(_loc3_ < gameAll.length)
               {
                  _loc4_ = gameAll[_loc3_];
                  if(_loc4_.getType() == _loc2_)
                  {
                     _loc1_[_loc2_].push(_loc4_);
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         if(_loc1_.length < 0)
         {
            return null;
         }
         return _loc1_;
      }
      
      public static function getSmallEveryType() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:Array = getEveryType();
         if(_loc1_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               if(edArr[_loc2_] == null)
               {
                  edArr[_loc2_] = [];
               }
               edArr[_loc2_] = getArr10(_loc1_[_loc2_],10);
               _loc2_++;
            }
         }
      }
      
      public static function getSmallGameType() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:Array = getGameType();
         if(_loc1_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               if(gaArr[_loc2_] == null)
               {
                  gaArr[_loc2_] = [];
               }
               gaArr[_loc2_] = getArr10(_loc1_[_loc2_],10);
               _loc2_++;
            }
         }
      }
      
      public static function getGaAcNum() : Number
      {
         var _loc3_:Achievement = null;
         var _loc1_:Array = gameAll;
         var _loc2_:Number = 0;
         if(_loc1_ != null)
         {
            for each(_loc3_ in _loc1_)
            {
               if(_loc3_.getStata() == 2)
               {
                  _loc2_++;
               }
            }
         }
         return _loc2_;
      }
      
      public static function getEvOrGa(param1:Number = 0) : Array
      {
         if(param1 == 1)
         {
            return gaArr;
         }
         if(param1 == 0)
         {
            return edArr;
         }
         return null;
      }
      
      public static function getArr10(param1:Array, param2:Number) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            if(param1.length >= param2)
            {
               _loc3_.push(param1.splice(0,param2));
            }
            else if(param1.length > 0)
            {
               _loc3_.push(param1.splice(0));
               break;
            }
            _loc4_ = --_loc4_ + 1;
         }
         return _loc3_;
      }
      
      public static function initGk(param1:Number, param2:Number, param3:Number) : void
      {
         if(param1 != 0)
         {
            if(param2 == 1)
            {
               setMap(param1);
               setStar(param3);
               initAcData();
            }
         }
      }
      
      public static function isTc(param1:Number) : void
      {
         setCs(param1);
         tgCstime();
      }
      
      public static function tgCstime() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            if(_loc1_.getStata() == 0 && _loc1_.getSmallType() == 33)
            {
               _loc1_.setTzGkTime();
            }
         }
      }
      
      public static function gkOk() : void
      {
         if(Main.gameNum.getValue() != 0)
         {
            addTgTime(WinShow.txt_1);
            addLjNum(WinShow.txt_2);
            addBjNum(WinShow.txt_3);
         }
         isAcOk();
      }
      
      public static function initAcData() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            if(_loc1_.getStata() == 0)
            {
               _loc1_.initSj();
            }
         }
      }
      
      public static function setMap(param1:Number) : void
      {
         var _loc2_:Achievement = null;
         for each(_loc2_ in allDataArr)
         {
            _loc2_.setMapId(param1);
         }
      }
      
      public static function setTg() : void
      {
         var _loc1_:Achievement = null;
         setTgTimeNum();
         for each(_loc1_ in allDataArr)
         {
            _loc1_.setTg();
         }
      }
      
      public static function setTzTgNum() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            _loc1_.setTzGkTime();
         }
      }
      
      public static function setStar(param1:Number) : void
      {
         var _loc2_:Achievement = null;
         for each(_loc2_ in allDataArr)
         {
            _loc2_.setStarId(param1);
         }
      }
      
      public static function setCs(param1:Number) : void
      {
         var _loc2_:Achievement = null;
         for each(_loc2_ in allDataArr)
         {
            _loc2_.setCs(param1);
         }
      }
      
      public static function addEnemyNum(param1:Number) : void
      {
         var _loc2_:Achievement = null;
         for each(_loc2_ in allDataArr)
         {
            _loc2_.setEnemyed(param1);
         }
      }
      
      public static function addBaoJiNum() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            _loc1_.setBaojiTime();
         }
      }
      
      public static function addLjNum(param1:Number) : void
      {
         var _loc2_:Achievement = null;
         for each(_loc2_ in allDataArr)
         {
            _loc2_.setLj(param1);
         }
      }
      
      public static function addTgTime(param1:Number) : void
      {
         var _loc2_:Achievement = null;
         for each(_loc2_ in allDataArr)
         {
            _loc2_.setTimeTg(param1);
         }
      }
      
      public static function addBjNum(param1:Number) : void
      {
         var _loc2_:Achievement = null;
         for each(_loc2_ in allDataArr)
         {
            _loc2_.setBj(param1);
         }
      }
      
      public static function addMiss() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            _loc1_.setMiss();
         }
      }
      
      public static function addHpNum() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            _loc1_.setHpTime();
         }
      }
      
      public static function addMpNum() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            _loc1_.setMpTime();
         }
      }
      
      public static function addSkillNum() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            _loc1_.setSkillTime();
         }
      }
      
      public static function addPtSkill() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in allDataArr)
         {
            _loc1_.setPtSkillTime();
         }
      }
      
      public static function isAcOk() : void
      {
         var _loc1_:Achievement = null;
         for each(_loc1_ in everyAll)
         {
            if(_loc1_.getStata() == 0 && _loc1_.isOk())
            {
               _loc1_.setStata(3);
               _loc1_.setOverTimer(Main.serverTime.getValue());
               cjPoint_1.setValue(cjPoint_1.getValue() + _loc1_.getRewardAc());
            }
         }
         for each(_loc1_ in gameAll)
         {
            if(_loc1_.getStata() == 0 && _loc1_.isOk())
            {
               _loc1_.setStata(2);
               cjPoint_2.setValue(cjPoint_2.getValue() + _loc1_.getRewardAc());
               cjPoint_1.setValue(cjPoint_1.getValue() + _loc1_.getRewardAc());
            }
         }
      }
      
      public static function upPoint() : void
      {
         var _loc3_:Achievement = null;
         var _loc1_:VT = VT.createVT();
         var _loc2_:Array = [];
         for each(_loc3_ in allDataArr)
         {
            if(!_loc3_.isEveryDady() && _loc3_.getStata() == 2)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc1_.setValue(_loc2_.length);
         if(cjPoint_2.getValue() != _loc1_.getValue())
         {
            cjPoint_2.setValue(_loc1_.getValue());
         }
         if(Main.serverTime.getValue() > cjPoint_RiQi.getValue())
         {
            cjPoint_1.setValue(cjPoint_1.getValue() + _loc1_.getValue());
            cjPoint_RiQi.setValue(Main.serverTime.getValue());
         }
      }
      
      public static function save() : Array
      {
         var _loc2_:Achievement = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         cjPointSave = [cjPoint_1,cjPoint_2,cjPoint_RiQi,xq1,xq2,hc1,hc2,zf1,zf2,m1,m2,strOk1,strok2,strLost1,strLost2,rcTask,tgTime];
         xxx[0] = cjPointSave;
         var _loc1_:uint = 0;
         while(_loc1_ < allDataArr.length)
         {
            _loc2_ = allDataArr[_loc1_];
            _loc3_ = _loc2_.getSmallType();
            _loc4_ = _loc2_.getId();
            if(_loc3_ == 33)
            {
               if(!xxx[33])
               {
                  xxx[33] = [];
               }
               xxx[_loc3_][_loc4_] = [_loc2_.getStata(),_loc2_.getTgCs(),_loc2_.getOverTimer()];
            }
            else if(_loc3_ == 44)
            {
               if(!xxx[44])
               {
                  xxx[44] = [];
               }
               xxx[_loc3_][_loc4_] = [_loc2_.getStata(),_loc2_.getGoodsNumed1(),_loc2_.getGoodsNumed2(),_loc2_.getOverTimer()];
            }
            else if(_loc3_ == 45)
            {
               if(!xxx[45])
               {
                  xxx[45] = [];
               }
               xxx[_loc3_][_loc4_] = [_loc2_.getStata(),_loc2_.getEnemyNum(),_loc2_.getOverTimer()];
            }
            else
            {
               if(!xxx[_loc3_])
               {
                  xxx[_loc3_] = [];
               }
               xxx[_loc3_][_loc4_] = [_loc2_.getStata(),_loc2_.getOverTimer()];
            }
            _loc1_++;
         }
         return xxx;
      }
      
      public static function duAc() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Achievement = null;
         var _loc5_:Number = NaN;
         if(!xxx[0])
         {
            xxx[0] = [];
         }
         if(xxx[0].length > 0)
         {
            cjPointSave = xxx[0];
            cjPoint_1.setValue(cjPointSave[0].getValue());
            cjPoint_2.setValue(cjPointSave[1].getValue());
            cjPoint_RiQi.setValue(cjPointSave[2].getValue());
            xq1.setValue(cjPointSave[3].getValue());
            xq2.setValue(cjPointSave[4].getValue());
            hc1.setValue(cjPointSave[5].getValue());
            hc2.setValue(cjPointSave[6].getValue());
            zf1.setValue(cjPointSave[7].getValue());
            zf2.setValue(cjPointSave[8].getValue());
            m1.setValue(cjPointSave[9].getValue());
            m2.setValue(cjPointSave[10].getValue());
            strOk1.setValue(cjPointSave[11].getValue());
            strok2.setValue(cjPointSave[12].getValue());
            strLost1.setValue(cjPointSave[13].getValue());
            strLost2.setValue(cjPointSave[14].getValue());
            rcTask.setValue(cjPointSave[15].getValue());
            tgTime.setValue(cjPointSave[16].getValue());
         }
         var _loc1_:uint = 1;
         while(_loc1_ < xxx.length)
         {
            if(xxx[_loc1_] != null)
            {
               _loc2_ = 1;
               while(_loc2_ < xxx[_loc1_].length)
               {
                  if(xxx[_loc1_][_loc2_] != null)
                  {
                     _loc3_ = 0;
                     while(_loc3_ < allDataArr.length)
                     {
                        _loc4_ = allDataArr[_loc3_];
                        _loc5_ = _loc4_.getId();
                        if(_loc1_ == 33)
                        {
                           if(xxx[_loc1_][_loc5_] != null)
                           {
                              _loc4_.setStata(xxx[_loc1_][_loc5_][0]);
                              _loc4_.DutzTime(xxx[_loc1_][_loc5_][1]);
                              _loc4_.setOverTimer(xxx[_loc1_][_loc5_][2]);
                           }
                        }
                        else if(_loc1_ == 44)
                        {
                           if(xxx[_loc1_][_loc5_] != null)
                           {
                              _loc4_.setStata(xxx[_loc1_][_loc5_][0]);
                              _loc4_.DuGoods(xxx[_loc1_][_loc5_][1],xxx[_loc1_][_loc5_][2]);
                              _loc4_.setOverTimer(xxx[_loc1_][_loc5_][3]);
                           }
                        }
                        else if(_loc1_ == 45)
                        {
                           if(xxx[_loc1_][_loc5_] != null)
                           {
                              _loc4_.setStata(xxx[_loc1_][_loc5_][0]);
                              _loc4_.DuEnemy(xxx[_loc1_][_loc5_][1]);
                              _loc4_.setOverTimer(xxx[_loc1_][_loc5_][2]);
                           }
                        }
                        else if(xxx[_loc1_][_loc5_] != null)
                        {
                           _loc4_.setStata(xxx[_loc1_][_loc5_][0]);
                           _loc4_.setOverTimer(xxx[_loc1_][_loc5_][1]);
                        }
                        _loc3_++;
                     }
                  }
                  _loc2_++;
               }
            }
            _loc1_++;
         }
      }
      
      public function getCjPoint_1() : Number
      {
         return cjPoint_1.getValue();
      }
      
      public function setCjPoint_1(param1:Number) : void
      {
         cjPoint_1.setValue(cjPoint_1.getValue() - param1);
      }
   }
}

