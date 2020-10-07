package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class Damage extends IncomingMessage
   {
       
      
      public var targetId_:int;
      
      public var effects_:Vector.<uint>;
      
      public var damageAmount_:int;
      
      public var kill_:Boolean;
      
      public var armorPierce_:Boolean;
      
      public var bulletId_:uint;
      
      public var objectId_:int;
      
      public function Damage(param1:uint, param2:Function)
      {
         this.effects_ = new Vector.<uint>();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         var _loc3_:int = 0;
         this.targetId_ = param1.readInt();
         this.effects_.length = 0;
         var _loc2_:uint = param1.readUnsignedByte();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.effects_.push(param1.readUnsignedByte());
            _loc3_++;
         }
         this.damageAmount_ = param1.readUnsignedShort();
         this.kill_ = param1.readBoolean();
         this.armorPierce_ = param1.readBoolean();
         this.bulletId_ = param1.readUnsignedByte();
         this.objectId_ = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("DAMAGE","targetId_","effects_","damageAmount_","kill_","armorPierce_","bulletId_","objectId_");
      }
   }
}
