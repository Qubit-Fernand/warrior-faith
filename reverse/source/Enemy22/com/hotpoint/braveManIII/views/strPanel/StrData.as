package com.hotpoint.braveManIII.views.strPanel
{
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.repository.probability.*;
   
   public class StrData
   {
      
      public function StrData()
      {
         super();
      }
      
      public static function getEquipOrSkillGem() : Array
      {
         var arr:Array = [];
         if(StrPanel.state == 0)
         {
            if(StrPanel.stateTow == 0)
            {
               arr = StrPanel.data.getBag().getEquipAndPoint();
            }
            else if(StrPanel.stateTow == 1)
            {
               arr = getStrGem();
            }
         }
         else if(StrPanel.state == 1)
         {
            if(StrPanel.stateTow == 0)
            {
               arr = StrPanel.data.getBag().getGemByType(4);
            }
            else if(StrPanel.stateTow == 1)
            {
               arr = getStrGem();
            }
         }
         return arr;
      }
      
      private static function getStrGem() : Array
      {
         var i:uint = 0;
         var allArr:Array = [];
         var xx1:Array = [];
         var xx2:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         if(StrPanel.state == 0)
         {
            arr1 = StrPanel.data.getBag().getGemByType(1);
            arr2 = StrPanel.data.getBag().getGemByType(2);
         }
         else if(StrPanel.state == 1)
         {
            arr1 = StrPanel.data.getBag().getGemByType(0);
            arr2 = StrPanel.data.getBag().getGemByType(2);
         }
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
         allArr = [xx1,xx2];
         if(xx1.length < 1)
         {
            return null;
         }
         return allArr;
      }
      
      public static function getGemUpLevel(gem:Gem) : Number
      {
         return gem.getProbability();
      }
      
      public static function getEquipUpLevel(equip:Equip, gem:Gem = null) : Number
      {
         var allPro:Number = NaN;
         var pro:Number = Number(EquipProbabilityFactory.getPorbabillty(equip.getDropLevel(),equip.getReinforceLevel()));
         var num:Number = gem.getUseLevel() - equip.getReinforceLevel();
         if(gem.getUseLevel < 10)
         {
            allPro = pro + num;
         }
         else
         {
            allPro = pro + num + 2;
         }
         return allPro;
      }
      
      public static function getLuckGemPosition(gem:Gem) : Number
      {
         if(gem.getType() == 2)
         {
            if(gem.getDropLevel() == 92315)
            {
               trace("品质1幸运宝石");
               return 10;
            }
            if(gem.getDropLevel() == 92316)
            {
               trace("品质2幸运宝石");
               return 50;
            }
            if(gem.getDropLevel() == 92317)
            {
               trace("品质3幸运宝石");
               return 100;
            }
         }
         return 0;
      }
      
      public static function setEquipPosition(gem:Gem, eq:Equip) : Number
      {
         return EquipPropertyFactory.getProperty(eq.getDropLevel(),eq.getPosition(),gem.getColor(),eq.getReinforceLevel());
      }
      
      private static function setAddAttribType(position:Number) : Number
      {
         switch(position)
         {
            case 1:
               return 2;
            case 2:
               return 1;
            case 3:
               return 6;
            case 4:
               return 5;
            case 5:
               return 3;
            case 6:
               return 3;
            case 7:
               return 3;
            case 8:
               return 4;
            case 9:
               return 3;
            default:
               return 0;
         }
      }
      
      public static function strengthenOver(eq:Equip, gem:Gem) : void
      {
         var my_num:Number = setEquipPosition(gem,eq);
         var ps:Number = eq.getPosition();
         ps = Number(setAddAttribType(ps));
         switch(ps)
         {
            case 3:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACK,my_num);
               break;
            case 10:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE,my_num);
               break;
            case 5:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.CRIT,my_num);
               break;
            case 4:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DEFENSE,my_num);
               break;
            case 6:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DUCK,my_num);
               break;
            case 9:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACK,my_num);
               break;
            case 1:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.HP,my_num);
               break;
            case 11:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.HPREGEN,my_num);
               break;
            case 7:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MOVESPEED,my_num);
               break;
            case 2:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MP,my_num);
               break;
            case 12:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MPREGEN,my_num);
               break;
            case 8:
               eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DEFENSE,my_num);
         }
      }
      
      public static function strengthenSkillOver(gem:Gem) : Gem
      {
         return gem.setUpGem();
      }
      
      public static function getStrenthenGold(type:Equip) : Number
      {
         return EquipProbabilityFactory.getGold(type.getDropLevel(),type.getReinforceLevel());
      }
      
      public static function getGemUpGold(type:Gem) : Number
      {
         return GemProbabilityFactory.getGold(type.getDropLevel(),type.getStrengthenLevel());
      }
      
      public function getStrenthenGold(type:Equip) : Number
      {
         return EquipProbabilityFactory.getGold(type.getDropLevel(),type.getReinforceLevel());
      }
   }
}

