package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   
   public class ReskinUnlock extends IncomingMessage
   {
       
      
      public var skinID:int;
      
      public var isPetSkin:int;
      
      public function ReskinUnlock(param1:uint, param2:Function)
      {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.skinID = param1.readInt();
         this.isPetSkin = param1.readInt();
      }
      
      override public function toString() : String
      {
         return formatToString("RESKIN","skinID","isPetSkin");
      }
   }
}
