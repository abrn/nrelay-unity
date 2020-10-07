package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class PlaySound extends IncomingMessage
   {
       
      
      public var ownerId_:int;
      
      public var soundId_:int;
      
      public function PlaySound(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.ownerId_ = param1.readInt();
         this.soundId_ = param1.readUnsignedByte();
      }
      
      override public function toString() : String
      {
         return formatToString("PLAYSOUND","ownerId_","soundId_");
      }
   }
}
