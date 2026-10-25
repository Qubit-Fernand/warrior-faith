package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.gem.Gem;
   import src.*;
   
   public class StampSlot
   {
      
      private var _slot1:Array = new Array();
      
      private var _slot2:Array = new Array();
      
      private var _slot3:Array = new Array();
      
      private var _slot4:Array = new Array();
      
      private var _slot5:Array = new Array();
      
      private var _slot6:Array = new Array();
      
      private var _slot7:Array = new Array();
      
      private var _slot8:Array = new Array();
      
      private var _slot9:Array = new Array();
      
      private var _slot10:Array = new Array();
      
      private var _slot11:Array = new Array();
      
      private var _slot11_key:Array = new Array();
      
      public function StampSlot()
      {
         super();
      }
      
      public static function createStampSlot() : StampSlot
      {
         var _loc1_:StampSlot = new StampSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc1_._slot1[_loc2_] = null;
            _loc1_._slot2[_loc2_] = null;
            _loc1_._slot3[_loc2_] = null;
            _loc1_._slot4[_loc2_] = null;
            _loc1_._slot5[_loc2_] = null;
            _loc1_._slot6[_loc2_] = null;
            _loc1_._slot7[_loc2_] = null;
            _loc1_._slot8[_loc2_] = null;
            _loc1_._slot9[_loc2_] = null;
            _loc1_._slot10[_loc2_] = null;
            _loc1_._slot11[_loc2_] = null;
            _loc1_._slot11_key[_loc2_] = 0;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get slot1() : Array
      {
         return _slot1;
      }
      
      public function set slot1(param1:Array) : void
      {
         _slot1 = param1;
      }
      
      public function get slot2() : Array
      {
         return _slot2;
      }
      
      public function set slot2(param1:Array) : void
      {
         _slot2 = param1;
      }
      
      public function get slot3() : Array
      {
         return _slot3;
      }
      
      public function set slot3(param1:Array) : void
      {
         _slot3 = param1;
      }
      
      public function get slot4() : Array
      {
         return _slot4;
      }
      
      public function set slot4(param1:Array) : void
      {
         _slot4 = param1;
      }
      
      public function get slot5() : Array
      {
         return _slot5;
      }
      
      public function set slot5(param1:Array) : void
      {
         _slot5 = param1;
      }
      
      public function get slot6() : Array
      {
         return _slot6;
      }
      
      public function set slot6(param1:Array) : void
      {
         _slot6 = param1;
      }
      
      public function get slot7() : Array
      {
         return _slot7;
      }
      
      public function set slot7(param1:Array) : void
      {
         _slot7 = param1;
      }
      
      public function get slot8() : Array
      {
         return _slot8;
      }
      
      public function set slot8(param1:Array) : void
      {
         _slot8 = param1;
      }
      
      public function get slot9() : Array
      {
         return _slot9;
      }
      
      public function set slot9(param1:Array) : void
      {
         _slot9 = param1;
      }
      
      public function get slot10() : Array
      {
         return _slot10;
      }
      
      public function set slot10(param1:Array) : void
      {
         _slot10 = param1;
      }
      
      public function get slot11() : Array
      {
         return _slot11;
      }
      
      public function set slot11(param1:Array) : void
      {
         _slot11 = param1;
      }
      
      public function get slot11_key() : Array
      {
         return _slot11_key;
      }
      
      public function set slot11_key(param1:Array) : void
      {
         _slot11_key = param1;
      }
      
      public function setSlot1(param1:Gem, param2:Number) : *
      {
         _slot1[param2] = param1;
      }
      
      public function delSlot1(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot1[param1];
         _slot1[param1] = null;
         return _loc2_;
      }
      
      public function getSlot1(param1:Number) : Gem
      {
         return _slot1[param1];
      }
      
      public function setSlot2(param1:Gem, param2:Number) : *
      {
         _slot2[param2] = param1;
      }
      
      public function delSlot2(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot2[param1];
         _slot2[param1] = null;
         return _loc2_;
      }
      
      public function getSlot2(param1:Number) : Gem
      {
         return _slot2[param1];
      }
      
      public function setSlot3(param1:Gem, param2:Number) : *
      {
         _slot3[param2] = param1;
      }
      
      public function delSlot3(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot3[param1];
         _slot3[param1] = null;
         return _loc2_;
      }
      
      public function getSlot3(param1:Number) : Gem
      {
         return _slot3[param1];
      }
      
      public function setSlot4(param1:Gem, param2:Number) : *
      {
         _slot4[param2] = param1;
      }
      
      public function delSlot4(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot4[param1];
         _slot4[param1] = null;
         return _loc2_;
      }
      
      public function getSlot4(param1:Number) : Gem
      {
         return _slot4[param1];
      }
      
      public function setSlot5(param1:Gem, param2:Number) : *
      {
         _slot5[param2] = param1;
      }
      
      public function delSlot5(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot5[param1];
         _slot5[param1] = null;
         return _loc2_;
      }
      
      public function getSlot5(param1:Number) : Gem
      {
         return _slot5[param1];
      }
      
      public function setSlot6(param1:Gem, param2:Number) : *
      {
         _slot6[param2] = param1;
      }
      
      public function delSlot6(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot6[param1];
         _slot6[param1] = null;
         return _loc2_;
      }
      
      public function getSlot6(param1:Number) : Gem
      {
         return _slot6[param1];
      }
      
      public function setSlot7(param1:Gem, param2:Number) : *
      {
         _slot7[param2] = param1;
      }
      
      public function delSlot7(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot7[param1];
         _slot7[param1] = null;
         return _loc2_;
      }
      
      public function getSlot7(param1:Number) : Gem
      {
         return _slot7[param1];
      }
      
      public function setSlot8(param1:Gem, param2:Number) : *
      {
         _slot8[param2] = param1;
      }
      
      public function delSlot8(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot8[param1];
         _slot8[param1] = null;
         return _loc2_;
      }
      
      public function getSlot8(param1:Number) : Gem
      {
         return _slot8[param1];
      }
      
      public function setSlot9(param1:Gem, param2:Number) : *
      {
         _slot9[param2] = param1;
      }
      
      public function delSlot9(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot9[param1];
         _slot9[param1] = null;
         return _loc2_;
      }
      
      public function getSlot9(param1:Number) : Gem
      {
         return _slot9[param1];
      }
      
      public function setSlot10(param1:Gem, param2:Number) : *
      {
         _slot10[param2] = param1;
      }
      
      public function delSlot10(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot10[param1];
         _slot10[param1] = null;
         return _loc2_;
      }
      
      public function getSlot10(param1:Number) : Gem
      {
         return _slot10[param1];
      }
      
      public function setSlot11(param1:Gem, param2:Number) : *
      {
         _slot11[param2] = param1;
      }
      
      public function delSlot11(param1:Number) : Gem
      {
         var _loc2_:Gem = _slot11[param1];
         _slot11[param1] = null;
         return _loc2_;
      }
      
      public function getSlot11(param1:Number) : Gem
      {
         return _slot11[param1];
      }
      
      public function setKeySlot11() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            if(_slot11_key[_loc1_] == 0)
            {
               _slot11_key[_loc1_] = 1;
               break;
            }
            _loc1_++;
         }
      }
      
      public function getSlot11_key(param1:Number) : Number
      {
         return _slot11_key[param1];
      }
      
      public function getValueSlot1() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            if(_slot1[_loc2_])
            {
               _loc1_ += getSlot1(_loc2_).getGemSkill();
            }
            if(_slot11[_loc2_])
            {
               if(getSlot11(_loc2_).getType() == 7)
               {
                  _loc1_ += getSlot11(_loc2_).getGemSkill();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getValueSlot2() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            if(_slot2[_loc2_])
            {
               _loc1_ += getSlot2(_loc2_).getGemSkill();
            }
            if(_slot11[_loc2_])
            {
               if(getSlot11(_loc2_).getType() == 8)
               {
                  _loc1_ += getSlot11(_loc2_).getGemSkill();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getValueSlot3() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            if(_slot3[_loc2_])
            {
               _loc1_ += getSlot3(_loc2_).getGemSkill();
            }
            if(_slot11[_loc2_])
            {
               if(getSlot11(_loc2_).getType() == 9)
               {
                  _loc1_ += getSlot11(_loc2_).getGemSkill();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getValueSlot4() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            if(_slot4[_loc2_])
            {
               _loc1_ += getSlot4(_loc2_).getGemSkill();
            }
            if(_slot11[_loc2_])
            {
               if(getSlot11(_loc2_).getType() == 10)
               {
                  _loc1_ += getSlot11(_loc2_).getGemSkill();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getValueSlot5() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            if(_slot5[_loc2_])
            {
               _loc1_ += getSlot5(_loc2_).getGemSkill();
            }
            if(_slot11[_loc2_])
            {
               if(getSlot11(_loc2_).getType() == 11)
               {
                  _loc1_ += getSlot11(_loc2_).getGemSkill();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

