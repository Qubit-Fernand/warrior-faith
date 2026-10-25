package com.hotpoint.braveManIII.views.achPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.achievement.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol6886")]
   public class AchPanel extends MovieClip
   {
      
      private static var _instance:AchPanel;
      
      private static var xxxArr:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,101,102,103,104,105,51,52,53,54,55];
      
      public var evPoint:TextField;
      
      public var by_0:成就按钮分页1;
      
      public var by_1:成就按钮下一页;
      
      public var a_0:MovieClip;
      
      public var sy_0:成就按钮分页1;
      
      public var closePanel:制作关闭按钮;
      
      public var a_1:MovieClip;
      
      public var sy_1:成就按钮下一页;
      
      public var a_2:MovieClip;
      
      public var a_3:MovieClip;
      
      public var gamePoint:TextField;
      
      public var gy_1:成就界面_打钩;
      
      public var a_4:MovieClip;
      
      public var na_0:小分类_0;
      
      public var bt_0:每日成就按钮;
      
      public var a_5:MovieClip;
      
      public var na_10:小分类_0;
      
      public var na_1:小分类_0;
      
      public var allAcText:TextField;
      
      public var bt_1:成就按钮1;
      
      public var a_6:MovieClip;
      
      public var na_11:小分类_0;
      
      public var na_2:小分类_0;
      
      public var a_7:MovieClip;
      
      public var na_12:小分类_0;
      
      public var na_3:小分类_0;
      
      public var a_8:MovieClip;
      
      public var na_13:小分类_0;
      
      public var na_4:小分类_0;
      
      public var a_9:MovieClip;
      
      public var na_14:小分类_0;
      
      public var na_5:小分类_0;
      
      public var na_6:小分类_0;
      
      public var b_text:TextField;
      
      public var na_7:小分类_0;
      
      public var mk1:MovieClip;
      
      public var na_8:小分类_0;
      
      public var s_text:TextField;
      
      public var mk2:MovieClip;
      
      public var na_9:小分类_0;
      
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
      
      private var bigTyeArr:Array = [["落月之原_0","落月之森_1","冰雪废墟_2","死亡流沙_3","万年雪山_4","废弃都市_5","火山的噩梦_6","堕落城堡_7"," 幽灵船_8","机械城_9","雪狼巢穴_10","火之祭坛_11","暗影城_12","暗夜遗迹_13","机械试练场_14","熔岩城堡_15","暗黑炼狱_16","神秘地带1_17","神秘地带2_18","神秘地带3_19","神秘地带4_20","神秘地带5_21","艾尔之海_22","安塔利亚_23","阿肯色_24","雅利安_25","奥戈_26"],["变态_0","装备_1","强化_2","关卡_3","收集_4","任务_5","友好_6","制作_7","合成_8","镶嵌_9","升星_10","挑 战_11","金币_12","在线_13","击杀点_14","战斗_15","特殊_16","技能_17","人物_18","宠物_19"]];
      
      public function AchPanel()
      {
         super();
      }
      
      public static function getStateByGkId(param1:Number) : Array
      {
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc2_:Number = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < xxxArr.length)
         {
            if(xxxArr[_loc3_] == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         var _loc4_:Array = [];
         var _loc5_:Array = AchData.getEvOrGa(0);
         var _loc6_:Array = _loc5_[_loc2_];
         if(_loc6_.length != 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc6_[_loc7_].length)
               {
                  _loc4_.push((_loc6_[_loc7_][_loc8_] as Achievement).getStata());
                  _loc8_++;
               }
               _loc7_++;
            }
         }
         return _loc4_;
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
         bigState = 1;
         bye = 0;
         sstate = 0;
         ye = 0;
         initType(bigState,sstate,ye,bo);
         initTiao(bigState,bye);
         getPlint();
         btnStata(1,2,"bt_");
         btnStata(0,15,"na_");
         mk1.visible = true;
         mk2.visible = false;
      }
      
      private function updeAc() : void
      {
         var _loc2_:Achievement = null;
         var _loc1_:Array = AchData.everyAll;
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.getStata() == 3)
            {
               if(Main.serverTime.getValue() > _loc2_.getOverTimer())
               {
                  _loc2_.setStata(0);
                  _loc2_.clearAcData();
               }
            }
         }
      }
      
      public function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,doChange);
         this.addEventListener(BtnEvent.DO_CLICK,doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,doClose);
         this.addEventListener(BtnEvent.DO_ONECLICK,doOneClick);
      }
      
      public function doChange(param1:BtnEvent) : void
      {
         var _loc2_:String = param1.target.name;
         var _loc3_:String = _loc2_.substr(0,1);
         var _loc4_:Number = Number(_loc2_.substr(3));
         if(_loc3_ == "b")
         {
            bigState = _loc4_;
            sstate = 0;
            ye = 0;
            bye = 0;
            initType(bigState,sstate,ye,bo);
            initTiao(bigState,bye);
            btnStata(bigState,2,"bt_");
            btnStata(0,15,"na_");
            if(bigState == 0)
            {
               mk1.visible = false;
               mk2.visible = true;
            }
            else if(bigState == 1)
            {
               mk1.visible = true;
               mk2.visible = false;
            }
         }
         else if(_loc3_ == "n")
         {
            if(tSlot.getName(_loc4_) != null)
            {
               ye = 0;
               sstate = getTypeByeNameId(_loc4_);
               initType(bigState,sstate,ye,bo);
               btnStata(_loc4_,15,"na_");
            }
         }
      }
      
      public function doClose(param1:BtnEvent) : void
      {
         close();
      }
      
      private function getTypeByeNameId(param1:Number = 0) : Number
      {
         var _loc3_:String = null;
         var _loc2_:Number = 0;
         if(tSlot.getName(param1) != null)
         {
            _loc3_ = tSlot.getName(param1);
            _loc2_ = Number(_loc3_.substring(_loc3_.lastIndexOf("_") + 1,_loc3_.length));
         }
         return _loc2_;
      }
      
      public function doClick(param1:BtnEvent) : void
      {
         var _loc2_:String = param1.target.name;
         var _loc3_:String = _loc2_.substr(0,1);
         var _loc4_:Number = Number(_loc2_.substr(3,1));
         if(_loc3_ == "b")
         {
            ye = 0;
            bye = addOrJian(_loc4_,bye,dataBigArr);
            initTiao(bigState,bye);
            sstate = getTypeByeNameId(0);
            initType(bigState,sstate,ye,bo);
            btnStata(0,15,"na_");
         }
         else if(_loc3_ == "s")
         {
            ye = addOrJian(_loc4_,ye,dataArr);
            initType(bigState,sstate,ye,bo);
         }
      }
      
      private function doOneClick(param1:BtnEvent) : void
      {
         bo = !bo;
         initType(bigState,sstate,ye,bo);
      }
      
      private function addOrJian(param1:Number, param2:Number, param3:Array) : Number
      {
         var _loc4_:Number = param2;
         if(param3 != null)
         {
            if(param1 == 0)
            {
               if(_loc4_ > 0)
               {
                  _loc4_--;
               }
            }
            else if(param1 == 1)
            {
               if(_loc4_ < param3.length - 1)
               {
                  _loc4_++;
               }
            }
         }
         return _loc4_;
      }
      
      private function initTiao(param1:Number = 0, param2:Number = 0) : void
      {
         bigTyeArr = [["落月之原_0","落月之森_1","冰雪废墟_2","死亡流沙_3","万年雪山_4","废弃都市_5","火山的噩梦_6","堕落城堡_7"," 幽灵船_8","机械城_9","雪狼巢穴_10","火之祭坛_11","暗影城_12","暗夜遗迹_13","机械试练场_14","熔岩城堡_15","暗黑炼狱_16","神秘地带1_17","神秘地带2_18","神秘地带3_19","神秘地带4_20","神秘地带5_21","艾尔之海_22","安塔利亚_23","阿肯色_24","雅利安_25","奥戈_26"],["变态_0","装备_1","强化_2","关卡_3","收集_4","任务_5","友好_6","制作_7","合成_8","镶嵌_9","升星_10","挑战_11","金币_12","在线_13","击杀点_14","战斗_15","特殊_16","技能_17","人物_18","宠物_19"]];
         dataBigArr = AchData.getArr10(bigTyeArr[param1],15);
         tSlot.clearAc();
         iniTiaoSlot(dataBigArr,param2);
         initTiaoVisble();
         byeNum(this.b_text,bye,dataBigArr);
      }
      
      private function byeNum(param1:TextField, param2:Number, param3:Array) : void
      {
         var _loc4_:* = undefined;
         if(param3 != null)
         {
            _loc4_ = param3.length;
            if(_loc4_ < 1)
            {
               _loc4_ = 1;
            }
            param1.text = param2 + 1 + "/" + _loc4_;
         }
         else
         {
            param1.text = param2 + 1 + "/" + 1;
         }
      }
      
      private function initTiaoVisble() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Array = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 15)
         {
            this["na_" + _loc1_].n_text.text = "";
            if(tSlot.getName(_loc1_) != null)
            {
               _loc3_ = tSlot.getName(_loc1_);
               _loc4_ = _loc3_.lastIndexOf("_");
               _loc2_ = _loc3_.substr(0,_loc4_);
               _loc5_ = Number(getTypeByeNameId(_loc1_));
               _loc6_ = getNum(_loc5_);
               this["na_" + _loc1_].n_text.text = _loc2_;
               this["na_" + _loc1_].num_text.text = String(_loc6_[0]) + "/" + String(_loc6_[1]);
            }
            else
            {
               this["na_" + _loc1_].n_text.text = "";
               this["na_" + _loc1_].num_text.text = "";
            }
            _loc1_++;
         }
      }
      
      private function getNum(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Achievement = null;
         var _loc2_:Array = [];
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         if(bigState == 0)
         {
            if(AchData.edArr.length > 0)
            {
               _loc2_ = AchData.edArr[param1];
               _loc5_ = 0;
               while(_loc5_ < _loc2_.length)
               {
                  _loc4_ += _loc2_[_loc5_].length;
                  _loc6_ = 0;
                  while(_loc6_ < _loc2_[_loc5_].length)
                  {
                     _loc7_ = _loc2_[_loc5_][_loc6_];
                     if(_loc7_.getStata() == 3)
                     {
                        _loc3_++;
                     }
                     _loc6_++;
                  }
                  _loc5_++;
               }
            }
         }
         else if(bigState == 1)
         {
            if(AchData.gaArr.length > 0)
            {
               _loc2_ = AchData.gaArr[param1];
               _loc5_ = 0;
               while(_loc5_ < _loc2_.length)
               {
                  _loc4_ += _loc2_[_loc5_].length;
                  _loc6_ = 0;
                  while(_loc6_ < _loc2_[_loc5_].length)
                  {
                     _loc7_ = _loc2_[_loc5_][_loc6_];
                     if(_loc7_.getStata() == 2)
                     {
                        _loc3_++;
                     }
                     _loc6_++;
                  }
                  _loc5_++;
               }
            }
         }
         return new Array(_loc3_,_loc4_);
      }
      
      private function initType(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Boolean = false) : void
      {
         xxArr = AchData.getEvOrGa(param1);
         dataArr = xxArr[param2];
         var _loc5_:Array = [];
         if(dataArr != null && dataArr.length > 0)
         {
            _loc5_ = xxArr[param2][param3];
         }
         acSlot.clearAc();
         iniSlot(_loc5_,param4);
         initAc();
         byeNum(this.s_text,ye,dataArr);
      }
      
      private function iniTiaoSlot(param1:Array, param2:Number = 0) : void
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         if(param1 != null)
         {
            _loc3_ = param1[param2];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               tSlot.addName(_loc3_[_loc4_]);
               _loc4_++;
            }
         }
      }
      
      private function iniSlot(param1:Array, param2:Boolean) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Achievement = null;
         if(param1.length != 0)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc4_ = param1[_loc3_];
               if(param2)
               {
                  if(_loc4_.getStata() == 0)
                  {
                     acSlot.addSlot(_loc4_);
                  }
               }
               else
               {
                  acSlot.addSlot(_loc4_);
               }
               _loc3_++;
            }
         }
      }
      
      private function initAc() : void
      {
         var _loc2_:Achievement = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:uint = 0;
         while(_loc1_ < 10)
         {
            if(acSlot.getAc(_loc1_) != null)
            {
               _loc2_ = acSlot.getAc(_loc1_);
               this["a_" + _loc1_].a_name.text = String(_loc2_.getName());
               this["a_" + _loc1_].gotoAndStop(_loc2_.getFrame());
               _loc3_ = 0;
               _loc3_ = _loc2_.getFinishNum();
               _loc4_ = Number(getNumByType(_loc2_));
               this["a_" + _loc1_].xxx_text.text = "进度:" + _loc4_ + "/" + _loc3_;
               if(_loc2_.getSmallType() == 26 || _loc2_.getSmallType() == 27 || _loc2_.getSmallType() == 28 || _loc2_.getSmallType() == 29 || _loc2_.getSmallType() == 30 || _loc2_.getSmallType() == 32 || _loc2_.getSmallType() == 35 || _loc2_.getSmallType() == 36 || _loc2_.getSmallType() == 37 || _loc2_.getSmallType() == 38 || _loc2_.getSmallType() == 39 || _loc2_.getSmallType() == 40 || _loc2_.getSmallType() == 41 || _loc2_.getSmallType() == 42 || _loc2_.getSmallType() == 43 || _loc2_.getSmallType() == 44 && _loc2_.isRy())
               {
                  this["a_" + _loc1_].xxx_text.text = "进度:" + "无";
               }
               this["a_" + _loc1_].a_jieShao.text = String(_loc2_.getSm());
               if(_loc2_.getStata() != 0)
               {
                  this["a_" + _loc1_].gotoAndStop(_loc2_.getFrame() + 1);
                  this["a_" + _loc1_].xxx_text.text = "进度:" + "完成";
               }
            }
            else
            {
               this["a_" + _loc1_].a_name.text = "";
               this["a_" + _loc1_].a_jieShao.text = "";
               this["a_" + _loc1_].xxx_text.text = "";
               this["a_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      private function getNumByType(param1:Achievement) : Number
      {
         switch(param1.getSmallType())
         {
            case 1:
               return Main.P1P2 ? Number(bjDx(Main.player1.getLevel(),Main.player2.getLevel())) : Number(Main.player1.getLevel());
            case 2:
               return Main.P1P2 ? Number(bjDx(Main.player1.getGold(),Main.player2.getGold())) : Number(Main.player1.getGold());
            case 5:
               return Main.P1P2 ? Number(bjDx(Main.player1.getKillPoint(),Main.player2.getKillPoint())) : Number(Main.player1.getKillPoint());
            case 7:
               return AchData.cjPoint_1.getValue();
            case 8:
               return AchData.cjPoint_2.getValue();
            case 10:
               return AchData.getGaAcNum();
            case 11:
               return Main.P1P2 ? Number(bjDx(Main.player1.getPetSlot().backPetNum(),Main.player2.getPetSlot().backPetNum())) : Number(Main.player1.getPetSlot().backPetNum());
            case 12:
               return Main.P1P2 ? Number(bjDx(Main.player1.getSkillNum(),Main.player2.getSkillNum())) : Number(Main.player1.getSkillNum());
            case 13:
               return Main.P1P2 ? Number(bjDx(AchData.xq1.getValue(),AchData.xq2.getValue())) : Number(AchData.xq1.getValue());
            case 14:
               return Main.P1P2 ? Number(bjDx(AchData.zf1.getValue(),AchData.zf2.getValue())) : Number(AchData.zf1.getValue());
            case 15:
               return Main.P1P2 ? Number(bjDx(AchData.m1.getValue(),AchData.m2.getValue())) : Number(AchData.m1.getValue());
            case 16:
               return Main.P1P2 ? Number(bjDx(AchData.hc1.getValue(),AchData.hc2.getValue())) : Number(AchData.hc1.getValue());
            case 17:
               return TaskData.getZxInOld();
            case 18:
               return AchData.rcTask.getValue();
            case 20:
               return Main.P1P2 ? Number(bjDx(AchData.strOk1.getValue(),AchData.strok2.getValue())) : Number(AchData.strOk1.getValue());
            case 21:
               return Main.P1P2 ? Number(bjDx(AchData.strLost1.getValue(),AchData.strLost2.getValue())) : Number(AchData.strLost1.getValue());
            case 22:
               return Main.P1P2 ? Number(bjDx(param1.getStrEquipNum(Main.player1),param1.getStrEquipNum(Main.player2))) : param1.getStrEquipNum(Main.player1);
            case 23:
               return Main.P1P2 ? Number(bjDx(Main.player1.getEquipSlot().getSuitStrength(),Main.player2.getEquipSlot().getSuitStrength())) : Number(Main.player1.getEquipSlot().getSuitStrength());
            case 24:
               return param1.getCwMaxLeve();
            case 31:
               return param1.getGkStar();
            case 33:
               return param1.getTgCs();
            case 34:
               return AchData.tgTime.getValue();
            case 44:
               return Main.P1P2 ? Number(bjDx(param1.getGoodsNum(1),param1.getGoodsNum(2))) : param1.getGoodsNum(1);
            case 45:
               return param1.getEnemyed();
            case 46:
               return PK_UI.whoNum;
            default:
               return;
         }
      }
      
      private function bjDx(param1:Number, param2:Number = 0) : Number
      {
         if(param1 <= param2)
         {
            return param2;
         }
         return param1;
      }
      
      private function getNumText(param1:Number) : void
      {
         var _loc2_:Array = [];
         if(param1 == 0)
         {
            _loc2_ = AchData.getEdAc();
         }
         else if(param1 == 1)
         {
            _loc2_ = AchData.getGaAc();
         }
         if(_loc2_ != null)
         {
            allAcText.text = String(_loc2_.length);
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
      
      private function btnStata(param1:Number, param2:Number, param3:String) : void
      {
         this[param3 + param1].isClick = true;
         var _loc4_:uint = 0;
         while(_loc4_ < param2)
         {
            if(param1 != _loc4_)
            {
               this[param3 + _loc4_].isClick = false;
            }
            _loc4_++;
         }
      }
   }
}

