package kabam.rotmg.messaging.impl.incoming
{
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.data.CompressedInt;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class ShowEffect extends IncomingMessage
   {
      
      private static const EFFECT_BIT_COLOR:int = 1;
      
      private static const EFFECT_BIT_POS1_X:int = 2;
      
      private static const EFFECT_BIT_POS1_Y:int = 4;
      
      private static const EFFECT_BIT_POS2_X:int = 8;
      
      private static const EFFECT_BIT_POS2_Y:int = 16;
      
      private static const EFFECT_BIT_POS1:int = 6;
      
      private static const EFFECT_BIT_POS2:int = 24;
      
      private static const EFFECT_BIT_DURATION:int = 32;
      
      private static const EFFECT_BIT_ID:int = 64;
       
      
      public var EFFECT_DICT:Vector.<String>;
      
      public const UNKNOWN_EFFECT_TYPE:int = 0;
      
      public const HEAL_EFFECT_TYPE:int = 1;
      
      public const TELEPORT_EFFECT_TYPE:int = 2;
      
      public const STREAM_EFFECT_TYPE:int = 3;
      
      public const THROW_EFFECT_TYPE:int = 4;
      
      public const NOVA_EFFECT_TYPE:int = 5;
      
      public const POISON_EFFECT_TYPE:int = 6;
      
      public const LINE_EFFECT_TYPE:int = 7;
      
      public const BURST_EFFECT_TYPE:int = 8;
      
      public const FLOW_EFFECT_TYPE:int = 9;
      
      public const RING_EFFECT_TYPE:int = 10;
      
      public const LIGHTNING_EFFECT_TYPE:int = 11;
      
      public const COLLAPSE_EFFECT_TYPE:int = 12;
      
      public const CONEBLAST_EFFECT_TYPE:int = 13;
      
      public const JITTER_EFFECT_TYPE:int = 14;
      
      public const FLASH_EFFECT_TYPE:int = 15;
      
      public const THROW_PROJECTILE_EFFECT_TYPE:int = 16;
      
      public const SHOCKER_EFFECT_TYPE:int = 17;
      
      public const SHOCKEE_EFFECT_TYPE:int = 18;
      
      public const RISING_FURY_EFFECT_TYPE:int = 19;
      
      public const NOVA_NO_AOE_EFFECT_TYPE:int = 20;
      
      public const GILDED_BUFF_EFFECT_TYPE:int = 27;
      
      public const JADE_BUFF_EFFECT_TYPE:int = 28;
      
      public const CHAOS_BUFF_EFFECT_TYPE:int = 29;
      
      public const THUNDER_BUFF_EFFECT_TYPE:int = 30;
      
      public const STATUS_FLASH_EFFECT_TYPE:int = 31;
      
      public const FIRE_ORB_BUFF_EFFECT_TYPE:int = 32;
      
      public const INSPIRED_EFFECT_TYPE:int = 21;
      
      public const HOLY_BEAM_EFFECT_TYPE:int = 22;
      
      public const CIRCLE_TELEGRAPH_EFFECT_TYPE:int = 23;
      
      public const CHAOS_BEAM_EFFECT_TYPE:int = 24;
      
      public const TELEPORT_MONSTER_EFFECT_TYPE:int = 25;
      
      public const METEOR_EFFECT_TYPE:int = 26;
      
      public var effectType_:uint;
      
      public var targetObjectId_:int;
      
      public var pos1_:WorldPosData;
      
      public var pos2_:WorldPosData;
      
      public var color_:int;
      
      public var duration_:Number;
      
      public function ShowEffect(param1:uint, param2:Function)
      {
         EFFECT_DICT = new <String>["UNKNOWN_EFFECT_TYPE","HEAL_EFFECT_TYPE","TELEPORT_EFFECT_TYPE","STREAM_EFFECT_TYPE","THROW_EFFECT_TYPE","NOVA_EFFECT_TYPE","POISON_EFFECT_TYPE","LINE_EFFECT_TYPE","BURST_EFFECT_TYPE","FLOW_EFFECT_TYPE","RING_EFFECT_TYPE","LIGHTNING_EFFECT_TYPE","COLLAPSE_EFFECT_TYPE","CONEBLAST_EFFECT_TYPE","JITTER_EFFECT_TYPE","FLASH_EFFECT_TYPE","THROW_PROJECTILE_EFFECT_TYPE","SHOCKER_EFFECT_TYPE","SHOCKEE_EFFECT_TYPE","RISING_FURY_EFFECT_TYPE","NOVA_NO_AOE_EFFECT_TYPE","GILDED_BUFF_EFFECT_TYPE","JADE_BUFF_EFFECT_TYPE","CHAOS_BUFF_EFFECT_TYPE","THUNDER_BUFF_EFFECT_TYPE","STATUS_FLASH_EFFECT_TYPE","FIRE_ORB_BUFF_EFFECT_TYPE","INSPIRED_EFFECT_TYPE","HOLY_BEAM_EFFECT_TYPE","CIRCLE_TELEGRAPH_EFFECT_TYPE","CHAOS_BEAM_EFFECT_TYPE","TELEPORT_MONSTER_EFFECT_TYPE","METEOR_EFFECT_TYPE"];
         this.pos1_ = new WorldPosData();
         this.pos2_ = new WorldPosData();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void
      {
         this.effectType_ = param1.readUnsignedByte();
         var _loc2_:uint = param1.readUnsignedByte();
         if(_loc2_ & 64)
         {
            this.targetObjectId_ = CompressedInt.Read(param1);
         }
         else
         {
            this.targetObjectId_ = 0;
         }
         if(_loc2_ & 2)
         {
            this.pos1_.x_ = param1.readFloat();
         }
         else
         {
            this.pos1_.x_ = 0;
         }
         if(_loc2_ & 4)
         {
            this.pos1_.y_ = param1.readFloat();
         }
         else
         {
            this.pos1_.y_ = 0;
         }
         if(_loc2_ & 8)
         {
            this.pos2_.x_ = param1.readFloat();
         }
         else
         {
            this.pos2_.x_ = 0;
         }
         if(_loc2_ & 16)
         {
            this.pos2_.y_ = param1.readFloat();
         }
         else
         {
            this.pos2_.y_ = 0;
         }
         if(_loc2_ & 1)
         {
            this.color_ = param1.readInt();
         }
         else
         {
            this.color_ = 4294967295;
         }
         if(_loc2_ & 32)
         {
            this.duration_ = param1.readFloat();
         }
         else
         {
            this.duration_ = 1;
         }
      }
      
      override public function toString() : String
      {
         var _loc1_:String = formatToString("SHOW_EFFECT","effectType_","targetObjectId_","pos1_","pos2_","color_","duration_").replace(/effectType_=\"\d+?\"/,"effectType_=\"" + this.effectType_ + "\" (" + this.EFFECT_DICT[this.effectType_] + ")");
         return _loc1_;
      }
   }
}
