/**
 * An object loaded from the Objects resource
 */
export interface GameObject {
  /**
   * The object type.
   */
  type: number;
  /**
   * The name of the object.
   */
  id: string;
  /**
   * Whether or not the object is an enemy.
   */
  enemy: boolean;
  /**
   * Whether or not the object is an item.
   */
  item: boolean;
  /**
   * Whether or not the object is a god.
   */
  god: boolean;
  /**
   * Whether or not the object is a pet.
   */
  pet: boolean;
  /**
   * The slot type which this object is for, if it is an item.
   */
  slotType: number;
  /**
   * The type of bag that this object is dropped in, if it is an item.
   */
  bagType: number;
  /**
   * The category of this object, such as `Equipment` or `Dye`.
   */
  class: string;
  /**
   * The max HP of this object, if it is an enemy.
   */
  maxHitPoints: number;
  /**
   * The defense of this object, if it is an enemy.
   */
  defense: number;
  /**
   * The XP multiplier of this object, if it is an enemy.
   */
  xpMultiplier: number;
  /**
   * The projcetiles fired by this object, if it is an enemy.
   */
  projectiles: ProjectileInfo[];
  /**
   * The first projectile in the `projectiles` array.
   * @see `GameObject.projectiles`
   */
  projectile: ProjectileInfo;
  /**
   * The stat bonuses activated when this object is equipped, if it is an item.
   */
  activateOnEquip: Array<{
    /**
     * The type of stat which is affected.
     */
    statType: number;
    /**
     * The change applied to the stat.
     */
    amount: number;
  }>;
  /**
   * The activation of the item
   */
  activate: ActivateInfo[];
  /**
   * The rate of fire of this object, if it is an item.
   */
  rateOfFire: number;
  /**
   * The number of projectiles fired by this object, if it is an item.
   */
  numProjectiles: number;
  /**
   * The angle (in degrees) between shots fired by this object, if it is an item.
   */
  arcGap: number;
  /**
   * The fame bonus applied when this object is equipped, if it is an item.
   */
  fameBonus: number;
  /**
   * The feed power of this object.
   */
  feedPower: number;
  /**
   * Whether or not this object occupies a square on the map.
   */
  occupySquare: boolean;
  /**
   * Whether or not the object occupies the entire square.
   */
  fullOccupy: boolean;
  /**
   * Whether or not the object protects players from ground damage.
   */
  protectFromGroundDamage: boolean;
  /**
   * The MP cost of the using the object
   */
  mpCost: number;
  /**
   * The MP cost when you stop using the item
   */
  mpEndCost: number;
  /**
   * Whether the item is soulbound
   */
  soulbound: boolean;
  /**
   * Whether the item is usable
   */
  usable: boolean;
}

/**
 * The activation properties of an object
 */
export interface ActivateInfo {
  /**
   * The ID of the object for indexing.
   */
  id: number;
  /**
   * The type of activation.
   */
  type: string;
  /**
   * The duration of activation.
   */
  duration?: number;
  /**
   * The stat amount.
   */
  stat?: number;
  /**
   * The effect name.
   */
  effect?: string;
  /**
   * The cooldown amount between activations in seconds.
   */
  cooldown?: number;
  /**
   * The target of the activation.
   */
  target?: string;
  /**
   * The activation position i.e "center"
   */
  center?: string;
  /**
   * The number of shots.
   */
  numShots?: number;
  /**
   * The speed of the activation.
   */
  speed?: number;
  /**
   * The range of the shot/AOE.
   */
  range?: number;
  /**
   * The tile radius of the AOE.
   */
  radius?: number;
  /**
   * The total damage over the activation.
   */
  totalDamage?: number;
  /**
   * The impact damage of an AOE.
   */
  impactDamage?: number;
  /**
   * The time in seconds taken to throw the projectile.
   */
  throwTime?: number;
  /**
   * The amount to heal on activation.
   */
  heal?: number;
  /**
   * The healing range of the activation.
   */
  healRange?: number;
  /**
   * The amount of defense the activation ignores.
   */
  ignoreDef?: number;
  /**
   * The minimum amount of wis required to activate.
   */
  wisMin?: number;
  /**
   * If the activation is affected by wismod.
   */
  useWisMod?: boolean;
  /**
   * The base amount of damage with wismod.
   */
  wisDamageBase?: number;
  /**
   * The condition to add on activation.
   */
  condEffect?: string;
  /**
   * The duration of the condition afflicted.
   */
  condDuration?: number;
  /**
   * If the activation stacks with other activations.
   */
  noStack?: boolean;
  /**
   * The type of unlocker i.e "char" or "vault".
   */
  slot?: string;
  /**
   * The hex ID of the skin if the activate is a skin changer.
   */
  skin?: string;
  /**
   * The ID of the skin if the activate is a skin unlocker.
   */
  skinType?: number;
  /**
   * If the key activation requires the client standing on a portal.
   */
  isUnlock?: boolean;
  /**
   * The new ID of a ChangeObject activation.
   */
  newId?: number;
  /**
   * The only area where activation is allowed i.e "realm" or "vault".
   */
  onlyIn?: string;
  /**
   * The only area where activation is allowed i.e "Guild Hall" or "Wine Cellar".
   */
  onlyInArea?: string;
}

/**
 * The properties of a projectile loaded from the Objects resource.
 */
export interface ProjectileInfo {
  /**
   * A local identifier for the projectile if this projectile is part of a list.
   */
  id: number;
  /**
   * The name of the projectile.
   */
  objectId: string;
  /**
   * The damage applied by this projectile, if it is not given by a range.
   */
  damage: number;
  /**
   * Whether or not the projectile is armor piercing.
   */
  armorPiercing: boolean;
  /**
   * The minimum damage applied by this projectile, if it is not given by the `damage`.
   */
  minDamage: number;
  /**
   * The maximum damage applied by this projectile, if it is not given by the `damage`.
   */
  maxDamage: number;
  /**
   * The speed of this projectile. Units are unknown, but most likely tiles/second
   */
  speed: number;
  /**
   * The lifetime of this projectile, in milliseconds.
   */
  lifetimeMS: number;
  /**
   * Whether or not this projectile follows a parametric path (like Bulwark projectiles do).
   */
  parametric: boolean;
  /**
   * Whether or not this projectile follows a wavy path (like staff projectiles do).
   */
  wavy: boolean;
  /**
   * Whether or not this projectile changes direction during it's lifetime.
   */
  boomerang: boolean;
  /**
   * Whether or not this projectile hits multiple entities.
   */
  multiHit: boolean;
  /**
   * Whether or not this projectile passes through obstacles.
   */
  passesCover: boolean;
  /**
   * The amplitude of the wave, if this projectile is `wavy`.
   */
  amplitude: number;
  /**
   * The frequency of the wave, if this projectile is `wavy`.
   */
  frequency: number;
  /**
   * Unknown.
   */
  magnitude: number;
  /**
   * A list of condition effects applied by this projectile.
   *
   * Note that effects are applied by the server independently of this
   * list, and modifying this list will not change the effects applied.
   */
  conditionEffects: Array<{
    /**
     * The name of the effect.
     */
    effectName: string;
    /**
     * The duration of the effect, in seconds.
     */
    duration: number;
  }>;
}
