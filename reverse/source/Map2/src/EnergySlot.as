package src
{
   import com.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.events.*;
   
   public class EnergySlot
   {
      
      public static var energyBool:Boolean = true;
      
      public var energyRightMax:Number;
      
      public var energyRightNum:Number = 0;
      
      public var energyLeftMax:Number;
      
      private var player_e:Player;
      
      public var energyLeftNum:Number = 0;
      
      public function EnergySlot()
      {
         super();
      }
      
      public function addEnergy(param1:Player, param2:Number) : *
      {
         if(energyBool == false)
         {
            return;
         }
         player_e = param1;
         if(player_e.data.skinNum == 0)
         {
            if(player_e.data.getEquipSkillSlot().getGemFromSkillSlot(0))
            {
               energyLeftNum += param2;
            }
         }
         else if(player_e.data.getEquipSkillSlot().getGemFromSkillSlot(1))
         {
            energyRightNum += param2;
         }
      }
      
      public function setZero() : *
      {
         energyLeftNum = 0;
         energyRightNum = 0;
      }
      
      public function getEnergyPer(param1:Player) : int
      {
         player_e = param1;
         if(player_e.data.skinNum == 0)
         {
            if(energyLeftNum == 0)
            {
               return 1;
            }
            if(energyLeftNum >= energyLeftMax * player_e.use_gongji.getValue())
            {
               return 100;
            }
            return (energyLeftNum / (energyLeftMax * player_e.use_gongji.getValue())).toFixed(2) * 100;
         }
         if(energyRightNum == 0)
         {
            return 1;
         }
         if(energyRightNum >= energyRightMax * player_e.use_gongji.getValue())
         {
            return 100;
         }
         return (energyRightNum / (energyRightMax * player_e.use_gongji.getValue())).toFixed(2) * 100;
      }
   }
}

