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
         var ts:TitleSlot = new TitleSlot();
         for(var i:int = 0; i < 20; i++)
         {
            ts._slot[i] = null;
         }
         return ts;
      }
      
      public function getListLength() : Number
      {
         var num:Number = 0;
         for(var i:int = 0; i < 20; i++)
         {
            if(_slot[num] != null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function getTitleFromSlot(num:Number) : Title
      {
         if(_slot[num] != null)
         {
            return _slot[num];
         }
         return null;
      }
      
      public function addToSlot(value:Title) : *
      {
         for(var i:int = 0; i < 20; i++)
         {
            if(_slot[i] == null)
            {
               _slot[i] = value;
               _titleView = value;
               _titleAttrib = value;
               break;
            }
            if((_slot[i] as Title).compare(value))
            {
               _slot[i] = value;
               _titleView = value;
               _titleAttrib = value;
               break;
            }
         }
      }
      
      public function delFromSlot(num:Number) : Boolean
      {
         if(_slot[num] != null)
         {
            _slot.splice(num,1);
            _titleView = null;
            _titleAttrib = null;
            return true;
         }
         return false;
      }
      
      public function setTitleView(value:Title) : *
      {
         _titleView = value;
      }
      
      public function delTitleView() : *
      {
         _titleView = null;
      }
      
      public function getTitleView() : Title
      {
         return _titleView;
      }
      
      public function setTitleAttrib(value:Title) : *
      {
         _titleAttrib = value;
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
         var j:uint = 0;
         for(var i:uint = 0; i < 20; i++)
         {
            for(j = i + 1; j < 19; j++)
            {
               if(Boolean(_slot[i]) && Boolean(_slot[j]) && Boolean((_slot[i] as Title).compare(_slot[j])))
               {
                  delFromSlot(j);
                  j--;
               }
            }
         }
      }
      
      public function get titleView() : Title
      {
         return _titleView;
      }
      
      public function set titleView(value:Title) : void
      {
         _titleView = value;
      }
      
      public function get titleAttrib() : Title
      {
         return _titleAttrib;
      }
      
      public function set titleAttrib(value:Title) : void
      {
         _titleAttrib = value;
      }
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(value:Array) : void
      {
         _slot = value;
      }
   }
}

