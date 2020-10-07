package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class RealmHeroesResponse extends IncomingMessage
   {
       
      
      public var numberOfRealmHeroes:int;
      
      public function RealmHeroesResponse(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.numberOfRealmHeroes = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("REALMHEROESRESPONSE","numberOfRealmHeroes");
      }
   }
}
