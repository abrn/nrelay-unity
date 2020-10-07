package kabam.rotmg.messaging.impl.data
{
   import flash.utils.IDataOutput;
   
   public class MoveRecord
   {
       
      
      public var time_:int;
      
      public var x_:Number;
      
      public var y_:Number;
      
      public function MoveRecord(param1:int, param2:Number, param3:Number)
      {
         super();
         this.time_ = param1;
         this.x_ = param2;
         this.y_ = param3;
      }
      
      public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeInt(this.time_);
         param1.writeFloat(this.x_);
         param1.writeFloat(this.y_);
      }
      
      public function toString() : String
      {
         return "time_: " + this.time_ + " x_: " + this.x_ + " y_: " + this.y_;
      }
   }
}
