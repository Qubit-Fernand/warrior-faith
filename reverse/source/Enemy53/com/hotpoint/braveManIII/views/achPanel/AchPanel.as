package com.hotpoint.braveManIII.views.achPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.achievement.Achievement;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import src.*;
   
   public class AchPanel extends MovieClip
   {
      
      private static var _instance:AchPanel;
      
      private var _data:AchData;
      
      private var bigState:Number = 0;
      
      private var bye:Number = 0;
      
      private var sstate:Number = 0;
      
      private var ye:Number = 0;
      
      private var dataArr:Array = [];
      
      private var dataBigArr:Array = [];
      
      private var acSlot:AchSlot;
      
      private var tSlot:AcTiaoSlot;
      
      private var xxArr:Array = [];
      
      private var aaArr:Array = [];
      
      private var bo:Boolean;
      
      private var bigTyeArr:Array = [["落月之原_0","落月之森_1","冰雪废墟_2","死亡流沙_3","万年雪山_4","废弃都市_5","火山的噩梦_6","堕落城堡_7","幽灵船_8","机械城_9","雪狼巢穴_10","火之祭坛_11","暗影城_12","暗夜遗迹_13","机械试练场_14","暗黑炼狱_15"],["变态_0","装备_1","强化_2","关卡_3","收集_4","任务_5","友好_6","制作_7","合成_8","镶嵌_9","升星_10","挑战_11","金币_12","在线_13","击杀点_14","战斗_15","特殊_16","技能_17","人物_18","宠物_19"]];
      
      public function AchPanel()
      {
         super();
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         if(AchPanel._instance == null)
         {
            AchPanel._instance = new AchPanel();
            AchPanel._instance._data = new AchData();
            AchPanel._instance.acSlot = new AchSlot();
            AchPanel._instance.tSlot = new AcTiaoSlot();
         }
         AchPanel._instance.bo = false;
         AchData.initXq();
         AchData.gkOk();
         AchData.initStr();
         AchPanel._instance.updeAc();
         Main._stage.addChild(AchPanel._instance);
         AchPanel._instance.initPanel();
         AchPanel._instance.addEvent();
         AchPanel._instance.visible = true;
         AchPanel._instance.y = 0;
         AchPanel._instance.x = 0;
      }
      
      public static function close() : void
      {
         if(AchPanel._instance != null)
         {
            if(AchPanel._instance.visible == true)
            {
               AchPanel._instance.visible = false;
            }
         }
      }
      
      private function initPanel() : void
      {
         gy_1._isClick = false;
         gy_1.gotoAndStop(1);
         AchData.setMadeById(1);
         AchData.setMadeById(2);
         AchData.setMadeById(3);
         AchData.isAcOk();
         this.bigState = 1;
         this.bye = 0;
         this.sstate = 0;
         this.ye = 0;
         this.initType(this.bigState,this.sstate,this.ye,this.bo);
         this.initTiao(this.bigState,this.bye);
         this.getPlint();
         this.btnStata(1,2,"bt_");
         this.btnStata(0,15,"na_");
         mk1.visible = true;
         mk2.visible = false;
      }
      
      private function updeAc() : void
      {
         var data:Achievement = null;
         var arr:Array = AchData.everyAll;
         for each(data in arr)
         {
            if(data.getStata() == 3)
            {
               if(Main.serverTime.getValue() > data.getOverTimer())
               {
                  data.setStata(0);
                  data.clearAcData();
               }
            }
         }
      }
      
      public function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,this.doChange);
         this.addEventListener(BtnEvent.DO_CLICK,this.doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,this.doClose);
         this.addEventListener(BtnEvent.DO_ONECLICK,this.doOneClick);
      }
      
      public function doChange(e:BtnEvent) : void
      {
         var str:String = e.target.name;
         var nameId:String = str.substr(0,1);
         var id:Number = Number(str.substr(3));
         if(nameId == "b")
         {
            this.bigState = id;
            this.sstate = 0;
            this.ye = 0;
            this.bye = 0;
            this.initType(this.bigState,this.sstate,this.ye,this.bo);
            this.initTiao(this.bigState,this.bye);
            this.btnStata(this.bigState,2,"bt_");
            this.btnStata(0,15,"na_");
            if(this.bigState == 0)
            {
               mk1.visible = false;
               mk2.visible = true;
            }
            else if(this.bigState == 1)
            {
               mk1.visible = true;
               mk2.visible = false;
            }
         }
         else if(nameId == "n")
         {
            if(this.tSlot.getName(id) != null)
            {
               this.ye = 0;
               this.sstate = this.getTypeByeNameId(id);
               this.initType(this.bigState,this.sstate,this.ye,this.bo);
               this.btnStata(id,15,"na_");
            }
         }
      }
      
      public function doClose(e:BtnEvent) : void
      {
         close();
      }
      
      private function getTypeByeNameId(id:Number = 0) : Number
      {
         var acName:String = null;
         var type:Number = 0;
         if(this.tSlot.getName(id) != null)
         {
            acName = this.tSlot.getName(id);
            type = Number(acName.substring(acName.lastIndexOf("_") + 1,acName.length));
         }
         return type;
      }
      
      public function doClick(e:BtnEvent) : void
      {
         var str:String = e.target.name;
         var nameId:String = str.substr(0,1);
         var id:Number = Number(str.substr(3,1));
         if(nameId == "b")
         {
            this.ye = 0;
            this.bye = this.addOrJian(id,this.bye,this.dataBigArr);
            this.initTiao(this.bigState,this.bye);
            this.sstate = this.getTypeByeNameId(0);
            this.initType(this.bigState,this.sstate,this.ye,this.bo);
            this.btnStata(0,15,"na_");
         }
         else if(nameId == "s")
         {
            this.ye = this.addOrJian(id,this.ye,this.dataArr);
            this.initType(this.bigState,this.sstate,this.ye,this.bo);
         }
      }
      
      private function doOneClick(e:BtnEvent) : void
      {
         this.bo = !this.bo;
         this.initType(this.bigState,this.sstate,this.ye,this.bo);
      }
      
      private function addOrJian(btnId:Number, ye:Number, allNum:Array) : Number
      {
         var num:Number = ye;
         if(allNum != null)
         {
            if(btnId == 0)
            {
               if(num > 0)
               {
                  num--;
               }
            }
            else if(btnId == 1)
            {
               if(num < allNum.length - 1)
               {
                  num++;
               }
            }
         }
         return num;
      }
      
      private function initTiao(type:Number = 0, num:Number = 0) : void
      {
         this.bigTyeArr = [["落月之原_0","落月之森_1","冰雪废墟_2","死亡流沙_3","万年雪山_4","废弃都市_5","火山的噩梦_6","堕落城堡_7","幽灵船_8","机械城_9","雪狼巢穴_10","火之祭坛_11","暗影城_12","暗夜遗迹_13","机械试练场_14","暗黑炼狱_15"],["变态_0","装备_1","强化_2","关卡_3","收集_4","任务_5","友好_6","制作_7","合成_8","镶嵌_9","升星_10","挑战_11","金币_12","在线_13","击杀点_14","战斗_15","特殊_16","技能_17","人物_18","宠物_19"]];
         this.dataBigArr = AchData.getArr10(this.bigTyeArr[type],15);
         this.tSlot.clearAc();
         this.iniTiaoSlot(this.dataBigArr,num);
         this.initTiaoVisble();
         this.byeNum(this.b_text,this.bye,this.dataBigArr);
      }
      
      private function byeNum(t:TextField, nowNum:Number, arr:Array) : void
      {
         var allNum:* = undefined;
         if(arr != null)
         {
            allNum = arr.length;
            if(allNum < 1)
            {
               allNum = 1;
            }
            t.text = nowNum + 1 + "/" + allNum;
         }
         else
         {
            t.text = nowNum + 1 + "/" + 1;
         }
      }
      
      private function initTiaoVisble() : void
      {
         var my_str:String = null;
         var str:String = null;
         var index:int = 0;
         var type:Number = NaN;
         var numArr:Array = null;
         for(var i:uint = 0; i < 15; i++)
         {
            this["na_" + i].n_text.text = "";
            if(this.tSlot.getName(i) != null)
            {
               str = this.tSlot.getName(i);
               index = str.lastIndexOf("_");
               my_str = str.substr(0,index);
               type = Number(this.getTypeByeNameId(i));
               numArr = this.getNum(type);
               this["na_" + i].n_text.text = my_str;
               this["na_" + i].num_text.text = String(numArr[0]) + "/" + String(numArr[1]);
            }
            else
            {
               this["na_" + i].n_text.text = "";
               this["na_" + i].num_text.text = "";
            }
         }
      }
      
      private function getNum(type:Number) : Array
      {
         var i:uint = 0;
         var j:uint = 0;
         var data:Achievement = null;
         var arr:Array = [];
         var num1:Number = 0;
         var num2:Number = 0;
         if(this.bigState == 0)
         {
            if(AchData.edArr.length > 0)
            {
               arr = AchData.edArr[type];
               for(i = 0; i < arr.length; i++)
               {
                  num2 += arr[i].length;
                  for(j = 0; j < arr[i].length; j++)
                  {
                     data = arr[i][j];
                     if(data.getStata() == 3)
                     {
                        num1++;
                     }
                  }
               }
            }
         }
         else if(this.bigState == 1)
         {
            if(AchData.gaArr.length > 0)
            {
               arr = AchData.gaArr[type];
               for(i = 0; i < arr.length; i++)
               {
                  num2 += arr[i].length;
                  for(j = 0; j < arr[i].length; j++)
                  {
                     data = arr[i][j];
                     if(data.getStata() == 2)
                     {
                        num1++;
                     }
                  }
               }
            }
         }
         return new Array(num1,num2);
      }
      
      private function initType(type:Number = 0, sType:Number = 0, num:Number = 0, bo:Boolean = false) : void
      {
         this.xxArr = AchData.getEvOrGa(type);
         this.dataArr = this.xxArr[sType];
         var arr:Array = [];
         if(this.dataArr != null && this.dataArr.length > 0)
         {
            arr = this.xxArr[sType][num];
         }
         this.acSlot.clearAc();
         this.iniSlot(arr,bo);
         this.initAc();
         this.byeNum(this.s_text,this.ye,this.dataArr);
      }
      
      private function iniTiaoSlot(typeArr:Array, num:Number = 0) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(typeArr != null)
         {
            arr = typeArr[num];
            for(i = 0; i < arr.length; i++)
            {
               this.tSlot.addName(arr[i]);
            }
         }
      }
      
      private function iniSlot(typeArr:Array, bo:Boolean) : void
      {
         var i:uint = 0;
         var ac:Achievement = null;
         if(typeArr.length != 0)
         {
            for(i = 0; i < typeArr.length; i++)
            {
               ac = typeArr[i];
               if(bo)
               {
                  if(ac.getStata() == 0)
                  {
                     this.acSlot.addSlot(ac);
                  }
               }
               else
               {
                  this.acSlot.addSlot(ac);
               }
            }
         }
      }
      
      private function initAc() : void
      {
         var ac:Achievement = null;
         var num2:Number = NaN;
         var num1:Number = NaN;
         for(var i:uint = 0; i < 10; i++)
         {
            if(this.acSlot.getAc(i) != null)
            {
               ac = this.acSlot.getAc(i);
               this["a_" + i].a_name.text = String(ac.getName());
               this["a_" + i].gotoAndStop(ac.getFrame());
               num2 = 0;
               num2 = ac.getFinishNum();
               num1 = Number(this.getNumByType(ac));
               this["a_" + i].xxx_text.text = "进度:" + num1 + "/" + num2;
               if(ac.getSmallType() == 26 || ac.getSmallType() == 27 || ac.getSmallType() == 28 || ac.getSmallType() == 29 || ac.getSmallType() == 30 || ac.getSmallType() == 32 || ac.getSmallType() == 35 || ac.getSmallType() == 36 || ac.getSmallType() == 37 || ac.getSmallType() == 38 || ac.getSmallType() == 39 || ac.getSmallType() == 40 || ac.getSmallType() == 41 || ac.getSmallType() == 42 || ac.getSmallType() == 43 || ac.getSmallType() == 44 && ac.isRy())
               {
                  this["a_" + i].xxx_text.text = "进度:" + "无";
               }
               this["a_" + i].a_jieShao.text = String(ac.getSm());
               if(ac.getStata() != 0)
               {
                  this["a_" + i].gotoAndStop(ac.getFrame() + 1);
                  this["a_" + i].xxx_text.text = "进度:" + "完成";
               }
            }
            else
            {
               this["a_" + i].a_name.text = "";
               this["a_" + i].a_jieShao.text = "";
               this["a_" + i].xxx_text.text = "";
               this["a_" + i].gotoAndStop(1);
            }
         }
      }
      
      private function getNumByType(ac:Achievement) : Number
      {
         switch(ac.getSmallType())
         {
            case 1:
               return Main.P1P2 ? Number(this.bjDx(Main.player1.getLevel(),Main.player2.getLevel())) : Number(Main.player1.getLevel());
            case 2:
               return Main.P1P2 ? Number(this.bjDx(Main.player1.getGold(),Main.player2.getGold())) : Number(Main.player1.getGold());
            case 5:
               return Main.P1P2 ? Number(this.bjDx(Main.player1.getKillPoint(),Main.player2.getKillPoint())) : Number(Main.player1.getKillPoint());
            case 7:
               return AchData.cjPoint_1.getValue();
            case 8:
               return AchData.cjPoint_2.getValue();
            case 10:
               return AchData.getGaAcNum();
            case 11:
               return Main.P1P2 ? Number(this.bjDx(Main.player1.getPetSlot().backPetNum(),Main.player2.getPetSlot().backPetNum())) : Number(Main.player1.getPetSlot().backPetNum());
            case 12:
               return Main.P1P2 ? Number(this.bjDx(Main.player1.getSkillNum(),Main.player2.getSkillNum())) : Number(Main.player1.getSkillNum());
            case 13:
               return Main.P1P2 ? Number(this.bjDx(AchData.xq1.getValue(),AchData.xq2.getValue())) : Number(AchData.xq1.getValue());
            case 14:
               return Main.P1P2 ? Number(this.bjDx(AchData.zf1.getValue(),AchData.zf2.getValue())) : Number(AchData.zf1.getValue());
            case 15:
               return Main.P1P2 ? Number(this.bjDx(AchData.m1.getValue(),AchData.m2.getValue())) : Number(AchData.m1.getValue());
            case 16:
               return Main.P1P2 ? Number(this.bjDx(AchData.hc1.getValue(),AchData.hc2.getValue())) : Number(AchData.hc1.getValue());
            case 17:
               return TaskData.getZxInOld();
            case 18:
               return AchData.rcTask.getValue();
            case 20:
               return Main.P1P2 ? Number(this.bjDx(AchData.strOk1.getValue(),AchData.strok2.getValue())) : Number(AchData.strOk1.getValue());
            case 21:
               return Main.P1P2 ? Number(this.bjDx(AchData.strLost1.getValue(),AchData.strLost2.getValue())) : Number(AchData.strLost1.getValue());
            case 22:
               return Main.P1P2 ? Number(this.bjDx(ac.getStrEquipNum(Main.player1),ac.getStrEquipNum(Main.player2))) : ac.getStrEquipNum(Main.player1);
            case 23:
               return Main.P1P2 ? Number(this.bjDx(Main.player1.getEquipSlot().getSuitStrength(),Main.player2.getEquipSlot().getSuitStrength())) : Number(Main.player1.getEquipSlot().getSuitStrength());
            case 24:
               return ac.getCwMaxLeve();
            case 31:
               return ac.getGkStar();
            case 33:
               return ac.getTgCs();
            case 34:
               return AchData.tgTime.getValue();
            case 44:
               return Main.P1P2 ? Number(this.bjDx(ac.getGoodsNum(1),ac.getGoodsNum(2))) : ac.getGoodsNum(1);
            case 45:
               return ac.getEnemyed();
            case 46:
               return PK_UI.whoNum;
            default:
               return;
         }
      }
      
      private function bjDx(num1:Number, num2:Number = 0) : Number
      {
         if(num1 <= num2)
         {
            return num2;
         }
         return num1;
      }
      
      private function getNumText(num:Number) : void
      {
         var arr:Array = [];
         if(num == 0)
         {
            arr = AchData.getEdAc();
         }
         else if(num == 1)
         {
            arr = AchData.getGaAc();
         }
         if(arr != null)
         {
            allAcText.text = String(arr.length);
         }
         else
         {
            allAcText.text = String(0);
         }
      }
      
      private function getPlint() : void
      {
         evPoint.text = String(AchData.cjPoint_1.getValue());
         gamePoint.text = String(AchData.cjPoint_2.getValue());
      }
      
      private function btnStata(id:Number, num:Number, str:String) : void
      {
         this[str + id].isClick = true;
         for(var i:uint = 0; i < num; i++)
         {
            if(id != i)
            {
               this[str + i].isClick = false;
            }
         }
      }
   }
}

