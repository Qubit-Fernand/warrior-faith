package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.media.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class MusicBox extends MovieClip
   {
      
      public static var musicString:String;
      
      public static var s1:*;
      
      public static var sc1:* = new SoundChannel();
      
      public static var mArr0:Array = [["攻击1","战士挥刀声音"],["攻击2","战士挥刀声音"],["攻击3","战士挥刀声音"],["攻击4","战士挥刀声音"],["转职技能4","战士转职技能4声音"]];
      
      public static var mArr1:Array = [["攻击1","法师挥杖声音"],["攻击2","法师挥杖声音"],["攻击3","法师挥杖声音"],["攻击4","法师挥杖声音"]];
      
      public static var mArr2:Array = [["攻击1","法师挥杖声音"]];
      
      public static var mArrX0:Array = [["攻击1","战士击中声音"],["攻击2","战士击中声音"],["攻击3","战士击中声音"],["攻击4","战士击中声音"]];
      
      public static var mArrX1:Array = [["攻击1","法师击中声音"],["攻击2","法师击中声音"],["攻击3","法师击中声音"],["攻击4","法师击中声音"]];
      
      public static var mArrX2:Array = [["攻击1","拳手普通攻击123声音"],["攻击2","拳手普通攻击123声音"],["攻击3","拳手普通攻击123声音"],["攻击4","拳手普通攻击4声音"],["技能2","拳手技能2声音"]];
      
      public function MusicBox()
      {
         super();
      }
      
      public static function ActMusicPlay(param1:int, param2:String) : *
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:Class = null;
         if(param2 == "站" || param2 == "走" || param2 == "跳" || param2 == "跑")
         {
            return;
         }
         _loc3_ = "";
         for(_loc4_ in MusicBox["mArr" + param1])
         {
            if(MusicBox["mArr" + param1][_loc4_][0] == param2)
            {
               _loc3_ = MusicBox["mArr" + param1][_loc4_][1];
            }
         }
         if(_loc3_ != "")
         {
            _loc5_ = new SoundChannel();
            _loc7_ = getDefinitionByName(_loc3_) as Class;
            _loc6_ = new _loc7_();
            _loc5_ = _loc6_.play(0,1);
         }
         else
         {
            _loc5_ = new SoundChannel();
            _loc3_ = MusicBox["mArr" + param1][0][1];
            _loc7_ = getDefinitionByName(_loc3_) as Class;
            _loc6_ = new _loc7_();
            _loc5_ = _loc6_.play(0,1);
         }
      }
      
      public static function ActMusicPlayX(param1:int, param2:String) : *
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:Class = null;
         _loc3_ = "";
         for(_loc4_ in MusicBox["mArrX" + param1])
         {
            if(MusicBox["mArrX" + param1][_loc4_][0] == param2)
            {
               _loc3_ = MusicBox["mArrX" + param1][_loc4_][1];
            }
         }
         if(_loc3_ != "")
         {
            _loc5_ = new SoundChannel();
            _loc7_ = getDefinitionByName(_loc3_) as Class;
            _loc6_ = new _loc7_();
            _loc5_ = _loc6_.play(0,1);
         }
         else
         {
            _loc5_ = new SoundChannel();
            _loc3_ = MusicBox["mArrX" + param1][0][1];
            _loc7_ = getDefinitionByName(_loc3_) as Class;
            _loc6_ = new _loc7_();
            _loc5_ = _loc6_.play(0,1);
         }
      }
      
      public static function MusicPlay(param1:String = "") : *
      {
         var _loc2_:String = null;
         var _loc3_:Class = null;
         if(param1 != "")
         {
            _loc2_ = param1;
         }
         else if(Main.gameNum == 0 && Main.gameNum2 == 1)
         {
            _loc2_ = "女神音乐";
         }
         else if(Main.gameNum == 0 && Main.gameNum2 == 0)
         {
            _loc2_ = "村庄音乐";
         }
         else
         {
            _loc2_ = "战斗音乐";
         }
         if(musicString != _loc2_)
         {
            sc1.stop();
            musicString = _loc2_;
            _loc3_ = getDefinitionByName(musicString) as Class;
            s1 = new _loc3_();
            sc1 = s1.play(0,99999);
         }
      }
   }
}

