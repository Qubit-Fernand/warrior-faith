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
      
      private function initType(type:Number = 0, num:Number = 0) : void
      {
         this.dataArr = MakeData.getArr4(type);
         this.bookSlot.clearMake();
         this.iniSlot(this.dataArr,num);
         this.initBook();
         this.yeNum();
      }
      
      private function iniSlot(typeArr:Array, num:Number = 0) : void
      {
         var i:uint = 0;
         var arr:Array = typeArr[num];
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               this.bookSlot.addSlot(arr[i]);
            }
         }
      }
      
      private function initBook() : void
      {
         var m:Make = null;
         for(var i:uint = 0; i < 4; i++)
         {
            if(this.bookSlot.getMake(i) != null)
            {
               m = this.bookSlot.getMake(i);
               trace(m.getFrame() + ":m.getFrame()");
               this["bk_" + i].gotoAndStop(m.getFrame());
               if(m.isState())
               {
                  this["bk_" + i].m_mask.gotoAndStop(2);
               }
               else
               {
                  this["bk_" + i].m_mask.gotoAndStop(1);
               }
            }
            else
            {
               this["bk_" + i].gotoAndStop(1);
               this["bk_" + i].m_mask.gotoAndStop(2);
            }
         }
      }
      
      private function yeNum() : void
      {
         var num:uint = 0;
         if(this.dataArr.length < 1)
         {
            num = 1;
         }
         else
         {
            num = uint(this.dataArr.length);
         }
         this.num1.text = String(this.ye + 1) + "/" + num;
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
      
      private function doOver(e:BtnEvent) : void
      {
         var make:Make = null;
         var nameId:String = e.target.name.substr(0,1);
         var id:Number = Number(e.target.name.substr(3,1));
         if(nameId == "m")
         {
            if(this.bookSlot.getMake(id) != null)
            {
               make = this.bookSlot.getMake(id);
               if(make.isState() == false)
               {
                  PropertyScreen.open(make,false,Main._stage.mouseX,Main._stage.mouseY,make.getSm());
               }
            }
         }
      }
      
      private function doOut(e:BtnEvent) : void
      {
         PropertyScreen.close();
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
      
      private function doChange(e:BtnEvent) : void
      {
         var nameId:String = e.target.name.substr(0,1);
         var id:Number = Number(e.target.name.substr(3,1));
         if(nameId == "t")
         {
            this.state = id;
            this.ye = 0;
            this.initType(this.state,0);
            this.initMadeLan(0);
            this.btnStata(id,7,"tb_");
            this.btnStata(0,4,"mk_");
            this.needZz();
         }
         if(nameId == "f")
         {
            if(id == 0)
            {
               if(this.ye > 0)
               {
                  --this.ye;
               }
            }
            if(id == 1)
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
         if(nameId == "m")
         {
            this.initMadeLan(id);
            this.btnStata(id,4,"mk_");
            this.needZz(id);
         }
         if(nameId == "p")
         {
            if(id == 0)
            {
               this.playerState = 1;
            }
            if(id == 1)
            {
               this.playerState = 2;
            }
            this.state = 0;
            this.ye = 0;
            this.initMadeLan(0);
            if(Main.P1P2)
            {
               this.btnStata(id,2,"pb_");
               this.playerGold();
            }
            this.btnStata(0,4,"mk_");
            this.needZz();
         }
      }
      
      private function doClick(e:BtnEvent) : void
      {
         var make:Make = null;
         var type:Number = NaN;
         var makeType:Array = null;
         var makeId:Array = null;
         var makeNum:Array = null;
         var finishArr:Array = null;
         var finishNum:Number = NaN;
         if(this.madeOk)
         {
            make = this.bookSlot.getMake(this.nowId);
            type = make.getType();
            makeType = make.getNeedType();
            makeId = make.getNeedId();
            makeNum = make.getNeedNum();
            finishArr = make.getObj();
            finishNum = make.getFinishNum();
            if(this.deGold(make.getGold()))
            {
               if(this.whoFinishMade(type,finishArr))
               {
                  this.whoDelBag(makeId,makeType,makeNum);
                  this.initMadeLan(this.nowId);
                  this.playerGold();
                  trace("制作成功");
                  ShortTip.open(29);
                  AchData.setMakeNum(this.playerState);
                  AchData.setMadeById(2,finishArr[0].getId(),this.playerState,finishArr.length);
               }
            }
            else
            {
               ShortTip.open(16);
            }
         }
      }
      
      private function deGold(gold:Number) : Boolean
      {
         if(this.playerState == 1)
         {
            if(Main.player1.getGold() >= gold)
            {
               Main.player1.payGold(gold);
               return true;
            }
         }
         else if(this.playerState == 2)
         {
            if(Main.player2.getGold() >= gold)
            {
               Main.player2.payGold(gold);
               return true;
            }
         }
         trace("金币不足");
         return false;
      }
      
      private function whoFinishMade(type:Number, arr:Array) : Boolean
      {
         if(this.playerState == 1)
         {
            return this.finishMake(type,arr,Main.player1.getBag());
         }
         if(this.playerState == 2)
         {
            return this.finishMake(type,arr,Main.player2.getBag());
         }
      }
      
      private function finishMake(type:Number, arr:Array, bag:Bag) : Boolean
      {
         var i:uint = 0;
         var gem:Gem = null;
         var num:Number = NaN;
         var other:Otherobj = null;
         if(type == 0 || type == 4 || type == 6)
         {
            if(bag.backequipBagNum() >= arr.length)
            {
               for(i = 0; i < arr.length; i++)
               {
                  bag.addEquipBag(arr[i]);
               }
               return true;
            }
            trace("装备栏满");
         }
         else if(type == 1)
         {
            trace("药品栏剩余格数:" + bag.backSuppliesBagNum());
            if(bag.backSuppliesBagNum() >= arr.length)
            {
               for(i = 0; i < arr.length; i++)
               {
                  bag.addSuppliesBag(arr[i]);
               }
               return true;
            }
            trace("药品栏满");
         }
         else if(type == 2)
         {
            gem = arr[0];
            num = gem.getId();
            trace("其他栏剩余:" + bag.canPutGemNum(num));
            if(bag.canPutGemNum(num) >= arr.length)
            {
               for(i = 0; i < arr.length; i++)
               {
                  bag.addGemBag(arr[i]);
               }
               return true;
            }
            trace("宝石栏满");
         }
         else if(type == 3)
         {
            other = arr[0];
            num = other.getId();
            trace("其他栏剩余:" + bag.canPutOtherNum(num));
            if(bag.canPutOtherNum(num) >= arr.length)
            {
               for(i = 0; i < arr.length; i++)
               {
                  bag.addOtherobjBag(arr[i]);
               }
               return true;
            }
            trace("其他栏满");
         }
         ShortTip.open(3);
         return false;
      }
      
      private function whoDelBag(idArr:Array, type:Array, numArr:Array) : void
      {
         if(this.playerState == 1)
         {
            this.delBag(idArr,type,numArr,Main.player1.getBag());
         }
         else if(this.playerState == 2)
         {
            this.delBag(idArr,type,numArr,Main.player2.getBag());
         }
      }
      
      private function delBag(idArr:Array, type:Array, numArr:Array, bag:Bag) : void
      {
         for(var i:uint = 0; i < idArr.length; i++)
         {
            if(idArr[i] != -1)
            {
               if(type[i] == 0 || type[i] == 4)
               {
                  bag.delEquipById(idArr[i],numArr[i]);
               }
               else if(type[i] == 1)
               {
                  bag.delSuppliesById(idArr[i],numArr[i]);
               }
               else if(type[i] == 2)
               {
                  bag.delGemById(idArr[i],numArr[i]);
               }
               else if(type[i] == 3)
               {
                  trace("删除其他");
                  bag.delOtherById(idArr[i],numArr[i]);
               }
            }
         }
      }
      
      private function daoJuOver(e:DaoJuEvent) : void
      {
         var make:Make = null;
         var arr:Array = null;
         var finishArr:Array = null;
         var finishObj:Object = null;
         var ob:Object = null;
         var id:Number = Number(e.target.name.substr(2,1));
         if(this.bookSlot.getMake(this.nowId) != null)
         {
            make = this.bookSlot.getMake(this.nowId);
            arr = make.addNeedOb();
            finishArr = make.getObj();
            finishObj = finishArr[0];
            if(id <= 4)
            {
               this.tooltip.visible = true;
               this.tooltip.x = Main._stage.mouseX;
               this.tooltip.y = Main._stage.mouseY;
               if(arr[id] != null)
               {
                  ob = arr[id];
                  if(ob as Equip)
                  {
                     this.tooltip.equipTooltip(ob);
                  }
                  else if(ob as Supplies)
                  {
                     this.tooltip.suppliesTooltip(ob);
                  }
                  else if(ob as Gem)
                  {
                     this.tooltip.gemTooltip(ob);
                  }
                  else if(ob as Otherobj)
                  {
                     this.tooltip.otherTooltip(ob);
                  }
               }
            }
            else if(finishObj as Equip)
            {
               PropertyScreen.open(finishObj,false,Main._stage.mouseX,Main._stage.mouseY,"获得后才可以查看属性(属性随机)");
            }
            else
            {
               this.tooltip.visible = true;
               this.tooltip.x = mouseX;
               this.tooltip.y = mouseY;
               if(finishObj as Supplies)
               {
                  this.tooltip.suppliesTooltip(finishObj);
               }
               else if(finishObj as Gem)
               {
                  this.tooltip.gemTooltip(finishObj);
               }
               else if(finishObj as Otherobj)
               {
                  this.tooltip.otherTooltip(finishObj);
               }
            }
         }
      }
      
      private function pointY(mc:MovieClip) : void
      {
         trace(mc.height + ":mc.height");
         var myPoint:Point = new Point(mc.x,mc.y);
         myPoint = this.localToGlobal(myPoint);
         if(myPoint.y + mc.height > 580)
         {
            mc.y = 580 - mc.height - 80;
         }
         if(myPoint.y < 0)
         {
            mc.y = 0;
         }
         if(myPoint.x + mc.width > 940)
         {
            mc.x = 940 - mc.width - 40;
         }
      }
      
      private function daoJuOut(e:DaoJuEvent) : void
      {
         this.tooltip.visible = false;
         PropertyScreen.close();
      }
      
      private function initMadeLan(id:Number) : void
      {
         var make:Make = null;
         var makeOb:Array = null;
         var makeType:Array = null;
         var makeId:Array = null;
         var makeNum:Array = null;
         var finishArr:Array = null;
         var finishNum:Number = NaN;
         this.finishSlot.clearMake();
         this.initFrame();
         all_makeBtn.gotoAndStop(2);
         gold_text.text = "";
         this.nowId = id;
         if(this.bookSlot.getMake(id) != null)
         {
            make = this.bookSlot.getMake(id);
            makeOb = make.addNeedOb();
            makeType = make.getNeedType();
            makeId = make.getNeedId();
            makeNum = make.getNeedNum();
            finishArr = make.getObj();
            finishNum = make.getFinishNum();
            this.nameVisible(makeId,makeType,makeNum,makeOb);
            this.findIdInBag(makeId,makeType,makeNum);
            this.needMcAp(make,makeOb);
            this.getFinishSlot(finishArr[0],finishNum);
            gold_text.text = make.getGold().toString();
            if(make.isState())
            {
               this.madeOk = this.isOk(makeId);
               if(this.madeOk == true)
               {
                  all_makeBtn.gotoAndStop(1);
               }
            }
         }
      }
      
      private function needZz(id:Number = 0) : void
      {
         var make:Make = null;
         var makeId:Array = null;
         var i:uint = 0;
         if(this.bookSlot.getMake(id) != null)
         {
            make = this.bookSlot.getMake(id);
            makeId = make.getNeedId();
            for(i = 0; i < makeId.length; i++)
            {
               if(makeId[i] == -1)
               {
                  this["z_" + i].visible = true;
               }
               else
               {
                  this["z_" + i].visible = false;
               }
            }
         }
         else
         {
            for(i = 0; i < 5; i++)
            {
               this["z_" + i].visible = false;
            }
         }
      }
      
      private function isOk(idArr:Array) : Boolean
      {
         var arr:Array = [];
         for(var i:uint = 0; i < idArr.length; i++)
         {
            if(idArr[i] != -1)
            {
               if(this.finishSlot.getMake(i) != null)
               {
                  arr.push(1);
               }
               else
               {
                  arr.push(-1);
               }
            }
            else
            {
               arr.push(1);
            }
         }
         for(i = 0; i < arr.length; i++)
         {
            if(arr[i] == -1)
            {
               return false;
            }
         }
         return true;
      }
      
      private function getFinishSlot(ob:Object, num:Number) : void
      {
         if(ob != null)
         {
            trace(ob.getColor() + "__________");
            this.finishSlot.addFinish(ob);
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
            if(num > 1)
            {
               this.n_5.howNum.text = String(num);
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
      
      private function findIdInBag(makeId:Array, makeType:Array, numType:Array) : void
      {
         var arr:Array = null;
         for(var i:uint = 0; i < makeId.length; i++)
         {
            arr = [];
            if(makeId[i] != -1)
            {
               arr = this.needOk(makeId[i],makeType[i]);
               if(arr != null)
               {
                  if(this.dbNum(arr,makeType[i],numType[i]))
                  {
                     this.finishSlot.addNeedSlot(i,arr[0][0]);
                  }
               }
            }
         }
      }
      
      private function needOk(id:Number, type:Number) : Array
      {
         var xxx:Array = [];
         if(type == 0 || type == 4)
         {
            xxx = MakeData.getEquip(id,this.playerState);
         }
         else if(type == 1)
         {
            xxx = MakeData.getSup(id,this.playerState);
         }
         else if(type == 2)
         {
            xxx = MakeData.getGem(id,this.playerState);
         }
         else if(type == 3)
         {
            xxx = MakeData.getOther(id,this.playerState);
         }
         return xxx;
      }
      
      private function dbNum(arr:Array, type:Number, num:Number) : Boolean
      {
         var gem:Gem = null;
         var other:Otherobj = null;
         var lengthNum:Number = Number(arr[0].length);
         var times:Number = 0;
         for(var i:uint = 0; i < lengthNum; i++)
         {
            if(type == 0 || type == 1)
            {
               if(lengthNum >= num)
               {
                  return true;
               }
            }
            else if(type == 2)
            {
               gem = arr[0][i];
               if(gem.getIsPile())
               {
                  times += gem.getTimes();
                  if(times >= num)
                  {
                     return true;
                  }
               }
               else if(lengthNum >= num)
               {
                  return true;
               }
            }
            else if(type == 3)
            {
               other = arr[0][i];
               if(other.isMany())
               {
                  times += other.getTimes();
                  if(times >= num)
                  {
                     return true;
                  }
               }
               else if(lengthNum >= num)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function nameVisible(id:Array, type:Array, num:Array, ob:Array) : void
      {
         var arr:Array = this.getName(id,type);
         var bagNum:Array = this.getNumInBag(id,type);
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(arr[i] != "")
            {
               this["name_" + i].text = arr[i];
               this["nx_" + i].text = bagNum[i];
               this["nb_" + i].text = num[i];
               this["nx_" + i].setTextFormat(this.bai);
               if(bagNum[i] < num[i])
               {
                  this["nx_" + i].setTextFormat(this.hong);
               }
               if(ob[i].getColor() == 1)
               {
                  this["name_" + i].setTextFormat(this.bai);
               }
               else if(ob[i].getColor() == 2)
               {
                  this["name_" + i].setTextFormat(this.lan);
               }
               else if(ob[i].getColor() == 3)
               {
                  this["name_" + i].setTextFormat(this.zi);
               }
               else if(ob[i].getColor() == 4)
               {
                  this["name_" + i].setTextFormat(this.ch);
               }
            }
            else
            {
               this["name_" + i].text = "";
               this["nx_" + i].text = "";
               this["nb_" + i].text = "";
            }
         }
      }
      
      public function needMcAp(make:Make, obArr:Array) : void
      {
         var i:uint = 0;
         if(make.isState() == false)
         {
            trace("没激活");
            for(i = 0; i < obArr.length; i++)
            {
               if(obArr[i] != null)
               {
                  this["n_" + i].gotoAndStop(obArr[i].getFrame());
                  trace(obArr[i].getFrame() + ":obArr[i].getFrame()");
                  this["n_" + i].ob_mast.gotoAndStop(3);
               }
               else
               {
                  this["n_" + i].gotoAndStop(1);
                  this["n_" + i].ob_mast.gotoAndStop(1);
               }
            }
         }
         else
         {
            trace("有激活");
            for(i = 0; i < obArr.length; i++)
            {
               if(obArr[i] != null)
               {
                  this["n_" + i].gotoAndStop(obArr[i].getFrame());
                  if(this.finishSlot.getMake(i) != null)
                  {
                     this["n_" + i].ob_mast.gotoAndStop(1);
                  }
                  else
                  {
                     this["n_" + i].ob_mast.gotoAndStop(2);
                  }
               }
               else
               {
                  this["n_" + i].gotoAndStop(1);
                  this["n_" + i].ob_mast.gotoAndStop(1);
               }
            }
         }
      }
      
      private function getName(id:Array, type:Array) : Array
      {
         var name:String = null;
         var nameArr:Array = [];
         for(var i:uint = 0; i < id.length; i++)
         {
            if(id[i] == -1)
            {
               name = "";
            }
            else if(type[i] == 0 || type[i] == 4)
            {
               name = EquipFactory.findName(id[i]);
            }
            else if(type[i] == 1)
            {
               name = SuppliesFactory.findName(id[i]);
            }
            else if(type[i] == 2)
            {
               name = GemFactory.findName(id[i]);
            }
            else if(type[i] == 3)
            {
               name = OtherFactory.getName(id[i]);
            }
            nameArr.push(name);
         }
         return nameArr;
      }
      
      private function getNumInBag(id:Array, type:Array) : Array
      {
         var num:Number = 0;
         var numArr:Array = [];
         for(var i:uint = 0; i < id.length; i++)
         {
            if(id[i] == -1)
            {
               num = 0;
            }
            else if(type[i] == 0 || type[i] == 4)
            {
               num = Number((Main["player" + this.playerState].getBag() as Bag).getEquipObjNum(id[i]));
            }
            else if(type[i] == 1)
            {
               num = Number((Main["player" + this.playerState].getBag() as Bag).getSupObjNum(id[i]));
            }
            else if(type[i] == 2)
            {
               num = Number((Main["player" + this.playerState].getBag() as Bag).getGemNum(id[i]));
            }
            else if(type[i] == 3)
            {
               num = Number((Main["player" + this.playerState].getBag() as Bag).getOtherobjNum(id[i]));
            }
            numArr.push(num);
         }
         return numArr;
      }
      
      private function needFrame() : void
      {
         for(var i:uint = 0; i < 5; i++)
         {
            if(this.finishSlot.getMake(i) != null)
            {
               this["n_" + i].gotoAndStop(this.finishSlot.getMake(i).getFrame());
            }
            else
            {
               this["n_" + i].gotoAndStop(1);
            }
         }
      }
      
      private function initFrame() : void
      {
         for(var i:uint = 0; i < 6; i++)
         {
            this["n_" + i].gotoAndStop(1);
            this["n_" + i].ob_mast.gotoAndStop(1);
            this["n_" + i].howNum.text = "";
            this["name_" + i].text = "";
         }
         for(i = 0; i < 5; i++)
         {
            this["nx_" + i].text = "";
            this["nb_" + i].text = "";
         }
      }
      
      private function doClose(e:BtnEvent) : void
      {
         close();
      }
   }
}

