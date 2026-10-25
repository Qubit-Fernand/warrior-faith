package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.media.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class MusicBox extends MovieClip
   {
      
      public static var MusicData:ClassLoader;
      
      public static var musicString:String;
      
      public static var s1:Sound;
      
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
      
      public static function MusicPlay(str:String = "") : *
      {
         var tempMusic:String = null;
         var classRef:Class = null;
         if(str != "")
         {
            tempMusic = str;
         }
         else if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 0)
         {
            tempMusic = "村庄音乐";
         }
         else if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 1)
         {
            tempMusic = "女神音乐";
         }
         else if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 4)
         {
            tempMusic = "海皇城";
         }
         else if(Main.gameNum.getValue() > 50 && Main.gameNum.getValue() < 100)
         {
            tempMusic = "艾尔之海";
         }
         else
         {
            tempMusic = "战斗音乐";
         }
         if(musicString != tempMusic)
         {
            try
            {
               if(s1)
               {
                  sc1.stop();
               }
            }
            catch(e:*)
            {
            }
            musicString = tempMusic;
            if(tempMusic == "封面声音")
            {
               classRef = getDefinitionByName(musicString) as Class;
            }
            else
            {
               classRef = MusicData.getClass(musicString) as Class;
            }
            s1 = new classRef();
            sc1 = s1.play(0,99999);
         }
      }
      
      public static function ActMusicPlay(who:int, run:String) : *
      {
         var i:int = 0;
         var scXX:* = undefined;
         var sXXX:* = undefined;
         var classRef:Class = null;
         if(run == "站" || run == "走" || run == "跳" || run == "跑")
         {
            return;
         }
         var className:String = "";
         for(i in MusicBox["mArr" + who])
         {
            if(MusicBox["mArr" + who][i][0] == run)
            {
               className = MusicBox["mArr" + who][i][1];
            }
         }
         if(className != "")
         {
            scXX = new SoundChannel();
            classRef = MusicData.getClass(className) as Class;
            sXXX = new classRef();
            scXX = sXXX.play(0,1);
         }
         else
         {
            scXX = new SoundChannel();
            className = MusicBox["mArr" + who][0][1];
            classRef = MusicData.getClass(className) as Class;
            sXXX = new classRef();
            scXX = sXXX.play(0,1);
         }
      }
      
      public static function ActMusicPlayX(who:int, run:String) : *
      {
         var i:int = 0;
         var scXX:* = undefined;
         var sXXX:* = undefined;
         var classRef:Class = null;
         var className:String = "";
         for(i in MusicBox["mArrX" + who])
         {
            if(MusicBox["mArrX" + who][i][0] == run)
            {
               className = MusicBox["mArrX" + who][i][1];
            }
         }
         if(className != "")
         {
            scXX = new SoundChannel();
            classRef = MusicData.getClass(className) as Class;
            sXXX = new classRef();
            scXX = sXXX.play(0,1);
         }
         else
         {
            scXX = new SoundChannel();
            className = MusicBox["mArrX" + who][0][1];
            classRef = MusicData.getClass(className) as Class;
            sXXX = new classRef();
            scXX = sXXX.play(0,1);
         }
      }
   }
}

