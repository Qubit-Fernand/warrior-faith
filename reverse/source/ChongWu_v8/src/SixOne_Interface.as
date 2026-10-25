package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class SixOne_Interface extends MovieClip
   {
      
      public static var loadData:ClassLoader;
      
      private static var _this:SixOne_Interface;
      
      public static var guankaNum:int;
      
      private static var name:String;
      
      public static var dayTimes:VT = VT.createVT(0);
      
      public static var nowdate:VT = VT.createVT(0);
      
      public static var okTimes:VT = VT.createVT(0);
      
      public static var state:VT = VT.createVT(0);
      
      private static var OpenYN:Boolean = false;
      
      private static var loadName:String = "HD61.swf";
      
      private static var allguanka:Array = [];
      
      public static var booltemp:Boolean = false;
      
      private static var nameArr:Array = [[1,"落月之原"],[2,"落月之森"],[3,"冰雪废墟"],[4,"死亡流沙"],[5,"万年雪山"],[6,"废弃都市"],[7,"火山的噩梦"],[8,"堕落城堡"],[9,"幽灵船"],[10,"机械城"],[11,"雪狼巢穴"],[12,"火之祭坛"],[13,"暗影城"],[14,"暗夜遗迹"],[15,"机械试验场"],[16,"熔岩城堡"],[51,"艾尔之海"],[52,"安塔利亚"],[53,"阿肯色"],[54,"雅利安"]];
      
      private static var timetemp:int = 0;
      
      private static var jlArr:Array = [[1,21221],[2,33314],[2,33510],[3,63181],[3,63210],[3,63235],[3,63102],[3,63203],[3,63155],[3,63100]];
      
      private var skin:MovieClip;
      
      private var tishi:MovieClip;
      
      public function SixOne_Interface()
      {
         super();
         LoadSkin();
         _this = this;
      }
      
      private static function InitOpen() : *
      {
         var _loc1_:SixOne_Interface = new SixOne_Interface();
         Main._stage.addChild(_loc1_);
         OpenYN = true;
      }
      
      public static function Open() : *
      {
         if(_this)
         {
            _this.visible = true;
            _this.skin.visible = true;
            _this.tishi.visible = false;
            _this.x = _this.y = 0;
            showAll();
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
            _this.skin.visible = false;
         }
      }
      
      private static function guanka_rdm() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         allguanka = [];
         _loc2_ = 1;
         while(_loc2_ <= 16)
         {
            allguanka.push(Main.guanKa[_loc2_]);
            _loc2_++;
         }
         _loc2_ = 51;
         while(_loc2_ <= 54)
         {
            allguanka.push(Main.guanKa[_loc2_]);
            _loc2_++;
         }
         for(_loc2_ in allguanka)
         {
            if(allguanka[_loc2_] != 0)
            {
               _loc1_++;
            }
         }
         _loc3_ = Math.floor(Math.random() * _loc1_);
         if(_loc3_ > 15)
         {
            _loc3_ += 34;
         }
         return int(_loc3_ + 1);
      }
      
      private static function getName(param1:int) : String
      {
         var _loc2_:* = undefined;
         for(_loc2_ in nameArr)
         {
            if(nameArr[_loc2_][0] == param1)
            {
               return nameArr[_loc2_][1];
            }
         }
      }
      
      private static function showAll() : *
      {
         if(state.getValue() != 1)
         {
            guankaNum = guanka_rdm();
            name = getName(guankaNum);
         }
         if(nowdate.getValue() < Main.serverTime.getValue())
         {
            nowdate = Main.serverTime;
            dayTimes.setValue(0);
         }
         if(dayTimes.getValue() < 10)
         {
            if(state.getValue() == 0 || state.getValue() == 3)
            {
               if(dayTimes.getValue() == 0)
               {
                  _this.skin["txt_1"].text = "哇哇哇，好激动哦~我看到了真正的勇士了！你愿意带我去探险吗？只要你能带我去探险，并教我战斗技巧，我就把我收藏的好东西送给你。如果你能在接下来的日子里都带我去探险的话，到时我将会把我最珍贵的宝贝送你哦~是我最珍贵的哦！嘿嘿。";
                  _this.skin["txt_2"].text = "我今天还想去" + (10 - dayTimes.getValue()) + "个地方，带我到" + name + "冒险吧，回来后我会送你一个好东西哦。";
               }
               else
               {
                  _this.skin["txt_1"].text = "哈哈哈哈，真是太好玩太刺激了，你能带我去下一个随机的任务地点名称玩玩么。";
                  _this.skin["txt_2"].text = "我今天还想去" + (10 - dayTimes.getValue()) + "个地方，带我到" + name + "冒险吧，回来后我会送你一个好东西哦。";
               }
            }
            else if(state.getValue() == 1)
            {
               _this.skin["txt_1"].text = "刚才去的那里根本不是刚才任务地点名称，你还是带我去刚才任务地点名称。";
               _this.skin["txt_2"].text = "我今天还想去" + (10 - dayTimes.getValue()) + "个地方，带我到" + name + "冒险吧，回来后我会送你一个好东西哦。";
            }
            else if(state.getValue() == 2)
            {
               _this.skin["txt_1"].text = "你根本就不是勇士，太差劲了！跟着你去冒险真不安全……你还是带我去别的地方玩吧。";
               _this.skin["txt_2"].text = "我今天还想去" + (10 - dayTimes.getValue()) + "个地方，带我到" + name + "冒险吧，回来后我会送你一个好东西哦。";
            }
         }
         else if(dayTimes.getValue() == 10)
         {
            _this.skin["txt_1"].text = "咩哈哈哈，今天玩的好开心阿。谢谢你阿，再多带我玩几天，我就把我身后的这个东西送给你。";
            _this.skin["txt_2"].text = "休息啦！";
            _this.skin["ok_btn"].visible = false;
         }
      }
      
      private static function jianbian(param1:*) : *
      {
         ++timetemp;
         _this.tishi.alpha -= 0.01;
         if(timetemp > 100)
         {
            TiaoShi.txtShow("timetemp = " + timetemp);
            timetemp = 0;
            _this.tishi.visible = false;
            _this.skin.removeEventListener(Event.ENTER_FRAME,jianbian);
         }
      }
      
      private static function okgo(param1:*) : *
      {
         var _loc5_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(state.getValue() == 3)
         {
            if(okTimes.getValue() == 30)
            {
               _loc4_++;
            }
            if(okTimes.getValue() % 10 == 0 && okTimes.getValue() > 0)
            {
               _loc2_++;
            }
            _loc5_ = getJiangLi();
            if(_loc5_ is Supplies)
            {
               _loc2_++;
               if(Main.player1.getBag().backSuppliesBagNum() < _loc2_)
               {
                  NewMC.Open("文字提示",_this.skin,400,400,30,0,true,2,"背包已满，请清理空间");
                  return;
               }
               Main.player1.getBag().addSuppliesBag(_loc5_);
               if(okTimes.getValue() % 10 == 0 && okTimes.getValue() > 0)
               {
                  Main.player1.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(21221));
                  _this.tishi["jl1"].gotoAndStop(SuppliesFactory.getSuppliesById(21221).getFrame());
               }
               _this.tishi.visible = true;
               _this.tishi.alpha = 1;
               _this.tishi["jl0"].gotoAndStop((_loc5_ as Supplies).getFrame());
               _this.skin.addEventListener(Event.ENTER_FRAME,jianbian);
               state.setValue(0);
               Main.Save();
            }
            if(_loc5_ is Gem)
            {
               _loc3_++;
               if(Main.player1.getBag().backGemBagNum() < _loc3_)
               {
                  NewMC.Open("文字提示",_this.skin,400,400,30,0,true,2,"背包已满，请清理空间");
                  return;
               }
               Main.player1.getBag().addGemBag(_loc5_);
               _this.tishi.visible = true;
               _this.tishi.alpha = 1;
               _this.tishi["jl0"].gotoAndStop((_loc5_ as Gem).getFrame());
               _this.skin.addEventListener(Event.ENTER_FRAME,jianbian);
               state.setValue(0);
               Main.Save();
            }
            if(_loc5_ is Otherobj)
            {
               _loc4_++;
               if(Main.player1.getBag().backOtherBagNum() < _loc4_)
               {
                  NewMC.Open("文字提示",_this.skin,400,400,30,0,true,2,"背包已满，请清理空间");
                  return;
               }
               Main.player1.getBag().addOtherobjBag(_loc5_);
               if(okTimes.getValue() == 30)
               {
                  Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63237));
                  _this.tishi["jl2"].gotoAndStop(OtherFactory.creatOther(63237).getFrame());
               }
               _this.tishi.visible = true;
               _this.tishi.alpha = 1;
               _this.tishi["jl0"].gotoAndStop((_loc5_ as Otherobj).getFrame());
               _this.skin.addEventListener(Event.ENTER_FRAME,jianbian);
               state.setValue(0);
               Main.Save();
            }
         }
         if(state.getValue() == 0 || state.getValue() == 2)
         {
            state.setValue(1);
         }
         Main.ysbtn.visible = false;
         Player.boolYS = true;
         Main.player_1.OpenYS();
         CloseX();
      }
      
      public static function getJiangLi() : Object
      {
         var _loc1_:int = Math.floor(Math.random() * jlArr.length);
         TiaoShi.txtShow(_loc1_);
         if(jlArr[_loc1_][0] == 1)
         {
            return SuppliesFactory.getSuppliesById(jlArr[_loc1_][1]);
         }
         if(jlArr[_loc1_][0] == 2)
         {
            return GemFactory.creatGemById(jlArr[_loc1_][1]);
         }
         if(jlArr[_loc1_][0] == 3)
         {
            return OtherFactory.creatOther(jlArr[_loc1_][1]);
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
         var _loc2_:Class = loadData.getClass("ysPanel") as Class;
         this.skin = new _loc2_();
         var _loc3_:Class = loadData.getClass("TiShi") as Class;
         this.tishi = new _loc3_();
         skin.addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addChild(skin);
         addChild(tishi);
         Play_Interface.interfaceX["load_mc"].visible = false;
         booltemp = true;
         if(OpenYN)
         {
            Open();
         }
         else
         {
            Close();
         }
      }
      
      private function Close(param1:*) : *
      {
         this.visible = false;
         this.x = this.y = 5000;
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         _this.skin["ok_btn"].addEventListener(MouseEvent.CLICK,okgo);
         _this.skin["no_btn"].addEventListener(MouseEvent.CLICK,Close);
         _this.skin["close_btn"].addEventListener(MouseEvent.CLICK,Close);
         _this.tishi.visible = false;
      }
   }
}

