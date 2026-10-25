package src
{
   import com.*;
   import com.efnx.fps.*;
   import com.hotpoint.braveManIII.models.plan.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.plan.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.cardPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   import src._data.*;
   import src.tool.*;
   
   public class JiHua_Interface extends MovieClip
   {
      
      private static var loadData:ClassLoader;
      
      private static var _this:JiHua_Interface;
      
      public static var itemsTooltip:ItemsTooltip;
      
      private static var OpenYN:Boolean = false;
      
      private static var loadName:String = "YZJH.swf";
      
      private static var lvNum:int = 0;
      
      private static var xzNum:int = 0;
      
      private static var lvMAX:int = 0;
      
      private static var yeshu:int = 1;
      
      private static var yeshuAll:int = 1;
      
      private static var arr1:Array = [];
      
      private static var arr2:Array = [];
      
      private static var arr3:Array = [];
      
      private static var arr4:Array = [];
      
      private static var arr5:Array = [];
      
      private static var arr6:Array = [];
      
      private static var arr7:Array = [];
      
      private static var arr8:Array = [];
      
      public static var ppp1_12:Boolean = false;
      
      public static var ppp1_14:Boolean = false;
      
      public static var ppp2_6:Boolean = false;
      
      public static var ppp2_7:Boolean = false;
      
      public static var ppp2_13:Boolean = false;
      
      public static var ppp3_14:Boolean = false;
      
      public static var ppp4_9:Boolean = false;
      
      public static var ppp4_10:Boolean = false;
      
      public static var ppp4_13:Boolean = false;
      
      public static var ppp5_4:Boolean = false;
      
      public static var ppp5_11:Boolean = false;
      
      public static var ppp5_17:Boolean = false;
      
      public static var ppp6_6:Boolean = false;
      
      private var skin:MovieClip;
      
      public function JiHua_Interface()
      {
         super();
         initArr();
         itemsTooltip = new ItemsTooltip();
         LoadSkin();
         _this = this;
      }
      
      private static function InitOpen() : *
      {
         var _loc1_:JiHua_Interface = new JiHua_Interface();
         Main._stage.addChild(_loc1_);
         OpenYN = true;
      }
      
      public static function Open() : *
      {
         if(_this)
         {
            Play_Interface.jihuaTiShi(false);
            xiufu();
            planGO();
            _this.visible = true;
            _this.x = _this.y = 0;
            lvShow();
         }
         else
         {
            InitOpen();
         }
      }
      
      public static function CloseX() : *
      {
         if(_this)
         {
            _this.visible = false;
            _this.x = _this.y = 5000;
         }
      }
      
      private static function goLunTan(param1:*) : *
      {
         ppp1_14 = true;
         var _loc2_:URLRequest = new URLRequest("http://my.4399.com/forums-thread-tagid-81127-id-35112154.html");
         navigateToURL(_loc2_,"_blank");
      }
      
      public static function initArr() : *
      {
         arr1 = [];
         arr2 = [];
         arr3 = [];
         arr4 = [];
         arr5 = [];
         arr6 = [];
         arr7 = [];
         arr8 = [];
         for(i in PlanFactory.JiHuaData)
         {
            if((PlanFactory.JiHuaData[i] as Plan).getGroup() == 1)
            {
               arr1.push(PlanFactory.JiHuaData[i]);
            }
            if((PlanFactory.JiHuaData[i] as Plan).getGroup() == 2)
            {
               TiaoShi.txtShow("i = " + i);
               arr2.push(PlanFactory.JiHuaData[i]);
            }
            if((PlanFactory.JiHuaData[i] as Plan).getGroup() == 3)
            {
               arr3.push(PlanFactory.JiHuaData[i]);
            }
            if((PlanFactory.JiHuaData[i] as Plan).getGroup() == 4)
            {
               arr4.push(PlanFactory.JiHuaData[i]);
            }
            if((PlanFactory.JiHuaData[i] as Plan).getGroup() == 5)
            {
               arr5.push(PlanFactory.JiHuaData[i]);
            }
            if((PlanFactory.JiHuaData[i] as Plan).getGroup() == 6)
            {
               arr6.push(PlanFactory.JiHuaData[i]);
            }
            if((PlanFactory.JiHuaData[i] as Plan).getGroup() == 7)
            {
               arr7.push(PlanFactory.JiHuaData[i]);
            }
            if((PlanFactory.JiHuaData[i] as Plan).getGroup() == 8)
            {
               arr8.push(PlanFactory.JiHuaData[i]);
            }
         }
      }
      
      public static function lvShow() : *
      {
         var _loc1_:int = 0;
         _this.skin["dj0"].visible = true;
         if(arr1.length > 0)
         {
            _loc1_ = 0;
            for(i in arr1)
            {
               if((arr1[i] as Plan).getState() != 0)
               {
                  _loc1_++;
               }
            }
            if(_loc1_ >= arr1.length)
            {
               lvMAX = 1;
               _this.skin["dj1"].visible = true;
            }
         }
         if(arr2.length > 0)
         {
            _loc1_ = 0;
            for(i in arr2)
            {
               if((arr2[i] as Plan).getState() != 0)
               {
                  _loc1_++;
               }
            }
            if(_loc1_ >= arr2.length)
            {
               lvMAX = 2;
               _this.skin["dj2"].visible = true;
            }
         }
         if(arr3.length > 0)
         {
            _loc1_ = 0;
            for(i in arr3)
            {
               if((arr3[i] as Plan).getState() != 0)
               {
                  _loc1_++;
               }
            }
            if(_loc1_ >= arr3.length)
            {
               lvMAX = 3;
               _this.skin["dj3"].visible = true;
            }
         }
         if(arr4.length > 0)
         {
            _loc1_ = 0;
            for(i in arr4)
            {
               if((arr4[i] as Plan).getState() != 0)
               {
                  _loc1_++;
               }
            }
            if(_loc1_ >= arr4.length)
            {
               lvMAX = 4;
               _this.skin["dj4"].visible = true;
            }
         }
         if(arr5.length > 0)
         {
            _loc1_ = 0;
            for(i in arr5)
            {
               if((arr5[i] as Plan).getState() != 0)
               {
                  _loc1_++;
               }
            }
            if(_loc1_ >= arr5.length)
            {
               lvMAX = 5;
               _this.skin["dj5"].visible = true;
            }
         }
         if(arr6.length > 0)
         {
            _loc1_ = 0;
            for(i in arr6)
            {
               if((arr6[i] as Plan).getState() != 0)
               {
                  _loc1_++;
               }
            }
            if(_loc1_ >= arr6.length)
            {
               lvMAX = 6;
               _this.skin["dj6"].visible = true;
            }
         }
         if(arr7.length > 0)
         {
            _loc1_ = 0;
            for(i in arr7)
            {
               if((arr7[i] as Plan).getState() != 0)
               {
                  _loc1_++;
               }
            }
            if(_loc1_ >= arr7.length)
            {
               lvMAX = 7;
               _this.skin["dj7"].visible = true;
            }
         }
         lvChangeShow();
         txtShow();
      }
      
      public static function lvChangeShow() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _this.skin["dj" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
         _this.skin["dj" + lvNum].gotoAndStop(3);
      }
      
      private static function lvChose(param1:*) : *
      {
         lvNum = (param1.target as MovieClip).name.substr(2,1);
         yeshu = 1;
         lvChangeShow();
         txtShow();
      }
      
      private static function lvOUT(param1:*) : *
      {
         if(lvNum == (param1.target as MovieClip).name.substr(2,1))
         {
            (param1.target as MovieClip).gotoAndStop(3);
         }
         else
         {
            (param1.target as MovieClip).gotoAndStop(1);
         }
      }
      
      private static function lvOVER(param1:*) : *
      {
         (param1.target as MovieClip).gotoAndStop(2);
      }
      
      private static function xzOUT(param1:*) : *
      {
         if(xzNum == (param1.target as MovieClip).name.substr(2,1))
         {
            (param1.target as MovieClip).gotoAndStop(3);
         }
         else
         {
            (param1.target as MovieClip).gotoAndStop(1);
         }
      }
      
      private static function xzOVER(param1:*) : *
      {
         (param1.target as MovieClip).gotoAndStop(2);
      }
      
      private static function xzChose(param1:*) : *
      {
         xzNum = (param1.target as MovieClip).name.substr(2,1);
         txtShow();
      }
      
      public static function xzChangeShow() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _this.skin["xz" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
         _this.skin["xz" + xzNum].gotoAndStop(3);
      }
      
      public static function jiangliShow() : *
      {
         if(getPlan(xzNum + (yeshu - 1) * 8))
         {
            _this.skin["jl1"].gotoAndStop(getPlan(xzNum + (yeshu - 1) * 8).getFrame_1());
            if(getPlan(xzNum + (yeshu - 1) * 8).getCount_1() > 1)
            {
               _this.skin["jl1"]["t_txt"].text = getPlan(xzNum + (yeshu - 1) * 8).getCount_1();
            }
            else
            {
               _this.skin["jl1"]["t_txt"].text = "";
            }
            _this.skin["jl2"].gotoAndStop(getPlan(xzNum + (yeshu - 1) * 8).getFrame_2());
            if(getPlan(xzNum + (yeshu - 1) * 8).getCount_2() > 1)
            {
               _this.skin["jl2"]["t_txt"].text = getPlan(xzNum + (yeshu - 1) * 8).getCount_2();
            }
            else
            {
               _this.skin["jl2"]["t_txt"].text = "";
            }
            _this.skin["jl1"].visible = true;
            _this.skin["jl2"].visible = true;
            if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 0)
            {
               _this.skin["jl2"].visible = false;
            }
         }
         else
         {
            _this.skin["jl1"].visible = false;
            _this.skin["jl2"].visible = false;
         }
      }
      
      public static function getPlan(param1:int) : Plan
      {
         if(lvNum == 0)
         {
            return arr1[param1];
         }
         if(lvNum == 1)
         {
            return arr2[param1];
         }
         if(lvNum == 2)
         {
            return arr3[param1];
         }
         if(lvNum == 3)
         {
            return arr4[param1];
         }
         if(lvNum == 4)
         {
            return arr5[param1];
         }
         if(lvNum == 5)
         {
            return arr6[param1];
         }
         if(lvNum == 6)
         {
            return arr7[param1];
         }
         if(lvNum == 7)
         {
            return arr8[param1];
         }
      }
      
      private static function oneOPEN(param1:*) : *
      {
         _this.skin.addChild(itemsTooltip);
         if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 1)
         {
            itemsTooltip.equipTooltip(EquipFactory.createEquipByID(getPlan(xzNum + (yeshu - 1) * 8).getReward_1()));
         }
         else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 2)
         {
            itemsTooltip.suppliesTooltip(SuppliesFactory.getSuppliesById(getPlan(xzNum + (yeshu - 1) * 8).getReward_1()));
         }
         else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 3)
         {
            itemsTooltip.gemTooltip(GemFactory.creatGemById(getPlan(xzNum + (yeshu - 1) * 8).getReward_1()));
         }
         else
         {
            if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() != 4)
            {
               return;
            }
            itemsTooltip.otherTooltip(OtherFactory.creatOther(getPlan(xzNum + (yeshu - 1) * 8).getReward_1()));
         }
         itemsTooltip.x = _this.skin.mouseX + 5;
         itemsTooltip.y = _this.skin.mouseY;
         itemsTooltip.setTooltipPoint();
         itemsTooltip.visible = true;
      }
      
      private static function jlCLOSE(param1:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function towOPEN(param1:*) : *
      {
         _this.skin.addChild(itemsTooltip);
         if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 1)
         {
            itemsTooltip.equipTooltip(EquipFactory.createEquipByID(getPlan(xzNum + (yeshu - 1) * 8).getReward_2()));
         }
         if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 2)
         {
            itemsTooltip.suppliesTooltip(SuppliesFactory.getSuppliesById(getPlan(xzNum + (yeshu - 1) * 8).getReward_2()));
         }
         if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 3)
         {
            itemsTooltip.gemTooltip(GemFactory.creatGemById(getPlan(xzNum + (yeshu - 1) * 8).getReward_2()));
         }
         if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 4)
         {
            itemsTooltip.otherTooltip(OtherFactory.creatOther(getPlan(xzNum + (yeshu - 1) * 8).getReward_2()));
            itemsTooltip.x = _this.skin.mouseX + 5;
            itemsTooltip.y = _this.skin.mouseY;
            itemsTooltip.setTooltipPoint();
            itemsTooltip.visible = true;
            return;
         }
      }
      
      private static function lingqu(param1:*) : *
      {
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         if(getPlan(xzNum + (yeshu - 1) * 8).getState() == 1)
         {
            if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2())
            {
               if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 1)
               {
                  if(Main.player1.getBag().backequipBagNum() >= 2)
                  {
                     _loc2_ = true;
                     _loc3_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 2)
               {
                  if(Main.player1.getBag().backSuppliesBagNum() >= 2)
                  {
                     _loc2_ = true;
                     _loc3_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 3)
               {
                  if(Main.player1.getBag().backGemBagNum() >= 2)
                  {
                     _loc2_ = true;
                     _loc3_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 4)
               {
                  if(Main.player1.getBag().backOtherBagNum() >= 2)
                  {
                     _loc2_ = true;
                     _loc3_ = true;
                  }
               }
            }
            else
            {
               if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 0)
               {
                  _loc2_ = true;
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 1)
               {
                  if(Main.player1.getBag().backequipBagNum() >= 1)
                  {
                     _loc2_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 2)
               {
                  if(Main.player1.getBag().backSuppliesBagNum() >= 1)
                  {
                     _loc2_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 3)
               {
                  if(Main.player1.getBag().backGemBagNum() >= 1)
                  {
                     _loc2_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 4)
               {
                  if(Main.player1.getBag().backOtherBagNum() >= 1)
                  {
                     _loc2_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 5)
               {
                  _loc2_ = true;
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 6)
               {
                  _loc2_ = true;
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 7)
               {
                  _loc2_ = true;
               }
               if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 0)
               {
                  _loc3_ = true;
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 1)
               {
                  if(Main.player1.getBag().backequipBagNum() >= 1)
                  {
                     _loc3_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 2)
               {
                  if(Main.player1.getBag().backSuppliesBagNum() >= 1)
                  {
                     _loc3_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 3)
               {
                  if(Main.player1.getBag().backGemBagNum() >= 1)
                  {
                     _loc3_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 4)
               {
                  if(Main.player1.getBag().backOtherBagNum() >= 1)
                  {
                     _loc3_ = true;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 5)
               {
                  _loc3_ = true;
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 6)
               {
                  _loc3_ = true;
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 7)
               {
                  _loc3_ = true;
               }
            }
            if(_loc2_ && _loc3_)
            {
               if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 1)
               {
                  Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(getPlan(xzNum + (yeshu - 1) * 8).getReward_1()));
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 2)
               {
                  Main.player1.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(getPlan(xzNum + (yeshu - 1) * 8).getReward_1()));
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 3)
               {
                  _loc4_ = 0;
                  while(_loc4_ < getPlan(xzNum + (yeshu - 1) * 8).getCount_1())
                  {
                     Main.player1.getBag().addGemBag(GemFactory.creatGemById(getPlan(xzNum + (yeshu - 1) * 8).getReward_1()));
                     _loc4_++;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 4)
               {
                  _loc4_ = 0;
                  while(_loc4_ < getPlan(xzNum + (yeshu - 1) * 8).getCount_1())
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(getPlan(xzNum + (yeshu - 1) * 8).getReward_1()));
                     _loc4_++;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 5)
               {
                  Main.player1.addGold(getPlan(xzNum + (yeshu - 1) * 8).getReward_1());
                  if(Main.P1P2)
                  {
                     Main.player2.addGold(getPlan(xzNum + (yeshu - 1) * 8).getReward_1());
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 6)
               {
                  if(Main.player1.getLevel() <= Player.maxLevel)
                  {
                     Main.player_1.ExpUP(getPlan(xzNum + (yeshu - 1) * 8).getReward_1(),2);
                  }
                  if(Main.P1P2)
                  {
                     if(Main.player2.getLevel() <= Player.maxLevel)
                     {
                        Main.player_2.ExpUP(getPlan(xzNum + (yeshu - 1) * 8).getReward_1(),2);
                     }
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_1() == 7)
               {
                  Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() + getPlan(xzNum + (yeshu - 1) * 8).getReward_1());
                  if(Main.P1P2)
                  {
                     Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() + getPlan(xzNum + (yeshu - 1) * 8).getReward_1());
                  }
               }
               if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 1)
               {
                  Main.player1.getBag().addEquipBag(EquipFactory.createEquipByID(getPlan(xzNum + (yeshu - 1) * 8).getReward_2()));
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 2)
               {
                  Main.player1.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(getPlan(xzNum + (yeshu - 1) * 8).getReward_2()));
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 3)
               {
                  _loc4_ = 0;
                  while(_loc4_ < getPlan(xzNum + (yeshu - 1) * 8).getCount_2())
                  {
                     Main.player1.getBag().addGemBag(GemFactory.creatGemById(getPlan(xzNum + (yeshu - 1) * 8).getReward_2()));
                     _loc4_++;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 4)
               {
                  _loc4_ = 0;
                  while(_loc4_ < getPlan(xzNum + (yeshu - 1) * 8).getCount_2())
                  {
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(getPlan(xzNum + (yeshu - 1) * 8).getReward_2()));
                     _loc4_++;
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 5)
               {
                  Main.player1.addGold(getPlan(xzNum + (yeshu - 1) * 8).getReward_2());
                  if(Main.P1P2)
                  {
                     Main.player2.addGold(getPlan(xzNum + (yeshu - 1) * 8).getReward_2());
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 6)
               {
                  if(Main.player1.getLevel() <= Player.maxLevel)
                  {
                     Main.player_1.ExpUP(getPlan(xzNum + (yeshu - 1) * 8).getReward_2(),2);
                  }
                  if(Main.P1P2)
                  {
                     if(Main.player2.getLevel() <= Player.maxLevel)
                     {
                        Main.player_2.ExpUP(getPlan(xzNum + (yeshu - 1) * 8).getReward_2(),2);
                     }
                  }
               }
               else if(getPlan(xzNum + (yeshu - 1) * 8).getRewardType_2() == 7)
               {
                  Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() + getPlan(xzNum + (yeshu - 1) * 8).getReward_2());
                  if(Main.P1P2)
                  {
                     Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() + getPlan(xzNum + (yeshu - 1) * 8).getReward_2());
                  }
               }
               getPlan(xzNum + (yeshu - 1) * 8).setState(2);
               NewMC.Open("文字提示",_this.skin,400,400,30,0,true,2,"领取成功");
            }
            else
            {
               ShortTip.open(3);
            }
         }
         txtShow();
      }
      
      private static function upup(param1:*) : *
      {
         if(yeshu > 1)
         {
            --yeshu;
         }
         txtShow();
      }
      
      private static function down(param1:*) : *
      {
         if(yeshu < yeshuAll)
         {
            ++yeshu;
         }
         txtShow();
      }
      
      public static function txtShow() : *
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         for(_loc2_ in PlanFactory.JiHuaData)
         {
            if((PlanFactory.JiHuaData[_loc2_] as Plan).getGroup() == lvNum + 1)
            {
               _loc1_.push(PlanFactory.JiHuaData[_loc2_]);
            }
         }
         yeshuAll = Math.ceil(_loc1_.length / 8);
         _this.skin["page"].text = yeshu + "/" + yeshuAll;
         if(lvNum == lvMAX)
         {
            _this.skin["jhdc"].visible = false;
         }
         else
         {
            _this.skin["jhdc"].visible = true;
         }
         _this.skin["pic"].gotoAndStop(lvNum + 1);
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            if(_loc1_[_loc2_ + (yeshu - 1) * 8] is Plan)
            {
               _this.skin["xz" + _loc2_].visible = true;
               _this.skin["xh" + _loc2_].text = _loc2_ + (yeshu - 1) * 8 + 1;
               _this.skin["tj" + _loc2_].text = (_loc1_[_loc2_ + (yeshu - 1) * 8] as Plan).getIntroduction();
               if((_loc1_[_loc2_ + (yeshu - 1) * 8] as Plan).getState() == 0)
               {
                  _this.skin["dc" + _loc2_].text = "---未达成";
                  ColorX(_this.skin["dc" + _loc2_],"0xFF0000");
               }
               else if((_loc1_[_loc2_ + (yeshu - 1) * 8] as Plan).getState() == 1)
               {
                  _this.skin["dc" + _loc2_].text = "---已达成";
                  ColorX(_this.skin["dc" + _loc2_],"0xFFCC00");
               }
               else
               {
                  _this.skin["dc" + _loc2_].text = "---已领取";
                  ColorX(_this.skin["dc" + _loc2_],"0x0066FF");
               }
            }
            else
            {
               _this.skin["xh" + _loc2_].text = "";
               _this.skin["tj" + _loc2_].text = "";
               _this.skin["dc" + _loc2_].text = "";
               _this.skin["xz" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         if(Boolean(getPlan(xzNum + (yeshu - 1) * 8)) && getPlan(xzNum + (yeshu - 1) * 8).getState() == 1)
         {
            _this.skin["lingqu"].visible = true;
         }
         else
         {
            _this.skin["lingqu"].visible = false;
         }
         if((arr1[13] as Plan).getState() == 0)
         {
            _this.skin["luntan"].visible = true;
         }
         else
         {
            _this.skin["luntan"].visible = false;
         }
         xzChangeShow();
         jiangliShow();
      }
      
      private static function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      private static function xiufu() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(Main.P1P2)
         {
            for(_loc1_ in PlanFactory.JiHuaData)
            {
               if(Main.player2.killPoint.getValue() > 99999 && (PlanFactory.JiHuaData[_loc1_] as Plan).getState() == 2 && (PlanFactory.JiHuaData[_loc1_] as Plan).getRewardType_2() == 6)
               {
                  Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() - (PlanFactory.JiHuaData[_loc1_] as Plan).getReward_2());
                  if(Main.player2.getKillPoint() < 0)
                  {
                     Main.player2.killPoint.setValue(0);
                  }
                  if(Main.player2.getLevel() <= Player.maxLevel)
                  {
                     Main.player_2.ExpUP((PlanFactory.JiHuaData[_loc1_] as Plan).getReward_2(),2);
                  }
                  Main.Save();
               }
            }
         }
         if(arr2[11].id.getValue() == 27 && arr2[12].id.getValue() == 29)
         {
            _loc1_ = 0;
            while(_loc1_ < PlanFactory.JiHuaData.length)
            {
               _loc2_ = _loc1_ + 1;
               while(_loc2_ < PlanFactory.JiHuaData.length)
               {
                  if(PlanFactory.JiHuaData[_loc1_].id.getValue() > PlanFactory.JiHuaData[_loc2_].id.getValue())
                  {
                     swap(PlanFactory.JiHuaData,_loc1_,_loc2_);
                  }
                  _loc2_++;
               }
               _loc1_++;
            }
            (PlanFactory.JiHuaData[29] as Plan).setState(1);
            (PlanFactory.JiHuaData[30] as Plan).setState(1);
            initArr();
            Main.Save();
         }
      }
      
      private static function swap(param1:Array, param2:int, param3:int) : *
      {
         var _loc4_:Plan = param1[param2];
         param1[param2] = param1[param3];
         param1[param3] = _loc4_;
      }
      
      private static function planGO() : *
      {
         if(lvMAX == 0)
         {
            if((arr1[0] as Plan).getState() == 0 && Boolean(TaskData.isOldById(110018)))
            {
               (arr1[0] as Plan).setState(1);
            }
            if((arr1[1] as Plan).getState() == 0 && Main.player1.getSkillNum() > 0)
            {
               (arr1[1] as Plan).setState(1);
            }
            if((arr1[2] as Plan).getState() == 0 && Main.player1.getSkillNum(1) > 0)
            {
               (arr1[2] as Plan).setState(1);
            }
            if((arr1[3] as Plan).getState() == 0 && Main.guanKa[3] == 3)
            {
               (arr1[3] as Plan).setState(1);
            }
            if((arr1[4] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan1_5()) || Boolean(Main.player1.getEquipSlot().plan1_5())))
            {
               (arr1[4] as Plan).setState(1);
            }
            if((arr1[5] as Plan).getState() == 0 && Main.player1.getLevel() >= 10)
            {
               (arr1[5] as Plan).setState(1);
            }
            if((arr1[6] as Plan).getState() == 0 && Boolean(Main.questArr[0][0]))
            {
               (arr1[6] as Plan).setState(1);
            }
            if((arr1[7] as Plan).getState() == 0 && Main.guanKa[101] == 3)
            {
               (arr1[7] as Plan).setState(1);
            }
            if((arr1[8] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().getEquipGold(10)) || Boolean(Main.player1.getEquipSlot().getEquipGold(10))))
            {
               (arr1[8] as Plan).setState(1);
            }
            if((arr1[9] as Plan).getState() == 0 && Main.player1.getLevel() >= 15)
            {
               (arr1[9] as Plan).setState(1);
            }
            if((arr1[10] as Plan).getState() == 0 && Boolean(CardPanel.monsterSlot.getMonsterCardOK(3)))
            {
               (arr1[10] as Plan).setState(1);
            }
            if((arr1[11] as Plan).getState() == 0 && (ppp1_12 || Boolean(TaskData.isOldById(110097))))
            {
               (arr1[11] as Plan).setState(1);
            }
            if((arr1[12] as Plan).getState() == 0 && (Main.player1.getBag().getGemNum(55155) > 0 || Main.player1.getBag().getGemNum(55156) > 0 || Main.player1.getBag().getGemNum(55157) > 0 || Main.player1.getBag().getGemNum(55158) > 0 || Main.player1.getBag().getGemNum(55159) > 0))
            {
               (arr1[12] as Plan).setState(1);
            }
            if((arr1[13] as Plan).getState() == 0 && ppp1_14)
            {
               (arr1[13] as Plan).setState(1);
            }
         }
         if(lvMAX == 1)
         {
            if((arr2[0] as Plan).getState() == 0 && AchData.getGaAcNum() >= 10)
            {
               (arr2[0] as Plan).setState(1);
            }
            if((arr2[1] as Plan).getState() == 0 && Boolean(TaskData.isOldById(110031)))
            {
               (arr2[1] as Plan).setState(1);
            }
            if((arr2[2] as Plan).getState() == 0 && Boolean(Main.player1.getEquipSlot().suitOK()))
            {
               (arr2[2] as Plan).setState(1);
            }
            if((arr2[3] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan2_5(3)) || Boolean(Main.player1.getEquipSlot().plan2_5(3))))
            {
               (arr2[3] as Plan).setState(1);
            }
            if((arr2[4] as Plan).getState() == 0 && ppp2_6)
            {
               (arr2[4] as Plan).setState(1);
            }
            if((arr2[5] as Plan).getState() == 0 && ppp2_7)
            {
               (arr2[5] as Plan).setState(1);
            }
            if((arr2[6] as Plan).getState() == 0 && Main.player1.getLevel() >= 25)
            {
               (arr2[6] as Plan).setState(1);
            }
            if((arr2[7] as Plan).getState() == 0 && Boolean(Main.player1.isTransferOk()))
            {
               (arr2[7] as Plan).setState(1);
            }
            if((arr2[8] as Plan).getState() == 0 && Main.guanKa[6] == 3)
            {
               (arr2[8] as Plan).setState(1);
            }
            if((arr2[9] as Plan).getState() == 0 && Boolean(Main.questArr[1][0]))
            {
               (arr2[9] as Plan).setState(1);
            }
            if((arr2[10] as Plan).getState() == 0 && Main.guanKa[102] == 3)
            {
               (arr2[10] as Plan).setState(1);
            }
            if((arr2[11] as Plan).getState() == 0 && ppp2_13)
            {
               (arr2[11] as Plan).setState(1);
            }
            if((arr2[12] as Plan).getState() == 0 && Boolean(CardPanel.monsterSlot.getMonsterCardOK(10)))
            {
               (arr2[12] as Plan).setState(1);
            }
            if((arr2[13] as Plan).getState() == 0 && Main.player1.getLevel() >= 35)
            {
               (arr2[13] as Plan).setState(1);
            }
            if((arr2[14] as Plan).getState() == 0 && (Main.player1.getBag().getGemNum(32210) > 0 || Main.player1.getBag().getGemNum(32211) > 0 || Main.player1.getBag().getGemNum(32212) > 0 || Main.player1.getBag().getGemNum(32213) > 0))
            {
               (arr2[14] as Plan).setState(1);
            }
         }
         if(lvMAX == 2)
         {
            if((arr3[0] as Plan).getState() == 0 && AchData.getGaAcNum() >= 30)
            {
               (arr3[0] as Plan).setState(1);
            }
            if((arr3[1] as Plan).getState() == 0 && Boolean(TaskData.isOldById(110043)))
            {
               (arr3[1] as Plan).setState(1);
            }
            if((arr3[2] as Plan).getState() == 0 && Main.player1.getLevel() >= 40)
            {
               (arr3[2] as Plan).setState(1);
            }
            if((arr3[3] as Plan).getState() == 0 && Main.guanKa[8] == 3)
            {
               (arr3[3] as Plan).setState(1);
            }
            if((arr3[4] as Plan).getState() == 0 && InitData.qinMiDu_Arr[2].getValue() >= 50 && InitData.qinMiDu_Arr[3].getValue() >= 50 && InitData.qinMiDu_Arr[4].getValue() >= 50 && (InitData.qinMiDu_Arr[1].getValue() >= 50 || Boolean(TaskData.isOldById(110097))))
            {
               (arr3[4] as Plan).setState(1);
            }
            if((arr3[5] as Plan).getState() == 0 && (Boolean(TaskData.isOldById(410025)) || Boolean(TaskData.isOldById(410035)) || Boolean(TaskData.isOldById(410051))))
            {
               (arr3[5] as Plan).setState(1);
            }
            if((arr3[6] as Plan).getState() == 0 && Boolean(CardPanel.monsterSlot.getMonsterCardOK(15)))
            {
               (arr3[6] as Plan).setState(1);
            }
            if((arr3[7] as Plan).getState() == 0 && Main.player1.getBag().getOtherobjNum(63138) > 0)
            {
               (arr3[7] as Plan).setState(1);
            }
            if((arr3[8] as Plan).getState() == 0 && Boolean(Main.questArr[2][0]))
            {
               (arr3[8] as Plan).setState(1);
            }
            if((arr3[9] as Plan).getState() == 0 && Main.guanKa[103] == 3)
            {
               (arr3[9] as Plan).setState(1);
            }
            if((arr3[10] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().getEquipGold(40)) || Boolean(Main.player1.getEquipSlot().getEquipGold(40))))
            {
               (arr3[10] as Plan).setState(1);
            }
            if((arr3[11] as Plan).getState() == 0 && Main.player1.getLevel() >= 50)
            {
               (arr3[11] as Plan).setState(1);
            }
            if((arr3[12] as Plan).getState() == 0 && Boolean(Main.player1.getElvesSlot().plan3_13(10)))
            {
               (arr3[12] as Plan).setState(1);
            }
            if((arr3[13] as Plan).getState() == 0 && ppp3_14)
            {
               (arr3[13] as Plan).setState(1);
            }
            if((arr3[14] as Plan).getState() == 0 && Boolean(TaskData.isOldById(110082)))
            {
               (arr3[14] as Plan).setState(1);
            }
            if((arr3[15] as Plan).getState() == 0 && Boolean(TaskData.isOldById(420025)))
            {
               (arr3[15] as Plan).setState(1);
            }
         }
         if(lvMAX == 3)
         {
            if((arr4[0] as Plan).getState() == 0 && AchData.getGaAcNum() >= 45)
            {
               (arr4[0] as Plan).setState(1);
            }
            if((arr4[1] as Plan).getState() == 0 && Boolean(TaskData.isOldById(110090)))
            {
               (arr4[1] as Plan).setState(1);
            }
            if((arr4[2] as Plan).getState() == 0 && Main.player1.getLevel() >= 55)
            {
               (arr4[2] as Plan).setState(1);
            }
            if((arr4[3] as Plan).getState() == 0 && Boolean(Main.player1.getEquipSlot().plan4_4()))
            {
               (arr4[3] as Plan).setState(1);
            }
            if((arr4[4] as Plan).getState() == 0 && Boolean(Main.questArr[3][0]))
            {
               (arr4[4] as Plan).setState(1);
            }
            if((arr4[5] as Plan).getState() == 0 && Main.guanKa[13] == 3)
            {
               (arr4[5] as Plan).setState(1);
            }
            if((arr4[6] as Plan).getState() == 0 && Main.wts.wantedTaskTimesLV1() >= 1)
            {
               (arr4[6] as Plan).setState(1);
            }
            if((arr4[7] as Plan).getState() == 0 && Main.guanKa[104] == 3)
            {
               (arr4[7] as Plan).setState(1);
            }
            if((arr4[8] as Plan).getState() == 0 && ppp4_9)
            {
               (arr4[8] as Plan).setState(1);
            }
            if((arr4[9] as Plan).getState() == 0 && ppp4_10)
            {
               (arr4[9] as Plan).setState(1);
            }
            if((arr4[10] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().getWuQiGold(50)) || Boolean(Main.player1.getEquipSlot().getWuQiGold(50))))
            {
               (arr4[10] as Plan).setState(1);
            }
            if((arr4[11] as Plan).getState() == 0 && Main.player1.getEquipSlot().getSuitStrength() >= 6)
            {
               (arr4[11] as Plan).setState(1);
            }
            if((arr4[12] as Plan).getState() == 0 && ppp4_13)
            {
               (arr4[12] as Plan).setState(1);
            }
            if((arr4[13] as Plan).getState() == 0 && Boolean(CardPanel.monsterSlot.getMonsterCardOK(20)))
            {
               (arr4[13] as Plan).setState(1);
            }
            if((arr4[14] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan4_15()) || Boolean(Main.player1.getEquipSlot().plan4_15())))
            {
               (arr4[14] as Plan).setState(1);
            }
            if((arr4[15] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan4_16()) || Boolean(Main.player1.getEquipSlot().plan4_16())))
            {
               (arr4[15] as Plan).setState(1);
            }
            if((arr4[16] as Plan).getState() == 0 && Main.player1.getLevel() >= 60)
            {
               (arr4[16] as Plan).setState(1);
            }
            if((arr4[17] as Plan).getState() == 0 && (Main.player1.getBag().getGemNum(34715) > 0 || Main.player1.getBag().getGemNum(34716) > 0 || Main.player1.getBag().getGemNum(34716) > 0 || Main.player1.getBag().getGemNum(34717) > 0 || Main.player1.getBag().getGemNum(34718) > 0 || Main.player1.getBag().getGemNum(34719) > 0))
            {
               (arr4[17] as Plan).setState(1);
            }
         }
         if(lvMAX == 4)
         {
            TiaoShi.txtShow("lvmax = " + lvMAX);
            if((arr5[0] as Plan).getState() == 0 && AchData.getGaAcNum() >= 60)
            {
               (arr5[0] as Plan).setState(1);
            }
            if((arr5[1] as Plan).getState() == 0 && Boolean(TaskData.isOldById(110101)))
            {
               (arr5[1] as Plan).setState(1);
            }
            if((arr5[2] as Plan).getState() == 0 && Boolean(Main.player1.getPetSlot().plan5_3()))
            {
               (arr5[2] as Plan).setState(1);
            }
            if((arr5[3] as Plan).getState() == 0 && ppp5_4)
            {
               (arr5[3] as Plan).setState(1);
            }
            if((arr5[4] as Plan).getState() == 0 && Main.player1.getLevel() >= 65)
            {
               (arr5[4] as Plan).setState(1);
            }
            if((arr5[5] as Plan).getState() == 0 && Main.player1.getEquipSlot().getSuitStrength() >= 9)
            {
               (arr5[5] as Plan).setState(1);
            }
            if((arr5[6] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan5_7()) || Boolean(Main.player1.getEquipSlot().plan5_7())))
            {
               (arr5[6] as Plan).setState(1);
            }
            if((arr5[7] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan5_8()) || Boolean(Main.player1.getEquipSlot().plan5_8())))
            {
               (arr5[7] as Plan).setState(1);
            }
            if((arr5[8] as Plan).getState() == 0 && Main.guanKa[15] == 3)
            {
               (arr5[8] as Plan).setState(1);
            }
            if((arr5[9] as Plan).getState() == 0 && Boolean(CardPanel.monsterSlot.getMonsterCardOK(25)))
            {
               (arr5[9] as Plan).setState(1);
            }
            if((arr5[10] as Plan).getState() == 0 && XingLingFactory.dianLiangNum * 10 >= 10)
            {
               (arr5[10] as Plan).setState(1);
            }
            if((arr5[11] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan5_12()) || Boolean(Main.player1.getEquipSlot().plan5_12())))
            {
               (arr5[11] as Plan).setState(1);
            }
            if((arr5[12] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan5_13()) || Boolean(Main.player1.getEquipSlot().plan5_13())))
            {
               (arr5[12] as Plan).setState(1);
            }
            if((arr5[13] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan5_14()) || Boolean(Main.player1.getEquipSlot().plan5_14())))
            {
               (arr5[13] as Plan).setState(1);
            }
            if((arr5[14] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan5_15()) || Boolean(Main.player1.getEquipSlot().plan5_15())))
            {
               (arr5[14] as Plan).setState(1);
            }
            if((arr5[15] as Plan).getState() == 0 && Main.player1.getLevel() >= 70)
            {
               (arr5[15] as Plan).setState(1);
            }
            if((arr5[16] as Plan).getState() == 0 && ppp5_17)
            {
               (arr5[16] as Plan).setState(1);
            }
            if((arr5[17] as Plan).getState() == 0 && Main.wts.wantedTaskTimesLV2() >= 1)
            {
               (arr5[17] as Plan).setState(1);
            }
         }
         if(lvMAX == 5)
         {
            if((arr6[0] as Plan).getState() == 0 && AchData.getGaAcNum() >= 70)
            {
               (arr6[0] as Plan).setState(1);
            }
            if((arr6[1] as Plan).getState() == 0 && Boolean(TaskData.isOldById(110107)))
            {
               (arr6[1] as Plan).setState(1);
            }
            if((arr6[2] as Plan).getState() == 0 && Boolean(Main.player1.getPetSlot().plan6_3()))
            {
               (arr6[2] as Plan).setState(1);
            }
            if((arr6[3] as Plan).getState() == 0 && Main.guanKa[15] >= 1)
            {
               (arr6[3] as Plan).setState(1);
            }
            if((arr6[4] as Plan).getState() == 0 && Boolean(Main.questArr[3][0]))
            {
               (arr6[4] as Plan).setState(1);
            }
            if((arr6[5] as Plan).getState() == 0 && ppp6_6)
            {
               (arr6[5] as Plan).setState(1);
            }
            if((arr6[6] as Plan).getState() == 0 && (Boolean(Main.player1.getEquipSlot().plan6_7()) || Boolean(Main.player1.getBag().plan6_7())))
            {
               (arr6[6] as Plan).setState(1);
            }
            if((arr6[7] as Plan).getState() == 0 && Main.water.getValue() != 1)
            {
               (arr6[7] as Plan).setState(1);
            }
            if((arr6[8] as Plan).getState() == 0 && Main.guanKa[51] >= 1)
            {
               (arr6[8] as Plan).setState(1);
            }
            if((arr6[9] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan6_10()) || Boolean(Main.player1.getEquipSlot().plan6_10())))
            {
               (arr6[9] as Plan).setState(1);
            }
            if((arr6[10] as Plan).getState() == 0 && Main.player1.getEquipSlot().getSuitStrength() >= 10)
            {
               (arr6[10] as Plan).setState(1);
            }
            if((arr6[11] as Plan).getState() == 0 && Main.player1.getLevel() >= 75)
            {
               (arr6[11] as Plan).setState(1);
            }
            if((arr6[12] as Plan).getState() == 0 && Boolean(CardPanel.monsterSlot.getMonsterCardOK(30)))
            {
               (arr6[12] as Plan).setState(1);
            }
            if((arr6[13] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan6_14()) || Boolean(Main.player1.getBadgeSlot().plan6_14())))
            {
               (arr6[13] as Plan).setState(1);
            }
            if((arr6[14] as Plan).getState() == 0 && Main.player1.getBag().plan6_15() + Main.player1.getEquipSlot().plan6_15() >= 6)
            {
               (arr6[14] as Plan).setState(1);
            }
            if((arr6[15] as Plan).getState() == 0 && Main.player1.getLevel() >= 80)
            {
               (arr6[15] as Plan).setState(1);
            }
            if((arr6[16] as Plan).getState() == 0 && Main.wts.wantedTaskTimesLV3() >= 1)
            {
               (arr6[16] as Plan).setState(1);
            }
         }
         if(lvMAX == 6)
         {
            if((arr7[0] as Plan).getState() == 0 && AchData.getGaAcNum() >= 80)
            {
               (arr7[0] as Plan).setState(1);
            }
            if((arr7[1] as Plan).getState() == 0 && Main.guanKa[81] >= 1)
            {
               (arr7[1] as Plan).setState(1);
            }
            if((arr7[2] as Plan).getState() == 0 && (Boolean(Main.player1.getBag().plan7_3()) || Boolean(Main.player1.getEquipSlot().plan7_3())))
            {
               (arr7[2] as Plan).setState(1);
            }
            if((arr7[3] as Plan).getState() == 0 && Main.player1.getBag().plan7_4() + Main.player1.getEquipSlot().plan7_4() >= 7)
            {
               (arr7[3] as Plan).setState(1);
            }
            if((arr7[4] as Plan).getState() == 0 && Boolean(CardPanel.monsterSlot.getMonsterCardOK(35)))
            {
               (arr7[4] as Plan).setState(1);
            }
            if((arr7[5] as Plan).getState() == 0 && Main.guanKa[105] == 3)
            {
               (arr7[5] as Plan).setState(1);
            }
            if((arr7[6] as Plan).getState() == 0 && Main.LuoPanArr[0] == 1)
            {
               (arr7[6] as Plan).setState(1);
            }
         }
      }
      
      private function LoadSkin() : *
      {
         if(!skin && !loadData)
         {
            loadData = new ClassLoader(loadName);
            loadData.addEventListener(Event.COMPLETE,onLoadingOK);
            Play_Interface.interfaceX["load_mc"].visible = true;
         }
      }
      
      private function onLoadingOK(param1:*) : *
      {
         var _loc2_:Class = loadData.getClass("Skin") as Class;
         this.skin = new _loc2_();
         skin.addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addChild(skin);
         Play_Interface.interfaceX["load_mc"].visible = false;
         if(OpenYN)
         {
            Open();
         }
         else
         {
            Close();
         }
      }
      
      private function Close(param1:* = null) : *
      {
         this.visible = false;
         this.x = this.y = 5000;
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            _this.skin["xh" + _loc2_].mouseEnabled = false;
            _this.skin["tj" + _loc2_].mouseEnabled = false;
            _this.skin["dc" + _loc2_].mouseEnabled = false;
            _this.skin["dj" + _loc2_].stop();
            _this.skin["xz" + _loc2_].stop();
            (_this.skin["dj" + _loc2_] as MovieClip).mouseChildren = false;
            (_this.skin["dj" + _loc2_] as MovieClip).visible = false;
            _this.skin["dj" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,lvOUT);
            _this.skin["dj" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,lvOVER);
            _this.skin["dj" + _loc2_].addEventListener(MouseEvent.CLICK,lvChose);
            _this.skin["xz" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,xzOUT);
            _this.skin["xz" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,xzOVER);
            _this.skin["xz" + _loc2_].addEventListener(MouseEvent.CLICK,xzChose);
            _loc2_++;
         }
         _this.skin["jl1"].addEventListener(MouseEvent.MOUSE_OUT,jlCLOSE);
         _this.skin["jl1"].addEventListener(MouseEvent.MOUSE_OVER,oneOPEN);
         _this.skin["jl2"].addEventListener(MouseEvent.MOUSE_OUT,jlCLOSE);
         _this.skin["jl2"].addEventListener(MouseEvent.MOUSE_OVER,towOPEN);
         _this.skin["lingqu"].addEventListener(MouseEvent.CLICK,lingqu);
         _this.skin["close"].addEventListener(MouseEvent.CLICK,Close);
         _this.skin["up"].addEventListener(MouseEvent.CLICK,upup);
         _this.skin["down"].addEventListener(MouseEvent.CLICK,down);
         _this.skin["luntan"].addEventListener(MouseEvent.CLICK,goLunTan);
         _this.skin["pic"].stop();
      }
   }
}

