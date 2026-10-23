package com.hotpoint.braveManIII.views.taskPanel
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.Task;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import src.*;
   
   public class TaskDisplay
   {
      
      public function TaskDisplay()
      {
         super();
      }
      
      public function getAllId(task:Task) : Array
      {
         var i:uint = 0;
         var id:Number = task.getId();
         var allId:Array = [];
         var arr1:Array = task.getEnemyName();
         var arr2:Array = task.getGoodsId();
         if(arr1[0] is VT)
         {
            if(arr1[0].getValue() != -1)
            {
               for(i = 0; i < arr1.length; i++)
               {
                  allId.push(arr1[i]);
               }
            }
         }
         else if(arr1[0] != -1)
         {
            for(i = 0; i < arr1.length; i++)
            {
               allId.push(arr1[i]);
            }
         }
         if(arr2[0].getValue() != -1)
         {
            for(i = 0; i < arr2.length; i++)
            {
               if(id != 210002 && TaskData.isTsTask(id) == false)
               {
                  allId.push(QuestFactory.getName(arr2[i].getValue()));
               }
               else
               {
                  allId.push(OtherFactory.getName(arr2[i].getValue()));
               }
            }
         }
         return allId;
      }
      
      public function getAllNum(task:Task) : Array
      {
         var i:uint = 0;
         var allNum:Array = [];
         var arr1:Array = task.getEnemyNum();
         var arr2:Array = task.getGoodsNum();
         if(arr1[0].getValue() != -1)
         {
            for(i = 0; i < arr1.length; i++)
            {
               allNum.push(arr1[i].getValue());
            }
         }
         if(arr2[0].getValue() != -1)
         {
            for(i = 0; i < arr2.length; i++)
            {
               allNum.push(arr2[i].getValue());
            }
         }
         return allNum;
      }
      
      public function getAllNuming(task:Task) : Array
      {
         var i:uint = 0;
         var allNum:Array = [];
         var eId:Array = task.getEnemyId();
         var gId:Array = task.getGoodsId();
         var arr1:Array = task.getEenemyedNum();
         var arr2:Array = task.getGoodsedNum();
         for(i = 0; i < arr2.length; i++)
         {
            if(arr2[i] is VT)
            {
               break;
            }
            arr2[i] = VT.createVT(arr2[i]);
         }
         if(eId[0].getValue() != -1)
         {
            for(i = 0; i < arr1.length; i++)
            {
               allNum.push(arr1[i].getValue());
            }
         }
         if(gId[0].getValue() != -1 && arr2.length > 0)
         {
            for(i = 0; i < arr2.length; i++)
            {
               allNum.push(arr2[i].getValue());
            }
         }
         return allNum;
      }
      
      public function getExp(task:Task) : Number
      {
         return task.getAwardExp();
      }
      
      public function getGold(task:Task) : Number
      {
         return task.getAwardGold();
      }
      
      public function getAwId(task:Task) : Array
      {
         return task.getAwardId();
      }
      
      public function getAwType(task:Task) : Array
      {
         return task.getAwardType();
      }
      
      public function getAwNum(task:Task) : Array
      {
         return task.getAwardNum();
      }
      
      public function getAwGl(task:Task) : Array
      {
         return task.getAwardGl();
      }
      
      public function getAwPs(task:Task) : Number
      {
         return task.getAwardPs();
      }
      
      public function awObj(task:Task) : Array
      {
         var i:uint = 0;
         var id:Number = NaN;
         var type:Number = NaN;
         var frame:Number = NaN;
         var idArr:Array = task.getAwardId();
         var typeArr:Array = task.getAwardType();
         var arr:Array = [];
         if(idArr[0].getValue() != -1 && typeArr[0].getValue() != -1)
         {
            for(i = 0; i < idArr.length; i++)
            {
               if(idArr[i].getValue() != -1)
               {
                  id = Number(idArr[i].getValue());
                  type = Number(typeArr[i].getValue());
                  frame = 0;
                  if(type == 1)
                  {
                     arr.push(EquipFactory.createEquipByID(id));
                  }
                  else if(type == 2)
                  {
                     arr.push(GemFactory.creatGemById(id));
                  }
                  else if(type == 3)
                  {
                     arr.push(SuppliesFactory.getSuppliesById(id));
                  }
                  else if(type == 4)
                  {
                     arr.push(OtherFactory.creatOther(id));
                  }
               }
            }
         }
         return arr;
      }
      
      public function overAward(task:Task, arr:Array) : void
      {
         var i:uint = 0;
         var arrEqu:Array = addJl(task,arr);
         if(arrEqu.length > 0)
         {
            for(i = 0; i < arrEqu.length; i++)
            {
               howAward(arrEqu[i]);
            }
         }
      }
      
      public function addJl(task:Task, arrxx:Array) : Array
      {
         var j:uint = 0;
         var equ:Equip = null;
         var gem:Gem = null;
         var sup:Supplies = null;
         var other:Otherobj = null;
         var idArr:Array = task.getAwardId();
         var typeArr:Array = task.getAwardType();
         var numArr:Array = task.getAwardNum();
         var glArr:Array = task.getAwardGl();
         var arr:Array = [];
         var xxx:Array = [];
         var numXX:Array = [];
         for(var i:uint = 0; i < idArr.length; i++)
         {
            if(idArr[i].getValue() != -1 && int(arrxx[i].getValue()) <= glArr[i].getValue())
            {
               for(j = 0; j < numArr[i].getValue(); j++)
               {
                  if(typeArr[i].getValue() == 1)
                  {
                     equ = EquipFactory.createEquipByID(idArr[i].getValue());
                     arr.push(equ);
                  }
                  else if(typeArr[i].getValue() == 2)
                  {
                     gem = GemFactory.creatGemById(idArr[i].getValue());
                     arr.push(gem);
                  }
                  else if(typeArr[i].getValue() == 3)
                  {
                     sup = SuppliesFactory.getSuppliesById(idArr[i].getValue());
                     arr.push(sup);
                  }
                  else if(typeArr[i].getValue() == 4)
                  {
                     other = OtherFactory.creatOther(idArr[i].getValue());
                     arr.push(other);
                  }
               }
               if(typeArr[i].getValue() == 1)
               {
                  equ = EquipFactory.createEquipByID(idArr[i].getValue());
                  xxx.push(equ);
               }
               else if(typeArr[i].getValue() == 2)
               {
                  gem = GemFactory.creatGemById(idArr[i].getValue());
                  xxx.push(gem);
               }
               else if(typeArr[i].getValue() == 3)
               {
                  sup = SuppliesFactory.getSuppliesById(idArr[i].getValue());
                  xxx.push(sup);
               }
               else if(typeArr[i].getValue() == 4)
               {
                  other = OtherFactory.creatOther(idArr[i].getValue());
                  xxx.push(other);
               }
               numXX.push(numArr[i]);
            }
         }
         if(xxx.length != 0)
         {
            AwardPanel.open(xxx,numXX);
         }
         return arr;
      }
      
      private function howAward(ob:Object) : void
      {
         var obj2:Object = new Object();
         obj2 = DeepCopyUtil.clone(ob);
         p1orp2(ob,Main.player1.getBag());
         if(Main.P1P2)
         {
            p1orp2(obj2,Main.player2.getBag());
         }
      }
      
      private function p1orp2(ob:Object, bag:Bag) : void
      {
         if(ob is Equip)
         {
            bag.addEquipBag(ob as Equip);
         }
         else if(ob is Gem)
         {
            bag.addGemBag(ob as Gem);
         }
         else if(ob is Supplies)
         {
            bag.addSuppliesBag(ob as Supplies);
         }
         else if(ob is Otherobj)
         {
            bag.addOtherobjBag(ob as Otherobj);
         }
      }
      
      public function bagNum(task:Task) : Boolean
      {
         var i:uint = 0;
         var arr:Array = [];
         var idArr:Array = task.getAwardId();
         var typeArr:Array = task.getAwardType();
         var numArr:Array = task.getAwardNum();
         if(idArr[0].getValue() == -1)
         {
            return true;
         }
         for(i = 0; i < idArr.length; i++)
         {
            arr.push(bagHow(idArr[i].getValue(),typeArr[i].getValue(),numArr[i].getValue()));
         }
         for(i = 0; i < arr.length; i++)
         {
            if(arr[i] == false)
            {
               return false;
            }
         }
         return true;
      }
      
      private function bagHow(id:Number, type:Number, num:Number) : Boolean
      {
         if(Main.P1P2)
         {
            if(Boolean(bbb(type,id,num,Main.player1.getBag())) && Boolean(bbb(type,id,num,Main.player2.getBag())))
            {
               return true;
            }
         }
         else if(bbb(type,id,num,Main.player1.getBag()))
         {
            return true;
         }
         return false;
      }
      
      private function bbb(type:Number, id:Number, num:Number, bag:Bag) : Boolean
      {
         if(type == 1)
         {
            if(num <= bag.backequipBagNum())
            {
               return true;
            }
         }
         else if(type == 2)
         {
            if(num <= bag.canPutGemNum(id))
            {
               return true;
            }
         }
         else if(type == 3)
         {
            if(num <= bag.backSuppliesBagNum())
            {
               return true;
            }
         }
         else if(type == 4)
         {
            if(num <= bag.canPutOtherNum(id))
            {
               return true;
            }
         }
         return false;
      }
      
      public function overGoldAncExp(task:Task) : void
      {
         Main.player1.addGold(getGold(task));
         Main.player_1.ExpUP(getExp(task));
         if(Main.P1P2)
         {
            Main.player2.addGold(getGold(task));
            Main.player_2.ExpUP(getExp(task));
         }
      }
      
      public function overPlayerStata(task:Task) : void
      {
         if(task.getAwardPs() == 1)
         {
            Main.player1.setRebirth();
            if(Main.P1P2)
            {
               Main.player2.setRebirth();
            }
            TransferOkPanel.open(2);
            TaskPanel.close();
         }
      }
   }
}

