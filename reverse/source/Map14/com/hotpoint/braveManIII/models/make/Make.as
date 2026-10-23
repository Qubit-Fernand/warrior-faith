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
      
      public static function creatMake(id:Number) : Make
      {
         var make:Make = new Make();
         make._id = VT.createVT(id);
         make._state = false;
         return make;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get state() : Boolean
      {
         return _state;
      }
      
      public function set state(value:Boolean) : void
      {
         _state = value;
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
         var arr:Array = [];
         var type:Number = getType();
         var id:Number = getFinishId();
         var num:Number = getFinishNum();
         for(var i:uint = 0; i < num; i++)
         {
            arr.push(addobj(type,id));
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function addNeedOb() : Array
      {
         var i:uint = 0;
         var idArr:Array = getNeedId();
         var typeArr:Array = getNeedType();
         var obArr:Array = [];
         if(idArr.length > 0)
         {
            for(i = 0; i < idArr.length; i++)
            {
               if(idArr[i] == -1)
               {
                  obArr.push(null);
               }
               else
               {
                  obArr.push(addobj(typeArr[i],idArr[i]));
               }
            }
         }
         if(obArr.length < 1)
         {
            return null;
         }
         return obArr;
      }
      
      private function addobj(type:Number, id:Number) : Object
      {
         var ob:Object = null;
         if(type == 0 || type == 4 || type == 5)
         {
            ob = EquipFactory.createEquipByID(id);
         }
         else if(type == 1)
         {
            ob = SuppliesFactory.getSuppliesById(id);
         }
         else if(type == 2)
         {
            ob = GemFactory.creatGemById(id);
         }
         else if(type == 3)
         {
            ob = OtherFactory.creatOther(id);
         }
         return ob;
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

