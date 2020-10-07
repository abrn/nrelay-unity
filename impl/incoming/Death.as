package kabam.rotmg.messaging.impl.incoming
{
   import flash.display.BitmapData;
   import flash.utils.IDataInput;
   
   public class Death extends IncomingMessage
   {
       
      
      public var accountId_:String;
      
      public var charId_:int;
      
      public var killedBy_:String;
      
      public var zombieId:int;
      
      public var zombieType:int;
      
      public var isZombie:Boolean;
      
      public var background:BitmapData;
      
      public var unknown:int;
      
      public function Death(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      public function disposeBackground() : void
      {
         this.background && this.background.dispose();
         this.background = null;
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.accountId_ = param1.readUTF();
         this.charId_ = param1.readInt();
         this.killedBy_ = param1.readUTF();
         this.zombieType = param1.readInt();
         this.zombieId = param1.readInt();
         this.unknown = param1.readInt();
         this.isZombie = this.zombieId != -1;
      }
      
      override public function toString() : String
      {
         return formatToString("DEATH","accountId_","charId_","killedBy_");
      }
   }
}
