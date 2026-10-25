package com.hotpoint.braveManIII.views.playerTaskPanel
{
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   
   public class TaskText
   {
      
      public function TaskText()
      {
         super();
      }
      
      public static function creatTaskData() : TaskText
      {
         var textData:TaskText = null;
         return new TaskText();
      }
      
      public function addJl(slot:Object, num:*) : Array
      {
         var arr1:Array = null;
         var arr2:Array = null;
         var e:Array = null;
         var g:Array = null;
         var s:Array = null;
         var o:Array = null;
         var arr:Array = null;
         arr1 = getAwardTypeAndId(slot,num);
         arr2 = getAwrdNum(slot,num);
         e = addJlEqu(slot,num);
         g = addJlGem(slot,num);
         s = addJlSup(slot,num);
         o = addJlOther(slot,num);
         arr = [];
         if(e.length > 0)
         {
            arr.push(e);
         }
         if(g.length > 0)
         {
            arr.push(g);
         }
         if(s.length > 0)
         {
            arr.push(s);
         }
         if(o.length > 0)
         {
            arr.push(o);
         }
         return arr;
      }
      
      public function getGoodsNum(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getGoodsNum();
      }
      
      public function getDemand(slot:Object, num:Number) : String
      {
         return slot.getTask(num).getDemand();
      }
      
      public function addJlSup(slot:Object, num:*) : Array
      {
         var arr1:Array = null;
         var arr2:Array = null;
         var arr:Array = null;
         var i:uint = 0;
         var j:uint = 0;
         var sup:Supplies = null;
         arr1 = getAwardTypeAndId(slot,num);
         arr2 = getAwrdNum(slot,num);
         arr = [];
         for(i = 0; i < arr1.length; i++)
         {
            if(arr1 != null)
            {
               for(j = 0; j < arr2[i]; j++)
               {
                  if(arr1[i][0] == 3)
                  {
                     sup = SuppliesFactory.getSuppliesById(arr1[i][1]);
                     arr.push(sup);
                  }
               }
            }
         }
         return arr;
      }
      
      public function addJlGem(slot:Object, num:*) : Array
      {
         var arr1:Array = null;
         var arr2:Array = null;
         var arr:Array = null;
         var i:uint = 0;
         var j:uint = 0;
         var gem:Gem = null;
         arr1 = getAwardTypeAndId(slot,num);
         arr2 = getAwrdNum(slot,num);
         arr = [];
         for(i = 0; i < arr1.length; i++)
         {
            if(arr1 != null)
            {
               for(j = 0; j < arr2[i]; j++)
               {
                  if(arr1[i][0] == 2)
                  {
                     gem = GemFactory.creatGemById(arr1[i][1]);
                     arr.push(gem);
                  }
               }
            }
         }
         return arr;
      }
      
      public function getEnemyId(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getEnemyId();
      }
      
      public function getGoodsedNum(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getGoodsedNum();
      }
      
      public function getIntroduction(slot:Object, num:Number) : String
      {
         return slot.getTask(num).getIntroduction();
      }
      
      public function getId(slot:Object, num:Number) : String
      {
         return (slot.getTask(num) as Task).getId();
      }
      
      public function getEnemyNum(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getEnemyNum();
      }
      
      public function getEnemyedNum(slot:Object, num:Number) : Array
      {
         return (slot.getTask(num) as Task).getEnemyArr();
      }
      
      public function getGold(slot:Object, num:Number) : Number
      {
         num = Number(slot.getTask(num).getGold());
         if(num < 0)
         {
            num = 0;
         }
         return num;
      }
      
      public function getAwrdNum(slot:Object, num:Number) : Array
      {
         return (slot.getTask(num) as Task).getAwardNum();
      }
      
      public function getAwardTypeAndId(slot:Object, num:Number) : Array
      {
         return (slot.getTask(num) as Task).getAwardTypeAndId();
      }
      
      public function getAllNum(slot:Object, num:Number) : Array
      {
         var allNum:Array = null;
         var arr1:Array = null;
         var arr2:Array = null;
         var i:uint = 0;
         allNum = [];
         arr1 = getEnemyNum(slot,num);
         arr2 = getGoodsNum(slot,num);
         if(arr1 != null)
         {
            for(i = 0; i < arr1.length; i++)
            {
               allNum.push(arr1[i]);
            }
         }
         if(arr2 != null)
         {
            for(i = 0; i < arr2.length; i++)
            {
               allNum.push(arr2[i]);
            }
         }
         return allNum;
      }
      
      public function addJlOther(slot:Object, num:*) : Array
      {
         var arr1:Array = null;
         var arr2:Array = null;
         var arr:Array = null;
         var i:uint = 0;
         var j:uint = 0;
         var other:Otherobj = null;
         arr1 = getAwardTypeAndId(slot,num);
         arr2 = getAwrdNum(slot,num);
         arr = [];
         for(i = 0; i < arr1.length; i++)
         {
            if(arr1 != null)
            {
               for(j = 0; j < arr2[i]; j++)
               {
                  if(arr1[i][0] == 4)
                  {
                     other = OtherFactory.creatOther(arr1[i][1]);
                     arr.push(other);
                  }
               }
            }
         }
         return arr;
      }
      
      public function addJlEqu(slot:Object, num:*) : Array
      {
         var arr1:Array = null;
         var arr2:Array = null;
         var arr:Array = null;
         var i:uint = 0;
         var j:uint = 0;
         var equ:Equip = null;
         arr1 = getAwardTypeAndId(slot,num);
         arr2 = getAwrdNum(slot,num);
         arr = [];
         for(i = 0; i < arr1.length; i++)
         {
            if(arr1 != null)
            {
               for(j = 0; j < arr2[i]; j++)
               {
                  if(arr1[i][0] == 1)
                  {
                     equ = EquipFactory.createEquipByID(arr1[i][1]);
                     arr.push(equ);
                  }
               }
            }
         }
         return arr;
      }
      
      public function getGoodsId(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getGoodsId();
      }
      
      public function getAllId(slot:Object, num:Number) : Array
      {
         var id:Number = NaN;
         var allId:Array = null;
         var arr1:Array = null;
         var arr2:Array = null;
         var i:uint = 0;
         id = Number(getId(slot,num));
         allId = [];
         arr1 = getEnemyId(slot,num);
         arr2 = getGoodsId(slot,num);
         if(arr1 != null)
         {
            for(i = 0; i < arr1.length; i++)
            {
               allId.push(arr1[i]);
            }
         }
         if(arr2 != null)
         {
            for(i = 0; i < arr2.length; i++)
            {
               if(id != 310002)
               {
                  allId.push(QuestFactory.getName(arr2[i]));
               }
               else
               {
                  allId.push(OtherFactory.getName(arr2[i]));
               }
            }
         }
         return allId;
      }
      
      public function getExp(slot:Object, num:Number) : Number
      {
         num = Number(slot.getTask(num).getExp());
         if(num < 0)
         {
            num = 0;
         }
         return num;
      }
      
      public function getAllNuming(slot:Object, num:Number) : Array
      {
         var allNum:Array = null;
         var arr1:Array = null;
         var arr2:Array = null;
         var i:uint = 0;
         allNum = [];
         arr1 = getEnemyedNum(slot,num);
         arr2 = getGoodsedNum(slot,num);
         if(arr1 != null)
         {
            for(i = 0; i < arr1.length; i++)
            {
               allNum.push(arr1[i]);
            }
         }
         if(arr2 != null)
         {
            for(i = 0; i < arr2.length; i++)
            {
               allNum.push(arr2[i]);
            }
         }
         return allNum;
      }
      
      public function getAwrdType(slot:Object, num:Number) : Array
      {
         return (slot.getTask(num) as Task).getAwardType();
      }
   }
}

QuestFactory;

