/**
 * The settings for automatically picking up loot the client finds in bags
 */
export class AutoLootSettings {
    
    /**
     * Auto equip gear which is a higher tier than gear already equipped
     * Does not apply to UT items
     */
    autoEquip: boolean;
    /**
     * The minimum weapon tier to pick up
     */
    minWeaponTier: number;
    /**
     * The minimum armor tier to pick up
     */
    minArmorTier: number;
    /**
     * The minimum ability tier to pick up
     */
    minAbilityTier: number;
    /**
     * The minimum ring tier to pick up
     */
    minRingTier: number;
    /**
     * Loot all HP potions
     */
    lootHPPots: boolean;
    /**
     * Loot all MP potions
     */
    lootMPPots: boolean;
    /**
     * Loot all rainbow potions
     */
    lootRainbowPots: boolean;
    /**
     * Loot life and mana potions
     */
    lootLifeManaPots: boolean;
    /**
     * Loot all untiered items
     */
    lootAllUntiered: boolean;
    /**
     * Loot pet or player skins
     */
    lootSkins: boolean;
    /**
     * Loot dungeon marks
     */
    lootMarks: boolean;
    /**
     * Loot all soulbound items
     */
    lootAllSoulbound: boolean;
    /**
     * Send a logging message when an untiered item is picked up
     */
    notifyUntiered: boolean;

    constructor() {
        this.autoEquip = false;
        this.minWeaponTier = 11;
        this.minArmorTier = 12;
        this.minAbilityTier = 5;
        this.minRingTier = 5;
        this.lootHPPots = true;
        this.lootMPPots = true;
        this.lootRainbowPots = false;
        this.lootLifeManaPots = true;
        this.lootAllUntiered = true;
        this.lootSkins = false;
        this.lootMarks = false;
        this.lootAllSoulbound = false;
        this.notifyUntiered = true;
    }
}