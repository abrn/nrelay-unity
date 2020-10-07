package kabam.rotmg.messaging.impl.data
{
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class WorldPosData
   {
       
      
      public var x_:Number;
      
      public var y_:Number;
      
      public function WorldPosData()
      {
         super();
      }
      
      public function toPoint() : Point
      {
         return new Point(this.x_,this.y_);
      }
      
      public function parseFromInput(param1:IDataInput) : void
      {
         this.x_ = param1.readFloat();
         this.y_ = param1.readFloat();
      }
      
      public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeFloat(this.x_);
         param1.writeFloat(this.y_);
      }
      
      public function toString() : String
      {
         return "x_: " + this.x_ + " y_: " + this.y_;
      }
   }
}
