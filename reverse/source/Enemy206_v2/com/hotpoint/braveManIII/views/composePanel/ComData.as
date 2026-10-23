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
      
      public static function getType(type:Number) : Array
      {
         var data:Make = null;
         var arr:Array = [];
         var makeArr:Array = MakeFactory.makeData;
         for each(data in makeArr)
         {
            if(data.getType() == type)
            {
               arr.push(data);
            }
         }
         if(arr.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public static function getTowIdById1(ob:Equip) : Array
      {
         var data:Make = null;
         var num:Number = NaN;
         var arr:Array = getType(5);
         if(arr == null || ob == null)
         {
            return null;
         }
         var id1:Number = ob.getId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i];
            if(data.getNeedId()[0] == id1)
            {
               num = Number(data.getNeedId()[1]);
               return ComPosePanel.data.getBag().getEquipByIdTOW(num);
            }
         }
         return null;
      }
      
      public static function towBo(num:Number, id1:Number) : Boolean
      {
         var i:uint = 0;
         var data:Make = null;
         var num1:Number = NaN;
         var arr:Array = getType(5);
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               data = arr[i];
               if(data.getNeedId()[0] == id1)
               {
                  num1 = Number(data.getNeedId()[1]);
                  if(num == num1)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public static function getThreeIdById1(ob:Equip) : Otherobj
      {
         var data:Make = null;
         var num:Number = NaN;
         var arr:Array = getType(5);
         if(arr == null || ob == null)
         {
            return null;
         }
         var id1:Number = ob.getId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i];
            if(data.getNeedId()[0] == id1)
            {
               num = Number(data.getNeedId()[2]);
               return OtherFactory.creatOther(num);
            }
         }
         return null;
      }
      
      public static function getThreeNumById1(ob:Equip) : Number
      {
         var data:Make = null;
         var num:Number = 0;
         var arr:Array = getType(5);
         if(arr == null || ob == null)
         {
            return null;
         }
         var id1:Number = ob.getId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i];
            if(data.getNeedId()[0] == id1)
            {
               num = Number(data.getNeedNum()[2]);
            }
         }
         return num;
      }
      
      public static function getNeedOne(type:Number) : Array
      {
         var make:Make = null;
         var arr:Array = [];
         var needArr:Array = [];
         arr = getType(type);
         if(arr == null)
         {
            return null;
         }
         for(var i:uint = 0; i < arr.length; i++)
         {
            make = arr[i];
            if(make.getNeedId()[0] != -1)
            {
               needArr.push(make.getNeedId()[0]);
            }
         }
         if(needArr.length < 1)
         {
            return null;
         }
         return needArr;
      }
      
      public static function getNeedEquipInBag() : Array
      {
         var i:uint = 0;
         var j:uint = 0;
         var nId:Array = [];
         var xxx1:Array = [];
         var xxx2:Array = [];
         var allArr:Array = [];
         var arr:Array = getNeedOne(5);
         if(arr == null)
         {
            return null;
         }
         for(i = 0; i < arr.length; i++)
         {
            if(ComPosePanel.data.getBag().getEquipByIdTOW(arr[i]) != null)
            {
               nId.push(ComPosePanel.data.getBag().getEquipByIdTOW(arr[i]));
            }
         }
         if(nId.length < 1)
         {
            return null;
         }
         for(i = 0; i < nId.length; i++)
         {
            for(j = 0; j < nId[i][0].length; j++)
            {
               xxx1.push(nId[i][0][j]);
               xxx2.push(nId[i][1][j]);
            }
         }
         return [xxx1,xxx2];
      }
      
      public static function getHcNum(ob:Equip) : Array
      {
         var num:Number = NaN;
         var data:Make = null;
         if(ob == null)
         {
            return null;
         }
         var id1:Number = ob.getId();
         num = 0;
         var num1:Number = 0;
         var arr:Array = getType(5);
         if(arr == null)
         {
            return null;
         }
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i];
            if(data.getNeedId()[0] == id1)
            {
               num = Number(data.getNeedId()[2]);
               num1 = Number(String(data.getNeedNum()[2]));
            }
         }
         var num2:String = ComPosePanel.data.getBag().getOtherobjNum(num).toString();
         xxx = [num1,num2];
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
      
      public static function getFinish(ob:Equip) : Array
      {
         var data:Make = null;
         var arr:Array = getType(5);
         if(arr == null || ob == null)
         {
            return null;
         }
         var id1:Number = ob.getId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i];
            if(data.getNeedId()[0] == id1)
            {
               return data.getObj();
            }
         }
         return null;
      }
      
      public static function getNeedStae(ob:Object = null) : Array
      {
         var id1:Number = NaN;
         var type:Number = NaN;
         var level:Number = NaN;
         var color:Number = NaN;
         var arr:Array = null;
         var xx1:Array = null;
         var xx2:Array = null;
         var xx3:Array = null;
         var i:uint = 0;
         var gem:Gem = null;
         var num:Number = NaN;
         if(ComPosePanel.state == 0)
         {
            if(ComPosePanel.stateTow == 0)
            {
               return getNeedEquipInBag();
            }
            if(ComPosePanel.stateTow == 1)
            {
               return getTowIdById1(ob);
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
               id1 = Number((ob as Gem).getId());
               type = Number((ob as Gem).getType());
               level = Number((ob as Gem).getUseLevel());
               color = Number((ob as Gem).getColor());
               if(type == 0)
               {
                  return getGemSp();
               }
               if(type == 1)
               {
                  arr = getGemStr();
                  xx1 = [];
                  xx2 = [];
                  xx3 = [];
                  if(arr == null)
                  {
                     return null;
                  }
                  for(i = 0; i < arr[0].length; i++)
                  {
                     gem = arr[0][i];
                     num = Number(arr[1][i]);
                     if(gem.getUseLevel() == (ob as Gem).getUseLevel())
                     {
                        xx1.push(gem);
                        xx2.push(num);
                     }
                  }
                  return [xx1,xx2];
               }
               if(type == 3)
               {
                  return getGemSx();
               }
            }
         }
         return null;
      }
      
      public static function getEquiping() : Array
      {
         var equip:Equip = null;
         var eId:Number = NaN;
         var j:uint = 0;
         var make:Make = null;
         var arr:Array = getType(5);
         var allArr:Array = [];
         if(arr == null)
         {
            return null;
         }
         for(var s:uint = 0; s < 8; s++)
         {
            allArr[s] = null;
         }
         for(var i:uint = 0; i < 8; i++)
         {
            if(ComPosePanel.data.getEquipSlot().getEquipFromSlot(i) != null)
            {
               equip = ComPosePanel.data.getEquipSlot().getEquipFromSlot(i);
               eId = equip.getId();
               for(j = 0; j < arr.length; j++)
               {
                  make = arr[j];
                  if(make.getNeedId()[0] == eId && equip.getRemainingTime() > 0)
                  {
                     allArr[i] = equip;
                     break;
                  }
               }
            }
         }
         return allArr;
      }
      
      public static function getPlayGod(ob:Equip) : String
      {
         var data:Make = null;
         var num:Number = 0;
         var arr:Array = getType(5);
         if(arr == null || ob == null)
         {
            return null;
         }
         var id1:Number = ob.getId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i];
            if(data.getNeedId()[0] == id1)
            {
               num = data.getGold();
               break;
            }
         }
         return num.toString();
      }
      
      private static function getGemSp() : Array
      {
         return ComPosePanel.data.getBag().getGemByType(0);
      }
      
      private static function getGemStr() : Array
      {
         var gem:Gem = null;
         var arr:Array = ComPosePanel.data.getBag().getGemByType(1);
         var xx1:Array = [];
         var xx2:Array = [];
         var colerOne:Array = [];
         if(arr == null)
         {
            return null;
         }
         for(var i:uint = 0; i < arr[0].length; i++)
         {
            gem = arr[0][i];
            if(gem.getColor() == 1)
            {
               xx1.push(gem);
               xx2.push(arr[1][i]);
            }
         }
         colerOne = [xx1,xx2];
         if(xx1.length < 1)
         {
            return null;
         }
         return colerOne;
      }
      
      private static function getGemSx() : Array
      {
         var gem:Gem = null;
         var arr:Array = ComPosePanel.data.getBag().getGemByType(3);
         var xx1:Array = [];
         var xx2:Array = [];
         var colerOne:Array = [];
         if(arr == null)
         {
            return null;
         }
         for(var i:uint = 0; i < arr[0].length; i++)
         {
            gem = arr[0][i];
            if(gem.getColor() == 1)
            {
               xx1.push(gem);
               xx2.push(arr[1][i]);
            }
         }
         colerOne = [xx1,xx2];
         if(xx1.length < 1)
         {
            return null;
         }
         return colerOne;
      }
      
      private static function getStrGem() : Array
      {
         var i:uint = 0;
         var allArr:Array = [];
         var xx1:Array = [];
         var xx2:Array = [];
         var arr1:Array = getGemSp();
         var arr2:Array = getGemStr();
         var arr3:Array = getGemSx();
         if(arr1 != null)
         {
            for(i = 0; i < arr1[0].length; i++)
            {
               xx1.push(arr1[0][i]);
               xx2.push(arr1[1][i]);
            }
         }
         if(arr2 != null)
         {
            for(i = 0; i < arr2[0].length; i++)
            {
               xx1.push(arr2[0][i]);
               xx2.push(arr2[1][i]);
            }
         }
         if(arr3 != null)
         {
            for(i = 0; i < arr3[0].length; i++)
            {
               xx1.push(arr3[0][i]);
               xx2.push(arr3[1][i]);
            }
         }
         allArr = [xx1,xx2];
         if(xx1.length < 1)
         {
            return null;
         }
         return allArr;
      }
      
      public static function gemFinish(ob1:Gem = null, ob2:Object = null) : Gem
      {
         var gem:Gem = null;
         var ob:Gem = null;
         var arr:Array = null;
         var arr2:Array = null;
         var arr3:Array = null;
         var i:uint = 0;
         var type:Number = ob1.getType();
         if(ob1.getUseLevel() >= ob2.getUseLevel())
         {
            ob = ob1;
         }
         else
         {
            ob = ob2;
         }
         switch(type)
         {
            case 0:
               gem = GemFactory.createGemByCompose(1,ob1.getStrengthenLevel() + 1,[]);
               break;
            case 1:
               gem = GemFactory.createGemByCompose(2,ob1.getStrengthenLevel(),[]);
               break;
            case 3:
               arr = [];
               arr2 = [];
               arr3 = [];
               arr2 = ob1.getGemAttrib();
               arr3 = ob2.getGemAttrib();
               for(i = 0; i < arr2.length; i++)
               {
                  arr.push(arr2[i]);
               }
               for(i = 0; i < arr3.length; i++)
               {
                  arr.push(arr3[i]);
               }
               gem = GemFactory.createGemByCompose(2,ob.getStrengthenLevel(),arr);
               arr = [];
         }
         return gem;
      }
   }
}

