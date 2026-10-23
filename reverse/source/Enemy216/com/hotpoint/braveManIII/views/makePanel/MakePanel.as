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
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   import src.tool.*;
   
   public class MakePanel extends MovieClip
   {
      
      public static var _instance:MakePanel;
      
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
      
      private var buyType:Number;
      
      private var buyObjArr:Array;
      
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
         MakePanel._instance.x = 0;
         MakePanel._instance.y = 0;
         MakePanel._instance._BLACK_mc.visible = false;
      }
      
      public static function close() : void
      {
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
         MakePanel._instance.initPanel();
         MakePanel._instance.addChild(MakePanel._instance.tooltip);
         MakePanel._instance.tooltip.visible = false;
         MakePanel._instance.x = 5000;
         MakePanel._instance.y = 5000;
         MakePanel._instance.visible = false;
         MakePanel._instance._BLACK_mc.visible = false;
      }
      
      private function initPanel() : void
      {
         state = 0;
         ye = 0;
         p1orp2();
         initType(state,ye);
         addEvent();
         initMadeLan(0);
         btnStata(0,4,"mk_");
         btnStata(0,7,"tb_");
         needZz();
         playerGold();
      }
      
      private function p1orp2() : void
      {
         playerState = 1;
         if(Main.P1P2)
         {
            pb_0.visible = true;
            pb_1.visible = true;
            btnStata(0,2,"pb_");
         }
         else
         {
            pb_0.visible = false;
            pb_1.visible = false;
         }
      }
      
      private function playerGold() : void
      {
         if(playerState == 1)
         {
            player_gold.text = String(Main.player1.getGold());
         }
         else if(playerState == 2)
         {
            player_gold.text = String(Main.player2.getGold());
         }
         if(Shop4399.moneyAll.getValue() > -1)
         {
            dianQun_Point.text = Shop4399.moneyAll.getValue();
         }
      }
      
      private function initType(param1:Number = 0, param2:Number = 0) : void
      {
         dataArr = MakeData.getArr4(param1);
         bookSlot.clearMake();
         iniSlot(dataArr,param2);
         initBook();
         yeNum();
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
               bookSlot.addSlot(_loc3_[_loc4_]);
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
            if(bookSlot.getMake(_loc1_) != null)
            {
               _loc2_ = bookSlot.getMake(_loc1_);
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
         if(dataArr.length < 1)
         {
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = uint(dataArr.length);
         }
         this.num1.text = String(ye + 1) + "/" + _loc1_;
      }
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,doChange);
         this.addEventListener(BtnEvent.DO_CLICK,doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,doClose);
         this.addEventListener(BtnEvent.DO_OVER,doOver);
         this.addEventListener(BtnEvent.DO_OUT,doOut);
         this.addEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,daoJuOver);
         this.addEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,daoJuOut);
         buy_btn.addEventListener(MouseEvent.CLICK,DianQuanBuy);
      }
      
      private function doOver(param1:BtnEvent) : void
      {
         var _loc4_:Make = null;
         var _loc2_:String = param1.target.name.substr(0,1);
         var _loc3_:Number = Number(param1.target.name.substr(3,1));
         if(_loc2_ == "m")
         {
            if(bookSlot.getMake(_loc3_) != null)
            {
               _loc4_ = bookSlot.getMake(_loc3_);
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
            state = _loc3_;
            ye = 0;
            initType(state,0);
            initMadeLan(0);
            btnStata(_loc3_,7,"tb_");
            btnStata(0,4,"mk_");
            needZz();
         }
         if(_loc2_ == "f")
         {
            if(_loc3_ == 0)
            {
               if(ye > 0)
               {
                  --ye;
               }
            }
            if(_loc3_ == 1)
            {
               if(dataArr.length > 0)
               {
                  if(ye < dataArr.length - 1)
                  {
                     ++ye;
                  }
               }
            }
            initType(state,ye);
            initMadeLan(0);
            btnStata(0,4,"mk_");
            needZz();
         }
         if(_loc2_ == "m")
         {
            initMadeLan(_loc3_);
            btnStata(_loc3_,4,"mk_");
            needZz(_loc3_);
         }
         if(_loc2_ == "p")
         {
            if(_loc3_ == 0)
            {
               playerState = 1;
            }
            if(_loc3_ == 1)
            {
               playerState = 2;
            }
            state = 0;
            ye = 0;
            initMadeLan(0);
            if(Main.P1P2)
            {
               btnStata(_loc3_,2,"pb_");
               playerGold();
            }
            btnStata(0,4,"mk_");
            needZz();
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
         if(madeOk)
         {
            _loc2_ = bookSlot.getMake(nowId);
            _loc3_ = _loc2_.getType();
            _loc4_ = _loc2_.getNeedType();
            _loc5_ = _loc2_.getNeedId();
            _loc6_ = _loc2_.getNeedNum();
            _loc7_ = _loc2_.getObj();
            _loc8_ = _loc2_.getFinishNum();
            if(deGold(_loc2_.getGold()))
            {
               if(whoFinishMade(_loc3_,_loc7_))
               {
                  whoDelBag(_loc5_,_loc4_,_loc6_);
                  initMadeLan(nowId);
                  playerGold();
                  trace("制作成功");
                  NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"物品已放入背包");
                  AchData.setMakeNum(playerState);
                  AchData.setMadeById(2,_loc7_[0].getId(),playerState,_loc7_.length);
               }
            }
            else
            {
               NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"金币不足");
            }
         }
      }
      
      private function deGold(param1:Number) : Boolean
      {
         if(playerState == 1)
         {
            if(Main.player1.getGold() >= param1)
            {
               Main.player1.payGold(param1);
               return true;
            }
         }
         else if(playerState == 2)
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
         if(playerState == 1)
         {
            return finishMake(param1,param2,Main.player1.getBag());
         }
         if(playerState == 2)
         {
            return finishMake(param1,param2,Main.player2.getBag());
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
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包空间不足");
         return false;
      }
      
      private function whoDelBag(param1:Array, param2:Array, param3:Array) : void
      {
         if(playerState == 1)
         {
            delBag(param1,param2,param3,Main.player1.getBag());
         }
         else if(playerState == 2)
         {
            delBag(param1,param2,param3,Main.player2.getBag());
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
         var _loc2_:Number = NaN;
         var _loc3_:Make = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         _loc2_ = Number(param1.target.name.substr(2,1));
         if(bookSlot.getMake(nowId) != null)
         {
            _loc3_ = bookSlot.getMake(nowId);
            _loc4_ = _loc3_.addNeedOb();
            _loc5_ = _loc3_.getObj();
            _loc6_ = _loc5_[0];
            if(_loc2_ <= 4)
            {
               tooltip.visible = true;
               tooltip.x = Main._stage.mouseX;
               tooltip.y = Main._stage.mouseY;
               if(_loc4_[_loc2_] != null)
               {
                  _loc7_ = _loc4_[_loc2_];
                  if(_loc7_ as Equip)
                  {
                     tooltip.equipTooltip(_loc7_);
                  }
                  else if(_loc7_ as Supplies)
                  {
                     tooltip.suppliesTooltip(_loc7_);
                  }
                  else if(_loc7_ as Gem)
                  {
                     tooltip.gemTooltip(_loc7_);
                  }
                  else if(_loc7_ as Otherobj)
                  {
                     tooltip.otherTooltip(_loc7_);
                  }
               }
            }
            else if(_loc6_ as Equip)
            {
               PropertyScreen.open(_loc6_,false,Main._stage.mouseX,Main._stage.mouseY,"获得后才可以查看属性(属性随机)");
            }
            else
            {
               tooltip.visible = true;
               tooltip.x = mouseX;
               tooltip.y = mouseY;
               if(_loc6_ as Supplies)
               {
                  tooltip.suppliesTooltip(_loc6_);
               }
               else if(_loc6_ as Gem)
               {
                  tooltip.gemTooltip(_loc6_);
               }
               else if(_loc6_ as Otherobj)
               {
                  tooltip.otherTooltip(_loc6_);
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
         tooltip.visible = false;
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
         finishSlot.clearMake();
         initFrame();
         all_makeBtn.gotoAndStop(2);
         gold_text.text = "";
         nowId = param1;
         if(bookSlot.getMake(param1) != null)
         {
            _loc2_ = bookSlot.getMake(param1);
            _loc3_ = _loc2_.addNeedOb();
            _loc4_ = _loc2_.getNeedType();
            _loc5_ = _loc2_.getNeedId();
            _loc6_ = _loc2_.getNeedNum();
            _loc7_ = _loc2_.getObj();
            _loc8_ = _loc2_.getFinishNum();
            nameVisible(_loc5_,_loc4_,_loc6_,_loc3_);
            findIdInBag(_loc5_,_loc4_,_loc6_);
            needMcAp(_loc2_,_loc3_);
            getFinishSlot(_loc7_[0],_loc8_);
            gold_text.text = _loc2_.getGold().toString();
            if(_loc2_.isState())
            {
               madeOk = isOk(_loc5_);
               if(madeOk == true)
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
         if(bookSlot.getMake(param1) != null)
         {
            _loc2_ = bookSlot.getMake(param1);
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
               if(finishSlot.getMake(_loc3_) != null)
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
            finishSlot.addFinish(param1);
            if(finishSlot.getMake(5) != null)
            {
               this.n_5.gotoAndStop(finishSlot.getMake(5).getFrame());
               this.name_5.text = finishSlot.getMake(5).getName();
               if(finishSlot.getMake(5).getColor() == 1)
               {
                  this.name_5.setTextFormat(bai);
               }
               else if(finishSlot.getMake(5).getColor() == 2)
               {
                  this.name_5.setTextFormat(lan);
               }
               else if(finishSlot.getMake(5).getColor() == 3)
               {
                  this.name_5.setTextFormat(zi);
               }
               else if(finishSlot.getMake(5).getColor() == 4 || finishSlot.getMake(5).getColor() == 5)
               {
                  this.name_5.setTextFormat(ch);
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
               _loc5_ = needOk(param1[_loc4_],param2[_loc4_]);
               if(_loc5_ != null)
               {
                  if(dbNum(_loc5_,param2[_loc4_],param3[_loc4_]))
                  {
                     finishSlot.addNeedSlot(_loc4_,_loc5_[0][0]);
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
            _loc3_ = MakeData.getEquip(param1,playerState);
         }
         else if(param2 == 1)
         {
            _loc3_ = MakeData.getSup(param1,playerState);
         }
         else if(param2 == 2)
         {
            _loc3_ = MakeData.getGem(param1,playerState);
         }
         else if(param2 == 3)
         {
            _loc3_ = MakeData.getOther(param1,playerState);
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
         var _loc5_:Array = getName(param1,param2);
         var _loc6_:Array = getNumInBag(param1,param2);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc5_.length)
         {
            if(_loc5_[_loc7_] != "")
            {
               this["name_" + _loc7_].text = _loc5_[_loc7_];
               this["nx_" + _loc7_].text = _loc6_[_loc7_];
               this["nb_" + _loc7_].text = param3[_loc7_];
               this["nx_" + _loc7_].setTextFormat(bai);
               if(_loc6_[_loc7_] < param3[_loc7_])
               {
                  this["nx_" + _loc7_].setTextFormat(hong);
               }
               if(param4[_loc7_].getColor() == 1)
               {
                  this["name_" + _loc7_].setTextFormat(bai);
               }
               else if(param4[_loc7_].getColor() == 2)
               {
                  this["name_" + _loc7_].setTextFormat(lan);
               }
               else if(param4[_loc7_].getColor() == 3)
               {
                  this["name_" + _loc7_].setTextFormat(zi);
               }
               else if(param4[_loc7_].getColor() == 4)
               {
                  this["name_" + _loc7_].setTextFormat(ch);
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
                  if(finishSlot.getMake(_loc3_) != null)
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
               _loc3_ = Number((Main["player" + playerState].getBag() as Bag).getEquipObjNum(param1[_loc5_]));
            }
            else if(param2[_loc5_] == 1)
            {
               _loc3_ = Number((Main["player" + playerState].getBag() as Bag).getSupObjNum(param1[_loc5_]));
            }
            else if(param2[_loc5_] == 2)
            {
               _loc3_ = Number((Main["player" + playerState].getBag() as Bag).getGemNum(param1[_loc5_]));
            }
            else if(param2[_loc5_] == 3)
            {
               _loc3_ = Number((Main["player" + playerState].getBag() as Bag).getOtherobjNum(param1[_loc5_]));
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
            if(finishSlot.getMake(_loc1_) != null)
            {
               this["n_" + _loc1_].gotoAndStop(finishSlot.getMake(_loc1_).getFrame());
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
      
      private function DianQuanBuy(param1:*) : *
      {
         var _loc6_:Bag = null;
         var _loc2_:Make = bookSlot.getMake(nowId);
         var _loc3_:Number = _loc2_.getType();
         var _loc4_:Array = _loc2_.getObj();
         var _loc5_:uint = _loc2_.getDj();
         if(playerState == 1)
         {
            _loc6_ = Main.player1.getBag();
         }
         else if(playerState == 2)
         {
            _loc6_ = Main.player2.getBag();
         }
         if(SelBagNum(_loc3_,_loc4_,_loc6_))
         {
            if(Shop4399.moneyAll.getValue() < _loc5_)
            {
               (NoMoney_mc as NoMoneyInfo).Open(_loc5_);
               return;
            }
            BuyOpen(_loc5_);
         }
      }
      
      private function BuyOpen(param1:uint) : *
      {
         buy_mc.x = buy_mc.y = 0;
         buy_mc.visible = true;
         buy_mc._txt.text = "是否要消费" + param1 + "点券购买";
         buy_mc.yes_btn.addEventListener(MouseEvent.CLICK,BuyGo);
         buy_mc.no_btn.addEventListener(MouseEvent.CLICK,BuyClose);
      }
      
      private function BuyClose(param1:* = null) : *
      {
         buy_mc.x = buy_mc.y = 5000;
         buy_mc.visible = false;
         buy_mc.yes_btn.removeEventListener(MouseEvent.CLICK,BuyGo);
         buy_mc.no_btn.removeEventListener(MouseEvent.CLICK,BuyClose);
      }
      
      private function BuyGo(param1:*) : *
      {
         MakePanel._instance._BLACK_mc.visible = true;
         var _loc2_:Make = bookSlot.getMake(nowId);
         buyType = _loc2_.getType();
         buyObjArr = _loc2_.getObj();
         var _loc3_:uint = _loc2_.getDj();
         var _loc4_:uint = _loc2_.getSCID();
         Api_4399_All.BuyObj(_loc4_);
      }
      
      public function GetBuyObj() : *
      {
         if(Boolean(buyObjArr) && buyObjArr.length > 0)
         {
            whoFinishMade(buyType,buyObjArr);
            buyObjArr = new Array();
            _BLACK_mc.visible = false;
            dianQun_Point.text = "" + Shop4399.moneyAll.getValue();
            BuyClose();
            Main.Save();
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"物品已放入背包");
         }
      }
      
      private function SelBagNum(param1:Number, param2:Array, param3:Bag) : Boolean
      {
         var _loc4_:Gem = null;
         var _loc5_:Number = NaN;
         var _loc6_:Otherobj = null;
         if(param1 == 0 || param1 == 4 || param1 == 6)
         {
            if(param3.backequipBagNum() >= param2.length)
            {
               return true;
            }
         }
         else if(param1 == 1)
         {
            if(param3.backSuppliesBagNum() >= param2.length)
            {
               return true;
            }
         }
         else if(param1 == 2)
         {
            _loc4_ = param2[0];
            _loc5_ = _loc4_.getId();
            if(param3.canPutGemNum(_loc5_) >= param2.length)
            {
               return true;
            }
         }
         else if(param1 == 3)
         {
            _loc6_ = param2[0];
            _loc5_ = _loc6_.getId();
            if(param3.canPutOtherNum(_loc5_) >= param2.length)
            {
               return true;
            }
         }
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包空间不足");
         return false;
      }
   }
}

