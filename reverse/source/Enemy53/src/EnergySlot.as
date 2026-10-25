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
         this.energyLeftNum.setValue(0);
         this.energyRightNum.setValue(0);
      }
      
      public function getEnergyPer(pp:Player) : int
      {
         this.player_e = pp;
         if(this.player_e.data.skinNum == 0)
         {
            if(this.energyLeftNum.getValue() == 0)
            {
               return 1;
            }
            if(this.energyLeftNum.getValue() >= this.energyLeftMax.getValue() * this.player_e.use_gongji.getValue())
            {
               return 100;
            }
            return (this.energyLeftNum.getValue() / (this.energyLeftMax.getValue() * this.player_e.use_gongji.getValue())).toFixed(2) * 100;
         }
         if(this.energyRightNum.getValue() == 0)
         {
            return 1;
         }
         if(this.energyRightNum.getValue() >= this.energyRightMax.getValue() * this.player_e.use_gongji.getValue())
         {
            return 100;
         }
         return (this.energyRightNum.getValue() / (this.energyRightMax.getValue() * this.player_e.use_gongji.getValue())).toFixed(2) * 100;
      }
      
      public function addEnergy(pp:Player, num:Number) : *
      {
         if(energyBool == false)
         {
            return;
         }
         this.player_e = pp;
         if(this.player_e.data.skinNum == 0)
         {
            if(this.player_e.data.getEquipSkillSlot().getGemFromSkillSlot(0))
            {
               if(Boolean(this.player_e.data.getEquipSlot().getEquipFromSlot(6)) && this.player_e.data.getEquipSlot().getEquipFromSlot(6).getJinHua() == -2)
               {
                  this.energyLeftNum.setValue(this.energyLeftNum.getValue() + num * 1.2);
               }
               else
               {
                  this.energyLeftNum.setValue(this.energyLeftNum.getValue() + num);
               }
            }
         }
         else if(this.player_e.data.getEquipSkillSlot().getGemFromSkillSlot(1))
         {
            if(Boolean(this.player_e.data.getEquipSlot().getEquipFromSlot(6)) && this.player_e.data.getEquipSlot().getEquipFromSlot(6).getJinHua() == -2)
            {
               this.energyRightNum.setValue(this.energyRightNum.getValue() + num * 1.2);
            }
            else
            {
               this.energyRightNum.setValue(this.energyRightNum.getValue() + num);
            }
         }
      }
   }
}

