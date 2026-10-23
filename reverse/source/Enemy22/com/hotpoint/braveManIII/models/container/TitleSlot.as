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
            if(this._slot[num] != null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function getTitleFromSlot(num:Number) : Title
      {
         if(this._slot[num] != null)
         {
            return this._slot[num];
         }
         return null;
      }
      
      public function addToSlot(value:Title) : *
      {
         for(var i:int = 0; i < 20; i++)
         {
            if(this._slot[i] == null)
            {
               this._slot[i] = value;
               this._titleView = value;
               this._titleAttrib = value;
               break;
            }
            if((this._slot[i] as Title).compare(value))
            {
               this._slot[i] = value;
               this._titleView = value;
               this._titleAttrib = value;
               break;
            }
         }
      }
      
      public function delFromSlot(num:Number) : Boolean
      {
         if(this._slot[num] != null)
         {
            this._slot.splice(num,1);
            this._titleView = null;
            this._titleAttrib = null;
            return true;
         }
         return false;
      }
      
      public function setTitleView(value:Title) : *
      {
         this._titleView = value;
      }
      
      public function delTitleView() : *
      {
         this._titleView = null;
      }
      
      public function getTitleView() : Title
      {
         return this._titleView;
      }
      
      public function setTitleAttrib(value:Title) : *
      {
         this._titleAttrib = value;
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
         var j:uint = 0;
         for(var i:uint = 0; i < 20; i++)
         {
            for(j = i + 1; j < 19; j++)
            {
               if(Boolean(this._slot[i]) && Boolean(this._slot[j]) && Boolean((this._slot[i] as Title).compare(this._slot[j])))
               {
                  this.delFromSlot(j);
                  j--;
               }
            }
         }
      }
      
      public function get titleView() : Title
      {
         return this._titleView;
      }
      
      public function set titleView(value:Title) : void
      {
         this._titleView = value;
      }
      
      public function get titleAttrib() : Title
      {
         return this._titleAttrib;
      }
      
      public function set titleAttrib(value:Title) : void
      {
         this._titleAttrib = value;
      }
      
      public function get slot() : Array
      {
         return this._slot;
      }
      
      public function set slot(value:Array) : void
      {
         this._slot = value;
      }
   }
}

