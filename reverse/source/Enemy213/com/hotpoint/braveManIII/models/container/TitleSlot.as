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
            if(this._slot[_loc1_] != null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getTitleFromSlot(param1:Number) : Title
      {
         if(this._slot[param1] != null)
         {
            return this._slot[param1];
         }
         return null;
      }
      
      public function addToSlot(param1:Title) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < 20)
         {
            if(this._slot[_loc2_] == null)
            {
               this._slot[_loc2_] = param1;
               this._titleView = param1;
               this._titleAttrib = param1;
               break;
            }
            if((this._slot[_loc2_] as Title).compare(param1))
            {
               this._slot[_loc2_] = param1;
               this._titleView = param1;
               this._titleAttrib = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public function delFromSlot(param1:Number) : Boolean
      {
         if(this._slot[param1] != null)
         {
            this._slot.splice(param1,1);
            this._titleView = null;
            this._titleAttrib = null;
            return true;
         }
         return false;
      }
      
      public function setTitleView(param1:Title) : *
      {
         this._titleView = param1;
      }
      
      public function delTitleView() : *
      {
         this._titleView = null;
      }
      
      public function getTitleView() : Title
      {
         return this._titleView;
      }
      
      public function setTitleAttrib(param1:Title) : *
      {
         this._titleAttrib = param1;
      }
      
      public function delTitleAttrib() : *
      {
         this._titleAttrib = null;
      }
      
      public function getTitleAttrib() : Title
      {
         return this._titleAttrib;
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
               if(Boolean(this._slot[_loc1_]) && Boolean(this._slot[_loc2_]) && Boolean((this._slot[_loc1_] as Title).compare(this._slot[_loc2_])))
               {
                  this.delFromSlot(_loc2_);
                  _loc2_--;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function get titleView() : Title
      {
         return this._titleView;
      }
      
      public function set titleView(param1:Title) : void
      {
         this._titleView = param1;
      }
      
      public function get titleAttrib() : Title
      {
         return this._titleAttrib;
      }
      
      public function set titleAttrib(param1:Title) : void
      {
         this._titleAttrib = param1;
      }
      
      public function get slot() : Array
      {
         return this._slot;
      }
      
      public function set slot(param1:Array) : void
      {
         this._slot = param1;
      }
   }
}

