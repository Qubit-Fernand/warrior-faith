package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.title.*;
   import src.*;
   
   public class TitleSlot
   {
      
      private var _slot:Array = new Array();
      
      private var _titleView:Title;
      
      private var _titleAttrib:Title;
      
      public function TitleSlot()
      {
         super();
      }
      
      public static function createTitleSlot() : TitleSlot
      {
         var _loc1_:TitleSlot = new TitleSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 20)
         {
            _loc1_._slot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getListLength() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 20)
         {
            if(_slot[_loc1_] != null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getTitleFromSlot(param1:Number) : Title
      {
         if(_slot[param1] != null)
         {
            return _slot[param1];
         }
         return null;
      }
      
      public function addToSlot(param1:Title) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < 20)
         {
            if(_slot[_loc2_] == null)
            {
               _slot[_loc2_] = param1;
               _titleView = param1;
               _titleAttrib = param1;
               break;
            }
            if((_slot[_loc2_] as Title).compare(param1))
            {
               _slot[_loc2_] = param1;
               _titleView = param1;
               _titleAttrib = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public function delFromSlot(param1:Number) : Boolean
      {
         if(_slot[param1] != null)
         {
            _slot.splice(param1,1);
            _titleView = null;
            _titleAttrib = null;
            return true;
         }
         return false;
      }
      
      public function setTitleView(param1:Title) : *
      {
         _titleView = param1;
      }
      
      public function delTitleView() : *
      {
         _titleView = null;
      }
      
      public function getTitleView() : Title
      {
         return _titleView;
      }
      
      public function setTitleAttrib(param1:Title) : *
      {
         _titleAttrib = param1;
      }
      
      public function delTitleAttrib() : *
      {
         _titleAttrib = null;
      }
      
      public function getTitleAttrib() : Title
      {
         return _titleAttrib;
      }
      
      public function debugTitle() : *
      {
         var _loc2_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 20)
         {
            _loc2_ = _loc1_ + 1;
            while(_loc2_ < 19)
            {
               if(Boolean(_slot[_loc1_]) && Boolean(_slot[_loc2_]) && Boolean((_slot[_loc1_] as Title).compare(_slot[_loc2_])))
               {
                  delFromSlot(_loc2_);
                  _loc2_--;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function get titleView() : Title
      {
         return _titleView;
      }
      
      public function set titleView(param1:Title) : void
      {
         _titleView = param1;
      }
      
      public function get titleAttrib() : Title
      {
         return _titleAttrib;
      }
      
      public function set titleAttrib(param1:Title) : void
      {
         _titleAttrib = param1;
      }
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(param1:Array) : void
      {
         _slot = param1;
      }
   }
}

