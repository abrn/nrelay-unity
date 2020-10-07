package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class EnemyShoot extends IncomingMessage
   {
       
      
      public var bulletId_:uint;
      
      public var ownerId_:int;
      
      public var bulletType_:int;
      
      public var startingPos_:WorldPosData;
      
      public var angle_:Number;
      
      public var damage_:int;
      
      public var numShots_:int;
      
      public var angleInc_:Number;
      
      public function EnemyShoot(param1:uint, param2:Function)
      {
         this.startingPos_ = new WorldPosData();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.bulletId_ = param1.readUnsignedByte();
         this.ownerId_ = param1.readInt();
         this.bulletType_ = param1.readUnsignedByte();
         this.startingPos_.parseFromInput(param1);
         this.angle_ = param1.readFloat();
         this.damage_ = param1.readShort();
         if(param1.bytesAvailable > 0)
         {
            this.numShots_ = param1.readUnsignedByte();
            this.angleInc_ = param1.readFloat();
         }
         else
         {
            this.numShots_ = 1;
            this.angleInc_ = 0;
         }
      }
      
      override public function toString() : String
      {
         return formatToString("SHOOT","bulletId_","ownerId_","bulletType_","startingPos_","angle_","damage_","numShots_","angleInc_");
      }
   }
}
