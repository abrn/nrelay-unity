package kabam.rotmg.messaging.impl
{
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.game.MoveRecords;
   import com.company.assembleegameclient.game.events.GuildResultEvent;
   import com.company.assembleegameclient.game.events.KeyInfoResponseSignal;
   import com.company.assembleegameclient.game.events.NameResultEvent;
   import com.company.assembleegameclient.game.events.ReconnectEvent;
   import com.company.assembleegameclient.map.AbstractMap;
   import com.company.assembleegameclient.map.GroundLibrary;
   import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
   import com.company.assembleegameclient.objects.Container;
   import com.company.assembleegameclient.objects.FlashDescription;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Merchant;
   import com.company.assembleegameclient.objects.NameChanger;
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.ObjectProperties;
   import com.company.assembleegameclient.objects.Pet;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.objects.Portal;
   import com.company.assembleegameclient.objects.Projectile;
   import com.company.assembleegameclient.objects.ProjectileProperties;
   import com.company.assembleegameclient.objects.SellableObject;
   import com.company.assembleegameclient.objects.StatusFlashDescription;
   import com.company.assembleegameclient.objects.particles.AOEEffect;
   import com.company.assembleegameclient.objects.particles.BurstEffect;
   import com.company.assembleegameclient.objects.particles.CircleTelegraph;
   import com.company.assembleegameclient.objects.particles.CollapseEffect;
   import com.company.assembleegameclient.objects.particles.ConeBlastEffect;
   import com.company.assembleegameclient.objects.particles.FlowEffect;
   import com.company.assembleegameclient.objects.particles.GildedEffect;
   import com.company.assembleegameclient.objects.particles.HealEffect;
   import com.company.assembleegameclient.objects.particles.HolyBeamEffect;
   import com.company.assembleegameclient.objects.particles.InspireEffect;
   import com.company.assembleegameclient.objects.particles.LightningEffect;
   import com.company.assembleegameclient.objects.particles.LineEffect;
   import com.company.assembleegameclient.objects.particles.MeteorEffect;
   import com.company.assembleegameclient.objects.particles.NovaEffect;
   import com.company.assembleegameclient.objects.particles.OrbEffect;
   import com.company.assembleegameclient.objects.particles.PoisonEffect;
   import com.company.assembleegameclient.objects.particles.RingEffect;
   import com.company.assembleegameclient.objects.particles.RisingFuryEffect;
   import com.company.assembleegameclient.objects.particles.ShockeeEffect;
   import com.company.assembleegameclient.objects.particles.ShockerEffect;
   import com.company.assembleegameclient.objects.particles.SmokeCloudEffect;
   import com.company.assembleegameclient.objects.particles.SpritesProjectEffect;
   import com.company.assembleegameclient.objects.particles.StreamEffect;
   import com.company.assembleegameclient.objects.particles.TeleportEffect;
   import com.company.assembleegameclient.objects.particles.ThrowEffect;
   import com.company.assembleegameclient.objects.particles.ThunderEffect;
   import com.company.assembleegameclient.objects.thrown.ThrowProjectileEffect;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   import com.company.assembleegameclient.ui.PicView;
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import com.company.assembleegameclient.ui.dialogs.NotEnoughFameDialog;
   import com.company.assembleegameclient.ui.panels.GuildInvitePanel;
   import com.company.assembleegameclient.ui.panels.TradeRequestPanel;
   import com.company.assembleegameclient.util.FreeList;
   import com.company.util.Random;
   import com.gskinner.motion.GTween;
   import com.hurlant.crypto.Crypto;
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.util.Base64;
   import com.hurlant.util.der.PEM;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import io.decagames.rotmg.characterMetrics.tracker.CharactersMetricsTracker;
   import io.decagames.rotmg.classes.NewClassUnlockSignal;
   import io.decagames.rotmg.dailyQuests.messages.incoming.QuestFetchResponse;
   import io.decagames.rotmg.dailyQuests.signal.QuestFetchCompleteSignal;
   import io.decagames.rotmg.dailyQuests.signal.QuestRedeemCompleteSignal;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.vo.HatchPetVO;
   import io.decagames.rotmg.pets.signals.DeletePetSignal;
   import io.decagames.rotmg.pets.signals.HatchPetSignal;
   import io.decagames.rotmg.pets.signals.NewAbilitySignal;
   import io.decagames.rotmg.pets.signals.PetFeedResultSignal;
   import io.decagames.rotmg.pets.signals.UpdateActivePet;
   import io.decagames.rotmg.pets.signals.UpdatePetYardSignal;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.social.model.SocialModel;
   import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.lib.net.api.MessageMap;
   import kabam.lib.net.api.MessageProvider;
   import kabam.lib.net.impl.ChatSocketServer;
   import kabam.lib.net.impl.ChatSocketServerModel;
   import kabam.lib.net.impl.Message;
   import kabam.lib.net.impl.SocketServer;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.view.PurchaseConfirmationDialog;
   import kabam.rotmg.arena.control.ArenaDeathSignal;
   import kabam.rotmg.arena.control.ImminentArenaWaveSignal;
   import kabam.rotmg.arena.model.CurrentArenaRunModel;
   import kabam.rotmg.arena.view.BattleSummaryDialog;
   import kabam.rotmg.arena.view.ContinueOrQuitDialog;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterSkinState;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.dailyLogin.message.ClaimDailyRewardMessage;
   import kabam.rotmg.dailyLogin.message.ClaimDailyRewardResponse;
   import kabam.rotmg.dailyLogin.signal.ClaimDailyRewardResponseSignal;
   import kabam.rotmg.death.control.HandleDeathSignal;
   import kabam.rotmg.death.control.ZombifySignal;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.game.focus.control.SetGameFocusSignal;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
   import kabam.rotmg.game.signals.AddTextLineSignal;
   import kabam.rotmg.game.signals.GiftStatusUpdateSignal;
   import kabam.rotmg.messaging.impl.data.GroundTileData;
   import kabam.rotmg.messaging.impl.data.ObjectData;
   import kabam.rotmg.messaging.impl.data.ObjectStatusData;
   import kabam.rotmg.messaging.impl.data.SlotObjectData;
   import kabam.rotmg.messaging.impl.data.StatData;
   import kabam.rotmg.messaging.impl.incoming.AccountList;
   import kabam.rotmg.messaging.impl.incoming.AllyShoot;
   import kabam.rotmg.messaging.impl.incoming.Aoe;
   import kabam.rotmg.messaging.impl.incoming.BuyResult;
   import kabam.rotmg.messaging.impl.incoming.ChatToken;
   import kabam.rotmg.messaging.impl.incoming.ClientStat;
   import kabam.rotmg.messaging.impl.incoming.CreateSuccess;
   import kabam.rotmg.messaging.impl.incoming.Damage;
   import kabam.rotmg.messaging.impl.incoming.Death;
   import kabam.rotmg.messaging.impl.incoming.EnemyShoot;
   import kabam.rotmg.messaging.impl.incoming.EvolvedMessageHandler;
   import kabam.rotmg.messaging.impl.incoming.EvolvedPetMessage;
   import kabam.rotmg.messaging.impl.incoming.Failure;
   import kabam.rotmg.messaging.impl.incoming.File;
   import kabam.rotmg.messaging.impl.incoming.GlobalNotification;
   import kabam.rotmg.messaging.impl.incoming.Goto;
   import kabam.rotmg.messaging.impl.incoming.GuildResult;
   import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
   import kabam.rotmg.messaging.impl.incoming.InvResult;
   import kabam.rotmg.messaging.impl.incoming.InvitedToGuild;
   import kabam.rotmg.messaging.impl.incoming.KeyInfoResponse;
   import kabam.rotmg.messaging.impl.incoming.MapInfo;
   import kabam.rotmg.messaging.impl.incoming.NameResult;
   import kabam.rotmg.messaging.impl.incoming.NewAbilityMessage;
   import kabam.rotmg.messaging.impl.incoming.NewCharacterInformation;
   import kabam.rotmg.messaging.impl.incoming.NewTick;
   import kabam.rotmg.messaging.impl.incoming.Notification;
   import kabam.rotmg.messaging.impl.incoming.PasswordPrompt;
   import kabam.rotmg.messaging.impl.incoming.Pic;
   import kabam.rotmg.messaging.impl.incoming.Ping;
   import kabam.rotmg.messaging.impl.incoming.PlaySound;
   import kabam.rotmg.messaging.impl.incoming.QuestObjId;
   import kabam.rotmg.messaging.impl.incoming.QuestRedeemResponse;
   import kabam.rotmg.messaging.impl.incoming.QueueInformation;
   import kabam.rotmg.messaging.impl.incoming.RealmHeroesResponse;
   import kabam.rotmg.messaging.impl.incoming.Reconnect;
   import kabam.rotmg.messaging.impl.incoming.ReskinUnlock;
   import kabam.rotmg.messaging.impl.incoming.ServerPlayerShoot;
   import kabam.rotmg.messaging.impl.incoming.ShowEffect;
   import kabam.rotmg.messaging.impl.incoming.TradeAccepted;
   import kabam.rotmg.messaging.impl.incoming.TradeChanged;
   import kabam.rotmg.messaging.impl.incoming.TradeDone;
   import kabam.rotmg.messaging.impl.incoming.TradeRequested;
   import kabam.rotmg.messaging.impl.incoming.TradeStart;
   import kabam.rotmg.messaging.impl.incoming.UnlockInformation;
   import kabam.rotmg.messaging.impl.incoming.Update;
   import kabam.rotmg.messaging.impl.incoming.VerifyEmail;
   import kabam.rotmg.messaging.impl.incoming.arena.ArenaDeath;
   import kabam.rotmg.messaging.impl.incoming.arena.ImminentArenaWave;
   import kabam.rotmg.messaging.impl.incoming.pets.DeletePetMessage;
   import kabam.rotmg.messaging.impl.incoming.pets.HatchPetMessage;
   import kabam.rotmg.messaging.impl.outgoing.AcceptTrade;
   import kabam.rotmg.messaging.impl.outgoing.ActivePetUpdateRequest;
   import kabam.rotmg.messaging.impl.outgoing.AoeAck;
   import kabam.rotmg.messaging.impl.outgoing.Buy;
   import kabam.rotmg.messaging.impl.outgoing.CancelTrade;
   import kabam.rotmg.messaging.impl.outgoing.ChangeGuildRank;
   import kabam.rotmg.messaging.impl.outgoing.ChangePetSkin;
   import kabam.rotmg.messaging.impl.outgoing.ChangeTrade;
   import kabam.rotmg.messaging.impl.outgoing.ChatHello;
   import kabam.rotmg.messaging.impl.outgoing.CheckCredits;
   import kabam.rotmg.messaging.impl.outgoing.ChooseName;
   import kabam.rotmg.messaging.impl.outgoing.Create;
   import kabam.rotmg.messaging.impl.outgoing.CreateGuild;
   import kabam.rotmg.messaging.impl.outgoing.EditAccountList;
   import kabam.rotmg.messaging.impl.outgoing.EnemyHit;
   import kabam.rotmg.messaging.impl.outgoing.Escape;
   import kabam.rotmg.messaging.impl.outgoing.GoToQuestRoom;
   import kabam.rotmg.messaging.impl.outgoing.GotoAck;
   import kabam.rotmg.messaging.impl.outgoing.GroundDamage;
   import kabam.rotmg.messaging.impl.outgoing.GuildInvite;
   import kabam.rotmg.messaging.impl.outgoing.GuildRemove;
   import kabam.rotmg.messaging.impl.outgoing.Hello;
   import kabam.rotmg.messaging.impl.outgoing.InvDrop;
   import kabam.rotmg.messaging.impl.outgoing.InvSwap;
   import kabam.rotmg.messaging.impl.outgoing.JoinGuild;
   import kabam.rotmg.messaging.impl.outgoing.KeyInfoRequest;
   import kabam.rotmg.messaging.impl.outgoing.Load;
   import kabam.rotmg.messaging.impl.outgoing.Move;
   import kabam.rotmg.messaging.impl.outgoing.OtherHit;
   import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;
   import kabam.rotmg.messaging.impl.outgoing.PlayerHit;
   import kabam.rotmg.messaging.impl.outgoing.PlayerShoot;
   import kabam.rotmg.messaging.impl.outgoing.PlayerText;
   import kabam.rotmg.messaging.impl.outgoing.Pong;
   import kabam.rotmg.messaging.impl.outgoing.RequestTrade;
   import kabam.rotmg.messaging.impl.outgoing.ResetDailyQuests;
   import kabam.rotmg.messaging.impl.outgoing.Reskin;
   import kabam.rotmg.messaging.impl.outgoing.SetCondition;
   import kabam.rotmg.messaging.impl.outgoing.ShootAck;
   import kabam.rotmg.messaging.impl.outgoing.SquareHit;
   import kabam.rotmg.messaging.impl.outgoing.Teleport;
   import kabam.rotmg.messaging.impl.outgoing.UseItem;
   import kabam.rotmg.messaging.impl.outgoing.UsePortal;
   import kabam.rotmg.messaging.impl.outgoing.arena.EnterArena;
   import kabam.rotmg.messaging.impl.outgoing.arena.QuestRedeem;
   import kabam.rotmg.minimap.control.UpdateGameObjectTileSignal;
   import kabam.rotmg.minimap.control.UpdateGroundTileSignal;
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.servers.api.ServerModel;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.model.HUDModel;
   import kabam.rotmg.ui.model.Key;
   import kabam.rotmg.ui.signals.RealmHeroesSignal;
   import kabam.rotmg.ui.signals.RealmQuestLevelSignal;
   import kabam.rotmg.ui.signals.ShowHideKeyUISignal;
   import kabam.rotmg.ui.signals.ShowKeySignal;
   import kabam.rotmg.ui.signals.UpdateBackpackTabSignal;
   import kabam.rotmg.ui.view.NotEnoughGoldDialog;
   import kabam.rotmg.ui.view.TitleView;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.framework.api.ILogger;
   
   public class GameServerConnectionConcrete extends GameServerConnection
   {
      
      private static const TO_MILLISECONDS:int = 1000;
      
      private static const MAX_RECONNECT_ATTEMPTS:int = 5;
      
      public static var connectionGuid:String = "";
      
      public static var lastConnectionFailureMessage:String = "";
      
      public static var lastConnectionFailureID:String = "";
       
      
      private var serverFull_:Boolean = false;
      
      public var petUpdater:PetUpdater;
      
      private var loader:URLLoader;
      
      private var messages:MessageProvider;
      
      private var player:Player;
      
      private var retryConnection_:Boolean = true;
      
      private var rand_:Random = null;
      
      private var giftChestUpdateSignal:GiftStatusUpdateSignal;
      
      private var death:Death;
      
      private var retryTimer_:Timer;
      
      private var delayBeforeReconnect:int = 2;
      
      private var addTextLine:AddTextLineSignal;
      
      private var addSpeechBalloon:AddSpeechBalloonSignal;
      
      private var updateGroundTileSignal:UpdateGroundTileSignal;
      
      private var updateGameObjectTileSignal:UpdateGameObjectTileSignal;
      
      private var logger:ILogger;
      
      private var handleDeath:HandleDeathSignal;
      
      private var zombify:ZombifySignal;
      
      private var setGameFocus:SetGameFocusSignal;
      
      private var updateBackpackTab:UpdateBackpackTabSignal;
      
      private var petFeedResult:PetFeedResultSignal;
      
      private var closeDialogs:CloseDialogsSignal;
      
      private var openDialog:OpenDialogSignal;
      
      private var showPopupSignal:ShowPopupSignal;
      
      private var arenaDeath:ArenaDeathSignal;
      
      private var imminentWave:ImminentArenaWaveSignal;
      
      private var questFetchComplete:QuestFetchCompleteSignal;
      
      private var questRedeemComplete:QuestRedeemCompleteSignal;
      
      private var keyInfoResponse:KeyInfoResponseSignal;
      
      private var claimDailyRewardResponse:ClaimDailyRewardResponseSignal;
      
      private var newClassUnlockSignal:NewClassUnlockSignal;
      
      private var currentArenaRun:CurrentArenaRunModel;
      
      private var classesModel:ClassesModel;
      
      private var seasonalEventModel:SeasonalEventModel;
      
      private var injector:Injector;
      
      private var model:GameModel;
      
      private var updateActivePet:UpdateActivePet;
      
      private var petsModel:PetsModel;
      
      private var socialModel:SocialModel;
      
      private var chatServerConnection:ChatSocketServer;
      
      private var chatServerModel:ChatSocketServerModel;
      
      private var _isReconnecting:Boolean;
      
      private var _numberOfReconnectAttempts:int;
      
      private var _chatReconnectionTimer:Timer;
      
      private var statsTracker:CharactersMetricsTracker;
      
      private var isNexusing:Boolean;
      
      private var serverModel:ServerModel;
      
      private var showHideKeyUISignal:ShowHideKeyUISignal;
      
      private var realmHeroesSignal:RealmHeroesSignal;
      
      private var realmQuestLevelSignal:RealmQuestLevelSignal;
      
      private var hudModel:HUDModel;
      
      private var ticksElapsed:int = 0;
      
      public function GameServerConnectionConcrete(param1:AGameSprite, param2:Server, param3:int, param4:Boolean, param5:int, param6:int, param7:ByteArray, param8:String, param9:Boolean)
      {
         loader = new URLLoader();
         super();
         this.injector = StaticInjectorContext.getInjector();
         this.giftChestUpdateSignal = this.injector.getInstance(GiftStatusUpdateSignal);
         this.addTextLine = this.injector.getInstance(AddTextLineSignal);
         this.addSpeechBalloon = this.injector.getInstance(AddSpeechBalloonSignal);
         this.updateGroundTileSignal = this.injector.getInstance(UpdateGroundTileSignal);
         this.updateGameObjectTileSignal = this.injector.getInstance(UpdateGameObjectTileSignal);
         this.petFeedResult = this.injector.getInstance(PetFeedResultSignal);
         this.updateBackpackTab = StaticInjectorContext.getInjector().getInstance(UpdateBackpackTabSignal);
         this.updateActivePet = this.injector.getInstance(UpdateActivePet);
         this.petsModel = this.injector.getInstance(PetsModel);
         this.socialModel = this.injector.getInstance(SocialModel);
         this.closeDialogs = this.injector.getInstance(CloseDialogsSignal);
         this.openDialog = this.injector.getInstance(OpenDialogSignal);
         this.showPopupSignal = this.injector.getInstance(ShowPopupSignal);
         this.arenaDeath = this.injector.getInstance(ArenaDeathSignal);
         this.imminentWave = this.injector.getInstance(ImminentArenaWaveSignal);
         this.questFetchComplete = this.injector.getInstance(QuestFetchCompleteSignal);
         this.questRedeemComplete = this.injector.getInstance(QuestRedeemCompleteSignal);
         this.keyInfoResponse = this.injector.getInstance(KeyInfoResponseSignal);
         this.claimDailyRewardResponse = this.injector.getInstance(ClaimDailyRewardResponseSignal);
         this.newClassUnlockSignal = this.injector.getInstance(NewClassUnlockSignal);
         this.showHideKeyUISignal = this.injector.getInstance(ShowHideKeyUISignal);
         this.realmHeroesSignal = this.injector.getInstance(RealmHeroesSignal);
         this.realmQuestLevelSignal = this.injector.getInstance(RealmQuestLevelSignal);
         this.statsTracker = this.injector.getInstance(CharactersMetricsTracker);
         this.logger = this.injector.getInstance(ILogger);
         this.handleDeath = this.injector.getInstance(HandleDeathSignal);
         this.zombify = this.injector.getInstance(ZombifySignal);
         this.setGameFocus = this.injector.getInstance(SetGameFocusSignal);
         this.classesModel = this.injector.getInstance(ClassesModel);
         this.seasonalEventModel = this.injector.getInstance(SeasonalEventModel);
         serverConnection = this.injector.getInstance(SocketServer);
         this.messages = this.injector.getInstance(MessageProvider);
         this.model = this.injector.getInstance(GameModel);
         this.hudModel = this.injector.getInstance(HUDModel);
         this.serverModel = this.injector.getInstance(ServerModel);
         this.currentArenaRun = this.injector.getInstance(CurrentArenaRunModel);
         gs_ = param1;
         server_ = param2;
         gameId_ = param3;
         createCharacter_ = param4;
         charId_ = param5;
         keyTime_ = param6;
         key_ = param7;
         mapJSON_ = param8;
         isFromArena_ = param9;
         this.socialModel.setCurrentServer(server_);
         this.getPetUpdater();
         instance = this;
         this.loader.addEventListener("httpStatus",loaderStatus);
      }
      
      private static function isStatPotion(param1:int) : Boolean
      {
         return param1 == 2591 || param1 == 5465 || param1 == 9064 || (param1 == 2592 || param1 == 5466 || param1 == 9065) || (param1 == 2593 || param1 == 5467 || param1 == 9066) || (param1 == 2612 || param1 == 5468 || param1 == 9067) || (param1 == 2613 || param1 == 5469 || param1 == 9068) || (param1 == 2636 || param1 == 5470 || param1 == 9069) || (param1 == 2793 || param1 == 5471 || param1 == 9070) || (param1 == 2794 || param1 == 5472 || param1 == 9071) || (param1 == 9724 || param1 == 9725 || param1 == 9726 || param1 == 9727 || param1 == 9728 || param1 == 9729 || param1 == 9730 || param1 == 9731);
      }
      
      override public function disconnect() : void
      {
         Parameters.savingMap_ = false;
         this.removeServerConnectionListeners();
         this.unmapMessages();
         serverConnection.disconnect();
      }
      
      override public function connect() : void
      {
         this.addServerConnectionListeners();
         this.mapMessages();
         var _loc2_:ChatMessage = new ChatMessage();
         _loc2_.name = "*Client*";
         _loc2_.text = "chat.connectingTo";
         var _loc1_:String = server_.name;
         if(_loc1_ == "{\"text\":\"server.vault\"}")
         {
            _loc1_ = "server.vault";
         }
         _loc1_ = LineBuilder.getLocalizedStringFromKey(_loc1_);
         _loc2_.tokens = {"serverName":_loc1_};
         this.addTextLine.dispatch(_loc2_);
         serverConnection.connect(server_.address,server_.port);
         Parameters.paramIPJoinedOnce = false;
      }
      
      override public function peekNextDamage(param1:uint, param2:uint) : uint
      {
         return this.rand_.nextIntRange(param1,param2);
      }
      
      override public function getNextDamage(param1:uint, param2:uint) : uint
      {
         return this.rand_.nextIntRange(param1,param2);
      }
      
      override public function enableJitterWatcher() : void
      {
         if(jitterWatcher_ == null)
         {
            jitterWatcher_ = new JitterWatcher();
         }
      }
      
      override public function disableJitterWatcher() : void
      {
         if(jitterWatcher_)
         {
            jitterWatcher_ = null;
         }
      }
      
      override public function playerShoot(param1:int, param2:Projectile) : void
      {
         var _loc3_:PlayerShoot = this.messages.require(30) as PlayerShoot;
         _loc3_.time_ = param1;
         _loc3_.bulletId_ = param2.bulletId_;
         _loc3_.containerType_ = param2.containerType_;
         _loc3_.startingPos_.x_ = param2.x_;
         _loc3_.startingPos_.y_ = param2.y_;
         _loc3_.angle_ = param2.angle_;
         _loc3_.lifeMult_ = param2.lifeMul_;
         _loc3_.speedMult_ = param2.speedMul_;
         serverConnection.sendMessage(_loc3_);
      }
      
      override public function playerHit(param1:int, param2:int) : void
      {
         var _loc3_:PlayerHit = this.messages.require(90) as PlayerHit;
         _loc3_.bulletId_ = param1;
         _loc3_.objectId_ = param2;
         serverConnection.sendMessage(_loc3_);
      }
      
      override public function enemyHit(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         var _loc5_:EnemyHit = this.messages.require(25) as EnemyHit;
         _loc5_.time_ = param1;
         _loc5_.bulletId_ = param2;
         _loc5_.targetId_ = param3;
         _loc5_.kill_ = param4;
         serverConnection.sendMessage(_loc5_);
      }
      
      override public function otherHit(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:OtherHit = this.messages.require(20) as OtherHit;
         _loc5_.time_ = param1;
         _loc5_.bulletId_ = param2;
         _loc5_.objectId_ = param3;
         _loc5_.targetId_ = param4;
         serverConnection.sendMessage(_loc5_);
      }
      
      override public function squareHit(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:SquareHit = this.messages.require(40) as SquareHit;
         _loc4_.time_ = param1;
         _loc4_.bulletId_ = param2;
         _loc4_.objectId_ = param3;
         serverConnection.sendMessage(_loc4_);
      }
      
      override public function groundDamage(param1:int, param2:Number, param3:Number) : void
      {
         var _loc4_:GroundDamage = this.messages.require(103) as GroundDamage;
         _loc4_.time_ = param1;
         _loc4_.position_.x_ = param2;
         _loc4_.position_.y_ = param3;
         serverConnection.sendMessage(_loc4_);
      }
      
      override public function playerText(param1:String) : void
      {
         var _loc2_:PlayerText = this.messages.require(10) as PlayerText;
         _loc2_.text_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function invSwap(param1:Player, param2:GameObject, param3:int, param4:int, param5:GameObject, param6:int, param7:int) : Boolean
      {
         if(!this.gs_)
         {
            return false;
         }
         if(this.gs_.lastUpdate_ - this.lastInvSwapTime < 500)
         {
            return false;
         }
         var _loc8_:InvSwap = this.messages.require(19) as InvSwap;
         _loc8_.time_ = this.gs_.lastUpdate_;
         _loc8_.position_.x_ = param1.x_;
         _loc8_.position_.y_ = param1.y_;
         _loc8_.slotObject1_.objectId_ = param2.objectId_;
         _loc8_.slotObject1_.slotId_ = param3;
         _loc8_.slotObject1_.objectType_ = param4;
         _loc8_.slotObject2_.objectId_ = param5.objectId_;
         _loc8_.slotObject2_.slotId_ = param6;
         _loc8_.slotObject2_.objectType_ = param7;
         serverConnection.sendMessage(_loc8_);
         this.lastInvSwapTime = _loc8_.time_;
         var _loc9_:int = param2.equipment_[param3];
         param2.equipment_[param3] = param5.equipment_[param6];
         param5.equipment_[param6] = _loc9_;
         SoundEffectLibrary.play("inventory_move_item");
         return true;
      }
      
      override public function invSwapRaw(param1:Number, param2:Number, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : Boolean
      {
         if(!gs_)
         {
            return false;
         }
         if(this.gs_.lastUpdate_ - this.lastInvSwapTime < 500)
         {
            return false;
         }
         var _loc9_:InvSwap = this.messages.require(19) as InvSwap;
         _loc9_.time_ = gs_.lastUpdate_;
         _loc9_.position_.x_ = param1;
         _loc9_.position_.y_ = param2;
         _loc9_.slotObject1_.objectId_ = param3;
         _loc9_.slotObject1_.slotId_ = param4;
         _loc9_.slotObject1_.objectType_ = param5;
         _loc9_.slotObject2_.objectId_ = param6;
         _loc9_.slotObject2_.slotId_ = param7;
         _loc9_.slotObject2_.objectType_ = param8;
         serverConnection.sendMessage(_loc9_);
         this.lastInvSwapTime = _loc9_.time_;
         SoundEffectLibrary.play("inventory_move_item");
         return true;
      }
      
      override public function invSwapPotion(param1:Player, param2:GameObject, param3:int, param4:int, param5:GameObject, param6:int, param7:int) : Boolean
      {
         if(!gs_)
         {
            return false;
         }
         if(this.gs_.lastUpdate_ - this.lastInvSwapTime < 500)
         {
            return false;
         }
         var _loc8_:InvSwap = this.messages.require(19) as InvSwap;
         _loc8_.time_ = gs_.lastUpdate_;
         _loc8_.position_.x_ = param1.x_;
         _loc8_.position_.y_ = param1.y_;
         _loc8_.slotObject1_.objectId_ = param2.objectId_;
         _loc8_.slotObject1_.slotId_ = param3;
         _loc8_.slotObject1_.objectType_ = param4;
         _loc8_.slotObject2_.objectId_ = param5.objectId_;
         _loc8_.slotObject2_.slotId_ = param6;
         _loc8_.slotObject2_.objectType_ = param7;
         param2.equipment_[param3] = -1;
         if(param4 == 2594)
         {
            param1.healthPotionCount_++;
         }
         else if(param4 == 2595)
         {
            param1.magicPotionCount_++;
         }
         serverConnection.sendMessage(_loc8_);
         this.lastInvSwapTime = _loc8_.time_;
         SoundEffectLibrary.play("inventory_move_item");
         return true;
      }
      
      override public function invDrop(param1:GameObject, param2:int, param3:int) : void
      {
         var _loc4_:InvDrop = this.messages.require(55) as InvDrop;
         _loc4_.slotObject_.objectId_ = param1.objectId_;
         _loc4_.slotObject_.slotId_ = param2;
         _loc4_.slotObject_.objectType_ = param3;
         serverConnection.sendMessage(_loc4_);
         if(param2 != 254 && param2 != 255)
         {
            param1.equipment_[param2] = -1;
         }
      }
      
      override public function invDropRaw(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:InvDrop = this.messages.require(55) as InvDrop;
         _loc4_.slotObject_.objectId_ = param1;
         _loc4_.slotObject_.slotId_ = param2;
         _loc4_.slotObject_.objectType_ = param3;
         serverConnection.sendMessage(_loc4_);
      }
      
      override public function useItem(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:Number, param7:int) : void
      {
         var _loc8_:* = null;
         if(Parameters.data.fameBlockAbility && param2 == this.playerId_ && param3 == 1)
         {
            this.player.textNotification("Ignored ability use, Mundane enabled",14835456);
            return;
         }
         if(Parameters.data.fameBlockThirsty && param2 == this.playerId_ && param3 > 3 && param3 < 254)
         {
            _loc8_ = ObjectLibrary.propsLibrary_[this.player.equipment_[param3]];
            if(_loc8_ && _loc8_.isPotion_)
            {
               this.player.textNotification("Ignored potion use, Thirsty enabled",14835456);
               return;
            }
         }
         var _loc9_:UseItem = this.messages.require(11) as UseItem;
         _loc9_.time_ = param1;
         _loc9_.slotObject_.objectId_ = param2;
         _loc9_.slotObject_.slotId_ = param3;
         _loc9_.slotObject_.objectType_ = param4;
         _loc9_.itemUsePos_.x_ = param5;
         _loc9_.itemUsePos_.y_ = param6;
         _loc9_.useType_ = param7;
         serverConnection.sendMessage(_loc9_);
      }
      
      override public function useItem_new(param1:GameObject, param2:int) : Boolean
      {
         var _loc3_:* = null;
         if(Parameters.data.fameBlockAbility && param1.objectId_ == this.playerId_ && param2 == 1)
         {
            this.player.textNotification("Ignored ability use, Mundane enabled",14835456);
            return false;
         }
         if(Parameters.data.fameBlockThirsty && param1.objectId_ == this.playerId_ && param2 > 3 && param2 < 254)
         {
            _loc3_ = ObjectLibrary.propsLibrary_[param1.equipment_[param2]];
            if(_loc3_ && _loc3_.isPotion_)
            {
               this.player.textNotification("Ignored potion use, Thirsty enabled",14835456);
               return false;
            }
         }
         if(param1 == null || param1.equipment_ == null)
         {
            return false;
         }
         var _loc5_:int = param1.equipment_[param2];
         var _loc4_:XML = ObjectLibrary.xmlLibrary_[_loc5_];
         if(_loc4_ && !param1.isPaused && ("Consumable" in _loc4_ || "InvUse" in _loc4_))
         {
            if(!this.validStatInc(_loc5_,param1))
            {
               this.addTextLine.dispatch(ChatMessage.make("",_loc4_.attribute("id") + " not consumed. Already at Max."));
               return false;
            }
            if(isStatPotion(_loc5_))
            {
               this.addTextLine.dispatch(ChatMessage.make("",_loc4_.attribute("id") + " Consumed ++"));
            }
            this.applyUseItem(param1,param2,_loc5_,_loc4_);
            if("Key" in _loc4_)
            {
               SoundEffectLibrary.play("use_key");
            }
            else
            {
               SoundEffectLibrary.play("use_potion");
            }
            return true;
         }
         if(this.swapEquip(param1,param2,_loc4_))
         {
            return true;
         }
         SoundEffectLibrary.play("error");
         return false;
      }
      
      override public function setCondition(param1:uint, param2:Number) : void
      {
         var _loc3_:SetCondition = this.messages.require(60) as SetCondition;
         _loc3_.conditionEffect_ = param1;
         _loc3_.conditionDuration_ = param2;
         serverConnection.sendMessage(_loc3_);
      }
      
      override public function teleport(param1:int) : void
      {
         if(Parameters.data.fameBlockTP)
         {
            this.player.textNotification("Ignored teleport, Boots on the Ground enabled",14835456);
            return;
         }
         var _loc2_:Teleport = this.messages.require(74) as Teleport;
         _loc2_.objectId_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function usePortal(param1:int) : void
      {
         var _loc2_:* = null;
         if(Parameters.usingPortal)
         {
            Parameters.portalID = param1;
         }
         var _loc3_:UsePortal = this.messages.require(47) as UsePortal;
         _loc3_.objectId_ = param1;
         serverConnection.sendMessage(_loc3_);
      }
      
      override public function buy(param1:int, param2:int) : void
      {
         _arg_1 = param1;
         _arg_2 = param2;
         var param1:int = _arg_1;
         var param2:int = _arg_2;
         var sellableObjectId:int = param1;
         var quantity:int = param2;
         if(outstandingBuy_)
         {
            return;
         }
         var sObj:SellableObject = gs_.map.goDict_[sellableObjectId];
         if(sObj == null)
         {
            return;
         }
         var converted:Boolean = false;
         if(sObj.currency_ == 0)
         {
            converted = gs_.model.getConverted() || this.player.credits_ > 100 || sObj.price_ > this.player.credits_;
         }
         if(sObj.soldObjectName() == "Vault.chest")
         {
            this.openDialog.dispatch(new PurchaseConfirmationDialog(function():void
            {
               buyConfirmation(sObj,converted,sellableObjectId,quantity);
            }));
         }
         else
         {
            this.buyConfirmation(sObj,converted,sellableObjectId,quantity);
         }
      }
      
      override public function buyRaw(param1:int, param2:int) : void
      {
         var _loc3_:Buy = this.messages.require(85) as Buy;
         _loc3_.objectId_ = param1;
         _loc3_.quantity_ = param2;
         serverConnection.sendMessage(_loc3_);
      }
      
      override public function editAccountList(param1:int, param2:Boolean, param3:int) : void
      {
         var _loc4_:EditAccountList = this.messages.require(27) as EditAccountList;
         _loc4_.accountListId_ = param1;
         _loc4_.add_ = param2;
         _loc4_.objectId_ = param3;
         serverConnection.sendMessage(_loc4_);
      }
      
      override public function chooseName(param1:String) : void
      {
         var _loc2_:ChooseName = this.messages.require(97) as ChooseName;
         _loc2_.name_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function createGuild(param1:String) : void
      {
         var _loc2_:CreateGuild = this.messages.require(59) as CreateGuild;
         _loc2_.name_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function guildRemove(param1:String) : void
      {
         var _loc2_:GuildRemove = this.messages.require(15) as GuildRemove;
         _loc2_.name_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function guildInvite(param1:String) : void
      {
         var _loc2_:GuildInvite = this.messages.require(104) as GuildInvite;
         _loc2_.name_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function requestTrade(param1:String) : void
      {
         var _loc2_:RequestTrade = this.messages.require(5) as RequestTrade;
         _loc2_.name_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function changeTrade(param1:Vector.<Boolean>) : void
      {
         var _loc2_:ChangeTrade = this.messages.require(56) as ChangeTrade;
         _loc2_.offer_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function acceptTrade(param1:Vector.<Boolean>, param2:Vector.<Boolean>) : void
      {
         var _loc3_:AcceptTrade = this.messages.require(36) as AcceptTrade;
         _loc3_.myOffer_ = param1;
         _loc3_.yourOffer_ = param2;
         serverConnection.sendMessage(_loc3_);
      }
      
      override public function cancelTrade() : void
      {
         serverConnection.sendMessage(this.messages.require(91));
      }
      
      override public function checkCredits() : void
      {
         serverConnection.sendMessage(this.messages.require(102));
      }
      
      override public function escape() : void
      {
         if(this.playerId_ == -1)
         {
            return;
         }
         if(gs_.map && gs_.map.name_ == "Arena")
         {
            serverConnection.sendMessage(this.messages.require(80));
         }
         else
         {
            this.isNexusing = true;
            serverConnection.sendMessage(this.messages.require(105));
            this.showHideKeyUISignal.dispatch(false);
         }
      }
      
      override public function gotoQuestRoom() : void
      {
         serverConnection.sendMessage(this.messages.require(48));
      }
      
      override public function joinGuild(param1:String) : void
      {
         var _loc2_:JoinGuild = this.messages.require(7) as JoinGuild;
         _loc2_.guildName_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function changeGuildRank(param1:String, param2:int) : void
      {
         var _loc3_:ChangeGuildRank = this.messages.require(37) as ChangeGuildRank;
         _loc3_.name_ = param1;
         _loc3_.guildRank_ = param2;
         serverConnection.sendMessage(_loc3_);
      }
      
      override public function changePetSkin(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:ChangePetSkin = this.messages.require(33) as ChangePetSkin;
         _loc4_.petId = param1;
         _loc4_.skinType = param2;
         _loc4_.currency = param3;
         serverConnection.sendMessage(_loc4_);
      }
      
      override public function fakeDeath() : void
      {
         this.addTextLine.dispatch(ChatMessage.make("",this.player.name_ + " died at level " + this.player.level_ + ", killed by Epic Prank"));
         var _loc1_:BitmapData = new BitmapData(gs_.stage.stageWidth,gs_.stage.stageHeight,true,0);
         _loc1_.draw(gs_);
         setBackground(_loc1_);
         this.escape();
         this.disconnect();
      }
      
      override public function questFetch() : void
      {
         serverConnection.sendMessage(this.messages.require(98));
      }
      
      override public function questRedeem(param1:String, param2:Vector.<SlotObjectData>, param3:int = -1) : void
      {
         var _loc4_:QuestRedeem = this.messages.require(58) as QuestRedeem;
         _loc4_.questID = param1;
         _loc4_.item = param3;
         _loc4_.slots = param2;
         serverConnection.sendMessage(_loc4_);
      }
      
      override public function keyInfoRequest(param1:int) : void
      {
         var _loc2_:KeyInfoRequest = this.messages.require(94) as KeyInfoRequest;
         _loc2_.itemType_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      override public function petUpgradeRequest(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:PetUpgradeRequest = this.messages.require(16) as PetUpgradeRequest;
         _loc7_.objectId = param5;
         _loc7_.paymentTransType = param1;
         _loc7_.petTransType = param2;
         _loc7_.PIDOne = param3;
         _loc7_.PIDTwo = param4;
         _loc7_.slotsObject = new Vector.<SlotObjectData>();
         _loc7_.slotsObject.push(new SlotObjectData());
         _loc7_.slotsObject[0].objectId_ = this.playerId_;
         _loc7_.slotsObject[0].slotId_ = param6;
         if(this.player.equipment_.length >= param6)
         {
            _loc7_.slotsObject[0].objectType_ = this.player.equipment_[param6];
         }
         else
         {
            _loc7_.slotsObject[0].objectType_ = -1;
         }
         this.serverConnection.sendMessage(_loc7_);
      }
      
      override public function isConnected() : Boolean
      {
         return serverConnection.isConnected();
      }
      
      override public function reskin(param1:Player, param2:int) : void
      {
         var _loc3_:Reskin = this.messages.require(51) as Reskin;
         _loc3_.skinID = param2;
         _loc3_.player = param1;
         serverConnection.sendMessage(_loc3_);
      }
      
      override public function resetDailyQuests() : void
      {
         var _loc1_:ResetDailyQuests = this.messages.require(52) as ResetDailyQuests;
         serverConnection.sendMessage(_loc1_);
      }
      
      public function addServerConnectionListeners() : void
      {
         serverConnection.connected.add(this.onConnected);
         serverConnection.closed.add(this.onClosed);
         serverConnection.error.add(this.onError);
      }
      
      public function mapMessages() : void
      {
         var _loc1_:MessageMap = this.injector.getInstance(MessageMap);
         _loc1_.map(61).toMessage(Create);
         _loc1_.map(30).toMessage(PlayerShoot);
         _loc1_.map(42).toMessage(Move);
         _loc1_.map(10).toMessage(PlayerText);
         _loc1_.map(81).toMessage(Message);
         _loc1_.map(19).toMessage(InvSwap);
         _loc1_.map(11).toMessage(UseItem);
         _loc1_.map(1).toMessage(Hello);
         _loc1_.map(55).toMessage(InvDrop);
         _loc1_.map(31).toMessage(Pong);
         _loc1_.map(57).toMessage(Load);
         _loc1_.map(60).toMessage(SetCondition);
         _loc1_.map(74).toMessage(Teleport);
         _loc1_.map(47).toMessage(UsePortal);
         _loc1_.map(85).toMessage(Buy);
         _loc1_.map(90).toMessage(PlayerHit);
         _loc1_.map(25).toMessage(EnemyHit);
         _loc1_.map(89).toMessage(AoeAck);
         _loc1_.map(100).toMessage(ShootAck);
         _loc1_.map(20).toMessage(OtherHit);
         _loc1_.map(40).toMessage(SquareHit);
         _loc1_.map(65).toMessage(GotoAck);
         _loc1_.map(103).toMessage(GroundDamage);
         _loc1_.map(97).toMessage(ChooseName);
         _loc1_.map(59).toMessage(CreateGuild);
         _loc1_.map(15).toMessage(GuildRemove);
         _loc1_.map(104).toMessage(GuildInvite);
         _loc1_.map(5).toMessage(RequestTrade);
         _loc1_.map(56).toMessage(ChangeTrade);
         _loc1_.map(36).toMessage(AcceptTrade);
         _loc1_.map(91).toMessage(CancelTrade);
         _loc1_.map(102).toMessage(CheckCredits);
         _loc1_.map(105).toMessage(Escape);
         _loc1_.map(48).toMessage(GoToQuestRoom);
         _loc1_.map(7).toMessage(JoinGuild);
         _loc1_.map(37).toMessage(ChangeGuildRank);
         _loc1_.map(27).toMessage(EditAccountList);
         _loc1_.map(24).toMessage(ActivePetUpdateRequest);
         _loc1_.map(16).toMessage(PetUpgradeRequest);
         _loc1_.map(17).toMessage(EnterArena);
         _loc1_.map(80).toMessage(OutgoingMessage);
         _loc1_.map(98).toMessage(OutgoingMessage);
         _loc1_.map(58).toMessage(QuestRedeem);
         _loc1_.map(52).toMessage(ResetDailyQuests);
         _loc1_.map(94).toMessage(KeyInfoRequest);
         _loc1_.map(53).toMessage(ReskinPet);
         _loc1_.map(3).toMessage(ClaimDailyRewardMessage);
         _loc1_.map(33).toMessage(ChangePetSkin);
         _loc1_.map(114).toMessage(IncomingMessage);
         _loc1_.map(0).toMessage(Failure).toMethod(this.onFailure);
         _loc1_.map(101).toMessage(CreateSuccess).toMethod(this.onCreateSuccess);
         _loc1_.map(12).toMessage(ServerPlayerShoot).toMethod(this.onServerPlayerShoot);
         _loc1_.map(75).toMessage(Damage).toMethod(this.onDamage);
         _loc1_.map(62).toMessage(Update).toMethod(this.onUpdate);
         _loc1_.map(67).toMessage(Notification).toMethod(this.onNotification);
         _loc1_.map(66).toMessage(GlobalNotification).toMethod(this.onGlobalNotification);
         _loc1_.map(9).toMessage(NewTick).toMethod(this.onNewTick);
         _loc1_.map(13).toMessage(ShowEffect).toMethod(this.onShowEffect);
         _loc1_.map(18).toMessage(Goto).toMethod(this.onGoto);
         _loc1_.map(95).toMessage(InvResult).toMethod(this.onInvResult);
         _loc1_.map(45).toMessage(Reconnect).toMethod(this.onReconnect);
         _loc1_.map(8).toMessage(Ping).toMethod(this.onPing);
         _loc1_.map(92).toMessage(MapInfo).toMethod(this.onMapInfo);
         _loc1_.map(83).toMessage(Pic).toMethod(this.onPic);
         _loc1_.map(46).toMessage(Death).toMethod(this.onDeath);
         _loc1_.map(22).toMessage(BuyResult).toMethod(this.onBuyResult);
         _loc1_.map(64).toMessage(Aoe).toMethod(this.onAoe);
         _loc1_.map(99).toMessage(AccountList).toMethod(this.onAccountList);
         _loc1_.map(82).toMessage(QuestObjId).toMethod(this.onQuestObjId);
         _loc1_.map(21).toMessage(NameResult).toMethod(this.onNameResult);
         _loc1_.map(26).toMessage(GuildResult).toMethod(this.onGuildResult);
         _loc1_.map(49).toMessage(AllyShoot).toMethod(this.onAllyShoot);
         _loc1_.map(35).toMessage(EnemyShoot).toMethod(this.onEnemyShoot);
         _loc1_.map(88).toMessage(TradeRequested).toMethod(this.onTradeRequested);
         _loc1_.map(86).toMessage(TradeStart).toMethod(this.onTradeStart);
         _loc1_.map(28).toMessage(TradeChanged).toMethod(this.onTradeChanged);
         _loc1_.map(34).toMessage(TradeDone).toMethod(this.onTradeDone);
         _loc1_.map(14).toMessage(TradeAccepted).toMethod(this.onTradeAccepted);
         _loc1_.map(69).toMessage(ClientStat).toMethod(this.onClientStat);
         _loc1_.map(106).toMessage(File).toMethod(this.onFile);
         _loc1_.map(77).toMessage(InvitedToGuild).toMethod(this.onInvitedToGuild);
         _loc1_.map(38).toMessage(PlaySound).toMethod(this.onPlaySound);
         _loc1_.map(76).toMessage(ActivePet).toMethod(this.onActivePetUpdate);
         _loc1_.map(41).toMessage(NewAbilityMessage).toMethod(this.onNewAbility);
         _loc1_.map(78).toMessage(PetYard).toMethod(this.onPetYardUpdate);
         _loc1_.map(87).toMessage(EvolvedPetMessage).toMethod(this.onEvolvedPet);
         _loc1_.map(4).toMessage(DeletePetMessage).toMethod(this.onDeletePet);
         _loc1_.map(23).toMessage(HatchPetMessage).toMethod(this.onHatchPet);
         _loc1_.map(50).toMessage(ImminentArenaWave).toMethod(this.onImminentArenaWave);
         _loc1_.map(68).toMessage(ArenaDeath).toMethod(this.onArenaDeath);
         _loc1_.map(39).toMessage(VerifyEmail).toMethod(this.onVerifyEmail);
         _loc1_.map(107).toMessage(ReskinUnlock).toMethod(this.onReskinUnlock);
         _loc1_.map(79).toMessage(PasswordPrompt).toMethod(this.onPasswordPrompt);
         _loc1_.map(6).toMessage(QuestFetchResponse).toMethod(this.onQuestFetchResponse);
         _loc1_.map(96).toMessage(QuestRedeemResponse).toMethod(this.onQuestRedeemResponse);
         _loc1_.map(63).toMessage(KeyInfoResponse).toMethod(this.onKeyInfoResponse);
         _loc1_.map(93).toMessage(ClaimDailyRewardResponse).toMethod(this.onLoginRewardResponse);
         _loc1_.map(84).toMessage(RealmHeroesResponse).toMethod(this.onRealmHeroesResponse);
         _loc1_.map(108).toMessage(NewCharacterInformation).toMethod(this.onNewCharacterInformation);
         _loc1_.map(109).toMessage(UnlockInformation).toMethod(this.onUnlockInformation);
         _loc1_.map(112).toMessage(QueueInformation).toMethod(this.onQueuePosition);
      }
      
      private function onNewCharacterInformation(param1:NewCharacterInformation) : void
      {
      }
      
      private function onUnlockInformation(param1:UnlockInformation) : void
      {
      }
      
      private function onQueuePosition(param1:QueueInformation) : void
      {
      }
      
      public function aoeAck(param1:int, param2:Number, param3:Number) : void
      {
         var _loc4_:AoeAck = this.messages.require(89) as AoeAck;
         _loc4_.time_ = param1;
         _loc4_.position_.x_ = param2;
         _loc4_.position_.y_ = param3;
         serverConnection.sendMessage(_loc4_);
      }
      
      public function shootAck(param1:int) : void
      {
         var _loc2_:ShootAck = this.messages.require(100) as ShootAck;
         _loc2_.time_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      public function swapEquip(param1:GameObject, param2:int, param3:XML) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc8_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         if(param3 && !param1.isPaused && "SlotType" in param3)
         {
            _loc8_ = param3.SlotType;
            _loc6_ = param1.slotTypes_.slice(0,4);
            _loc7_ = 0;
            _loc5_ = 0;
            _loc4_ = _loc6_;
            var _loc11_:int = 0;
            var _loc10_:* = _loc6_;
            for each(_loc9_ in _loc6_)
            {
               if(_loc9_ == _loc8_)
               {
                  this.swapItems(param1,_loc7_,param2);
                  return true;
               }
               _loc7_++;
            }
         }
         return false;
      }
      
      public function swapItems(param1:GameObject, param2:int, param3:int) : void
      {
         var _loc4_:Vector.<int> = param1.equipment_;
         this.invSwap(param1 as Player,param1,param2,_loc4_[param2],param1,param3,_loc4_[param3]);
      }
      
      public function move(param1:int, param2:uint, param3:Player) : void
      {
         var _loc7_:* = 0;
         var _loc5_:int = 0;
         var _loc9_:* = -1;
         var _loc6_:* = -1;
         if(param3 && !param3.isPaused)
         {
            _loc9_ = Number(param3.x_);
            _loc6_ = Number(param3.y_);
         }
         var _loc8_:Move = this.messages.require(42) as Move;
         _loc8_.tickId_ = param1;
         _loc8_.time_ = this.gs_.lastUpdate_;
         _loc8_.serverRealTimeMSofLastNewTick_ = param2;
         _loc8_.newPosition_.x_ = _loc9_;
         _loc8_.newPosition_.y_ = _loc6_;
         var _loc4_:MoveRecords = this.gs_.moveRecords_;
         _loc8_.records_.length = 0;
         if(_loc4_.lastClearTime_ >= 0 && _loc8_.time_ - _loc4_.lastClearTime_ > 125)
         {
            _loc7_ = uint(Math.min(10,_loc4_.records_.length));
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               if(_loc4_.records_[_loc5_].time_ < _loc8_.time_ - 25)
               {
                  _loc8_.records_.push(_loc4_.records_[_loc5_]);
                  _loc5_++;
                  continue;
               }
               break;
            }
         }
         _loc4_.clear(_loc8_.time_);
         this.serverConnection.sendMessage(_loc8_);
         if(param3)
         {
            param3.onMove();
         }
      }
      
      public function gotoAck(param1:int) : void
      {
         var _loc2_:GotoAck = this.messages.require(65) as GotoAck;
         _loc2_.time_ = param1;
         serverConnection.sendMessage(_loc2_);
      }
      
      public function setPlayerSkinTemplate(param1:Player, param2:int) : void
      {
         var _loc3_:Reskin = this.messages.require(51) as Reskin;
         _loc3_.skinID = param2;
         _loc3_.player = param1;
         _loc3_.consume();
      }
      
      public function setBackground(param1:BitmapData) : void
      {
         this.gs_.deathOverlay.bitmapData = param1;
         var _loc2_:GTween = new GTween(this.gs_.deathOverlay,2,{"alpha":0});
         _loc2_.onComplete = this.onFadeComplete;
         SoundEffectLibrary.play("death_screen");
      }
      
      public function onFadeComplete(param1:GTween) : void
      {
         this.gs_.removeChild(this.gs_.deathOverlay);
         this.gs_.deathOverlay = null;
         this.gs_.deathOverlay = new Bitmap();
         this.gs_.addChild(this.gs_.deathOverlay);
         this.gs_.dispatchEvent(Parameters.reconNexus);
      }
      
      private function getPetUpdater() : void
      {
         this.injector.map(AGameSprite).toValue(gs_);
         this.petUpdater = this.injector.getInstance(PetUpdater);
         this.injector.unmap(AGameSprite);
      }
      
      private function removeServerConnectionListeners() : void
      {
         serverConnection.connected.remove(this.onConnected);
         serverConnection.closed.remove(this.onClosed);
         serverConnection.error.remove(this.onError);
      }
      
      private function onHatchPet(param1:HatchPetMessage) : void
      {
         var _loc2_:HatchPetSignal = this.injector.getInstance(HatchPetSignal);
         var _loc3_:HatchPetVO = new HatchPetVO();
         _loc3_.itemType = param1.itemType;
         _loc3_.petSkin = param1.petSkin;
         _loc3_.petName = param1.petName;
         _loc2_.dispatch(_loc3_);
      }
      
      private function onDeletePet(param1:DeletePetMessage) : void
      {
         var _loc2_:DeletePetSignal = this.injector.getInstance(DeletePetSignal);
         this.injector.getInstance(PetsModel).deletePet(param1.petID);
         _loc2_.dispatch(param1.petID);
      }
      
      private function onNewAbility(param1:NewAbilityMessage) : void
      {
         var _loc2_:NewAbilitySignal = this.injector.getInstance(NewAbilitySignal);
         _loc2_.dispatch(param1.type);
      }
      
      private function onPetYardUpdate(param1:PetYard) : void
      {
         var _loc2_:UpdatePetYardSignal = StaticInjectorContext.getInjector().getInstance(UpdatePetYardSignal);
         _loc2_.dispatch(param1.type);
      }
      
      private function onEvolvedPet(param1:EvolvedPetMessage) : void
      {
         var _loc2_:EvolvedMessageHandler = this.injector.getInstance(EvolvedMessageHandler);
         _loc2_.handleMessage(param1);
      }
      
      private function onActivePetUpdate(param1:ActivePet) : void
      {
         this.updateActivePet.dispatch(param1.instanceID);
         var _loc2_:String = param1.instanceID > 0?this.petsModel.getPet(param1.instanceID).name:"";
         var _loc3_:String = param1.instanceID < 0?"Pets.notFollowing":"Pets.following";
         this.addTextLine.dispatch(ChatMessage.make("",_loc3_,-1,-1,"",false,{"petName":_loc2_}));
      }
      
      private function unmapMessages() : void
      {
         var _loc1_:MessageMap = this.injector.getInstance(MessageMap);
         _loc1_.unmap(61);
         _loc1_.unmap(30);
         _loc1_.unmap(42);
         _loc1_.unmap(10);
         _loc1_.unmap(81);
         _loc1_.unmap(19);
         _loc1_.unmap(11);
         _loc1_.unmap(1);
         _loc1_.unmap(55);
         _loc1_.unmap(31);
         _loc1_.unmap(57);
         _loc1_.unmap(60);
         _loc1_.unmap(74);
         _loc1_.unmap(47);
         _loc1_.unmap(85);
         _loc1_.unmap(90);
         _loc1_.unmap(25);
         _loc1_.unmap(89);
         _loc1_.unmap(100);
         _loc1_.unmap(20);
         _loc1_.unmap(40);
         _loc1_.unmap(65);
         _loc1_.unmap(103);
         _loc1_.unmap(97);
         _loc1_.unmap(59);
         _loc1_.unmap(15);
         _loc1_.unmap(104);
         _loc1_.unmap(5);
         _loc1_.unmap(56);
         _loc1_.unmap(36);
         _loc1_.unmap(91);
         _loc1_.unmap(102);
         _loc1_.unmap(105);
         _loc1_.unmap(48);
         _loc1_.unmap(7);
         _loc1_.unmap(37);
         _loc1_.unmap(27);
         _loc1_.unmap(0);
         _loc1_.unmap(101);
         _loc1_.unmap(12);
         _loc1_.unmap(75);
         _loc1_.unmap(62);
         _loc1_.unmap(67);
         _loc1_.unmap(66);
         _loc1_.unmap(9);
         _loc1_.unmap(13);
         _loc1_.unmap(18);
         _loc1_.unmap(95);
         _loc1_.unmap(45);
         _loc1_.unmap(8);
         _loc1_.unmap(92);
         _loc1_.unmap(83);
         _loc1_.unmap(46);
         _loc1_.unmap(22);
         _loc1_.unmap(64);
         _loc1_.unmap(99);
         _loc1_.unmap(82);
         _loc1_.unmap(21);
         _loc1_.unmap(26);
         _loc1_.unmap(49);
         _loc1_.unmap(35);
         _loc1_.unmap(88);
         _loc1_.unmap(86);
         _loc1_.unmap(28);
         _loc1_.unmap(34);
         _loc1_.unmap(14);
         _loc1_.unmap(69);
         _loc1_.unmap(106);
         _loc1_.unmap(77);
         _loc1_.unmap(38);
         _loc1_.unmap(84);
      }
      
      private function encryptConnection() : void
      {
         serverConnection.setOutgoingCipher(Crypto.getCipher("rc4",Parameters.RANDOM1_BA));
         serverConnection.setIncomingCipher(Crypto.getCipher("rc4",Parameters.RANDOM2_BA));
      }
      
      private function setChatEncryption() : void
      {
         this.chatServerConnection.setOutgoingCipher(Crypto.getCipher("rc4",Parameters.RANDOM1_BA));
         this.chatServerConnection.setIncomingCipher(Crypto.getCipher("rc4",Parameters.RANDOM2_BA));
      }
      
      private function create() : void
      {
         var _loc2_:CharacterClass = this.classesModel.getSelected();
         var _loc1_:Create = this.messages.require(61) as Create;
         _loc1_.classType = _loc2_.id;
         _loc1_.skinType = _loc2_.skins.getSelectedSkin().id;
         _loc1_.isChallenger = this.seasonalEventModel.isChallenger == 1;
         serverConnection.sendMessage(_loc1_);
         Parameters.Cache_CHARLIST_valid = false;
         Parameters.lockRecon = true;
      }
      
      private function load() : void
      {
         var _loc1_:Load = this.messages.require(57) as Load;
         _loc1_.charId_ = charId_;
         _loc1_.isFromArena_ = isFromArena_;
         _loc1_.isChallenger_ = this.seasonalEventModel.isChallenger == 1;
         serverConnection.sendMessage(_loc1_);
         if(isFromArena_)
         {
            this.openDialog.dispatch(new BattleSummaryDialog());
         }
         Parameters.lockRecon = true;
      }
      
      private function validStatInc(param1:int, param2:GameObject) : Boolean
      {
         var _loc4_:* = undefined;
         var _loc7_:Player = null;
         var _loc5_:Boolean = false;
         var _loc3_:* = param1;
         var _loc6_:* = param2;
         try
         {
            if(_loc6_ is Player)
            {
               _loc7_ = _loc6_ as Player;
            }
            else
            {
               _loc7_ = this.player;
            }
            if((_loc3_ == 2591 || _loc3_ == 5465 || _loc3_ == 9064 || _loc3_ == 9729) && _loc7_.attackMax_ == _loc7_.attack_ - _loc7_.attackBoost_ - _loc7_.exaltedAttack || (_loc3_ == 2592 || _loc3_ == 5466 || _loc3_ == 9065 || _loc3_ == 9727) && _loc7_.defenseMax_ == _loc7_.defense_ - _loc7_.defenseBoost_ - _loc7_.exaltedDefense || (_loc3_ == 2593 || _loc3_ == 5467 || _loc3_ == 9066 || _loc3_ == 9726) && _loc7_.speedMax_ == _loc7_.speed_ - _loc7_.speedBoost_ - _loc7_.exaltedSpeed || (_loc3_ == 2612 || _loc3_ == 5468 || _loc3_ == 9067 || _loc3_ == 9724) && _loc7_.vitalityMax_ == _loc7_.vitality_ - _loc7_.vitalityBoost_ - _loc7_.exaltedVitality || (_loc3_ == 2613 || _loc3_ == 5469 || _loc3_ == 9068 || _loc3_ == 9725) && _loc7_.wisdomMax_ == _loc7_.wisdom - _loc7_.wisdomBoost_ - _loc7_.exaltedWisdom || (_loc3_ == 2636 || _loc3_ == 5470 || _loc3_ == 9069 || _loc3_ == 9728) && _loc7_.dexterityMax_ == _loc7_.dexterity_ - _loc7_.dexterityBoost_ - _loc7_.exaltedDexterity || (_loc3_ == 2793 || _loc3_ == 5471 || _loc3_ == 9070 || _loc3_ == 9731) && _loc7_.maxHPMax_ == _loc7_.maxHP_ - _loc7_.maxHPBoost_ - _loc7_.exaltedHealth || (_loc3_ == 2794 || _loc3_ == 5472 || _loc3_ == 9071 || _loc3_ == 9730) && _loc7_.maxMPMax_ == _loc7_.maxMP_ - _loc7_.maxMPBoost_ - _loc7_.exaltedMana)
            {
               _loc5_ = false;
               _loc4_ = _loc5_;
               var _loc9_:* = _loc4_;
               return _loc9_;
            }
         }
         catch(err:Error)
         {
            logger.error("PROBLEM IN STAT INC " + err.getStackTrace());
         }
         return true;
      }
      
      private function applyUseItem(param1:GameObject, param2:int, param3:int, param4:XML) : void
      {
         var _loc5_:UseItem = this.messages.require(11) as UseItem;
         _loc5_.time_ = getTimer();
         _loc5_.slotObject_.objectId_ = param1.objectId_;
         _loc5_.slotObject_.slotId_ = param2;
         _loc5_.slotObject_.objectType_ = param3;
         _loc5_.itemUsePos_.x_ = 0;
         _loc5_.itemUsePos_.y_ = 0;
         serverConnection.sendMessage(_loc5_);
         if("Consumable" in param4)
         {
            param1.equipment_[param2] = -1;
         }
      }
      
      private function buyConfirmation(param1:SellableObject, param2:Boolean, param3:int, param4:int, param5:Boolean = false) : void
      {
         outstandingBuy_ = new OutstandingBuy(param1.soldObjectInternalName(),param1.price_,param1.currency_,param2);
         var _loc6_:Buy = this.messages.require(85) as Buy;
         _loc6_.objectId_ = param3;
         _loc6_.quantity_ = param4;
         serverConnection.sendMessage(_loc6_);
      }
      
      private function rsaEncrypt(param1:String) : String
      {
         var _loc2_:RSAKey = PEM.readRSAPublicKey("-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDCKFctVrhfF3m2Kes0FBL/JFeOcmNg9eJz8k/hQy1kadD+XFUpluRqa//Uxp2s9W2qE0EoUCu59ugcf/p7lGuL99UoSGmQEynkBvZct+/M40L0E0rZ4BVgzLOJmIbXMp0J4PnPcb6VLZvxazGcmSfjauC7F3yWYqUbZd/HCBtawwIDAQAB\n-----END PUBLIC KEY-----");
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUTFBytes(param1);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.encrypt(_loc4_,_loc3_,_loc4_.length);
         return Base64.encodeByteArray(_loc3_);
      }
      
      public function onConnected() : void
      {
         this.isNexusing = false;
         this.encryptConnection();
         var _loc1_:Account = StaticInjectorContext.getInjector().getInstance(Account);
         this.addTextLine.dispatch(ChatMessage.make("*Client*","chat.connected"));
         var _loc3_:Hello = this.messages.require(1) as Hello;
         _loc3_.buildVersion_ = "1.1.0.2";
         var _loc2_:int = gameId_;
         if(Parameters.data.vaultOnly && _loc2_ == -2)
         {
            _loc2_ = -8;
         }
         _loc3_.gameId_ = _loc2_;
         _loc3_.guid_ = this.rsaEncrypt(_loc1_.getUserId());
         _loc3_.password_ = this.rsaEncrypt(_loc1_.getPassword());
         _loc3_.secret_ = this.rsaEncrypt(_loc1_.getSecret());
         _loc3_.keyTime_ = keyTime_;
         _loc3_.key_.length = 0;
         this.key_ && _loc3_.key_.writeBytes(this.key_);
         _loc3_.mapJSON_ = mapJSON_ == null?"":this.mapJSON_;
         _loc3_.entrytag_ = _loc1_.getEntryTag();
         _loc3_.gameNet = "rotmg";
         _loc3_.gameNetUserId = _loc1_.gameNetworkUserId();
         _loc3_.playPlatform = "rotmg";
         _loc3_.platformToken = _loc1_.getPlatformToken();
         _loc3_.userToken = _loc1_.getToken();
         _loc3_.previousConnectionGuid = connectionGuid;
         serverConnection.sendMessage(_loc3_);
      }
      
      private function onCreateSuccess(param1:CreateSuccess) : void
      {
         this.playerId_ = param1.objectId_;
         charId_ = param1.charId_;
         gs_.initialize();
         createCharacter_ = false;
         Parameters.lockRecon = false;
         this.gs_.map.party_.setExaltLists();
      }
      
      private function onDamage(param1:Damage) : void
      {
         var _loc5_:int = 0;
         var _loc7_:* = false;
         var _loc4_:* = undefined;
         var _loc6_:* = undefined;
         var _loc2_:* = null;
         if(Parameters.lowCPUMode)
         {
            if(param1.objectId_ != this.player.objectId_ || param1.targetId_ != this.player.objectId_)
            {
               return;
            }
         }
         var _loc8_:AbstractMap = gs_.map;
         if(param1.objectId_ >= 0 && param1.bulletId_ > 0)
         {
            _loc5_ = Projectile.findObjId(param1.objectId_,param1.bulletId_);
            _loc2_ = _loc8_.boDict_[_loc5_] as Projectile;
            if(_loc2_ && !_loc2_.projProps_.multiHit_)
            {
               _loc8_.removeObj(_loc5_);
            }
         }
         var _loc3_:GameObject = _loc8_.goDict_[param1.targetId_];
         if(_loc3_ && _loc3_.props_.isEnemy_)
         {
            _loc7_ = param1.objectId_ == this.player.objectId_;
            _loc3_.damage(_loc7_,param1.damageAmount_,param1.effects_,param1.kill_,_loc2_,param1.armorPierce_);
            if(_loc7_)
            {
               if(isNaN(Parameters.dmgCounter[param1.targetId_]))
               {
                  Parameters.dmgCounter[param1.targetId_] = 0;
               }
               _loc4_ = param1.targetId_;
               _loc6_ = Parameters.dmgCounter[_loc4_] + param1.damageAmount_;
               Parameters.dmgCounter[_loc4_] = _loc6_;
            }
         }
      }
      
      private function onServerPlayerShoot(param1:ServerPlayerShoot) : void
      {
         var _loc5_:* = param1.ownerId_ == this.playerId_;
         var _loc2_:GameObject = gs_.map.goDict_[param1.ownerId_];
         if(_loc2_ == null || _loc2_.dead_)
         {
            if(_loc5_)
            {
               this.shootAck(-1);
            }
            return;
         }
         if(_loc2_.objectId_ != this.playerId_ && Parameters.data.disableAllyShoot)
         {
            return;
         }
         var _loc4_:Projectile = FreeList.newObject(Projectile) as Projectile;
         var _loc3_:Player = _loc2_ as Player;
         if(_loc3_)
         {
            _loc4_.reset(param1.containerType_,0,param1.ownerId_,param1.bulletId_,param1.angle_,gs_.lastUpdate_,_loc3_.projectileIdSetOverrideNew,_loc3_.projectileIdSetOverrideOld);
         }
         else
         {
            _loc4_.reset(param1.containerType_,0,param1.ownerId_,param1.bulletId_,param1.angle_,gs_.lastUpdate_);
         }
         _loc4_.setDamage(param1.damage_);
         gs_.map.addObj(_loc4_,param1.startingPos_.x_,param1.startingPos_.y_);
         if(_loc5_)
         {
            this.shootAck(gs_.lastUpdate_);
            if(!_loc4_.update(_loc4_.startTime_,0))
            {
               gs_.map.removeObj(_loc4_.objectId_);
            }
         }
      }
      
      private function onAllyShoot(param1:AllyShoot) : void
      {
         var _loc6_:* = null;
         var _loc4_:Player = null;
         var _loc3_:* = NaN;
         var _loc2_:* = NaN;
         var _loc5_:GameObject = this.gs_.map.goDict_[param1.ownerId_];
         if(_loc5_)
         {
            if(_loc5_.dead_)
            {
               return;
            }
            if(Parameters.data.disableAllyShoot == 1)
            {
               return;
            }
            _loc5_.setAttack(param1.containerType_,param1.angle_);
            if(Parameters.data.disableAllyShoot == 2)
            {
               return;
            }
            _loc6_ = FreeList.newObject(Projectile) as Projectile;
            _loc4_ = _loc5_ as Player;
            if(_loc4_)
            {
               _loc3_ = Number(_loc4_.projectileLifeMult);
               _loc2_ = Number(_loc4_.projectileSpeedMult);
               if(!param1.bard_)
               {
                  _loc3_ = 1;
                  _loc2_ = 1;
               }
               _loc6_.reset(param1.containerType_,0,param1.ownerId_,param1.bulletId_,param1.angle_,this.gs_.lastUpdate_,_loc4_.projectileIdSetOverrideNew,_loc4_.projectileIdSetOverrideOld,_loc3_,_loc2_);
            }
            else
            {
               _loc6_.reset(param1.containerType_,0,param1.ownerId_,param1.bulletId_,param1.angle_,this.gs_.lastUpdate_);
            }
            this.gs_.map.addObj(_loc6_,_loc5_.x_,_loc5_.y_);
         }
      }
      
      private function onReskinUnlock(param1:ReskinUnlock) : void
      {
         var _loc4_:int = 0;
         var _loc6_:* = undefined;
         var _loc3_:* = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         if(param1.isPetSkin == 0)
         {
            _loc4_ = 0;
            _loc6_ = this.model.player.lockedSlot;
            var _loc8_:int = 0;
            var _loc7_:* = this.model.player.lockedSlot;
            for(_loc3_ in this.model.player.lockedSlot)
            {
               if(this.model.player.lockedSlot[_loc3_] == param1.skinID)
               {
                  this.model.player.lockedSlot[_loc3_] = 0;
               }
            }
            _loc2_ = this.classesModel.getCharacterClass(this.model.player.objectType_).skins.getSkin(param1.skinID);
            _loc2_.setState(CharacterSkinState.OWNED);
         }
         else
         {
            _loc5_ = StaticInjectorContext.getInjector().getInstance(PetsModel);
            _loc5_.unlockSkin(param1.skinID);
         }
      }
      
      private function onEnemyShoot(param1:EnemyShoot) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Projectile = null;
         var _loc7_:Number = NaN;
         var _loc3_:GameObject = gs_.map.goDict_[param1.ownerId_];
         if(_loc3_ == null || _loc3_.dead_)
         {
            this.shootAck(-1);
            return;
         }
         if(Parameters.suicideMode)
         {
            param1.startingPos_.x_ = player.x_;
            param1.startingPos_.y_ = player.y_;
         }
         var _loc2_:ObjectProperties = ObjectLibrary.propsLibrary_[_loc3_.objectType_];
         var _loc5_:ProjectileProperties = _loc2_.projectiles_[param1.bulletType_];
         _loc6_ = 0;
         while(_loc6_ < param1.numShots_)
         {
            _loc4_ = FreeList.newObject(Projectile) as Projectile;
            _loc7_ = param1.angle_ + param1.angleInc_ * _loc6_;
            _loc4_.reset(_loc3_.objectType_,param1.bulletType_,param1.ownerId_,(param1.bulletId_ + _loc6_) % 256,_loc7_,gs_.lastUpdate_,"","",1,1,_loc2_,_loc5_);
            _loc4_.setDamage(param1.damage_);
            gs_.map.addObj(_loc4_,param1.startingPos_.x_,param1.startingPos_.y_);
            _loc6_++;
         }
         this.shootAck(gs_.lastUpdate_);
         _loc3_.setAttack(_loc3_.objectType_,param1.angle_ + param1.angleInc_ * ((param1.numShots_ - 1) * 0.5));
      }
      
      private function onTradeRequested(param1:TradeRequested) : void
      {
         if(Parameters.autoAcceptTrades || Parameters.receivingPots)
         {
            this.requestTrade(param1.name_);
            return;
         }
         if(!Parameters.data.chatTrade)
         {
            return;
         }
         if(Parameters.data.tradeWithFriends && !this.socialModel.isMyFriend(param1.name_))
         {
            return;
         }
         if(Parameters.data.showTradePopup)
         {
            gs_.hudView.interactPanel.setOverride(new TradeRequestPanel(gs_,param1.name_));
         }
         this.addTextLine.dispatch(ChatMessage.make("",param1.name_ + " wants to " + "trade with you.  Type \"/trade " + param1.name_ + "\" to trade."));
      }
      
      private function onTradeStart(param1:TradeStart) : void
      {
         gs_.hudView.startTrade(gs_,param1);
         if(Parameters.givingPotions)
         {
            this.changeTrade(Parameters.potionsToTrade);
            this.acceptTrade(Parameters.potionsToTrade,Parameters.emptyOffer);
            Parameters.givingPotions = false;
         }
      }
      
      private function onTradeChanged(param1:TradeChanged) : void
      {
         gs_.hudView.tradeChanged(param1);
         if(Parameters.receivingPots)
         {
            this.acceptTrade(Parameters.emptyOffer,param1.offer_);
            Parameters.receivingPots = false;
         }
      }
      
      private function onTradeDone(param1:TradeDone) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         gs_.hudView.tradeDone();
         var _loc2_:String = "";
         try
         {
            _loc3_ = JSON.parse(param1.description_);
            _loc2_ = _loc3_.key;
            _loc4_ = _loc3_.tokens;
         }
         catch(e:Error)
         {
         }
         this.addTextLine.dispatch(ChatMessage.make("",_loc2_,-1,-1,"",false,_loc4_));
         if(Parameters.autoDrink && param1.code_ == 0)
         {
            Parameters.watchInv = true;
         }
      }
      
      private function onTradeAccepted(param1:TradeAccepted) : void
      {
         gs_.hudView.tradeAccepted(param1);
         if(Parameters.autoAcceptTrades || Parameters.receivingPots)
         {
            acceptTrade(param1.myOffer_,param1.yourOffer_);
         }
      }
      
      private function addObject(param1:ObjectData) : void
      {
         var _loc2_:AbstractMap = gs_.map;
         var _loc3_:GameObject = ObjectLibrary.getObjectFromType(param1.objectType_);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:ObjectStatusData = param1.status_;
         _loc3_.setObjectId(_loc4_.objectId_);
         _loc2_.addObj(_loc3_,_loc4_.pos_.x_,_loc4_.pos_.y_);
         if(_loc3_ is Player)
         {
            this.handleNewPlayer(_loc3_ as Player,_loc2_);
         }
         this.processObjectStatus(_loc4_,0,-1);
         if(_loc3_.props_.static_ && _loc3_.props_.occupySquare_ && !_loc3_.props_.noMiniMap_)
         {
            this.updateGameObjectTileSignal.dispatch(_loc3_.x_,_loc3_.y_,_loc3_);
         }
      }
      
      private function handleNewPlayer(param1:Player, param2:AbstractMap) : void
      {
         this.setPlayerSkinTemplate(param1,0);
         if(param1.objectId_ == this.playerId_)
         {
            this.player = param1;
            this.model.player = param1;
            param2.player_ = param1;
            gs_.setFocus(param1);
            this.setGameFocus.dispatch(this.playerId_.toString());
         }
      }
      
      private function onUpdate(param1:Update) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Message = this.messages.require(81);
         serverConnection.queueMessage(_loc2_);
         _loc3_ = 0;
         while(_loc3_ < param1.tiles_.length)
         {
            _loc4_ = param1.tiles_[_loc3_];
            gs_.map.setGroundTile(_loc4_.x_,_loc4_.y_,_loc4_.type_);
            this.updateGroundTileSignal.dispatch(_loc4_.x_,_loc4_.y_,_loc4_.type_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.drops_.length)
         {
            gs_.map.removeObj(param1.drops_[_loc3_]);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.newObjs_.length)
         {
            this.addObject(param1.newObjs_[_loc3_]);
            _loc3_++;
         }
         gs_.map.calcVulnerables();
      }
      
      private function onNotification(param1:Notification) : void
      {
         var _loc2_:LineBuilder = null;
         var _loc3_:GameObject = this.gs_.map.goDict_[param1.objectId_];
         if(_loc3_)
         {
            _loc2_ = LineBuilder.fromJSON(param1.message);
            if(Parameters.data.ignoreStatusText && _loc2_.key == "server.no_effect")
            {
               return;
            }
            var _loc4_:* = _loc2_.key;
            switch(_loc4_)
            {
               case "server.plus_symbol":
                  param1.message = "+" + _loc2_.tokens.amount;
                  break;
               case "server.no_effect":
                  param1.message = "No Effect";
                  break;
               case "server.class_quest_complete":
                  param1.message = "Class Quest Completed!";
                  break;
               case "server.quest_complete":
                  param1.message = "Quest Complete!";
                  break;
               case "blank":
                  param1.message = _loc2_.tokens.data;
            }
            if(_loc3_.objectId_ == this.player.objectId_)
            {
               if(param1.message == "Quest Complete!")
               {
                  this.gs_.map.quest_.completed();
               }
               else if(_loc2_.key == "server.plus_symbol" && param1.color_ == 65280)
               {
                  this.player.addHealth(_loc2_.tokens.amount);
               }
               this.makeNotification(param1.message,_loc3_,param1.color_,1000);
            }
            else if(_loc3_.props_.isEnemy_ || !Parameters.data.noAllyNotifications)
            {
               this.makeNotification(param1.message,_loc3_,param1.color_,1000);
            }
         }
      }
      
      private function makeNotification(param1:String, param2:GameObject, param3:uint, param4:int) : void
      {
         var _loc5_:CharacterStatusText = new CharacterStatusText(param2,param3,param4);
         _loc5_.setText(param1);
         gs_.map.mapOverlay_.addStatusText(_loc5_);
      }
      
      private function onGlobalNotification(param1:GlobalNotification) : void
      {
         var _loc2_:* = param1.text;
         var _loc3_:* = _loc2_;
         switch(_loc3_)
         {
            case "yellow":
               ShowKeySignal.instance.dispatch(Key.YELLOW);
               return;
            case "red":
               ShowKeySignal.instance.dispatch(Key.RED);
               return;
            case "green":
               ShowKeySignal.instance.dispatch(Key.GREEN);
               return;
            case "purple":
               ShowKeySignal.instance.dispatch(Key.PURPLE);
               return;
            case "showKeyUI":
               this.showHideKeyUISignal.dispatch(false);
               return;
            case "giftChestOccupied":
               this.giftChestUpdateSignal.dispatch(true);
               return;
            case "giftChestEmpty":
               this.giftChestUpdateSignal.dispatch(false);
               return;
            case "beginnersPackage":
               return;
            default:
               return;
         }
      }
      
      private function onNewTick(param1:NewTick) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Boolean = false;
         if(this.jitterWatcher_)
         {
            this.jitterWatcher_.record();
         }
         lastServerRealTimeMS_ = param1.serverRealTimeMS_;
         this.move(param1.tickId_,this.lastServerRealTimeMS_,this.player);
         this.ticksElapsed++;
         var _loc6_:int = 0;
         var _loc5_:* = param1.statuses_;
         for each(var _loc3_ in param1.statuses_)
         {
            this.processObjectStatus(_loc3_,param1.tickTime_,param1.tickId_);
         }
         this.lastTickId_ = param1.tickId_;
         this.gs_.map.calcVulnerables();
         if(Parameters.usingPortal)
         {
            _loc2_ = 0;
            while(_loc2_ < Parameters.portalSpamRate)
            {
               usePortal(Parameters.portalID);
               _loc2_++;
            }
         }
         if(Parameters.watchInv)
         {
            _loc2_ = 4;
            while(_loc2_ < 12)
            {
               if(player.equipment_[_loc2_] != -1)
               {
                  if(player.shouldDrink(player.getPotType(player.equipment_[_loc2_])))
                  {
                     useItem(gs_.lastUpdate_,player.objectId_,_loc2_,player.equipment_[_loc2_],player.x_,player.y_,1);
                     _loc4_ = true;
                  }
               }
               _loc2_++;
            }
            if(_loc4_)
            {
               Parameters.watchInv = false;
            }
         }
      }
      
      private function canShowEffect(param1:GameObject) : Boolean
      {
         if(param1)
         {
            return true;
         }
         if(param1.objectId_ != this.playerId_ && param1.props_.isPlayer_ && Parameters.data.disableAllyShoot)
         {
            return false;
         }
         return true;
      }
      
      private function onShowEffect(param1:ShowEffect) : void
      {
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc5_:AbstractMap = gs_.map;
         var _loc7_:GameObject = _loc5_.goDict_[param1.targetObjectId_];
         if(_loc7_)
         {
            if(_loc7_.objectType_ == 799 && param1.color_ == 16711680)
            {
               _loc3_ = (_loc7_ as Player).calcSealHeal();
               if(_loc3_ != 0)
               {
                  player.addSealHealth(_loc3_);
               }
            }
            else if(_loc7_.objectType_ == 797 && _loc7_.equipment_ && _loc7_.equipment_[1] == 32699 && param1.effectType_ == 5 && param1.color_ == 16033044)
            {
               player.addSealHealth(250);
            }
            else if(param1.effectType_ == 12 && param1.color_ == 16711816)
            {
               Parameters.mystics.push(_loc7_.name_ + " " + getTimer());
            }
            if(_loc7_.props_.isPlayer_ && _loc7_.objectId_ != this.playerId_ && Parameters.data.alphaOnOthers)
            {
               return;
            }
         }
         if(Parameters.lowCPUMode && !(param1.effectType_ == 23 || param1.effectType_ == 22 || param1.effectType_ == 26 || param1.effectType_ == 24))
         {
            return;
         }
         if(Parameters.data.liteParticle && !(param1.effectType_ == 4 || param1.effectType_ == 12 || param1.effectType_ == 16 || param1.effectType_ == 15 || param1.effectType_ == 23 || param1.effectType_ == 22 || param1.effectType_ == 26 || param1.effectType_ == 24))
         {
            return;
         }
         if(Parameters.data.noParticlesMaster && (param1.effectType_ == 1 || param1.effectType_ == 2 || param1.effectType_ == 3 || param1.effectType_ == 6 || param1.effectType_ == 7 || param1.effectType_ == 9 || param1.effectType_ == 13 || param1.effectType_ == 20))
         {
            return;
         }
         var _loc4_:uint = param1.effectType_;
         var _loc8_:* = _loc4_;
         switch(_loc8_)
         {
            case 1:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc5_.addObj(new HealEffect(_loc7_,param1.color_),_loc7_.x_,_loc7_.y_);
               break;
            case 2:
               _loc5_.addObj(new TeleportEffect(),param1.pos1_.x_,param1.pos1_.y_);
               break;
            case 3:
               _loc2_ = new StreamEffect(param1.pos1_,param1.pos2_,param1.color_);
               _loc5_.addObj(_loc2_,param1.pos1_.x_,param1.pos1_.y_);
               break;
            case 4:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               _loc6_ = _loc7_ != null?new Point(_loc7_.x_,_loc7_.y_):param1.pos2_.toPoint();
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new ThrowEffect(_loc6_,param1.pos1_.toPoint(),param1.color_,param1.duration_ * 1000);
               _loc5_.addObj(_loc2_,_loc6_.x,_loc6_.y);
               break;
            case 5:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new NovaEffect(_loc7_,param1.pos1_.x_,param1.color_);
               _loc5_.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 20:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new PoisonEffect(_loc7_,param1.color_);
               _loc5_.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 6:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new LineEffect(_loc7_,param1.pos1_,param1.color_);
               _loc5_.addObj(_loc2_,param1.pos1_.x_,param1.pos1_.y_);
               break;
            case 7:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new BurstEffect(_loc7_,param1.pos1_,param1.pos2_,param1.color_);
               _loc5_.addObj(_loc2_,param1.pos1_.x_,param1.pos1_.y_);
               break;
            case 8:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new FlowEffect(param1.pos1_,_loc7_,param1.color_);
               _loc5_.addObj(_loc2_,param1.pos1_.x_,param1.pos1_.y_);
               break;
            case 9:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new RingEffect(_loc7_,param1.pos1_.x_,param1.color_);
               _loc5_.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 10:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new LightningEffect(_loc7_,param1.pos1_,param1.color_,param1.pos2_.x_);
               _loc5_.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 11:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new CollapseEffect(_loc7_,param1.pos1_,param1.pos2_,param1.color_);
               _loc5_.addObj(_loc2_,param1.pos1_.x_,param1.pos1_.y_);
               break;
            case 12:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new ConeBlastEffect(_loc7_,param1.pos1_,param1.pos2_.x_,param1.color_);
               _loc5_.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 13:
               gs_.camera_.startJitter();
               break;
            case 14:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc7_.flash = new FlashDescription(getTimer(),param1.color_,param1.pos1_.x_,param1.pos1_.y_);
               break;
            case 15:
               _loc6_ = param1.pos1_.toPoint();
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new ThrowProjectileEffect(param1.color_,param1.pos2_.toPoint(),param1.pos1_.toPoint(),param1.duration_ * 1000);
               _loc5_.addObj(_loc2_,_loc6_.x,_loc6_.y);
               break;
            case 16:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               if(_loc7_ && _loc7_.spritesProjectEffect)
               {
                  _loc7_.spritesProjectEffect.destroy();
               }
               _loc5_.addObj(new InspireEffect(_loc7_,16759296,5),_loc7_.x_,_loc7_.y_);
               _loc7_.flash = new FlashDescription(getTimer(),param1.color_,param1.pos2_.x_,param1.pos2_.y_);
               _loc2_ = new SpritesProjectEffect(_loc7_,param1.pos1_.x_);
               _loc7_.spritesProjectEffect = SpritesProjectEffect(_loc2_);
               this.gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 21:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               if(_loc7_ && !_loc7_.shockEffect)
               {
                  _loc2_ = new ShockerEffect(_loc7_);
                  _loc7_.shockEffect = ShockerEffect(_loc2_);
                  gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               }
               break;
            case 17:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               if(!_loc7_.hasShock)
               {
                  _loc2_ = new ShockeeEffect(_loc7_);
                  gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               }
               break;
            case 18:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc4_ = param1.pos1_.x_ * 1000;
               _loc2_ = new RisingFuryEffect(_loc7_,_loc4_);
               gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 19:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new HolyBeamEffect(_loc7_,param1.pos1_.x_ * 1000,0);
               gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 22:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new CircleTelegraph(_loc7_,param1.pos1_.x_ * 1000,param1.pos1_.y_);
               gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 23:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new HolyBeamEffect(_loc7_,param1.pos1_.x_ * 1000,1);
               gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 24:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new SmokeCloudEffect(_loc7_,param1.pos1_.x_ * 1000,param1.pos1_.y_,120,1);
               gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               _loc2_ = new SmokeCloudEffect(_loc7_,param1.pos1_.x_ * 750,param1.pos1_.y_ * 1.5,60,0.33);
               gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 25:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc2_ = new MeteorEffect(_loc7_,param1.pos1_.x_ * 1000,0);
               gs_.map.addObj(_loc2_,_loc7_.x_,_loc7_.y_);
               break;
            case 26:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc7_.flash = new FlashDescription(getTimer(),16768115,0.5,9);
               _loc5_.addObj(new GildedEffect(_loc7_,16768115,16751104,10904576,2,4500),_loc7_.x_,_loc7_.y_);
               break;
            case 27:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc7_.flash = new FlashDescription(getTimer(),4736621,0.5,9);
               _loc5_.addObj(new GildedEffect(_loc7_,4736621,4031656,4640207,2,4500),_loc7_.x_,_loc7_.y_);
               break;
            case 28:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc7_.flash = new FlashDescription(getTimer(),3675232,0.5,9);
               _loc5_.addObj(new GildedEffect(_loc7_,3675232,11673446,16659566,2,4500),_loc7_.x_,_loc7_.y_);
               break;
            case 29:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc7_.flash = new FlashDescription(getTimer(),16768115,0.25,1);
               _loc5_.addObj(new ThunderEffect(_loc7_),_loc7_.x_,_loc7_.y_);
               break;
            case 30:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc7_.statusFlash_ = new StatusFlashDescription(getTimer(),param1.color_,param1.pos1_.x_);
               break;
            case 31:
               _loc7_ = _loc5_.goDict_[param1.targetObjectId_];
               if(_loc7_ == null || !this.canShowEffect(_loc7_))
               {
                  return;
               }
               _loc7_.flash = new FlashDescription(getTimer(),11673446,0.25,1);
               _loc5_.addObj(new OrbEffect(_loc7_,11673446,3675232,16659566,1.5,2500,param1.pos1_.toPoint()),param1.pos1_.x_,param1.pos1_.y_);
               break;
            case 32:
         }
      }
      
      private function onGoto(param1:Goto) : void
      {
         this.gotoAck(gs_.lastUpdate_);
         var _loc2_:GameObject = gs_.map.goDict_[param1.objectId_];
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.onGoto(param1.pos_.x_,param1.pos_.y_,gs_.lastUpdate_);
      }
      
      private function updateGameObject(param1:GameObject, param2:Vector.<StatData>, param3:Boolean, param4:Boolean) : void
      {
         var _loc9_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         var _loc15_:StatData = null;
         var _loc8_:int = 0;
         var _loc12_:Player = param1 as Player;
         var _loc7_:Merchant = param1 as Merchant;
         var _loc13_:Pet = param1 as Pet;
         if(_loc13_)
         {
            this.petUpdater.updatePet(_loc13_,param2);
            if(this.gs_.map.isPetYard)
            {
               this.petUpdater.updatePetVOs(_loc13_,param2);
            }
            param1.updateStatuses();
            return;
         }
         var _loc10_:int = param2.length;
         var _loc14_:Boolean = false;
         _loc8_ = 0;
         for(; _loc8_ < _loc10_; _loc8_++)
         {
            _loc15_ = param2[_loc8_];
            _loc5_ = _loc15_.statValue_;
            _loc6_ = _loc15_.statType_;
            var _loc16_:* = _loc6_;
            switch(_loc16_)
            {
               case 0:
                  if(param3)
                  {
                     _loc12_.maxHpChanged(_loc5_);
                     param1.maxHP_ = _loc5_;
                     _loc12_.calcHealthPercent();
                  }
                  else
                  {
                     param1.maxHP_ = _loc5_;
                  }
                  continue;
               case 1:
                  if(param3)
                  {
                     if(param4)
                     {
                        _loc12_.clientHp = _loc5_;
                        _loc12_.maxHpChanged(_loc5_);
                     }
                     _loc12_.hp2 = _loc5_;
                  }
                  param1.hp_ = _loc5_;
                  if(param1.dead_ && _loc5_ > 1 && param1.props_.isEnemy_ && _loc9_ >= 2)
                  {
                     param1.dead_ = false;
                  }
                  continue;
               case 2:
                  param1.size_ = _loc5_;
                  continue;
               case 3:
                  _loc12_.maxMP_ = _loc5_;
                  if(param3)
                  {
                     _loc12_.calcManaPercent();
                  }
                  continue;
               case 4:
                  _loc12_.mp_ = _loc5_;
                  if(_loc5_ == 0)
                  {
                     _loc12_.mpZeroed_ = true;
                  }
                  continue;
               case 5:
                  _loc12_.nextLevelExp_ = _loc5_;
                  continue;
               case 6:
                  _loc12_.exp_ = _loc5_;
                  continue;
               case 7:
                  param1.level_ = _loc5_;
                  if(param3)
                  {
                     this.realmQuestLevelSignal.dispatch(_loc5_);
                  }
                  continue;
               case 20:
                  _loc12_.attack_ = _loc5_;
                  continue;
               case 21:
                  param1.defense_ = _loc5_;
                  continue;
               case 22:
                  _loc12_.speed_ = _loc5_;
                  continue;
               case 28:
                  _loc12_.dexterity_ = _loc5_;
                  continue;
               case 26:
                  _loc12_.vitality_ = _loc5_;
                  continue;
               case 27:
                  _loc12_.wisdom = _loc5_;
                  continue;
               case 29:
                  param1.condition_[0] = _loc5_;
                  param1.updateStatuses();
                  continue;
               case 8:
               case 9:
               case 10:
               case 11:
               case 12:
               case 13:
               case 14:
               case 15:
               case 16:
               case 17:
               case 18:
               case 19:
                  _loc11_ = _loc15_.statType_ - 8;
                  if(_loc5_ != -1)
                  {
                     param1.lockedSlot[_loc11_] = 0;
                  }
                  param1.equipment_[_loc11_] = _loc5_;
                  continue;
               case 30:
                  _loc12_.numStars_ = _loc5_;
                  continue;
               case 100:
                  _loc12_.starsBg_ = _loc5_ >= 0?int(_loc5_):0;
                  continue;
               case 31:
                  if(param1.name_ != _loc15_.strStatValue_)
                  {
                     param1.name_ = _loc15_.strStatValue_;
                     param1.name_ = param1 is Portal && param1.name_.indexOf("NexusPortal.") != -1?param1.name_.substring("NexusPortal.".length):param1.name_;
                     if(param1.nameBitmapData_)
                     {
                        param1.nameBitmapData_.dispose();
                     }
                     param1.nameBitmapData_ = null;
                     if(param1.name_.toUpperCase() == Parameters.followName)
                     {
                        Parameters.followPlayer = param1;
                     }
                  }
                  continue;
               case 32:
                  _loc5_ >= 0 && param1.setTex1(_loc5_);
                  continue;
               case 33:
                  _loc5_ >= 0 && param1.setTex2(_loc5_);
                  continue;
               case 34:
                  _loc7_.setMerchandiseType(_loc5_);
                  continue;
               case 35:
                  _loc12_.setCredits(_loc5_);
                  continue;
               case 36:
                  (param1 as SellableObject).setPrice(_loc5_);
                  continue;
               case 37:
                  (param1 as Portal).active_ = _loc5_ != 0;
                  continue;
               case 38:
                  _loc12_.accountId_ = param2[_loc8_].strStatValue_;
                  continue;
               case 39:
                  _loc12_.setFame(_loc5_);
                  continue;
               case 97:
                  _loc12_.setTokens(_loc5_);
                  continue;
               case 98:
                  if(_loc12_)
                  {
                     _loc12_.supporterPoints = _loc5_;
                     _loc12_.clearTextureCache();
                     if(param3)
                     {
                        this.injector.getInstance(SupporterCampaignModel).updatePoints(_loc5_);
                     }
                  }
                  continue;
               case 99:
                  if(_loc12_)
                  {
                     _loc12_.setSupporterFlag(_loc5_);
                  }
                  continue;
               case 40:
                  (param1 as SellableObject).setCurrency(_loc5_);
                  continue;
               case 41:
                  param1.connectType_ = _loc5_;
                  continue;
               case 42:
                  _loc7_.count_ = _loc5_;
                  _loc7_.untilNextMessage_ = 0;
                  continue;
               case 43:
                  _loc7_.minsLeft_ = _loc5_;
                  _loc7_.untilNextMessage_ = 0;
                  continue;
               case 44:
                  _loc7_.discount_ = _loc5_;
                  _loc7_.untilNextMessage_ = 0;
                  continue;
               case 45:
                  (param1 as SellableObject).setRankReq(_loc5_);
                  continue;
               case 46:
                  if(param3)
                  {
                     _loc14_ = true;
                  }
                  _loc12_.maxHPBoost_ = _loc5_;
                  continue;
               case 47:
                  _loc12_.maxMPBoost_ = _loc5_;
                  continue;
               case 48:
                  _loc12_.attackBoost_ = _loc5_;
                  continue;
               case 49:
                  _loc12_.defenseBoost_ = _loc5_;
                  continue;
               case 50:
                  _loc12_.speedBoost_ = _loc5_;
                  continue;
               case 51:
                  _loc12_.vitalityBoost_ = _loc5_;
                  continue;
               case 52:
                  _loc12_.wisdomBoost_ = _loc5_;
                  continue;
               case 53:
                  _loc12_.dexterityBoost_ = _loc5_;
                  continue;
               case 54:
                  (param1 as Container).setOwnerId(param2[_loc8_].strStatValue_);
                  continue;
               case 55:
                  (param1 as NameChanger).setRankRequired(_loc5_);
                  continue;
               case 56:
                  _loc12_.nameChosen_ = _loc5_ != 0;
                  if(param1.nameBitmapData_)
                  {
                     param1.nameBitmapData_.dispose();
                  }
                  param1.nameBitmapData_ = null;
                  continue;
               case 57:
                  _loc12_.currFame_ = _loc5_;
                  continue;
               case 58:
                  _loc12_.nextClassQuestFame_ = _loc5_;
                  continue;
               case 59:
                  _loc12_.legendaryRank_ = _loc5_;
                  continue;
               case 60:
                  if(!param3)
                  {
                     _loc12_.sinkLevel = _loc5_;
                  }
                  continue;
               case 61:
                  param1.setAltTexture(_loc5_);
                  continue;
               case 62:
                  _loc12_.setGuildName(param2[_loc8_].strStatValue_);
                  continue;
               case 63:
                  _loc12_.guildRank_ = _loc5_;
                  continue;
               case 64:
                  _loc12_.breath_ = _loc5_;
                  continue;
               case 65:
                  _loc12_.xpBoost_ = _loc5_;
                  continue;
               case 66:
                  _loc12_.xpTimer = _loc5_ * 1000;
                  continue;
               case 67:
                  _loc12_.dropBoost = _loc5_ * 1000;
                  continue;
               case 68:
                  _loc12_.tierBoost = _loc5_ * 1000;
                  continue;
               case 69:
                  _loc12_.healthPotionCount_ = _loc5_;
                  continue;
               case 70:
                  _loc12_.magicPotionCount_ = _loc5_;
                  continue;
               case 103:
                  _loc12_.projectileLifeMult = _loc5_ / 1000;
                  continue;
               case 102:
                  _loc12_.projectileSpeedMult = _loc5_ / 1000;
                  continue;
               case 80:
                  if(_loc12_)
                  {
                     _loc12_.skinId != _loc5_ && _loc5_ >= 0 && this.setPlayerSkinTemplate(_loc12_,_loc5_);
                  }
                  else if(param1.objectType_ == 1813 && _loc5_ > 0)
                  {
                     param1.setTexture(_loc5_);
                  }
                  continue;
               case 79:
                  (param1 as Player).hasBackpack_ = Boolean(_loc5_);
                  if(param3)
                  {
                     this.updateBackpackTab.dispatch(Boolean(_loc5_));
                  }
                  continue;
               case 71:
               case 72:
               case 73:
               case 74:
               case 75:
               case 76:
               case 77:
               case 78:
                  _loc11_ = _loc15_.statType_ - 71 + 4 + 8;
                  (param1 as Player).equipment_[_loc11_] = _loc5_;
                  continue;
               case 96:
                  param1.condition_[1] = _loc5_;
                  param1.updateStatuses();
                  continue;
               case 101:
                  continue;
               case 107:
                  trace("hp",_loc5_,param1.name_);
                  (param1 as Player).exaltedHealth = _loc5_;
                  continue;
               case 108:
                  trace("mp",_loc5_,param1.name_);
                  (param1 as Player).exaltedMana = _loc5_;
                  continue;
               case 105:
                  trace("att",_loc5_,param1.name_);
                  (param1 as Player).exaltedAttack = _loc5_;
                  continue;
               case 106:
                  trace("def",_loc5_,param1.name_);
                  (param1 as Player).exaltedDefense = _loc5_;
                  continue;
               case 109:
                  trace("speed",_loc5_,param1.name_);
                  (param1 as Player).exaltedSpeed = _loc5_;
                  continue;
               case 110:
                  trace("dex",_loc5_,param1.name_);
                  (param1 as Player).exaltedDexterity = _loc5_;
                  continue;
               case 111:
                  trace("vit",_loc5_,param1.name_);
                  (param1 as Player).exaltedVitality = _loc5_;
                  continue;
               case 112:
                  trace("wis",_loc5_,param1.name_);
                  (param1 as Player).exaltedWisdom = _loc5_;
                  continue;
               case 113:
                  if(_loc5_ != 1000)
                  {
                     trace("Unknown stat:",_loc6_,", statVal:",_loc5_,", strStatVal:",_loc15_.strStatValue_,", name:",param1.name_);
                  }
                  continue;
               default:
                  trace("Unhandled stat type:",_loc6_,", statVal:",_loc5_,", strStatVal:",_loc15_.strStatValue_,", name:",param1.name_);
                  continue;
            }
         }
         if(param3)
         {
            if(_loc14_)
            {
               _loc12_.triggerHealBuffer();
            }
            if(Parameters.data.AutoSyncClientHP && Math.abs(_loc12_.clientHp - _loc12_.hp_) > 60)
            {
               _loc9_ = _loc12_.ticksHPLastOff;
               _loc12_.ticksHPLastOff = _loc9_ + 1;
               if(_loc9_ > 3)
               {
                  _loc12_.ticksHPLastOff = 0;
                  _loc12_.clientHp = _loc12_.hp_;
               }
            }
         }
      }
      
      private function processObjectStatus(param1:ObjectStatusData, param2:int, param3:int) : void
      {
         var _loc15_:int = 0;
         var _loc18_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc16_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc12_:int = 0;
         var _loc10_:* = null;
         var _loc9_:* = null;
         var _loc6_:* = null;
         var _loc7_:GameObject = this.gs_.map.goDict_[param1.objectId_];
         if(_loc7_ == null)
         {
            return;
         }
         var _loc11_:* = param1.objectId_ == this.playerId_;
         if(param2 != 0)
         {
            if(!_loc11_)
            {
               _loc7_.onTickPos(param1.pos_.x_,param1.pos_.y_,param2,param3);
            }
            else
            {
               _loc7_.tickPosition_.x = param1.pos_.x_;
               _loc7_.tickPosition_.y = param1.pos_.y_;
            }
         }
         var _loc17_:Player = _loc7_ as Player;
         if(_loc17_)
         {
            _loc15_ = _loc17_.level_;
            _loc18_ = _loc17_.exp_;
            _loc13_ = _loc17_.skinId;
            _loc14_ = _loc17_.currFame_;
         }
         this.updateGameObject(_loc7_,param1.stats_,_loc11_,param2 == 0);
         if(_loc17_)
         {
            if(_loc11_)
            {
               _loc16_ = this.classesModel.getCharacterClass(_loc17_.objectType_);
               if(_loc16_.getMaxLevelAchieved() < _loc17_.level_)
               {
                  _loc16_.setMaxLevelAchieved(_loc17_.level_);
               }
            }
            if(_loc17_.skinId != _loc13_)
            {
               if(ObjectLibrary.skinSetXMLDataLibrary_[_loc17_.skinId])
               {
                  _loc8_ = ObjectLibrary.skinSetXMLDataLibrary_[_loc17_.skinId] as XML;
                  _loc5_ = _loc8_.attribute("color");
                  _loc4_ = _loc8_.attribute("bulletType");
                  if(_loc15_ != -1 && _loc5_.length > 0)
                  {
                     _loc17_.levelUpParticleEffect(parseInt(_loc5_));
                  }
                  if(_loc4_.length > 0)
                  {
                     _loc17_.projectileIdSetOverrideNew = _loc4_;
                     _loc12_ = _loc17_.equipment_[0];
                     _loc10_ = ObjectLibrary.propsLibrary_[_loc12_];
                     _loc9_ = _loc10_.projectiles_[0];
                     _loc17_.projectileIdSetOverrideOld = _loc9_.objectId_;
                  }
               }
               else if(ObjectLibrary.skinSetXMLDataLibrary_[_loc17_.skinId] == null)
               {
                  _loc17_.projectileIdSetOverrideNew = "";
                  _loc17_.projectileIdSetOverrideOld = "";
               }
            }
            if(_loc15_ != -1 && _loc17_.level_ > _loc15_)
            {
               if(_loc11_)
               {
                  _loc6_ = gs_.model.getNewUnlocks(_loc17_.objectType_,_loc17_.level_);
                  _loc17_.handleLevelUp(_loc6_.length != 0);
                  if(_loc6_.length > 0)
                  {
                     this.newClassUnlockSignal.dispatch(_loc6_);
                  }
               }
               else if(!Parameters.data.noAllyNotifications)
               {
                  _loc17_.levelUpEffect("Level Up!");
               }
            }
            else if(_loc15_ != -1 && _loc17_.exp_ > _loc18_)
            {
               if(_loc7_ || !Parameters.data.noAllyNotifications)
               {
                  _loc17_.handleExpUp(_loc17_.exp_ - _loc18_);
               }
            }
            if(_loc14_ != -1 && _loc17_.currFame_ > _loc14_)
            {
               if(_loc11_)
               {
                  Parameters.fpmGain++;
                  if(Parameters.data.showFameGain)
                  {
                     _loc17_.updateFame(_loc17_.currFame_ - _loc14_);
                  }
               }
            }
            this.socialModel.updateFriendVO(_loc17_.getName(),_loc17_);
         }
      }
      
      private function onInvResult(param1:InvResult) : void
      {
         if(param1.result_ != 0)
         {
            this.handleInvFailure();
         }
      }
      
      private function handleInvFailure() : void
      {
         SoundEffectLibrary.play("error");
         this.gs_.hudView.interactPanel.redraw();
      }
      
      private function onReconnect(param1:Reconnect) : void
      {
         if(Parameters.ignoreRecon)
         {
            if(!Parameters.usingPortal)
            {
               this.addTextLine.dispatch(ChatMessage.make(param1.key_.length.toString(),param1.toString()));
            }
            return;
         }
         var _loc3_:Server = new Server().setName(param1.name_).setAddress(param1.host_ != ""?param1.host_:server_.address).setPort(param1.host_ != ""?param1.port_:int(server_.port));
         var _loc2_:int = param1.gameId_;
         var _loc4_:Boolean = createCharacter_;
         var _loc5_:int = this.charId_;
         var _loc6_:int = param1.keyTime_;
         var _loc7_:ByteArray = param1.key_;
         isFromArena_ = param1.isFromArena_;
         if(param1.stats_)
         {
            this.statsTracker.setBinaryStringData(_loc5_,param1.stats_);
         }
         var _loc8_:ReconnectEvent = new ReconnectEvent(_loc3_,_loc2_,_loc4_,_loc5_,_loc6_,_loc7_,isFromArena_);
         _loc8_.createCharacter_ = false;
         Parameters.reconList[param1.gameId_] = _loc8_;
         this.disconnect();
         this.isNexusing = false;
         gs_.dispatchEvent(_loc8_);
      }
      
      private function onPing(param1:Ping) : void
      {
         var _loc2_:Pong = this.messages.require(31) as Pong;
         _loc2_.serial_ = param1.serial_;
         _loc2_.time_ = getTimer();
         serverConnection.sendMessage(_loc2_);
      }
      
      private function parseXML(param1:String) : void
      {
         var _loc2_:XML = XML(param1);
         GroundLibrary.parseFromXML(_loc2_);
         ObjectLibrary.parseFromXML(_loc2_);
         ObjectLibrary.parseFromXML(_loc2_);
      }
      
      private function onMapInfo(param1:MapInfo) : void
      {
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         if(param1.name_ == "Nexus" || !Parameters.reconNexus)
         {
            Parameters.reconNexus = new ReconnectEvent(new Server().setName("Nexus").setAddress(this.server_.address).setPort(this.server_.port),-2,false,this.charId_,0,null,this.isFromArena_);
         }
         if(Parameters.reconNexus)
         {
            Parameters.reconNexus.charId_ = this.charId_;
         }
         var _loc3_:int = 0;
         var _loc6_:* = param1.clientXML_;
         var _loc10_:int = 0;
         var _loc9_:* = param1.clientXML_;
         for each(_loc7_ in param1.clientXML_)
         {
            this.parseXML(_loc7_);
         }
         var _loc2_:int = 0;
         var _loc4_:* = param1.extraXML_;
         var _loc12_:int = 0;
         var _loc11_:* = param1.extraXML_;
         for each(_loc5_ in param1.extraXML_)
         {
            this.parseXML(_loc5_);
         }
         this.closeDialogs.dispatch();
         this.gs_.applyMapInfo(param1);
         this.rand_ = new Random(param1.fp_);
         Parameters.suicideMode = false;
         Parameters.suicideAT = -1;
         if(Parameters.needToRecalcDesireables)
         {
            Parameters.setAutolootDesireables();
            Parameters.needToRecalcDesireables = false;
         }
         Parameters.questFollow = false;
         Parameters.VHS = 0;
         Parameters.swapINVandBP = 0;
         if(param1.name_ == "Realm of the Mad God")
         {
            Parameters.mystics.length = 0;
         }
         else if(param1.name_ == "Tutorial")
         {
            if(Parameters.manualTutorial)
            {
               Parameters.manualTutorial = false;
            }
            else
            {
               this.disconnect();
               this.gs_.dispatchEvent(Parameters.reconNexus);
               Parameters.data.needsTutorial = false;
               Parameters.save();
               return;
            }
         }
         if(Parameters.preload)
         {
            this.charId_ = Parameters.forceCharId;
            this.load();
         }
         else if(this.createCharacter_)
         {
            this.create();
         }
         else
         {
            this.load();
         }
         connectionGuid = param1.connectionGuid_;
         this.gs_.deathOverlay = new Bitmap();
         this.gs_.addChild(this.gs_.deathOverlay);
         Parameters.ignoredShotCount = 0;
         Parameters.dmgCounter.length = 0;
         Parameters.needsMapCheck = this.gs_.map.needsMapHack(param1.name_);
      }
      
      private function onPic(param1:Pic) : void
      {
         gs_.addChild(new PicView(param1.bitmapData_));
      }
      
      private function onDeath(param1:Death) : void
      {
         this.death = param1;
         var _loc2_:BitmapData = new BitmapData(gs_.stage.stageWidth,gs_.stage.stageHeight,true,0);
         _loc2_.draw(gs_);
         param1.background = _loc2_;
         if(!gs_.isEditor)
         {
            this.handleDeath.dispatch(param1);
         }
         if(gs_.map.name_ == "Davy Jones\' Locker")
         {
            this.showHideKeyUISignal.dispatch(false);
         }
         Parameters.Cache_CHARLIST_valid = false;
         Parameters.suicideMode = false;
         Parameters.suicideAT = -1;
      }
      
      private function onBuyResult(param1:BuyResult) : void
      {
         outstandingBuy_ = null;
         this.handleBuyResultType(param1);
      }
      
      private function handleBuyResultType(param1:BuyResult) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = int(param1.result_) - -1;
         switch(_loc3_)
         {
            case 0:
               _loc2_ = ChatMessage.make("",param1.resultString_);
               this.addTextLine.dispatch(_loc2_);
               return;
            case 4:
               this.showPopupSignal.dispatch(new NotEnoughGoldDialog());
               return;
            case 7:
               this.openDialog.dispatch(new NotEnoughFameDialog());
               return;
            default:
               this.handleDefaultResult(param1);
               return;
         }
      }
      
      private function handleDefaultResult(param1:BuyResult) : void
      {
         var _loc2_:LineBuilder = LineBuilder.fromJSON(param1.resultString_);
         var _loc4_:Boolean = param1.result_ == 0 || param1.result_ == 7;
         var _loc3_:ChatMessage = ChatMessage.make(!!_loc4_?"":"*Error*",_loc2_.key);
         _loc3_.tokens = _loc2_.tokens;
         this.addTextLine.dispatch(_loc3_);
      }
      
      private function onAccountList(param1:AccountList) : void
      {
         if(param1.accountListId_ == 0)
         {
            if(param1.lockAction_ != -1)
            {
               if(param1.lockAction_ == 1)
               {
                  gs_.map.party_.setStars(param1);
               }
               else
               {
                  gs_.map.party_.removeStars(param1);
               }
            }
            else
            {
               gs_.map.party_.setStars(param1);
            }
         }
         else if(param1.accountListId_ == 1)
         {
            gs_.map.party_.setIgnores(param1);
         }
      }
      
      private function onQuestObjId(param1:QuestObjId) : void
      {
         gs_.map.quest_.setObject(param1.objectId_);
      }
      
      private function onAoe(param1:Aoe) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = undefined;
         if(this.player == null)
         {
            this.aoeAck(gs_.lastUpdate_,0,0);
            return;
         }
         var _loc3_:AOEEffect = new AOEEffect(param1.pos_.toPoint(),param1.radius_,param1.color_);
         gs_.map.addObj(_loc3_,param1.pos_.x_,param1.pos_.y_);
         if(this.player.isInvincible || this.player.isPaused)
         {
            this.aoeAck(gs_.lastUpdate_,this.player.x_,this.player.y_);
            return;
         }
         if(this.player.distTo(param1.pos_) < param1.radius_)
         {
            _loc4_ = this.player.damageWithDefense(param1.damage_,this.player.defense_,param1.armorPierce_,this.player.condition_);
            _loc2_ = null;
            if(param1.effect_ != 0)
            {
               _loc2_ = new Vector.<uint>();
               _loc2_.push(param1.effect_);
            }
            if(this.player.subtractDamage(_loc4_))
            {
               return;
            }
            this.player.damage(true,_loc4_,_loc2_,false,null,param1.armorPierce_);
         }
         this.aoeAck(gs_.lastUpdate_,this.player.x_,this.player.y_);
      }
      
      private function onNameResult(param1:NameResult) : void
      {
         gs_.dispatchEvent(new NameResultEvent(param1));
      }
      
      private function onGuildResult(param1:GuildResult) : void
      {
         var _loc2_:* = null;
         if(param1.lineBuilderJSON == "")
         {
            gs_.dispatchEvent(new GuildResultEvent(param1.success_,"",{}));
         }
         else
         {
            _loc2_ = LineBuilder.fromJSON(param1.lineBuilderJSON);
            this.addTextLine.dispatch(ChatMessage.make("*Error*",_loc2_.key,-1,-1,"",false,_loc2_.tokens));
            gs_.dispatchEvent(new GuildResultEvent(param1.success_,_loc2_.key,_loc2_.tokens));
         }
      }
      
      private function onClientStat(param1:ClientStat) : void
      {
         var _loc2_:* = null;
         if(Parameters.data.showClientStat)
         {
            if(!Parameters.usingPortal)
            {
               this.addTextLine.dispatch(ChatMessage.make("#" + param1.name_,param1.value_.toString()));
               _loc2_ = StaticInjectorContext.getInjector().getInstance(Account);
               _loc2_.reportIntStat(param1.name_,param1.value_);
            }
         }
      }
      
      private function onFile(param1:File) : void
      {
         new FileReference().save(param1.file_,param1.filename_);
      }
      
      private function onInvitedToGuild(param1:InvitedToGuild) : void
      {
         if(Parameters.data.showGuildInvitePopup)
         {
            gs_.hudView.interactPanel.setOverride(new GuildInvitePanel(gs_,param1.name_,param1.guildName_));
         }
         this.addTextLine.dispatch(ChatMessage.make("","You have been invited by " + param1.name_ + " to join the guild " + param1.guildName_ + ".\n  If you wish to join type \"/join " + param1.guildName_ + "\""));
      }
      
      private function onPlaySound(param1:PlaySound) : void
      {
         var _loc2_:GameObject = gs_.map.goDict_[param1.ownerId_];
      }
      
      private function onImminentArenaWave(param1:ImminentArenaWave) : void
      {
         this.imminentWave.dispatch(param1.currentRuntime);
      }
      
      private function onArenaDeath(param1:ArenaDeath) : void
      {
         this.addTextLine.dispatch(ChatMessage.make("ArenaDeath","Cost: " + param1.cost));
         this.currentArenaRun.costOfContinue = param1.cost;
         this.openDialog.dispatch(new ContinueOrQuitDialog(param1.cost,false));
         this.arenaDeath.dispatch();
      }
      
      private function onVerifyEmail(param1:VerifyEmail) : void
      {
         TitleView.queueEmailConfirmation = true;
         if(gs_ != null)
         {
            gs_.closed.dispatch();
         }
      }
      
      private function onPasswordPrompt(param1:PasswordPrompt) : void
      {
         if(param1.cleanPasswordStatus == 3)
         {
            TitleView.queuePasswordPromptFull = true;
         }
         else if(param1.cleanPasswordStatus == 2)
         {
            TitleView.queuePasswordPrompt = true;
         }
         else if(param1.cleanPasswordStatus == 4)
         {
            TitleView.queueRegistrationPrompt = true;
         }
         if(gs_ != null)
         {
            gs_.closed.dispatch();
         }
      }
      
      private function onQuestFetchResponse(param1:QuestFetchResponse) : void
      {
         this.questFetchComplete.dispatch(param1);
      }
      
      private function onQuestRedeemResponse(param1:QuestRedeemResponse) : void
      {
         this.questRedeemComplete.dispatch(param1);
      }
      
      private function onKeyInfoResponse(param1:KeyInfoResponse) : void
      {
         this.keyInfoResponse.dispatch(param1);
      }
      
      private function onLoginRewardResponse(param1:ClaimDailyRewardResponse) : void
      {
         this.claimDailyRewardResponse.dispatch(param1);
      }
      
      private function onChatToken(param1:ChatToken) : void
      {
         this.chatServerModel.chatToken = param1.token_;
         this.chatServerModel.port = param1.port_;
         this.chatServerModel.server = param1.host_;
         this.addChatServerConnectionListeners();
         this.loginToChatServer();
      }
      
      private function addChatServerConnectionListeners() : void
      {
         this.chatServerConnection.chatConnected.add(this.onChatConnected);
         this.chatServerConnection.chatClosed.add(this.onChatClosed);
         this.chatServerConnection.chatError.add(this.onChatError);
      }
      
      private function removeChatServerConnectionListeners() : void
      {
         this.chatServerConnection.chatConnected.remove(this.onChatConnected);
         this.chatServerConnection.chatClosed.remove(this.onChatClosed);
         this.chatServerConnection.chatError.remove(this.onChatError);
      }
      
      private function loginToChatServer() : void
      {
         this.chatServerConnection.connect(this.chatServerModel.server,this.chatServerModel.port);
      }
      
      private function onChatConnected() : void
      {
         var _loc1_:* = null;
         _loc1_ = this.messages.require(206) as ChatHello;
         _loc1_ = this.messages.require(206) as ChatHello;
         _loc1_.accountId = this.rsaEncrypt(this.player.accountId_);
         _loc1_.token = this.chatServerModel.chatToken;
         this.chatServerConnection.sendMessage(_loc1_);
         if(this.chatServerConnection.isChatConnected())
         {
            this.addTextLine.dispatch(ChatMessage.make("*Client*","Chat Server connected"));
            this._isReconnecting = false;
         }
         else
         {
            this.chatServerConnection.isConnecting = false;
         }
      }
      
      private function onChatClosed() : void
      {
         if(!this.chatServerConnection.isChatConnected() && this._numberOfReconnectAttempts < 5)
         {
            this._numberOfReconnectAttempts++;
            if(serverConnection.isConnected() && !this._isReconnecting)
            {
               this._isReconnecting = true;
               this.removeChatServerConnectionListeners();
               this.chatServerConnection.dispose();
               this.chatServerConnection = null;
               this.chatServerConnection = this.injector.getInstance(ChatSocketServer);
               this.setChatEncryption();
               this.chatServerConnection.isConnecting = true;
               this.addChatServerConnectionListeners();
               this.addTextLine.dispatch(ChatMessage.make("*Error*","Chat Connection closed!  Reconnecting..."));
               this.chatReconnectTimer(10);
            }
         }
         else
         {
            this.addTextLine.dispatch(ChatMessage.make("*Error*","Chat Connection closed!  Unable to reconnect - Please restart game!"));
         }
      }
      
      private function onChatError(param1:String) : void
      {
         this.addTextLine.dispatch(ChatMessage.make("*Error*",param1));
      }
      
      private function chatReconnectTimer(param1:int) : void
      {
         if(!this._chatReconnectionTimer)
         {
            this._chatReconnectionTimer = new Timer(param1 * 1000,1);
         }
         else
         {
            this._chatReconnectionTimer.delay = param1 * 1000;
         }
         this._chatReconnectionTimer.addEventListener("timerComplete",this.onChatRetryTimer);
         this._chatReconnectionTimer.start();
      }
      
      private function onRealmHeroesResponse(param1:RealmHeroesResponse) : void
      {
         this.realmHeroesSignal.dispatch(param1.numberOfRealmHeroes);
      }
      
      private function onClosed() : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(!this.isNexusing)
         {
            if(this.playerId_ != -1)
            {
               gs_.closed.dispatch();
            }
            else if(this.retryConnection_)
            {
               if(this.delayBeforeReconnect < 10)
               {
                  _loc4_ = this.delayBeforeReconnect;
                  this.delayBeforeReconnect++;
                  this.retry(_loc4_);
                  if(!this.serverFull_)
                  {
                     this.addTextLine.dispatch(ChatMessage.make("*Error*","Connection failed!  Retrying..."));
                  }
               }
               else
               {
                  gs_.closed.dispatch();
               }
            }
         }
         else
         {
            this.isNexusing = false;
            _loc1_ = this.serverModel.getServer();
            _loc2_ = new ReconnectEvent(_loc1_,-2,false,charId_,1,new ByteArray(),isFromArena_);
            gs_.dispatchEvent(_loc2_);
         }
      }
      
      private function retry(param1:int) : void
      {
         this.retryTimer_ = new Timer(param1 * 1000,1);
         this.retryTimer_.addEventListener("timerComplete",this.onRetryTimer,false,0,true);
         this.retryTimer_.start();
      }
      
      private function onError(param1:String) : void
      {
         this.addTextLine.dispatch(ChatMessage.make("*Error*",param1));
      }
      
      private function onFailure(param1:Failure) : void
      {
         lastConnectionFailureMessage = param1.errorDescription_;
         lastConnectionFailureID = param1.errorConnectionId_;
         this.serverFull_ = false;
         if("is dead" in LineBuilder.getLocalizedStringFromJSON(param1.errorDescription_) || "is dead" in param1.errorDescription_)
         {
            Parameters.Cache_CHARLIST_valid = false;
         }
         var _loc2_:* = int(param1.errorId_) - 4;
         switch(_loc2_)
         {
            case 0:
               this.handleIncorrectVersionFailure(param1);
               break;
            case 1:
               this.handleBadKeyFailure(param1);
               break;
            case 2:
               this.handleInvalidTeleportTarget(param1);
               break;
            case 3:
               this.handleEmailVerificationNeeded(param1);
               break;
            case 5:
               this.handleRealmTeleportBlock(param1);
               break;
            case 6:
               this.handleWrongServerEnter(param1);
               break;
            case 11:
               this.handleServerFull(param1);
               break;
            default:
               this.handleDefaultFailure(param1);
         }
         if(param1.errorDescription_.indexOf("Client Token Error") != -1)
         {
            this.addTextLine.dispatch(ChatMessage.make("","Your hacked client is outdated! Please wait for a new version to be released then redownload the client."));
         }
      }
      
      private function handleServerFull(param1:Failure) : void
      {
         this.addTextLine.dispatch(ChatMessage.make("",param1.errorDescription_));
         this.retryConnection_ = true;
         this.delayBeforeReconnect = 5;
         this.serverFull_ = true;
      }
      
      private function handleEmailVerificationNeeded(param1:Failure) : void
      {
         this.retryConnection_ = false;
         gs_.closed.dispatch();
      }
      
      private function handleRealmTeleportBlock(param1:Failure) : void
      {
         this.addTextLine.dispatch(ChatMessage.make("","You need to wait at least " + param1.errorDescription_ + " seconds before a non guild member teleport."));
         this.player.nextTeleportAt_ = getTimer() + parseFloat(param1.errorDescription_) * 1000;
      }
      
      private function handleWrongServerEnter(param1:Failure) : void
      {
         this.addTextLine.dispatch(ChatMessage.make("",param1.errorDescription_));
         this.retryConnection_ = false;
         gs_.closed.dispatch();
      }
      
      private function handleInvalidTeleportTarget(param1:Failure) : void
      {
         var _loc2_:String = LineBuilder.getLocalizedStringFromJSON(param1.errorDescription_);
         if(_loc2_ == "")
         {
            _loc2_ = param1.errorDescription_;
         }
         this.addTextLine.dispatch(ChatMessage.make("*Error*",_loc2_));
         this.player.nextTeleportAt_ = 0;
      }
      
      private function handleBadKeyFailure(param1:Failure) : void
      {
         var _loc2_:String = LineBuilder.getLocalizedStringFromJSON(param1.errorDescription_);
         if(_loc2_ == "")
         {
            _loc2_ = param1.errorDescription_;
         }
         this.addTextLine.dispatch(ChatMessage.make("*Error*",_loc2_));
         this.retryConnection_ = false;
         gs_.closed.dispatch();
      }
      
      private function handleIncorrectVersionFailure(param1:Failure) : void
      {
         this.addTextLine.dispatch(ChatMessage.make("","Your hacked client is outdated! Please wait for a new version to be released then redownload the client."));
         var _loc2_:Dialog = new Dialog("ClientUpdate.title","","ClientUpdate.leftButton",null,"/clientUpdate");
         _loc2_.setTextParams("ClientUpdate.description",{
            "client":"1.1.0.2",
            "server":param1.errorDescription_
         });
         _loc2_.addEventListener("dialogLeftButton",this.onDoClientUpdate,false,0,true);
         gs_.stage.addChild(_loc2_);
         this.retryConnection_ = false;
      }
      
      private function handleDefaultFailure(param1:Failure) : void
      {
         var _loc2_:String = LineBuilder.getLocalizedStringFromJSON(param1.errorDescription_);
         if(_loc2_ == "")
         {
            _loc2_ = param1.errorDescription_;
         }
         this.addTextLine.dispatch(ChatMessage.make("*Error*",_loc2_));
      }
      
      private function loaderStatus(param1:HTTPStatusEvent) : void
      {
         this.hudModel.gameSprite.gsc_.pingReceivedAt = getTimer() - this.hudModel.gameSprite.gsc_.pingSentAt;
      }
      
      private function conRecon(param1:ReconnectEvent) : void
      {
         this.gs_.dispatchEvent(param1);
      }
      
      private function onChatRetryTimer(param1:TimerEvent) : void
      {
         this._chatReconnectionTimer.removeEventListener("timerComplete",this.onChatRetryTimer);
         this.loginToChatServer();
      }
      
      private function onRetryTimer(param1:TimerEvent) : void
      {
         serverConnection.connect(server_.address,server_.port);
      }
      
      private function onDoClientUpdate(param1:Event) : void
      {
         var _loc2_:Dialog = param1.currentTarget as Dialog;
         _loc2_.parent.removeChild(_loc2_);
         gs_.closed.dispatch();
      }
   }
}
