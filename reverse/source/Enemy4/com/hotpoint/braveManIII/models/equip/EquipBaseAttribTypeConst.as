package com.hotpoint.braveManIII.models.equip
{
   public class EquipBaseAttribTypeConst
   {
      
      public static const HP:uint = 1;
      
      public static const MP:uint = 2;
      
      public static const ATTACK:uint = 3;
      
      public static const DEFENSE:uint = 4;
      
      public static const CRIT:uint = 5;
      
      public static const DUCK:uint = 6;
      
      public static const MOVESPEED:uint = 7;
      
      public static const HARDVALUE:uint = 8;
      
      public static const EXPERIENCE:uint = 9;
      
      public static const ATTACKIGNOREDEFENSE:uint = 10;
      
      public static const HPREGEN:uint = 11;
      
      public static const MPREGEN:uint = 12;
      
      public function EquipBaseAttribTypeConst()
      {
         super();
      }
      
      public static function getDescription(param1:uint, param2:uint) : String
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case EquipBaseAttribTypeConst.ATTACK:
               _loc3_ = "攻击+" + param2;
               break;
            case EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE:
               _loc3_ = "无视防御的攻击力+" + param2;
               break;
            case EquipBaseAttribTypeConst.CRIT:
               _loc3_ = "暴击+" + param2;
               break;
            case EquipBaseAttribTypeConst.DEFENSE:
               _loc3_ = "防御+" + param2;
               break;
            case EquipBaseAttribTypeConst.DUCK:
               _loc3_ = "闪避+" + param2;
               break;
            case EquipBaseAttribTypeConst.HARDVALUE:
               _loc3_ = "硬值+" + param2;
               break;
            case EquipBaseAttribTypeConst.HP:
               _loc3_ = "生命+" + param2;
               break;
            case EquipBaseAttribTypeConst.HPREGEN:
               _loc3_ = "回血+" + param2;
               break;
            case EquipBaseAttribTypeConst.MOVESPEED:
               _loc3_ = "移动速度+" + param2;
               break;
            case EquipBaseAttribTypeConst.MP:
               _loc3_ = "魔法+" + param2;
               break;
            case EquipBaseAttribTypeConst.MPREGEN:
               _loc3_ = "回魔+" + param2;
               break;
            default:
               throw new Error("物品基础属性不存在的类型:type:" + param1);
         }
         return _loc3_;
      }
   }
}

