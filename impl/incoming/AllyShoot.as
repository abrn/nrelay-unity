package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class AllyShoot extends IncomingMessage
   {
       
      
      public var bulletId_:uint;
      
      public var ownerId_:int;
      
      public var containerType_:int;
      
      public var angle_:Number;
      
      public var bard_:Boolean;
      
      public function AllyShoot(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.bulletId_ = param1.readUnsignedByte();
         this.ownerId_ = param1.readInt();
         this.containerType_ = param1.readShort();
         this.angle_ = param1.readFloat();
         this.bard_ = param1.readBoolean();
      }
      
      override public function toString() : String
      {
         return formatToString("ALLYSHOOT","bulletId_","ownerId_","containerType_","angle_","bard_");
      }
   }
}
