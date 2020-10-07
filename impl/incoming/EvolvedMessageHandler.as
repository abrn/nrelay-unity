package kabam.rotmg.messaging.impl.incoming
{
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import io.decagames.rotmg.pets.signals.EvolvePetSignal;
   import kabam.rotmg.messaging.impl.EvolvePetInfo;
   import org.swiftsuspenders.Injector;
   
   public class EvolvedMessageHandler
   {
       
      
      [Inject]
      public var injector:Injector;
      
      private var evolvePetInfo:EvolvePetInfo;
      
      private var message:EvolvedPetMessage;
      
      private var finalPet:PetVO;
      
      private var initialPet:PetVO;
      
      public function EvolvedMessageHandler()
      {
         super();
      }
      
      public function handleMessage(param1:EvolvedPetMessage) : void
      {
         this.message = param1;
         this.evolvePetInfo = new EvolvePetInfo();
         this.addFinalPet();
         this.addInitialPet(param1);
         this.dispatchEvolvePetSignal();
      }
      
      private function addFinalPet() : void
      {
         var _loc1_:PetsModel = this.injector.getInstance(PetsModel);
         this.finalPet = _loc1_.getPet(this.message.petID);
         this.finalPet.setSkin(this.message.finalSkin);
         this.evolvePetInfo.finalPet = this.finalPet;
      }
      
      private function addInitialPet(param1:EvolvedPetMessage) : void
      {
         this.initialPet = PetVO.clone(this.finalPet);
         this.initialPet.setSkin(param1.initialSkin);
         this.evolvePetInfo.initialPet = this.initialPet;
      }
      
      private function dispatchEvolvePetSignal() : void
      {
         var _loc1_:EvolvePetSignal = this.injector.getInstance(EvolvePetSignal);
         _loc1_.dispatch(this.evolvePetInfo);
      }
   }
}
