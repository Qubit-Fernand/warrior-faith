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
         var _loc1_:int = 0;
         for(_loc1_ in all_LVData)
         {
            all_LVData_vt[_loc1_] = VT.createVT(all_LVData[_loc1_]);
         }
      }
      
      public static function creatPetFactory() : *
      {
         var _loc1_:PetFactory = new PetFactory();
         myXml = XMLAsset.createXML(Data2.pet_set);
         _loc1_.creatPetFactory();
      }
      
      public static function getPetById(param1:Number) : PetBasicData
      {
         var _loc2_:PetBasicData = null;
         var _loc3_:PetBasicData = null;
         for each(_loc3_ in allData)
         {
            if(_loc3_.getId() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            trace("找不到");
         }
         return _loc2_;
      }
      
      public static function getId(param1:Number) : Number
      {
         return getPetById(param1).getId();
      }
      
      public static function getName(param1:Number) : String
      {
         return getPetById(param1).getName();
      }
      
      public static function getType(param1:Number) : Number
      {
         return getPetById(param1).getType();
      }
      
      public static function getFrame(param1:Number) : Number
      {
         return getPetById(param1).getFrame();
      }
      
      public static function getClassName(param1:Number) : String
      {
         return getPetById(param1).getClassName();
      }
      
      public static function getIntroduction(param1:Number) : String
      {
         return getPetById(param1).getIntroduction();
      }
      
      public static function getEvolution(param1:Number) : Number
      {
         return getPetById(param1).getEvolution();
      }
      
      public static function getEvolutionLV(param1:Number) : Number
      {
         return getPetById(param1).getEvolutionLV();
      }
      
      public static function getWuxingLV(param1:Number) : Number
      {
         return getPetById(param1).getWuxingLV();
      }
      
      public static function getAtt(param1:Number) : Number
      {
         return getPetById(param1).getAtt();
      }
      
      public static function getDef(param1:Number) : Number
      {
         return getPetById(param1).getDef();
      }
      
      public static function getCrit(param1:Number) : Number
      {
         return getPetById(param1).getCrit();
      }
      
      public static function getLife(param1:Number) : Number
      {
         return getPetById(param1).getLife();
      }
      
      public static function getAttup(param1:Number) : Number
      {
         return getPetById(param1).getAttup();
      }
      
      public static function getDefup(param1:Number) : Number
      {
         return getPetById(param1).getDefup();
      }
      
      public static function getCritup(param1:Number) : Number
      {
         return getPetById(param1).getCritup();
      }
      
      public static function getLifeup(param1:Number) : Number
      {
         return getPetById(param1).getLifeup();
      }
      
      public static function getLink(param1:Number) : Number
      {
         return getPetById(param1).getLink();
      }
      
      public static function creatPet(param1:Number) : Pet
      {
         return getPetById(param1).creatPet();
      }
      
      private function creatPetFactory() : *
      {
         this.xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:PetBasicData = null;
         for each(_loc1_ in myXml.宠物)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = String(_loc1_.名字);
            _loc4_ = String(_loc1_.类名);
            _loc5_ = Number(_loc1_.类型);
            _loc6_ = Number(_loc1_.帧数);
            _loc7_ = String(_loc1_.描述);
            _loc8_ = Number(_loc1_.进化);
            _loc9_ = Number(_loc1_.进化等级);
            _loc10_ = Number(_loc1_.悟性);
            _loc11_ = Number(_loc1_.攻击);
            _loc12_ = Number(_loc1_.防御);
            _loc13_ = Number(_loc1_.暴击);
            _loc14_ = Number(_loc1_.生命);
            _loc15_ = Number(_loc1_.攻击成长);
            _loc16_ = Number(_loc1_.防御成长);
            _loc17_ = Number(_loc1_.暴击成长);
            _loc18_ = Number(_loc1_.生命成长);
            _loc19_ = Number(_loc1_.关联数值);
            _loc20_ = PetBasicData.creatPetBasicData(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_);
            allData.push(_loc20_);
         }
      }
   }
}

