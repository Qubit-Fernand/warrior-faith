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
         var ss:StampSlot = new StampSlot();
         for(var i:int = 0; i < 4; i++)
         {
            ss._slot1[i] = null;
            ss._slot2[i] = null;
            ss._slot3[i] = null;
            ss._slot4[i] = null;
            ss._slot5[i] = null;
            ss._slot6[i] = null;
            ss._slot7[i] = null;
            ss._slot8[i] = null;
            ss._slot9[i] = null;
            ss._slot10[i] = null;
            ss._slot11[i] = null;
            ss._slot11_key[i] = 0;
         }
         return ss;
      }
      
      public function get slot1() : Array
      {
         return this._slot1;
      }
      
      public function set slot1(value:Array) : void
      {
         this._slot1 = value;
      }
      
      public function get slot2() : Array
      {
         return this._slot2;
      }
      
      public function set slot2(value:Array) : void
      {
         this._slot2 = value;
      }
      
      public function get slot3() : Array
      {
         return this._slot3;
      }
      
      public function set slot3(value:Array) : void
      {
         this._slot3 = value;
      }
      
      public function get slot4() : Array
      {
         return this._slot4;
      }
      
      public function set slot4(value:Array) : void
      {
         this._slot4 = value;
      }
      
      public function get slot5() : Array
      {
         return this._slot5;
      }
      
      public function set slot5(value:Array) : void
      {
         this._slot5 = value;
      }
      
      public function get slot6() : Array
      {
         return this._slot6;
      }
      
      public function set slot6(value:Array) : void
      {
         this._slot6 = value;
      }
      
      public function get slot7() : Array
      {
         return this._slot7;
      }
      
      public function set slot7(value:Array) : void
      {
         this._slot7 = value;
      }
      
      public function get slot8() : Array
      {
         return this._slot8;
      }
      
      public function set slot8(value:Array) : void
      {
         this._slot8 = value;
      }
      
      public function get slot9() : Array
      {
         return this._slot9;
      }
      
      public function set slot9(value:Array) : void
      {
         this._slot9 = value;
      }
      
      public function get slot10() : Array
      {
         return this._slot10;
      }
      
      public function set slot10(value:Array) : void
      {
         this._slot10 = value;
      }
      
      public function get slot11() : Array
      {
         return this._slot11;
      }
      
      public function set slot11(value:Array) : void
      {
         this._slot11 = value;
      }
      
      public function get slot11_key() : Array
      {
         return this._slot11_key;
      }
      
      public function set slot11_key(value:Array) : void
      {
         this._slot11_key = value;
      }
      
      public function setSlot1(gem:Gem, num:Number) : *
      {
         this._slot1[num] = gem;
      }
      
      public function delSlot1(num:Number) : Gem
      {
         var gem:Gem = this._slot1[num];
         this._slot1[num] = null;
         return gem;
      }
      
      public function getSlot1(num:Number) : Gem
      {
         return this._slot1[num];
      }
      
      public function setSlot2(gem:Gem, num:Number) : *
      {
         this._slot2[num] = gem;
      }
      
      public function delSlot2(num:Number) : Gem
      {
         var gem:Gem = this._slot2[num];
         this._slot2[num] = null;
         return gem;
      }
      
      public function getSlot2(num:Number) : Gem
      {
         return this._slot2[num];
      }
      
      public function setSlot3(gem:Gem, num:Number) : *
      {
         this._slot3[num] = gem;
      }
      
      public function delSlot3(num:Number) : Gem
      {
         var gem:Gem = this._slot3[num];
         this._slot3[num] = null;
         return gem;
      }
      
      public function getSlot3(num:Number) : Gem
      {
         return this._slot3[num];
      }
      
      public function setSlot4(gem:Gem, num:Number) : *
      {
         this._slot4[num] = gem;
      }
      
      public function delSlot4(num:Number) : Gem
      {
         var gem:Gem = this._slot4[num];
         this._slot4[num] = null;
         return gem;
      }
      
      public function getSlot4(num:Number) : Gem
      {
         return this._slot4[num];
      }
      
      public function setSlot5(gem:Gem, num:Number) : *
      {
         this._slot5[num] = gem;
      }
      
      public function delSlot5(num:Number) : Gem
      {
         var gem:Gem = this._slot5[num];
         this._slot5[num] = null;
         return gem;
      }
      
      public function getSlot5(num:Number) : Gem
      {
         return this._slot5[num];
      }
      
      public function setSlot6(gem:Gem, num:Number) : *
      {
         this._slot6[num] = gem;
      }
      
      public function delSlot6(num:Number) : Gem
      {
         var gem:Gem = this._slot6[num];
         this._slot6[num] = null;
         return gem;
      }
      
      public function getSlot6(num:Number) : Gem
      {
         return this._slot6[num];
      }
      
      public function setSlot7(gem:Gem, num:Number) : *
      {
         this._slot7[num] = gem;
      }
      
      public function delSlot7(num:Number) : Gem
      {
         var gem:Gem = this._slot7[num];
         this._slot7[num] = null;
         return gem;
      }
      
      public function getSlot7(num:Number) : Gem
      {
         return this._slot7[num];
      }
      
      public function setSlot8(gem:Gem, num:Number) : *
      {
         this._slot8[num] = gem;
      }
      
      public function delSlot8(num:Number) : Gem
      {
         var gem:Gem = this._slot8[num];
         this._slot8[num] = null;
         return gem;
      }
      
      public function getSlot8(num:Number) : Gem
      {
         return this._slot8[num];
      }
      
      public function setSlot9(gem:Gem, num:Number) : *
      {
         this._slot9[num] = gem;
      }
      
      public function delSlot9(num:Number) : Gem
      {
         var gem:Gem = this._slot9[num];
         this._slot9[num] = null;
         return gem;
      }
      
      public function getSlot9(num:Number) : Gem
      {
         return this._slot9[num];
      }
      
      public function setSlot10(gem:Gem, num:Number) : *
      {
         this._slot10[num] = gem;
      }
      
      public function delSlot10(num:Number) : Gem
      {
         var gem:Gem = this._slot10[num];
         this._slot10[num] = null;
         return gem;
      }
      
      public function getSlot10(num:Number) : Gem
      {
         return this._slot10[num];
      }
      
      public function setSlot11(gem:Gem, num:Number) : *
      {
         this._slot11[num] = gem;
      }
      
      public function delSlot11(num:Number) : Gem
      {
         var gem:Gem = this._slot11[num];
         this._slot11[num] = null;
         return gem;
      }
      
      public function getSlot11(num:Number) : Gem
      {
         return this._slot11[num];
      }
      
      public function setKeySlot11() : *
      {
         for(var i:int = 0; i < 4; i++)
         {
            if(this._slot11_key[i] == 0)
            {
               this._slot11_key[i] = 1;
               break;
            }
         }
      }
      
      public function getSlot11_key(num:Number) : Number
      {
         return this._slot11_key[num];
      }
      
      public function getValueSlot1() : Number
      {
         var count:Number = 0;
         for(var i:int = 0; i < 4; i++)
         {
            if(this._slot1[i])
            {
               count += this.getSlot1(i).getGemSkill();
            }
            if(this._slot11[i])
            {
               if(this.getSlot11(i).getType() == 7)
               {
                  count += this.getSlot11(i).getGemSkill();
               }
            }
         }
         return count;
      }
   }
}

