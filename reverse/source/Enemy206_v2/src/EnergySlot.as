package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.events.*;
   import src.other.*;
   
   public class EnergySlot
   {
      
      public static var energyBool:Boolean = true;
      
      public var energyLeftMax:VT = VT.createVT(0);
      
      public var energyRightMax:VT = VT.createVT(0);
      
      private var player_e:Player;
      
      public var energyLeftNum:VT = VT.createVT(0);
      
      public var energyRightNum:VT = VT.createVT(0);
      
      public function EnergySlot()
      {
         super();
      }
      
      public function setZero() : *
      {
         energyLeftNum.setValue(0);
         energyRightNum.setValue(0);
      }
      
      public function getEnergyPer(pp:Player) : int
      {
         player_e = pp;
         if(player_e.data.skinNum == 0)
         {
            if(energyLeftNum.getValue() == 0)
            {
               return 1;
            }
            if(energyLeftNum.getValue() >= energyLeftMax.getValue() * player_e.use_gongji.getValue())
            {
               return 100;
            }
            return (energyLeftNum.getValue() / (energyLeftMax.getValue() * player_e.use_gongji.getValue())).toFixed(2) * 100;
         }
         if(energyRightNum.getValue() == 0)
         {
            return 1;
         }
         if(energyRightNum.getValue() >= energyRightMax.getValue() * player_e.use_gongji.getValue())
         {
            return 100;
         }
         return (energyRightNum.getValue() / (energyRightMax.getValue() * player_e.use_gongji.getValue())).toFixed(2) * 100;
      }
      
      public function addEnergy(pp:Player, num:Number) : *
      {
         if(energyBool == false)
         {
            return;
         }
         player_e = pp;
         if(player_e.data.skinNum == 0)
         {
            if(player_e.data.getEquipSkillSlot().getGemFromSkillSlot(0))
            {
               if(Boolean(player_e.data.getEquipSlot().getEquipFromSlot(6)) && player_e.data.getEquipSlot().getEquipFromSlot(6).getColor() >= 4)
               {
                  energyLeftNum.setValue(energyLeftNum.getValue() + num * 1.2);
               }
               else
               {
                  energyLeftNum.setValue(energyLeftNum.getValue() + num);
               }
            }
         }
         else if(player_e.data.getEquipSkillSlot().getGemFromSkillSlot(1))
         {
            if(Boolean(player_e.data.getEquipSlot().getEquipFromSlot(6)) && player_e.data.getEquipSlot().getEquipFromSlot(6).getColor() >= 4)
            {
               energyRightNum.setValue(energyRightNum.getValue() + num * 1.2);
            }
            else
            {
               energyRightNum.setValue(energyRightNum.getValue() + num);
            }
         }
      }
   }
}

