package kabam.rotmg.messaging.impl.data
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class StatData
   {
      
      public static const MAX_HP_STAT:int = 0;
      
      public static const HP_STAT:int = 1;
      
      public static const SIZE_STAT:int = 2;
      
      public static const MAX_MP_STAT:int = 3;
      
      public static const MP_STAT:int = 4;
      
      public static const NEXT_LEVEL_EXP_STAT:int = 5;
      
      public static const EXP_STAT:int = 6;
      
      public static const LEVEL_STAT:int = 7;
      
      public static const ATTACK_STAT:int = 20;
      
      public static const DEFENSE_STAT:int = 21;
      
      public static const SPEED_STAT:int = 22;
      
      public static const INVENTORY_0_STAT:int = 8;
      
      public static const INVENTORY_1_STAT:int = 9;
      
      public static const INVENTORY_2_STAT:int = 10;
      
      public static const INVENTORY_3_STAT:int = 11;
      
      public static const INVENTORY_4_STAT:int = 12;
      
      public static const INVENTORY_5_STAT:int = 13;
      
      public static const INVENTORY_6_STAT:int = 14;
      
      public static const INVENTORY_7_STAT:int = 15;
      
      public static const INVENTORY_8_STAT:int = 16;
      
      public static const INVENTORY_9_STAT:int = 17;
      
      public static const INVENTORY_10_STAT:int = 18;
      
      public static const INVENTORY_11_STAT:int = 19;
      
      public static const VITALITY_STAT:int = 26;
      
      public static const WISDOM_STAT:int = 27;
      
      public static const DEXTERITY_STAT:int = 28;
      
      public static const CONDITION_STAT:int = 29;
      
      public static const NUM_STARS_STAT:int = 30;
      
      public static const NAME_STAT:int = 31;
      
      public static const TEX1_STAT:int = 32;
      
      public static const TEX2_STAT:int = 33;
      
      public static const MERCHANDISE_TYPE_STAT:int = 34;
      
      public static const CREDITS_STAT:int = 35;
      
      public static const MERCHANDISE_PRICE_STAT:int = 36;
      
      public static const ACTIVE_STAT:int = 37;
      
      public static const ACCOUNT_ID_STAT:int = 38;
      
      public static const FAME_STAT:int = 39;
      
      public static const MERCHANDISE_CURRENCY_STAT:int = 40;
      
      public static const CONNECT_STAT:int = 41;
      
      public static const MERCHANDISE_COUNT_STAT:int = 42;
      
      public static const MERCHANDISE_MINS_LEFT_STAT:int = 43;
      
      public static const MERCHANDISE_DISCOUNT_STAT:int = 44;
      
      public static const MERCHANDISE_RANK_REQ_STAT:int = 45;
      
      public static const MAX_HP_BOOST_STAT:int = 46;
      
      public static const MAX_MP_BOOST_STAT:int = 47;
      
      public static const ATTACK_BOOST_STAT:int = 48;
      
      public static const DEFENSE_BOOST_STAT:int = 49;
      
      public static const SPEED_BOOST_STAT:int = 50;
      
      public static const VITALITY_BOOST_STAT:int = 51;
      
      public static const WISDOM_BOOST_STAT:int = 52;
      
      public static const DEXTERITY_BOOST_STAT:int = 53;
      
      public static const OWNER_ACCOUNT_ID_STAT:int = 54;
      
      public static const RANK_REQUIRED_STAT:int = 55;
      
      public static const NAME_CHOSEN_STAT:int = 56;
      
      public static const CURR_FAME_STAT:int = 57;
      
      public static const NEXT_CLASS_QUEST_FAME_STAT:int = 58;
      
      public static const LEGENDARY_RANK_STAT:int = 59;
      
      public static const SINK_LEVEL_STAT:int = 60;
      
      public static const ALT_TEXTURE_STAT:int = 61;
      
      public static const GUILD_NAME_STAT:int = 62;
      
      public static const GUILD_RANK_STAT:int = 63;
      
      public static const BREATH_STAT:int = 64;
      
      public static const XP_BOOSTED_STAT:int = 65;
      
      public static const XP_TIMER_STAT:int = 66;
      
      public static const LD_TIMER_STAT:int = 67;
      
      public static const LT_TIMER_STAT:int = 68;
      
      public static const HEALTH_POTION_STACK_STAT:int = 69;
      
      public static const MAGIC_POTION_STACK_STAT:int = 70;
      
      public static const BACKPACK_0_STAT:int = 71;
      
      public static const BACKPACK_1_STAT:int = 72;
      
      public static const BACKPACK_2_STAT:int = 73;
      
      public static const BACKPACK_3_STAT:int = 74;
      
      public static const BACKPACK_4_STAT:int = 75;
      
      public static const BACKPACK_5_STAT:int = 76;
      
      public static const BACKPACK_6_STAT:int = 77;
      
      public static const BACKPACK_7_STAT:int = 78;
      
      public static const HASBACKPACK_STAT:int = 79;
      
      public static const TEXTURE_STAT:int = 80;
      
      public static const PET_INSTANCEID_STAT:int = 81;
      
      public static const PET_NAME_STAT:int = 82;
      
      public static const PET_TYPE_STAT:int = 83;
      
      public static const PET_RARITY_STAT:int = 84;
      
      public static const PET_MAXABILITYPOWER_STAT:int = 85;
      
      public static const PET_FAMILY_STAT:int = 86;
      
      public static const PET_FIRSTABILITY_POINT_STAT:int = 87;
      
      public static const PET_SECONDABILITY_POINT_STAT:int = 88;
      
      public static const PET_THIRDABILITY_POINT_STAT:int = 89;
      
      public static const PET_FIRSTABILITY_POWER_STAT:int = 90;
      
      public static const PET_SECONDABILITY_POWER_STAT:int = 91;
      
      public static const PET_THIRDABILITY_POWER_STAT:int = 92;
      
      public static const PET_FIRSTABILITY_TYPE_STAT:int = 93;
      
      public static const PET_SECONDABILITY_TYPE_STAT:int = 94;
      
      public static const PET_THIRDABILITY_TYPE_STAT:int = 95;
      
      public static const NEW_CON_STAT:int = 96;
      
      public static const FORTUNE_TOKEN_STAT:int = 97;
      
      public static const SUPPORTER_POINTS_STAT:int = 98;
      
      public static const SUPPORTER_STAT:int = 99;
      
      public static const CHALLENGER_STARBG_STAT:int = 100;
      
      public static const UNKNOWN_STAT:int = 101;
      
      public static const PROJECTILE_SPEED_MULT:int = 102;
      
      public static const PROJECTILE_LIFE_MULT:int = 103;
      
      public static const OPENED_AT_TIMESTAMP:int = 104;
      
      public static const EXALTED_HEALTH:int = 107;
      
      public static const EXALTED_MANA:int = 108;
      
      public static const EXALTED_ATTACK:int = 105;
      
      public static const EXALTED_DEFENSE:int = 106;
      
      public static const EXALTED_SPEED:int = 109;
      
      public static const EXALTED_DEXTERITY:int = 110;
      
      public static const EXALTED_VITALITY:int = 111;
      
      public static const EXALTED_WISDOM:int = 112;
       
      
      public var statType_:uint = 0;
      
      public var statValue_:int;
      
      public var strStatValue_:String;
      
      public function StatData()
      {
         super();
      }
      
      public static function statToName(param1:int) : String
      {
         var _loc2_:* = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_)
         {
            case 0:
               return "StatData.MaxHP";
            case 1:
               return "StatusBar.HealthPoints";
            case 2:
               return "StatData.Size";
            case 3:
               return "StatData.MaxMP";
            case 4:
               return "StatusBar.ManaPoints";
            case 6:
               return "StatData.XP";
            case 7:
               return "StatData.Level";
            case 20:
               return "StatModel.attack.long";
            case 21:
               return "StatModel.defense.long";
            case 22:
               return "StatModel.speed.long";
            case 26:
               return "StatModel.vitality.long";
            case 27:
               return "StatModel.wisdom.long";
            case 28:
               return "StatModel.dexterity.long";
            default:
               return "StatData.UnknownStat";
         }
      }
      
      public function isStringStat() : Boolean
      {
         var _loc1_:* = this.statType_;
         var _loc2_:* = _loc1_;
         switch(_loc2_)
         {
            case 31:
            case 62:
            case 82:
            case 38:
            case 54:
               return true;
            default:
               return false;
         }
      }
      
      public function parseFromInput(param1:IDataInput) : void
      {
         this.statType_ = param1.readUnsignedByte();
         if(!this.isStringStat())
         {
            this.statValue_ = CompressedInt.Read(param1);
         }
         else
         {
            this.strStatValue_ = param1.readUTF();
         }
      }
      
      public function writeToOutput(param1:IDataOutput) : void
      {
         param1.writeByte(this.statType_);
         if(!this.isStringStat())
         {
            param1.writeInt(this.statValue_);
         }
         else
         {
            param1.writeUTF(this.strStatValue_);
         }
      }
      
      public function toString() : String
      {
         if(!this.isStringStat())
         {
            return "[" + this.statType_ + ": " + this.statValue_ + "]";
         }
         return "[" + this.statType_ + ": \"" + this.strStatValue_ + "\"]";
      }
   }
}
