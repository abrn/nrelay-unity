package kabam.rotmg.messaging.impl
{
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.objects.Pet;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import kabam.rotmg.messaging.impl.data.StatData;
   
   public class PetUpdater
   {
       
      
      [Inject]
      public var petsModel:PetsModel;
      
      [Inject]
      public var gameSprite:AGameSprite;
      
      public function PetUpdater()
      {
         super();
      }
      
      public function updatePetVOs(param1:Pet, param2:Vector.<StatData>, param3:Boolean = true) : void
      {
         var _loc9_:int = 0;
         var _loc7_:* = 0;
         var _loc10_:* = null;
         var _loc8_:* = null;
         if(!param3)
         {
            return;
         }
         var _loc5_:PetVO = param1.vo || this.createPetVO(param1,param2);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc6_:* = param2;
         var _loc12_:int = 0;
         var _loc11_:* = param2;
         for each(_loc8_ in param2)
         {
            _loc9_ = _loc8_.statValue_;
            _loc7_ = uint(_loc8_.statType_);
            if(_loc7_ == 80)
            {
               _loc5_.setSkin(_loc9_);
            }
            else if(_loc7_ == 81)
            {
               _loc5_.setID(_loc9_);
            }
            else if(_loc7_ == 82)
            {
               _loc5_.setName(_loc8_.strStatValue_);
            }
            else if(_loc7_ == 83)
            {
               _loc5_.setType(_loc9_);
            }
            else if(_loc7_ == 84)
            {
               _loc5_.setRarity(_loc9_);
            }
            else if(_loc7_ == 85)
            {
               _loc5_.setMaxAbilityPower(_loc9_);
            }
            else if(_loc7_ == 87)
            {
               _loc10_ = _loc5_.abilityList[0];
               _loc10_.points = _loc9_;
            }
            else if(_loc7_ == 88)
            {
               _loc10_ = _loc5_.abilityList[1];
               _loc10_.points = _loc9_;
            }
            else if(_loc7_ == 89)
            {
               _loc10_ = _loc5_.abilityList[2];
               _loc10_.points = _loc9_;
            }
            else if(_loc7_ == 90)
            {
               _loc10_ = _loc5_.abilityList[0];
               _loc10_.level = _loc9_;
            }
            else if(_loc7_ == 91)
            {
               _loc10_ = _loc5_.abilityList[1];
               _loc10_.level = _loc9_;
            }
            else if(_loc7_ == 92)
            {
               _loc10_ = _loc5_.abilityList[2];
               _loc10_.level = _loc9_;
            }
            else if(_loc7_ == 93)
            {
               _loc10_ = _loc5_.abilityList[0];
               _loc10_.type = _loc9_;
            }
            else if(_loc7_ == 94)
            {
               _loc10_ = _loc5_.abilityList[1];
               _loc10_.type = _loc9_;
            }
            else if(_loc7_ == 95)
            {
               _loc10_ = _loc5_.abilityList[2];
               _loc10_.type = _loc9_;
            }
            if(_loc10_)
            {
               _loc10_.updated.dispatch(_loc10_);
            }
         }
      }
      
      public function updatePet(param1:Pet, param2:Vector.<StatData>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:StatData = null;
         var _loc6_:int = 0;
         var _loc5_:* = param2;
         for each(_loc4_ in param2)
         {
            _loc3_ = _loc4_.statValue_;
            if(_loc4_.statType_ == 80)
            {
               param1.setSkin(_loc3_,false);
            }
            if(_loc4_.statType_ == 2)
            {
               param1.size_ = _loc3_;
            }
            if(_loc4_.statType_ == 29)
            {
               param1.condition_[0] = _loc3_;
            }
         }
      }
      
      private function createPetVO(param1:Pet, param2:Vector.<StatData>) : PetVO
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc6_:* = param2;
         var _loc8_:int = 0;
         var _loc7_:* = param2;
         for each(_loc5_ in param2)
         {
            if(_loc5_.statType_ == 81)
            {
               _loc3_ = this.petsModel.getCachedVOOnly(_loc5_.statValue_);
               param1.vo = !!_loc3_?_loc3_:!!this.gameSprite.map.isPetYard?this.petsModel.getPetVO(_loc5_.statValue_):new PetVO(_loc5_.statValue_);
               return param1.vo;
            }
         }
         return null;
      }
   }
}
