package com.hotpoint.braveManIII.models.make
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.make.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   
   public class Make
   {
      
      private var _id:VT;
      
      private var _state:Boolean;
      
      public function Make()
      {
         super();
      }
      
      public static function creatMake(param1:Number) : Make
      {
         var _loc2_:Make = new Make();
         _loc2_._id = VT.createVT(param1);
         _loc2_._state = false;
         return _loc2_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get state() : Boolean
      {
         return _state;
      }
      
      public function set state(param1:Boolean) : void
      {
         _state = param1;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getType() : Number
      {
         return MakeFactory.getType(_id.getValue());
      }
      
      public function getName() : String
      {
         return MakeFactory.getName(_id.getValue());
      }
      
      public function getFrame() : Number
      {
         return MakeFactory.getFrame(_id.getValue());
      }
      
      public function getSm() : String
      {
         return MakeFactory.getSm(_id.getValue());
      }
      
      public function getNeedId() : Array
      {
         return MakeFactory.getNeedId(_id.getValue());
      }
      
      public function getNeedType() : Array
      {
         return MakeFactory.getNeedType(_id.getValue());
      }
      
      public function getNeedNum() : Array
      {
         return MakeFactory.getNeedNum(_id.getValue());
      }
      
      public function getFinishId() : Number
      {
         return MakeFactory.getFinishId(_id.getValue());
      }
      
      public function getFinishNum() : Number
      {
         return MakeFactory.getFinishNum(_id.getValue());
      }
      
      public function getObj() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Number = getType();
         var _loc3_:Number = getFinishId();
         var _loc4_:Number = getFinishNum();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc1_.push(addobj(_loc2_,_loc3_));
            _loc5_++;
         }
         if(_loc1_.length < 1)
         {
            return null;
         }
         return _loc1_;
      }
      
      public function addNeedOb() : Array
      {
         var _loc4_:uint = 0;
         var _loc1_:Array = getNeedId();
         var _loc2_:Array = getNeedType();
         var _loc3_:Array = [];
         if(_loc1_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               if(_loc1_[_loc4_] == -1)
               {
                  _loc3_.push(null);
               }
               else
               {
                  _loc3_.push(addobj(_loc2_[_loc4_],_loc1_[_loc4_]));
               }
               _loc4_++;
            }
         }
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc3_;
      }
      
      private function addobj(param1:Number, param2:Number) : Object
      {
         var _loc3_:Object = null;
         if(param1 == 0 || param1 == 4 || param1 == 5 || param1 == 6)
         {
            _loc3_ = EquipFactory.createEquipByID(param2);
         }
         else if(param1 == 1)
         {
            _loc3_ = SuppliesFactory.getSuppliesById(param2);
         }
         else if(param1 == 2)
         {
            _loc3_ = GemFactory.creatGemById(param2);
         }
         else if(param1 == 3)
         {
            _loc3_ = OtherFactory.creatOther(param2);
         }
         return _loc3_;
      }
      
      public function getGold() : Number
      {
         return MakeFactory.getGold(_id.getValue());
      }
      
      public function isState() : Boolean
      {
         return _state;
      }
      
      public function setState() : void
      {
         _state = true;
      }
   }
}

