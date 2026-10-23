package com.hotpoint.braveManIII.repository.pet
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.pet.Pet;
   import src.*;
   
   public class PetFactory
   {
      
      private static var all_LVData:Array = [105,115,126,137,148,160,173,185,198,212,225,239,253,267,282,296,311,326,341,357,372,388,403,419,435,451,468,484,500,517];
      
      public static var all_LVData_vt:Array = new Array();
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function PetFactory()
      {
         super();
      }
      
      public static function AddLVDataInit() : *
      {
         var i:int = 0;
         for(i in all_LVData)
         {
            all_LVData_vt[i] = VT.createVT(all_LVData[i]);
         }
      }
      
      public static function creatPetFactory() : *
      {
         var pet:PetFactory = new PetFactory();
         myXml = XMLAsset.createXML(Data2.pet_set);
         pet.creatPetFactory();
      }
      
      public static function getPetById(id:Number) : PetBasicData
      {
         var petData:PetBasicData = null;
         var data:PetBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               petData = data;
            }
         }
         if(petData == null)
         {
            trace("找不到");
         }
         return petData;
      }
      
      public static function getId(id:Number) : Number
      {
         return getPetById(id).getId();
      }
      
      public static function getName(id:Number) : String
      {
         return getPetById(id).getName();
      }
      
      public static function getType(id:Number) : Number
      {
         return getPetById(id).getType();
      }
      
      public static function getFrame(id:Number) : Number
      {
         return getPetById(id).getFrame();
      }
      
      public static function getClassName(id:Number) : String
      {
         return getPetById(id).getClassName();
      }
      
      public static function getIntroduction(id:Number) : String
      {
         return getPetById(id).getIntroduction();
      }
      
      public static function getEvolution(id:Number) : Number
      {
         return getPetById(id).getEvolution();
      }
      
      public static function getEvolutionLV(id:Number) : Number
      {
         return getPetById(id).getEvolutionLV();
      }
      
      public static function getWuxingLV(id:Number) : Number
      {
         return getPetById(id).getWuxingLV();
      }
      
      public static function getAtt(id:Number) : Number
      {
         return getPetById(id).getAtt();
      }
      
      public static function getDef(id:Number) : Number
      {
         return getPetById(id).getDef();
      }
      
      public static function getCrit(id:Number) : Number
      {
         return getPetById(id).getCrit();
      }
      
      public static function getLife(id:Number) : Number
      {
         return getPetById(id).getLife();
      }
      
      public static function getAttup(id:Number) : Number
      {
         return getPetById(id).getAttup();
      }
      
      public static function getDefup(id:Number) : Number
      {
         return getPetById(id).getDefup();
      }
      
      public static function getCritup(id:Number) : Number
      {
         return getPetById(id).getCritup();
      }
      
      public static function getLifeup(id:Number) : Number
      {
         return getPetById(id).getLifeup();
      }
      
      public static function getLink(id:Number) : Number
      {
         return getPetById(id).getLink();
      }
      
      public static function creatPet(id:Number) : Pet
      {
         return getPetById(id).creatPet();
      }
      
      private function creatPetFactory() : *
      {
         this.xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var property:XML = null;
         var id:Number = NaN;
         var name:String = null;
         var className:String = null;
         var type:Number = NaN;
         var frame:Number = NaN;
         var introduction:String = null;
         var evolution:Number = NaN;
         var evolutionLV:Number = NaN;
         var wuxingLV:Number = NaN;
         var att:Number = NaN;
         var def:Number = NaN;
         var crit:Number = NaN;
         var life:Number = NaN;
         var attup:Number = NaN;
         var defup:Number = NaN;
         var critup:Number = NaN;
         var lifeup:Number = NaN;
         var link:Number = NaN;
         var data:PetBasicData = null;
         for each(property in myXml.宠物)
         {
            id = Number(property.编号);
            name = String(property.名字);
            className = String(property.类名);
            type = Number(property.类型);
            frame = Number(property.帧数);
            introduction = String(property.描述);
            evolution = Number(property.进化);
            evolutionLV = Number(property.进化等级);
            wuxingLV = Number(property.悟性);
            att = Number(property.攻击);
            def = Number(property.防御);
            crit = Number(property.暴击);
            life = Number(property.生命);
            attup = Number(property.攻击成长);
            defup = Number(property.防御成长);
            critup = Number(property.暴击成长);
            lifeup = Number(property.生命成长);
            link = Number(property.关联数值);
            data = PetBasicData.creatPetBasicData(id,name,className,type,frame,introduction,evolution,evolutionLV,wuxingLV,att,def,crit,life,attup,defup,critup,lifeup,link);
            allData.push(data);
         }
      }
   }
}

