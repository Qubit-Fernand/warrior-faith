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
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setStata(0);
            data.clearAcData();
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
         }
         return allDataArr;
      }
      
      public static function getXXXX() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            if(data.getSmallType() == 44)
            {
               trace(data.getGoodsNumed1() + "cnm________________________");
            }
         }
      }
      
      public static function setMadeById(type:Number = 0, id:Number = 1, p:Number = 1, num:Number = 0) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setMd(type,id,p,num);
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
      
      public static function strNum(player:PlayerData) : Number
      {
         var eq:Equip = null;
         var num:Number = 0;
         for(var i:uint = 0; i < 8; i++)
         {
            if(player.getEquipSlot().getEquipFromSlot(i) != null)
            {
               eq = player.getEquipSlot().getEquipFromSlot(i);
               num += eq.getReinforceLevel();
            }
         }
         for(i = 0; i < 24; i++)
         {
            if(player.getBag().getEquipFromBag(i) != null)
            {
               eq = player.getBag().getEquipFromBag(i);
               num += eq.getReinforceLevel();
            }
         }
         return num;
      }
      
      public static function setXqNum(who:Number = 1) : void
      {
         if(who == 1)
         {
            xq1.setValue(xq1.getValue() + 1);
         }
         else if(who == 2)
         {
            xq2.setValue(xq1.getValue() + 1);
         }
      }
      
      private static function getNumGem(player:PlayerData) : Number
      {
         var eq:Equip = null;
         var num:Number = 0;
         for(var i:uint = 0; i < 8; i++)
         {
            if(player.getEquipSlot().getEquipFromSlot(i) != null)
            {
               eq = player.getEquipSlot().getEquipFromSlot(i);
               if(eq.getGrid() == 0)
               {
                  num++;
               }
            }
         }
         for(i = 0; i < 24; i++)
         {
            if(player.getBag().getEquipFromBag(i) != null)
            {
               eq = player.getBag().getEquipFromBag(i);
               if(eq.getGrid() == 0)
               {
                  num++;
               }
            }
         }
         for(i = 0; i < 35; i++)
         {
            if(StoragePanel.storage.getEquipFromStorage(i) != null)
            {
               eq = StoragePanel.storage.getEquipFromStorage(i);
               if(eq.getGrid() == 0)
               {
                  num++;
               }
            }
         }
         return num;
      }
      
      public static function setHcNum(who:Number = 1) : void
      {
         if(who == 1)
         {
            hc1.setValue(hc1.getValue() + 1);
         }
         else if(who == 2)
         {
            hc2.setValue(hc2.getValue() + 1);
         }
      }
      
      public static function setStrOkNum(who:Number = 1) : void
      {
         if(who == 1)
         {
            strOk1.setValue(strOk1.getValue() + 1);
         }
         else if(who == 2)
         {
            strOk1.setValue(strOk1.getValue() + 1);
         }
      }
      
      public static function setStrLostNum(who:Number = 1) : void
      {
         if(who == 1)
         {
            strLost1.setValue(strLost1.getValue() + 1);
         }
         else if(who == 2)
         {
            strLost1.setValue(strLost1.getValue() + 1);
         }
      }
      
      public static function setZfNum(who:Number = 1) : void
      {
         if(who == 1)
         {
            zf1.setValue(zf1.getValue() + 1);
         }
         else if(who == 2)
         {
            zf2.setValue(zf2.getValue() + 1);
         }
      }
      
      public static function setMakeNum(who:Number = 1) : void
      {
         if(who == 1)
         {
            m1.setValue(m1.getValue() + 1);
         }
         else if(who == 2)
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
      
      public static function getEdAc(bo:Boolean = false) : Array
      {
         var data:Achievement = null;
         var arr:Array = [];
         for each(data in allDataArr)
         {
            if(data.isEveryDady())
            {
               if(!bo)
               {
                  arr.push(data);
               }
               else if(data.getStata() == 0)
               {
                  arr.push(data);
               }
            }
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public static function getEveryDadyType(bo:Boolean) : void
      {
         var i:uint = 0;
         var j:uint = 0;
         var data:Achievement = null;
         edArr = [];
         var arr:Array = getEdAc(bo);
         if(arr != null)
         {
            for(i = 0; i < 24; i++)
            {
               if(edArr[i] == null)
               {
                  edArr[i] = [];
               }
               for(j = 0; j < arr.length; j++)
               {
                  data = arr[j];
                  if(data.getType() == i)
                  {
                     edArr[i].push(data);
                  }
               }
            }
            for(i = 0; i < edArr.length; i++)
            {
               edArr[i] = getArr10(edArr[i],10);
            }
         }
      }
      
      public static function getGameType(bo:Boolean = false) : void
      {
         var i:uint = 0;
         var j:uint = 0;
         var data:Achievement = null;
         gaArr = [];
         var arr:Array = getGaAc(bo);
         if(arr != null)
         {
            for(i = 0; i < 24; i++)
            {
               if(gaArr[i] == null)
               {
                  gaArr[i] = [];
               }
               for(j = 0; j < arr.length; j++)
               {
                  data = arr[j];
                  if(data.getType() == i)
                  {
                     gaArr[i].push(data);
                  }
               }
            }
            for(i = 0; i < gaArr.length; i++)
            {
               gaArr[i] = getArr10(gaArr[i],10);
            }
         }
      }
      
      public static function getGaAc(bo:Boolean = false) : Array
      {
         var data:Achievement = null;
         var arr:Array = [];
         for each(data in allDataArr)
         {
            if(!data.isEveryDady())
            {
               if(!bo)
               {
                  arr.push(data);
               }
               else if(data.getStata() == 0)
               {
                  arr.push(data);
               }
            }
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public static function getGaAcNum() : Number
      {
         var data:Achievement = null;
         var arr:Array = getGaAc();
         var num:Number = 0;
         if(arr != null)
         {
            for each(data in arr)
            {
               if(data.getStata() == 2)
               {
                  num++;
               }
            }
         }
         return num;
      }
      
      public static function getEvOrGa(type:Number = 0) : Array
      {
         if(type == 1)
         {
            return gaArr;
         }
         if(type == 0)
         {
            return edArr;
         }
         return null;
      }
      
      public static function getsmallType(arr:Array, num:Number) : Array
      {
         var data:Achievement = null;
         var typeArr:Array = [];
         if(arr != null)
         {
            for each(data in arr)
            {
               if(data.getType() == num)
               {
                  typeArr.push(data);
               }
            }
         }
         return typeArr;
      }
      
      public static function getArr10(arr:Array, num:Number) : Array
      {
         var arr2:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(arr.length >= num)
            {
               arr2.push(arr.splice(0,num));
            }
            else if(arr.length > 0)
            {
               arr2.push(arr.splice(0));
               break;
            }
            i--;
         }
         return arr2;
      }
      
      public static function initGk(num1:Number, num2:Number, num3:Number) : void
      {
         trace("进入大关:" + num1,"进入小关卡___________:" + num2,"星级:" + num3);
         if(num1 != 0)
         {
            if(num2 == 1)
            {
               setMap(num1);
               setStar(num3);
               initAcData();
            }
         }
      }
      
      public static function isTc(num:Number) : void
      {
         setCs(num);
         tgCstime();
      }
      
      public static function tgCstime() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            if(data.getStata() == 0 && data.getSmallType() == 33)
            {
               data.setTzGkTime();
            }
         }
      }
      
      public static function gkOk() : void
      {
         if(Main.gameNum != 0)
         {
            addTgTime(WinShow.txt_1);
            addLjNum(WinShow.txt_2);
            addBjNum(WinShow.txt_3);
         }
         isAcOk();
      }
      
      public static function initAcData() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            if(data.getStata() == 0)
            {
               data.initSj();
            }
         }
      }
      
      public static function setMap(num:Number) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setMapId(num);
         }
      }
      
      public static function setTg() : void
      {
         var data:Achievement = null;
         setTgTimeNum();
         for each(data in allDataArr)
         {
            data.setTg();
         }
      }
      
      public static function setTzTgNum() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setTzGkTime();
         }
      }
      
      public static function setStar(num:Number) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setStarId(num);
         }
      }
      
      public static function setCs(num:Number) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setCs(num);
         }
      }
      
      public static function addEnemyNum(enemyId:Number) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setEnemyed(enemyId);
         }
      }
      
      public static function addBaoJiNum() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setBaojiTime();
         }
      }
      
      public static function addLjNum(num:Number) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setLj(num);
         }
      }
      
      public static function addTgTime(num:Number) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setTimeTg(num);
         }
      }
      
      public static function addBjNum(num:Number) : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setBj(num);
         }
      }
      
      public static function addMiss() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setMiss();
         }
      }
      
      public static function addHpNum() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setHpTime();
         }
      }
      
      public static function addMpNum() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setMpTime();
         }
      }
      
      public static function addSkillNum() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setSkillTime();
         }
      }
      
      public static function addPtSkill() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            data.setPtSkillTime();
         }
      }
      
      public static function isAcOk() : void
      {
         var data:Achievement = null;
         for each(data in allDataArr)
         {
            if(data.getStata() == 0 && data.isOk())
            {
               if(data.isEveryDady())
               {
                  data.setStata(3);
                  data.setOverTimer(Main.serverTime.getValue());
                  cjPoint_1.setValue(cjPoint_1.getValue() + data.getRewardAc());
               }
               else
               {
                  data.setStata(2);
                  cjPoint_2.setValue(cjPoint_2.getValue() + data.getRewardAc());
                  cjPoint_1.setValue(cjPoint_1.getValue() + data.getRewardAc());
               }
               trace(data.getName() + "成就完成______");
            }
         }
      }
      
      public static function upPoint() : void
      {
         var data:Achievement = null;
         var num:VT = VT.createVT();
         var arr:Array = [];
         for each(data in allDataArr)
         {
            if(!data.isEveryDady() && data.getStata() == 2)
            {
               arr.push(data);
            }
         }
         num.setValue(arr.length);
         if(cjPoint_2.getValue() != num.getValue())
         {
            cjPoint_2.setValue(num.getValue());
         }
         if(Main.serverTime.getValue() > cjPoint_RiQi.getValue())
         {
            cjPoint_1.setValue(cjPoint_1.getValue() + num.getValue());
            cjPoint_RiQi.setValue(Main.serverTime.getValue());
         }
      }
      
      public static function save() : Array
      {
         var data:Achievement = null;
         var type:Number = NaN;
         var id:Number = NaN;
         cjPointSave = [cjPoint_1,cjPoint_2,cjPoint_RiQi,xq1,xq2,hc1,hc2,zf1,zf2,m1,m2,strOk1,strok2,strLost1,strLost2,rcTask,tgTime];
         xxx[0] = cjPointSave;
         for(var z:uint = 0; z < allDataArr.length; z++)
         {
            data = allDataArr[z];
            type = data.getSmallType();
            id = data.getId();
            trace(type + "__type" + id);
            if(type == 33)
            {
               if(!xxx[33])
               {
                  xxx[33] = [];
               }
               xxx[type][id] = [data.getStata(),data.getTgCs(),data.getOverTimer()];
            }
            else if(type == 44)
            {
               if(!xxx[44])
               {
                  xxx[44] = [];
               }
               xxx[type][id] = [data.getStata(),data.getGoodsNumed1(),data.getGoodsNumed2(),data.getOverTimer()];
            }
            else if(type == 45)
            {
               if(!xxx[45])
               {
                  xxx[45] = [];
               }
               xxx[type][id] = [data.getStata(),data.getEnemyNum(),data.getOverTimer()];
            }
            else
            {
               if(!xxx[type])
               {
                  xxx[type] = [];
               }
               xxx[type][id] = [data.getStata(),data.getOverTimer()];
            }
         }
         return xxx;
      }
      
      public static function duAc() : void
      {
         var j:uint = 0;
         var z:uint = 0;
         var data:Achievement = null;
         var id:Number = NaN;
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
         for(var i:uint = 1; i < xxx.length; i++)
         {
            if(xxx[i] != null)
            {
               for(j = 1; j < xxx[i].length; j++)
               {
                  if(xxx[i][j] != null)
                  {
                     for(z = 0; z < allDataArr.length; z++)
                     {
                        data = allDataArr[z];
                        id = data.getId();
                        if(i == 33)
                        {
                           if(xxx[i][id] != null)
                           {
                              data.setStata(xxx[i][id][0]);
                              data.DutzTime(xxx[i][id][1]);
                              data.setOverTimer(xxx[i][id][2]);
                           }
                        }
                        else if(i == 44)
                        {
                           if(xxx[i][id] != null)
                           {
                              data.setStata(xxx[i][id][0]);
                              data.DuGoods(xxx[i][id][1],xxx[i][id][2]);
                              data.setOverTimer(xxx[i][id][3]);
                           }
                        }
                        else if(i == 45)
                        {
                           if(xxx[i][id] != null)
                           {
                              data.setStata(xxx[i][id][0]);
                              data.DuEnemy(xxx[i][id][1]);
                              data.setOverTimer(xxx[i][id][2]);
                           }
                        }
                        else if(xxx[i][id] != null)
                        {
                           data.setStata(xxx[i][id][0]);
                           data.setOverTimer(xxx[i][id][1]);
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function getCjPoint_1() : Number
      {
         return cjPoint_1.getValue();
      }
      
      public function setCjPoint_1(num:Number) : void
      {
         cjPoint_1.setValue(cjPoint_1.getValue() - num);
      }
   }
}

