package com.hotpoint.braveManIII.views.composePanel
{
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.make.Make;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.make.*;
   import com.hotpoint.braveManIII.repository.other.*;
   
   public class ComData
   {
      
      public function ComData()
      {
         super();
      }
      
      public static function getType(param1:Number) : Array
      {
         var _loc4_:Make = null;
         var _loc2_:Array = [];
         var _loc3_:Array = MakeFactory.makeData;
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.getType() == param1)
            {
               _loc2_.push(_loc4_);
            }
         }
         if(_loc2_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public static function getTowIdById1(param1:Equip) : Array
      {
         var _loc5_:Make = null;
         var _loc6_:Number = NaN;
         var _loc2_:Array = getType(5);
         if(_loc2_ == null || param1 == null)
         {
            return null;
         }
         var _loc3_:Number = param1.getId();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_];
            if(_loc5_.getNeedId()[0] == _loc3_)
            {
               _loc6_ = Number(_loc5_.getNeedId()[1]);
               return ComPosePanel.data.getBag().getEquipByIdTOW(_loc6_);
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function towBo(param1:Number, param2:Number) : Boolean
      {
         var _loc4_:uint = 0;
         var _loc5_:Make = null;
         var _loc6_:Number = NaN;
         var _loc3_:Array = getType(5);
         if(_loc3_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc3_[_loc4_];
               if(_loc5_.getNeedId()[0] == param2)
               {
                  _loc6_ = Number(_loc5_.getNeedId()[1]);
                  if(param1 == _loc6_)
                  {
                     return true;
                  }
               }
               _loc4_++;
            }
         }
         return false;
      }
      
      public static function getThreeIdById1(param1:Equip) : Otherobj
      {
         var _loc5_:Make = null;
         var _loc6_:Number = NaN;
         var _loc2_:Array = getType(5);
         if(_loc2_ == null || param1 == null)
         {
            return null;
         }
         var _loc3_:Number = param1.getId();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_];
            if(_loc5_.getNeedId()[0] == _loc3_)
            {
               _loc6_ = Number(_loc5_.getNeedId()[2]);
               return OtherFactory.creatOther(_loc6_);
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function getThreeNumById1(param1:Equip) : Number
      {
         var _loc6_:Make = null;
         var _loc2_:Number = 0;
         var _loc3_:Array = getType(5);
         if(_loc3_ == null || param1 == null)
         {
            return null;
         }
         var _loc4_:Number = param1.getId();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_];
            if(_loc6_.getNeedId()[0] == _loc4_)
            {
               _loc2_ = Number(_loc6_.getNeedNum()[2]);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function getNeedOne(param1:Number) : Array
      {
         var _loc5_:Make = null;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         _loc2_ = getType(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_];
            if(_loc5_.getNeedId()[0] != -1)
            {
               _loc3_.push(_loc5_.getNeedId()[0]);
            }
            _loc4_++;
         }
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc3_;
      }
      
      public static function getNeedEquipInBag() : Array
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = getNeedOne(5);
         if(_loc5_ == null)
         {
            return null;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(ComPosePanel.data.getBag().getEquipByIdTOW(_loc5_[_loc6_]) != null)
            {
               _loc1_.push(ComPosePanel.data.getBag().getEquipByIdTOW(_loc5_[_loc6_]));
            }
            _loc6_++;
         }
         if(_loc1_.length < 1)
         {
            return null;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc1_.length)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc1_[_loc6_][0].length)
            {
               _loc2_.push(_loc1_[_loc6_][0][_loc7_]);
               _loc3_.push(_loc1_[_loc6_][1][_loc7_]);
               _loc7_++;
            }
            _loc6_++;
         }
         return [_loc2_,_loc3_];
      }
      
      public static function getHcNum(param1:Equip) : Array
      {
         var _loc3_:Number = NaN;
         var _loc8_:Make = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Number = param1.getId();
         _loc3_ = 0;
         var _loc4_:Number = 0;
         var _loc5_:Array = getType(5);
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc8_ = _loc5_[_loc6_];
            if(_loc8_.getNeedId()[0] == _loc2_)
            {
               _loc3_ = Number(_loc8_.getNeedId()[2]);
               _loc4_ = Number(String(_loc8_.getNeedNum()[2]));
            }
            _loc6_++;
         }
         var _loc7_:String = ComPosePanel.data.getBag().getOtherobjNum(_loc3_).toString();
         xxx = [_loc4_,_loc7_];
         return xxx;
      }
      
      public static function gethcOther() : Otherobj
      {
         return OtherFactory.creatOther(63100);
      }
      
      public static function gethcOtherNum() : Number
      {
         return ComPosePanel.data.getBag().getOtherobjNum(63100);
      }
      
      public static function getFinish(param1:Equip) : Array
      {
         var _loc5_:Make = null;
         var _loc2_:Array = getType(5);
         if(_loc2_ == null || param1 == null)
         {
            return null;
         }
         var _loc3_:Number = param1.getId();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_];
            if(_loc5_.getNeedId()[0] == _loc3_)
            {
               return _loc5_.getObj();
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function getNeedStae(param1:Object = null) : Array
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:Gem = null;
         var _loc12_:Number = NaN;
         if(ComPosePanel.state == 0)
         {
            if(ComPosePanel.stateTow == 0)
            {
               return getNeedEquipInBag();
            }
            if(ComPosePanel.stateTow == 1)
            {
               return getTowIdById1(param1);
            }
         }
         if(ComPosePanel.state == 1)
         {
            if(ComPosePanel.stateTow == 0)
            {
               return getStrGem();
            }
            if(ComPosePanel.stateTow == 1)
            {
               _loc2_ = Number((param1 as Gem).getId());
               _loc3_ = Number((param1 as Gem).getType());
               _loc4_ = Number((param1 as Gem).getUseLevel());
               _loc5_ = Number((param1 as Gem).getColor());
               if(_loc3_ == 0)
               {
                  return getGemSp();
               }
               if(_loc3_ == 1)
               {
                  _loc6_ = getGemStr();
                  _loc7_ = [];
                  _loc8_ = [];
                  _loc9_ = [];
                  if(_loc6_ == null)
                  {
                     return null;
                  }
                  _loc10_ = 0;
                  while(_loc10_ < _loc6_[0].length)
                  {
                     _loc11_ = _loc6_[0][_loc10_];
                     _loc12_ = Number(_loc6_[1][_loc10_]);
                     if(_loc11_.getUseLevel() == (param1 as Gem).getUseLevel())
                     {
                        _loc7_.push(_loc11_);
                        _loc8_.push(_loc12_);
                     }
                     _loc10_++;
                  }
                  return [_loc7_,_loc8_];
               }
               if(_loc3_ == 3)
               {
                  return getGemSx();
               }
            }
         }
         return null;
      }
      
      public static function getEquiping() : Array
      {
         var _loc5_:Equip = null;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:Make = null;
         var _loc1_:Array = getType(5);
         var _loc2_:Array = [];
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < 8)
         {
            _loc2_[_loc3_] = null;
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            if(ComPosePanel.data.getEquipSlot().getEquipFromSlot(_loc4_) != null)
            {
               _loc5_ = ComPosePanel.data.getEquipSlot().getEquipFromSlot(_loc4_);
               _loc6_ = _loc5_.getId();
               _loc7_ = 0;
               while(_loc7_ < _loc1_.length)
               {
                  _loc8_ = _loc1_[_loc7_];
                  if(_loc8_.getNeedId()[0] == _loc6_ && _loc5_.getRemainingTime() > 0)
                  {
                     _loc2_[_loc4_] = _loc5_;
                     break;
                  }
                  _loc7_++;
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function getPlayGod(param1:Equip) : String
      {
         var _loc6_:Make = null;
         var _loc2_:Number = 0;
         var _loc3_:Array = getType(5);
         if(_loc3_ == null || param1 == null)
         {
            return null;
         }
         var _loc4_:Number = param1.getId();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_];
            if(_loc6_.getNeedId()[0] == _loc4_)
            {
               _loc2_ = _loc6_.getGold();
               break;
            }
            _loc5_++;
         }
         return _loc2_.toString();
      }
      
      private static function getGemSp() : Array
      {
         return ComPosePanel.data.getBag().getGemByType(0);
      }
      
      private static function getGemStr() : Array
      {
         var _loc6_:Gem = null;
         var _loc1_:Array = ComPosePanel.data.getBag().getGemByType(1);
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < _loc1_[0].length)
         {
            _loc6_ = _loc1_[0][_loc5_];
            if(_loc6_.getColor() == 1)
            {
               _loc2_.push(_loc6_);
               _loc3_.push(_loc1_[1][_loc5_]);
            }
            _loc5_++;
         }
         _loc4_ = [_loc2_,_loc3_];
         if(_loc2_.length < 1)
         {
            return null;
         }
         return _loc4_;
      }
      
      private static function getGemSx() : Array
      {
         var _loc6_:Gem = null;
         var _loc1_:Array = ComPosePanel.data.getBag().getGemByType(3);
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < _loc1_[0].length)
         {
            _loc6_ = _loc1_[0][_loc5_];
            if(_loc6_.getColor() == 1)
            {
               _loc2_.push(_loc6_);
               _loc3_.push(_loc1_[1][_loc5_]);
            }
            _loc5_++;
         }
         _loc4_ = [_loc2_,_loc3_];
         if(_loc2_.length < 1)
         {
            return null;
         }
         return _loc4_;
      }
      
      private static function getStrGem() : Array
      {
         var _loc7_:uint = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = getGemSp();
         var _loc5_:Array = getGemStr();
         var _loc6_:Array = getGemSx();
         if(_loc4_ != null)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_[0].length)
            {
               _loc2_.push(_loc4_[0][_loc7_]);
               _loc3_.push(_loc4_[1][_loc7_]);
               _loc7_++;
            }
         }
         if(_loc5_ != null)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_[0].length)
            {
               _loc2_.push(_loc5_[0][_loc7_]);
               _loc3_.push(_loc5_[1][_loc7_]);
               _loc7_++;
            }
         }
         if(_loc6_ != null)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_[0].length)
            {
               _loc2_.push(_loc6_[0][_loc7_]);
               _loc3_.push(_loc6_[1][_loc7_]);
               _loc7_++;
            }
         }
         _loc1_ = [_loc2_,_loc3_];
         if(_loc2_.length < 1)
         {
            return null;
         }
         return _loc1_;
      }
      
      public static function gemFinish(param1:Gem = null, param2:Object = null) : Gem
      {
         var _loc4_:Gem = null;
         var _loc5_:Gem = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc3_:Number = param1.getType();
         if(param1.getUseLevel() >= param2.getUseLevel())
         {
            _loc5_ = param1;
         }
         else
         {
            _loc5_ = param2;
         }
         switch(_loc3_)
         {
            case 0:
               _loc4_ = GemFactory.createGemByCompose(1,param1.getStrengthenLevel() + 1,[]);
               break;
            case 1:
               _loc4_ = GemFactory.createGemByCompose(2,param1.getStrengthenLevel(),[]);
               break;
            case 3:
               _loc6_ = [];
               _loc7_ = [];
               _loc8_ = [];
               _loc7_ = param1.getGemAttrib();
               _loc8_ = param2.getGemAttrib();
               _loc9_ = 0;
               while(_loc9_ < _loc7_.length)
               {
                  _loc6_.push(_loc7_[_loc9_]);
                  _loc9_++;
               }
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  _loc6_.push(_loc8_[_loc9_]);
                  _loc9_++;
               }
               _loc4_ = GemFactory.createGemByCompose(2,_loc5_.getStrengthenLevel(),_loc6_);
               _loc6_ = [];
         }
         return _loc4_;
      }
   }
}

