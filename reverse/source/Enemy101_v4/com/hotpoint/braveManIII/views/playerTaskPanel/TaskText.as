package com.hotpoint.braveManIII.views.playerTaskPanel
{
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.npcTaskPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import src.*;
   
   public class TaskText
   {
      
      public function TaskText()
      {
         super();
      }
      
      public static function creatTaskData() : TaskText
      {
         return new TaskText();
      }
      
      public function getIntroduction(slot:Object, num:Number) : String
      {
         return slot.getTask(num).getIntroduction();
      }
      
      public function getId(slot:Object, num:Number) : Number
      {
         return (slot.getTask(num) as Task).getId();
      }
      
      public function getDemand(slot:Object, num:Number) : String
      {
         return slot.getTask(num).getDemand();
      }
      
      public function getEnemyId(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getEnemyId();
      }
      
      public function getEnemyName(slot:Object, num:Number) : Array
      {
         return (slot.getTask(num) as Task).getEnemyName();
      }
      
      public function getEnemyNum(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getEnemyNum();
      }
      
      public function getEnemyedNum(slot:Object, num:Number) : Array
      {
         return (slot.getTask(num) as Task).getEnemyArr();
      }
      
      public function getGoodsId(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getGoodsId();
      }
      
      public function getGoodsNum(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getGoodsNum();
      }
      
      public function getGoodsedNum(slot:Object, num:Number) : Array
      {
         return slot.getTask(num).getGoodsedNum();
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
      
      public function getGold(slot:Object, num:Number) : Number
      {
         num = Number(slot.getTask(num).getGold());
         if(num < 0)
         {
            num = 0;
         }
         return num;
      }
      
      public function getAwardTypeAndId(slot:Object, num:Number) : Array
      {
         return (slot.getTask(num) as Task).getAwardTypeAndId();
      }
      
      public function getAwrdNum(slot:Object, num:Number) : Array
      {
         return (slot.getTask(num) as Task).getAwardNum();
      }
      
      public function getAwrdType(slot:Object, num:Number) : Array
      {
         return (slot.getTask(num) as Task).getAwardType();
      }
      
      public function addJl(slot:Object, num:*) : Array
      {
         var arr1:Array = getAwardTypeAndId(slot,num);
         var arr2:Array = getAwrdNum(slot,num);
         var e:Array = addJlEqu(slot,num);
         var g:Array = addJlGem(slot,num);
         var s:Array = addJlSup(slot,num);
         var o:Array = addJlOther(slot,num);
         var arr:Array = [];
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
      
      public function getOneObj(slot:Object, num:Number) : Array
      {
         var xxx:Array = [];
         var arr:Array = getAwardTypeAndId(slot,num);
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(arr[i][0] == 1)
            {
               xxx.push(EquipFactory.createEquipByID(arr[i][1]));
            }
            else if(arr[i][0] == 2)
            {
               xxx.push(GemFactory.creatGemById(arr[i][1]));
            }
            else if(arr[i][0] == 3)
            {
               xxx.push(SuppliesFactory.getSuppliesById(arr[i][1]));
            }
            else if(arr[i][0] == 4)
            {
               xxx.push(OtherFactory.creatOther(arr[i][1]));
            }
         }
         return xxx;
      }
      
      public function addJlEqu(slot:Object, num:*) : Array
      {
         var j:uint = 0;
         var equ:Equip = null;
         var arr1:Array = getAwardTypeAndId(slot,num);
         var arr2:Array = getAwrdNum(slot,num);
         var arr:Array = [];
         for(var i:uint = 0; i < arr1.length; i++)
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
      
      public function addJlGem(slot:Object, num:*) : Array
      {
         var j:uint = 0;
         var gem:Gem = null;
         var arr1:Array = getAwardTypeAndId(slot,num);
         var arr2:Array = getAwrdNum(slot,num);
         var arr:Array = [];
         for(var i:uint = 0; i < arr1.length; i++)
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
      
      public function addJlSup(slot:Object, num:*) : Array
      {
         var j:uint = 0;
         var sup:Supplies = null;
         var arr1:Array = getAwardTypeAndId(slot,num);
         var arr2:Array = getAwrdNum(slot,num);
         var arr:Array = [];
         for(var i:uint = 0; i < arr1.length; i++)
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
      
      public function addJlOther(slot:Object, num:*) : Array
      {
         var j:uint = 0;
         var other:Otherobj = null;
         var arr1:Array = getAwardTypeAndId(slot,num);
         var arr2:Array = getAwrdNum(slot,num);
         var arr:Array = [];
         for(var i:uint = 0; i < arr1.length; i++)
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
      
      public function getAllId(slot:Object, num:Number) : Array
      {
         var i:uint = 0;
         var id:Number = getId(slot,num);
         var allId:Array = [];
         var arr1:Array = getEnemyName(slot,num);
         var arr2:Array = getGoodsId(slot,num);
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
               trace(arr2[i] + ":arr2[i])");
               if(id != 210002)
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
      
      public function getAllNum(slot:Object, num:Number) : Array
      {
         var i:uint = 0;
         var allNum:Array = [];
         var arr1:Array = getEnemyNum(slot,num);
         var arr2:Array = getGoodsNum(slot,num);
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
      
      public function getAllNuming(slot:Object, num:Number) : Array
      {
         var i:uint = 0;
         var allNum:Array = [];
         var arr1:Array = getEnemyedNum(slot,num);
         var arr2:Array = getGoodsedNum(slot,num);
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
      
      public function bagNum(slot:Object, taskingNum:Number) : Boolean
      {
         var i:uint = 0;
         var arr:Array = [];
         var arr1:Array = getAwardTypeAndId(slot,taskingNum);
         var arr2:Array = getAwrdNum(slot,taskingNum);
         var task:Task = slot.getTask(taskingNum);
         if(arr1.length < 1)
         {
            return true;
         }
         for(i = 0; i < arr1.length; i++)
         {
            arr.push(bagHow(arr1[i][0],arr1[i][1],arr2[i],task));
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
      
      private function bagHow(type:Number, id:Number, num:Number, task:Task) : Boolean
      {
         if(task.getWho() == 1)
         {
            return bbb(type,id,num,Main.player1.getBag());
         }
         if(task.getWho() == 2)
         {
            return bbb(type,id,num,Main.player2.getBag());
         }
         if(task.getWho() == 3)
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
         }
         return false;
      }
      
      private function bbb(type:Number, id:Number, num:Number, bag:Bag) : Boolean
      {
         if(type == 1)
         {
            trace("装备背包剩余:" + bag.backequipBagNum());
            trace(num + "要放入的数量_装备+++++++");
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
            trace(bag.canPutOtherNum(id) + "背包剩余数量_其他");
            trace(num + "要放入的数量_其他");
            if(num <= bag.canPutOtherNum(id))
            {
               trace("其他栏没满" + bag.canPutOtherNum(id));
               return true;
            }
         }
         return false;
      }
      
      public function overAward(slot:Object, taskingNum:Number) : void
      {
         var i:uint = 0;
         var arrEqu:Array = addJlEqu(slot,taskingNum);
         var arrGem:Array = addJlGem(slot,taskingNum);
         var arrSup:Array = addJlSup(slot,taskingNum);
         var arrOth:Array = addJlOther(slot,taskingNum);
         var task:Task = slot.getTask(taskingNum);
         trace("Equ:" + arrEqu);
         trace("arrGem:" + arrGem);
         trace("arrSup:" + arrSup);
         trace("arrOth:" + arrOth);
         if(arrEqu.length > 0)
         {
            for(i = 0; i < arrEqu.length; i++)
            {
               howAward(task,arrEqu[i]);
            }
         }
         if(arrGem.length > 0)
         {
            for(i = 0; i < arrGem.length; i++)
            {
               howAward(task,arrGem[i]);
            }
         }
         if(arrSup.length > 0)
         {
            for(i = 0; i < arrSup.length; i++)
            {
               howAward(task,arrSup[i]);
            }
         }
         if(arrOth.length > 0)
         {
            for(i = 0; i < arrOth.length; i++)
            {
               howAward(task,arrOth[i]);
            }
         }
      }
      
      private function howAward(task:Task, ob:Object) : void
      {
         var obj2:Object = null;
         if(task.getWho() == 1)
         {
            p1orp2(ob,Main.player1.getBag());
         }
         else if(task.getWho() == 2)
         {
            p1orp2(ob,Main.player2.getBag());
         }
         else if(task.getWho() == 3)
         {
            obj2 = new Object();
            obj2 = DeepCopyUtil.clone(ob);
            p1orp2(ob,Main.player1.getBag());
            if(Main.P1P2)
            {
               p1orp2(obj2,Main.player2.getBag());
            }
         }
      }
      
      private function p1orp2(ob:Object, bag:Bag) : void
      {
         if(ob is Equip)
         {
            trace("加入装备");
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
      
      public function overGoldAncExp(slot:Object, taskingNum:Number) : void
      {
         var task:Task = slot.getTask(taskingNum);
         if(task.getWho() == 1)
         {
            Main.player1.addGold(getGold(slot,taskingNum));
            Main.player_1.ExpUP(int(getExp(slot,taskingNum)));
         }
         else if(task.getWho() == 2)
         {
            Main.player2.addGold(getGold(slot,taskingNum));
            Main.player_2.ExpUP(int(getExp(slot,taskingNum)));
         }
         else if(task.getWho() == 3)
         {
            Main.player1.addGold(getGold(slot,taskingNum));
            Main.player_1.ExpUP(int(getExp(slot,taskingNum)));
            if(Main.P1P2)
            {
               Main.player2.addGold(getGold(slot,taskingNum));
               Main.player_2.ExpUP(int(getExp(slot,taskingNum)));
            }
         }
      }
      
      public function overPlayerStata(slot:Object, taskingNum:Number) : void
      {
         var task:Task = slot.getTask(taskingNum);
         trace("奖励类型:" + task.getAwardPlayerDate());
         trace("指定玩家:" + task.getWho());
         if(task.getAwardPlayerDate() == 1)
         {
            trace("奖励重生");
            if(task.getWho() == 1)
            {
               Main.player1.setRebirth();
            }
            else if(task.getWho() == 2)
            {
               Main.player2.setRebirth();
            }
            else if(task.getWho() == 3)
            {
               trace("角色1重生");
               Main.player1.setRebirth();
               if(Main.P1P2)
               {
                  trace("角色2重生");
                  Main.player2.setRebirth();
               }
            }
            TransferOkPanel.open(2);
            NpcTaskPanel.close();
            PlayerTaskPanel.close();
         }
      }
   }
}

