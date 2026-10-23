package com.hotpoint.braveManIII.views.makePanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.make.Make;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.MovieClip;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class MakePanel extends MovieClip
   {
      
      private static var _instance:MakePanel;
      
      private var dataArr:Array = [];
      
      private var state:Number = 0;
      
      private var ye:Number = 0;
      
      private var bookSlot:MakeBookSlot;
      
      private var finishSlot:MakeFinishSlot;
      
      private var tooltip:ItemsTooltip;
      
      private var playerState:Number = 1;
      
      private var madeOk:Boolean;
      
      private var nowId:Number = 0;
      
      private var hong:TextFormat;
      
      private var bai:TextFormat;
      
      private var lan:TextFormat;
      
      private var zi:TextFormat;
      
      private var ch:TextFormat;
      
      public function MakePanel()
      {
         super();
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         if(MakePanel._instance == null)
         {
            MakePanel._instance = new MakePanel();
            MakePanel._instance.bookSlot = MakeBookSlot.creatSlot();
            MakePanel._instance.finishSlot = MakeFinishSlot.creatSlot();
            MakePanel._instance.tooltip = new ItemsTooltip();
            MakePanel._instance.hong = new TextFormat();
            MakePanel._instance.hong.color = 16711680;
            MakePanel._instance.bai = new TextFormat();
            MakePanel._instance.bai.color = 4294967295;
            MakePanel._instance.lan = new TextFormat();
            MakePanel._instance.lan.color = 26367;
            MakePanel._instance.zi = new TextFormat();
            MakePanel._instance.zi.color = 16724991;
            MakePanel._instance.ch = new TextFormat();
            MakePanel._instance.ch.color = 16750848;
         }
         Main._stage.addChild(MakePanel._instance);
         MakePanel._instance.visible = true;
         MakePanel._instance.initPanel();
         MakePanel._instance.addChild(MakePanel._instance.tooltip);
         MakePanel._instance.tooltip.visible = false;
         MakePanel._instance.x = 50;
         MakePanel._instance.y = 10;
      }
      
      public static function close() : void
      {
         if(MakePanel._instance != null)
         {
            if(MakePanel._instance.visible == true)
            {
               MakePanel._instance.visible = false;
            }
         }
      }
      
      private function initPanel() : void
      {
         this.state = 0;
         this.ye = 0;
         this.p1orp2();
         this.initType(this.state,this.ye);
         this.addEvent();
         this.initMadeLan(0);
         this.btnStata(0,4,"mk_");
         this.btnStata(0,7,"tb_");
         this.needZz();
         this.playerGold();
      }
      
      private function p1orp2() : void
      {
         this.playerState = 1;
         if(Main.P1P2)
         {
            pb_0.visible = true;
            pb_1.visible = true;
            this.btnStata(0,2,"pb_");
         }
         else
         {
            pb_0.visible = false;
            pb_1.visible = false;
         }
      }
      
      private function playerGold() : void
      {
         if(this.playerState == 1)
         {
            player_gold.text = String(Main.player1.getGold());
         }
         else if(this.playerState == 2)
         {
            player_gold.text = String(Main.player2.getGold());
         }
      }
      
      private function initType(param1:Number = 0, param2:Number = 0) : void
      {
         this.dataArr = MakeData.getArr4(param1);
         this.bookSlot.clearMake();
         this.iniSlot(this.dataArr,param2);
         this.initBook();
         this.yeNum();
      }
      
      private function iniSlot(param1:Array, param2:Number = 0) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:Array = param1[param2];
         if(_loc3_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               this.bookSlot.addSlot(_loc3_[_loc4_]);
               _loc4_++;
            }
         }
      }
      
      private function initBook() : void
      {
         var _loc2_:Make = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            if(this.bookSlot.getMake(_loc1_) != null)
            {
               _loc2_ = this.bookSlot.getMake(_loc1_);
               trace(_loc2_.getFrame() + ":m.getFrame()");
               this["bk_" + _loc1_].gotoAndStop(_loc2_.getFrame());
               if(_loc2_.isState())
               {
                  this["bk_" + _loc1_].m_mask.gotoAndStop(2);
               }
               else
               {
                  this["bk_" + _loc1_].m_mask.gotoAndStop(1);
               }
            }
            else
            {
               this["bk_" + _loc1_].gotoAndStop(1);
               this["bk_" + _loc1_].m_mask.gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      private function yeNum() : void
      {
         var _loc1_:uint = 0;
         if(this.dataArr.length < 1)
         {
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = uint(this.dataArr.length);
         }
         this.num1.text = String(this.ye + 1) + "/" + _loc1_;
      }
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,this.doChange);
         this.addEventListener(BtnEvent.DO_CLICK,this.doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,this.doClose);
         this.addEventListener(BtnEvent.DO_OVER,this.doOver);
         this.addEventListener(BtnEvent.DO_OUT,this.doOut);
         this.addEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,this.daoJuOver);
         this.addEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,this.daoJuOut);
      }
      
      private function doOver(param1:BtnEvent) : void
      {
         var _loc4_:Make = null;
         var _loc2_:String = param1.target.name.substr(0,1);
         var _loc3_:Number = Number(param1.target.name.substr(3,1));
         if(_loc2_ == "m")
         {
            if(this.bookSlot.getMake(_loc3_) != null)
            {
               _loc4_ = this.bookSlot.getMake(_loc3_);
               if(_loc4_.isState() == false)
               {
                  PropertyScreen.open(_loc4_,false,Main._stage.mouseX,Main._stage.mouseY,_loc4_.getSm());
               }
            }
         }
      }
      
      private function doOut(param1:BtnEvent) : void
      {
         PropertyScreen.close();
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
      
      private function doChange(param1:BtnEvent) : void
      {
         var _loc2_:String = param1.target.name.substr(0,1);
         var _loc3_:Number = Number(param1.target.name.substr(3,1));
         if(_loc2_ == "t")
         {
            this.state = _loc3_;
            this.ye = 0;
            this.initType(this.state,0);
            this.initMadeLan(0);
            this.btnStata(_loc3_,7,"tb_");
            this.btnStata(0,4,"mk_");
            this.needZz();
         }
         if(_loc2_ == "f")
         {
            if(_loc3_ == 0)
            {
               if(this.ye > 0)
               {
                  --this.ye;
               }
            }
            if(_loc3_ == 1)
            {
               if(this.dataArr.length > 0)
               {
                  if(this.ye < this.dataArr.length - 1)
                  {
                     ++this.ye;
                  }
               }
            }
            this.initType(this.state,this.ye);
            this.initMadeLan(0);
            this.btnStata(0,4,"mk_");
            this.needZz();
         }
         if(_loc2_ == "m")
         {
            this.initMadeLan(_loc3_);
            this.btnStata(_loc3_,4,"mk_");
            this.needZz(_loc3_);
         }
         if(_loc2_ == "p")
         {
            if(_loc3_ == 0)
            {
               this.playerState = 1;
            }
            if(_loc3_ == 1)
            {
               this.playerState = 2;
            }
            this.state = 0;
            this.ye = 0;
            this.initMadeLan(0);
            if(Main.P1P2)
            {
               this.btnStata(_loc3_,2,"pb_");
               this.playerGold();
            }
            this.btnStata(0,4,"mk_");
            this.needZz();
         }
      }
      
      private function doClick(param1:BtnEvent) : void
      {
         var _loc2_:Make = null;
         var _loc3_:Number = NaN;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Number = NaN;
         if(this.madeOk)
         {
            _loc2_ = this.bookSlot.getMake(this.nowId);
            _loc3_ = _loc2_.getType();
            _loc4_ = _loc2_.getNeedType();
            _loc5_ = _loc2_.getNeedId();
            _loc6_ = _loc2_.getNeedNum();
            _loc7_ = _loc2_.getObj();
            _loc8_ = _loc2_.getFinishNum();
            if(this.deGold(_loc2_.getGold()))
            {
               if(this.whoFinishMade(_loc3_,_loc7_))
               {
                  this.whoDelBag(_loc5_,_loc4_,_loc6_);
                  this.initMadeLan(this.nowId);
                  this.playerGold();
                  trace("制作成功");
                  ShortTip.open(29);
                  AchData.setMakeNum(this.playerState);
                  AchData.setMadeById(2,_loc7_[0].getId(),this.playerState,_loc7_.length);
               }
            }
            else
            {
               ShortTip.open(16);
            }
         }
      }
      
      private function deGold(param1:Number) : Boolean
      {
         if(this.playerState == 1)
         {
            if(Main.player1.getGold() >= param1)
            {
               Main.player1.payGold(param1);
               return true;
            }
         }
         else if(this.playerState == 2)
         {
            if(Main.player2.getGold() >= param1)
            {
               Main.player2.payGold(param1);
               return true;
            }
         }
         trace("金币不足");
         return false;
      }
      
      private function whoFinishMade(param1:Number, param2:Array) : Boolean
      {
         if(this.playerState == 1)
         {
            return this.finishMake(param1,param2,Main.player1.getBag());
         }
         if(this.playerState == 2)
         {
            return this.finishMake(param1,param2,Main.player2.getBag());
         }
      }
      
      private function finishMake(param1:Number, param2:Array, param3:Bag) : Boolean
      {
         var _loc4_:uint = 0;
         var _loc5_:Gem = null;
         var _loc6_:Number = NaN;
         var _loc7_:Otherobj = null;
         if(param1 == 0 || param1 == 4 || param1 == 6)
         {
            if(param3.backequipBagNum() >= param2.length)
            {
               _loc4_ = 0;
               while(_loc4_ < param2.length)
               {
                  param3.addEquipBag(param2[_loc4_]);
                  _loc4_++;
               }
               return true;
            }
            trace("装备栏满");
         }
         else if(param1 == 1)
         {
            trace("药品栏剩余格数:" + param3.backSuppliesBagNum());
            if(param3.backSuppliesBagNum() >= param2.length)
            {
               _loc4_ = 0;
               while(_loc4_ < param2.length)
               {
                  param3.addSuppliesBag(param2[_loc4_]);
                  _loc4_++;
               }
               return true;
            }
            trace("药品栏满");
         }
         else if(param1 == 2)
         {
            _loc5_ = param2[0];
            _loc6_ = _loc5_.getId();
            trace("其他栏剩余:" + param3.canPutGemNum(_loc6_));
            if(param3.canPutGemNum(_loc6_) >= param2.length)
            {
               _loc4_ = 0;
               while(_loc4_ < param2.length)
               {
                  param3.addGemBag(param2[_loc4_]);
                  _loc4_++;
               }
               return true;
            }
            trace("宝石栏满");
         }
         else if(param1 == 3)
         {
            _loc7_ = param2[0];
            _loc6_ = _loc7_.getId();
            trace("其他栏剩余:" + param3.canPutOtherNum(_loc6_));
            if(param3.canPutOtherNum(_loc6_) >= param2.length)
            {
               _loc4_ = 0;
               while(_loc4_ < param2.length)
               {
                  param3.addOtherobjBag(param2[_loc4_]);
                  _loc4_++;
               }
               return true;
            }
            trace("其他栏满");
         }
         ShortTip.open(3);
         return false;
      }
      
      private function whoDelBag(param1:Array, param2:Array, param3:Array) : void
      {
         if(this.playerState == 1)
         {
            this.delBag(param1,param2,param3,Main.player1.getBag());
         }
         else if(this.playerState == 2)
         {
            this.delBag(param1,param2,param3,Main.player2.getBag());
         }
      }
      
      private function delBag(param1:Array, param2:Array, param3:Array, param4:Bag) : void
      {
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            if(param1[_loc5_] != -1)
            {
               if(param2[_loc5_] == 0 || param2[_loc5_] == 4)
               {
                  param4.delEquipById(param1[_loc5_],param3[_loc5_]);
               }
               else if(param2[_loc5_] == 1)
               {
                  param4.delSuppliesById(param1[_loc5_],param3[_loc5_]);
               }
               else if(param2[_loc5_] == 2)
               {
                  param4.delGemById(param1[_loc5_],param3[_loc5_]);
               }
               else if(param2[_loc5_] == 3)
               {
                  trace("删除其他");
                  param4.delOtherById(param1[_loc5_],param3[_loc5_]);
               }
            }
            _loc5_++;
         }
      }
      
      private function daoJuOver(param1:DaoJuEvent) : void
      {
         var _loc3_:Make = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc2_:Number = Number(param1.target.name.substr(2,1));
         if(this.bookSlot.getMake(this.nowId) != null)
         {
            _loc3_ = this.bookSlot.getMake(this.nowId);
            _loc4_ = _loc3_.addNeedOb();
            _loc5_ = _loc3_.getObj();
            _loc6_ = _loc5_[0];
            if(_loc2_ <= 4)
            {
               this.tooltip.visible = true;
               this.tooltip.x = Main._stage.mouseX;
               this.tooltip.y = Main._stage.mouseY;
               if(_loc4_[_loc2_] != null)
               {
                  _loc7_ = _loc4_[_loc2_];
                  if(_loc7_ as Equip)
                  {
                     this.tooltip.equipTooltip(_loc7_);
                  }
                  else if(_loc7_ as Supplies)
                  {
                     this.tooltip.suppliesTooltip(_loc7_);
                  }
                  else if(_loc7_ as Gem)
                  {
                     this.tooltip.gemTooltip(_loc7_);
                  }
                  else if(_loc7_ as Otherobj)
                  {
                     this.tooltip.otherTooltip(_loc7_);
                  }
               }
            }
            else if(_loc6_ as Equip)
            {
               PropertyScreen.open(_loc6_,false,Main._stage.mouseX,Main._stage.mouseY,"获得后才可以查看属性(属性随机)");
            }
            else
            {
               this.tooltip.visible = true;
               this.tooltip.x = mouseX;
               this.tooltip.y = mouseY;
               if(_loc6_ as Supplies)
               {
                  this.tooltip.suppliesTooltip(_loc6_);
               }
               else if(_loc6_ as Gem)
               {
                  this.tooltip.gemTooltip(_loc6_);
               }
               else if(_loc6_ as Otherobj)
               {
                  this.tooltip.otherTooltip(_loc6_);
               }
            }
         }
      }
      
      private function pointY(param1:MovieClip) : void
      {
         trace(param1.height + ":mc.height");
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
         if(_loc2_.x + param1.width > 940)
         {
            param1.x = 940 - param1.width - 40;
         }
      }
      
      private function daoJuOut(param1:DaoJuEvent) : void
      {
         this.tooltip.visible = false;
         PropertyScreen.close();
      }
      
      private function initMadeLan(param1:Number) : void
      {
         var _loc2_:Make = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Number = NaN;
         this.finishSlot.clearMake();
         this.initFrame();
         all_makeBtn.gotoAndStop(2);
         gold_text.text = "";
         this.nowId = param1;
         if(this.bookSlot.getMake(param1) != null)
         {
            _loc2_ = this.bookSlot.getMake(param1);
            _loc3_ = _loc2_.addNeedOb();
            _loc4_ = _loc2_.getNeedType();
            _loc5_ = _loc2_.getNeedId();
            _loc6_ = _loc2_.getNeedNum();
            _loc7_ = _loc2_.getObj();
            _loc8_ = _loc2_.getFinishNum();
            this.nameVisible(_loc5_,_loc4_,_loc6_,_loc3_);
            this.findIdInBag(_loc5_,_loc4_,_loc6_);
            this.needMcAp(_loc2_,_loc3_);
            this.getFinishSlot(_loc7_[0],_loc8_);
            gold_text.text = _loc2_.getGold().toString();
            if(_loc2_.isState())
            {
               this.madeOk = this.isOk(_loc5_);
               if(this.madeOk == true)
               {
                  all_makeBtn.gotoAndStop(1);
               }
            }
         }
      }
      
      private function needZz(param1:Number = 0) : void
      {
         var _loc2_:Make = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         if(this.bookSlot.getMake(param1) != null)
         {
            _loc2_ = this.bookSlot.getMake(param1);
            _loc3_ = _loc2_.getNeedId();
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_] == -1)
               {
                  this["z_" + _loc4_].visible = true;
               }
               else
               {
                  this["z_" + _loc4_].visible = false;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               this["z_" + _loc4_].visible = false;
               _loc4_++;
            }
         }
      }
      
      private function isOk(param1:Array) : Boolean
      {
         var _loc2_:Array = [];
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != -1)
            {
               if(this.finishSlot.getMake(_loc3_) != null)
               {
                  _loc2_.push(1);
               }
               else
               {
                  _loc2_.push(-1);
               }
            }
            else
            {
               _loc2_.push(1);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] == -1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function getFinishSlot(param1:Object, param2:Number) : void
      {
         if(param1 != null)
         {
            trace(param1.getColor() + "__________");
            this.finishSlot.addFinish(param1);
            if(this.finishSlot.getMake(5) != null)
            {
               this.n_5.gotoAndStop(this.finishSlot.getMake(5).getFrame());
               this.name_5.text = this.finishSlot.getMake(5).getName();
               if(this.finishSlot.getMake(5).getColor() == 1)
               {
                  this.name_5.setTextFormat(this.bai);
               }
               else if(this.finishSlot.getMake(5).getColor() == 2)
               {
                  this.name_5.setTextFormat(this.lan);
               }
               else if(this.finishSlot.getMake(5).getColor() == 3)
               {
                  this.name_5.setTextFormat(this.zi);
               }
               else if(this.finishSlot.getMake(5).getColor() == 4 || this.finishSlot.getMake(5).getColor() == 5)
               {
                  this.name_5.setTextFormat(this.ch);
               }
            }
            if(param2 > 1)
            {
               this.n_5.howNum.text = String(param2);
            }
            else
            {
               this.n_5.howNum.text = "";
            }
         }
         else
         {
            this.n_5.gotoAndStop(1);
            this.name_5.text = "";
            this.n_5.howNum.text = "";
         }
      }
      
      private function findIdInBag(param1:Array, param2:Array, param3:Array) : void
      {
         var _loc5_:Array = null;
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = [];
            if(param1[_loc4_] != -1)
            {
               _loc5_ = this.needOk(param1[_loc4_],param2[_loc4_]);
               if(_loc5_ != null)
               {
                  if(this.dbNum(_loc5_,param2[_loc4_],param3[_loc4_]))
                  {
                     this.finishSlot.addNeedSlot(_loc4_,_loc5_[0][0]);
                  }
               }
            }
            _loc4_++;
         }
      }
      
      private function needOk(param1:Number, param2:Number) : Array
      {
         var _loc3_:Array = [];
         if(param2 == 0 || param2 == 4)
         {
            _loc3_ = MakeData.getEquip(param1,this.playerState);
         }
         else if(param2 == 1)
         {
            _loc3_ = MakeData.getSup(param1,this.playerState);
         }
         else if(param2 == 2)
         {
            _loc3_ = MakeData.getGem(param1,this.playerState);
         }
         else if(param2 == 3)
         {
            _loc3_ = MakeData.getOther(param1,this.playerState);
         }
         return _loc3_;
      }
      
      private function dbNum(param1:Array, param2:Number, param3:Number) : Boolean
      {
         var _loc7_:Gem = null;
         var _loc8_:Otherobj = null;
         var _loc4_:Number = Number(param1[0].length);
         var _loc5_:Number = 0;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc4_)
         {
            if(param2 == 0 || param2 == 1)
            {
               if(_loc4_ >= param3)
               {
                  return true;
               }
            }
            else if(param2 == 2)
            {
               _loc7_ = param1[0][_loc6_];
               if(_loc7_.getIsPile())
               {
                  _loc5_ += _loc7_.getTimes();
                  if(_loc5_ >= param3)
                  {
                     return true;
                  }
               }
               else if(_loc4_ >= param3)
               {
                  return true;
               }
            }
            else if(param2 == 3)
            {
               _loc8_ = param1[0][_loc6_];
               if(_loc8_.isMany())
               {
                  _loc5_ += _loc8_.getTimes();
                  if(_loc5_ >= param3)
                  {
                     return true;
                  }
               }
               else if(_loc4_ >= param3)
               {
                  return true;
               }
            }
            _loc6_++;
         }
         return false;
      }
      
      public function nameVisible(param1:Array, param2:Array, param3:Array, param4:Array) : void
      {
         var _loc5_:Array = this.getName(param1,param2);
         var _loc6_:Array = this.getNumInBag(param1,param2);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc5_.length)
         {
            if(_loc5_[_loc7_] != "")
            {
               this["name_" + _loc7_].text = _loc5_[_loc7_];
               this["nx_" + _loc7_].text = _loc6_[_loc7_];
               this["nb_" + _loc7_].text = param3[_loc7_];
               this["nx_" + _loc7_].setTextFormat(this.bai);
               if(_loc6_[_loc7_] < param3[_loc7_])
               {
                  this["nx_" + _loc7_].setTextFormat(this.hong);
               }
               if(param4[_loc7_].getColor() == 1)
               {
                  this["name_" + _loc7_].setTextFormat(this.bai);
               }
               else if(param4[_loc7_].getColor() == 2)
               {
                  this["name_" + _loc7_].setTextFormat(this.lan);
               }
               else if(param4[_loc7_].getColor() == 3)
               {
                  this["name_" + _loc7_].setTextFormat(this.zi);
               }
               else if(param4[_loc7_].getColor() == 4)
               {
                  this["name_" + _loc7_].setTextFormat(this.ch);
               }
            }
            else
            {
               this["name_" + _loc7_].text = "";
               this["nx_" + _loc7_].text = "";
               this["nb_" + _loc7_].text = "";
            }
            _loc7_++;
         }
      }
      
      public function needMcAp(param1:Make, param2:Array) : void
      {
         var _loc3_:uint = 0;
         if(param1.isState() == false)
         {
            trace("没激活");
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(param2[_loc3_] != null)
               {
                  this["n_" + _loc3_].gotoAndStop(param2[_loc3_].getFrame());
                  trace(param2[_loc3_].getFrame() + ":obArr[i].getFrame()");
                  this["n_" + _loc3_].ob_mast.gotoAndStop(3);
               }
               else
               {
                  this["n_" + _loc3_].gotoAndStop(1);
                  this["n_" + _loc3_].ob_mast.gotoAndStop(1);
               }
               _loc3_++;
            }
         }
         else
         {
            trace("有激活");
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(param2[_loc3_] != null)
               {
                  this["n_" + _loc3_].gotoAndStop(param2[_loc3_].getFrame());
                  if(this.finishSlot.getMake(_loc3_) != null)
                  {
                     this["n_" + _loc3_].ob_mast.gotoAndStop(1);
                  }
                  else
                  {
                     this["n_" + _loc3_].ob_mast.gotoAndStop(2);
                  }
               }
               else
               {
                  this["n_" + _loc3_].gotoAndStop(1);
                  this["n_" + _loc3_].ob_mast.gotoAndStop(1);
               }
               _loc3_++;
            }
         }
      }
      
      private function getName(param1:Array, param2:Array) : Array
      {
         var _loc3_:String = null;
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            if(param1[_loc5_] == -1)
            {
               _loc3_ = "";
            }
            else if(param2[_loc5_] == 0 || param2[_loc5_] == 4)
            {
               _loc3_ = EquipFactory.findName(param1[_loc5_]);
            }
            else if(param2[_loc5_] == 1)
            {
               _loc3_ = SuppliesFactory.findName(param1[_loc5_]);
            }
            else if(param2[_loc5_] == 2)
            {
               _loc3_ = GemFactory.findName(param1[_loc5_]);
            }
            else if(param2[_loc5_] == 3)
            {
               _loc3_ = OtherFactory.getName(param1[_loc5_]);
            }
            _loc4_.push(_loc3_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function getNumInBag(param1:Array, param2:Array) : Array
      {
         var _loc3_:Number = 0;
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            if(param1[_loc5_] == -1)
            {
               _loc3_ = 0;
            }
            else if(param2[_loc5_] == 0 || param2[_loc5_] == 4)
            {
               _loc3_ = Number((Main["player" + this.playerState].getBag() as Bag).getEquipObjNum(param1[_loc5_]));
            }
            else if(param2[_loc5_] == 1)
            {
               _loc3_ = Number((Main["player" + this.playerState].getBag() as Bag).getSupObjNum(param1[_loc5_]));
            }
            else if(param2[_loc5_] == 2)
            {
               _loc3_ = Number((Main["player" + this.playerState].getBag() as Bag).getGemNum(param1[_loc5_]));
            }
            else if(param2[_loc5_] == 3)
            {
               _loc3_ = Number((Main["player" + this.playerState].getBag() as Bag).getOtherobjNum(param1[_loc5_]));
            }
            _loc4_.push(_loc3_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function needFrame() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 5)
         {
            if(this.finishSlot.getMake(_loc1_) != null)
            {
               this["n_" + _loc1_].gotoAndStop(this.finishSlot.getMake(_loc1_).getFrame());
            }
            else
            {
               this["n_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      private function initFrame() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            this["n_" + _loc1_].gotoAndStop(1);
            this["n_" + _loc1_].ob_mast.gotoAndStop(1);
            this["n_" + _loc1_].howNum.text = "";
            this["name_" + _loc1_].text = "";
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this["nx_" + _loc1_].text = "";
            this["nb_" + _loc1_].text = "";
            _loc1_++;
         }
      }
      
      private function doClose(param1:BtnEvent) : void
      {
         close();
      }
   }
}

