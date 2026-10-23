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
      
      public static function getDescription(type:uint, value:uint) : String
      {
         var description:String = null;
         switch(type)
         {
            case EquipBaseAttribTypeConst.ATTACK:
               description = "攻击+" + value;
               break;
            case EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE:
               description = "无视防御的攻击力+" + value;
               break;
            case EquipBaseAttribTypeConst.CRIT:
               description = "暴击+" + value;
               break;
            case EquipBaseAttribTypeConst.DEFENSE:
               description = "防御+" + value;
               break;
            case EquipBaseAttribTypeConst.DUCK:
               description = "闪避+" + value;
               break;
            case EquipBaseAttribTypeConst.HARDVALUE:
               description = "硬值+" + value;
               break;
            case EquipBaseAttribTypeConst.HP:
               description = "生命+" + value;
               break;
            case EquipBaseAttribTypeConst.HPREGEN:
               description = "回血+" + value;
               break;
            case EquipBaseAttribTypeConst.MOVESPEED:
               description = "移动速度+" + value;
               break;
            case EquipBaseAttribTypeConst.MP:
               description = "魔法+" + value;
               break;
            case EquipBaseAttribTypeConst.MPREGEN:
               description = "回魔+" + value;
               break;
            default:
               throw new Error("物品基础属性不存在的类型:type:" + type);
         }
         return description;
      }
   }
}

