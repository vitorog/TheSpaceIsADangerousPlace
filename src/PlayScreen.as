package  {	
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import base.GameScene;	
	import flash.text.TextField;
	
	import base.GameEntity;
	import Ship;
	import LevelManager;
	
	public class PlayScreen extends GameScene {
		
		private var game_timer_ : Timer;	
		private var death_timer_ : Timer;
		private var player_ : PlayerShip;
		private var aim_ : Aim;
		private var level_manager_ : LevelManager;
		private var score_ : Score;
		private var player_energy_ : EnergyHUD;
		private var player_shields_ : ShieldsHUD;
		private var alive_clock_ : TimerHUD;
		private var stars_bg_ : StarsBackground2;
		private var bg_timer_ : Timer;
		public static var SCREEN_WIDTH_ : Number;
		public static var SCREEN_HEIGHT_ : Number;	
		private var shield_hit_anim_ : ShieldHitAnimation;
		private var shield_sound_channel_ : SoundChannel;
		private var shield_hit_sound_effect_ : ShieldHitSound;
		 
		public function PlayScreen() {		
			super();
			Mouse.hide();		
			stars_bg_ = new StarsBackground2();
			addChild(stars_bg_);
			//bg_timer_ = new Timer(2500);
			//bg_timer_.addEventListener(TimerEvent.TIMER, MoveBackground );
			//bg_timer_.start();
				
			SCREEN_WIDTH_ = 800;
			SCREEN_HEIGHT_ = 600;			
			
			player_ = new PlayerShip(this);		
			player_.x = this.width / 2;
			player_.y = this.height / 2;			
			AddEntity(player_);			
			
			game_timer_ = new Timer(25);
			game_timer_.addEventListener(TimerEvent.TIMER,GameLoop);
			game_timer_.start();
			
			death_timer_ = new Timer(1100);
			death_timer_.addEventListener(TimerEvent.TIMER, GameOver );
			
			addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			
			level_manager_ = new LevelManager(this);
			
			score_ = new Score();
			score_.x = width - score_.width - 200;
			addChild(score_);
			var score_label : TextField = score_.getChildByName("ScoreLabel") as TextField;			
			score_label.textColor = 0xFF0000;
			
			alive_clock_ = new TimerHUD();
			addChild(alive_clock_);
			alive_clock_.x = SCREEN_WIDTH_ - alive_clock_.width;
			alive_clock_.y = score_.y + score_.height;
			
			
			shield_hit_anim_ = new ShieldHitAnimation();
			addChild(shield_hit_anim_);
			
			player_energy_ = new EnergyHUD();		
			player_shields_ = new ShieldsHUD();			
			addChild(player_energy_);
			addChild(player_shields_);
			player_shields_.y += player_energy_.height;
			
			player_energy_.SetValue(player_.GetEnergy());
			player_shields_.SetValue(player_.GetShields());			
			
		
			this.SetSize(800, 600);
			
			shield_hit_anim_.x = player_.x;
			shield_hit_anim_.y = player_.y;		
			
			shield_sound_channel_ = new SoundChannel();
			shield_hit_sound_effect_ = new ShieldHitSound();
			
			aim_ = new Aim();
			addChild(aim_);
			aim_.x = mouseX;
			aim_.y = mouseY;
			
			alive_clock_.Start();
		}
		
		override public function Destroy() : void 
		{
			game_timer_.stop();
			game_timer_.removeEventListener(TimerEvent.TIMER, GameLoop );
			game_timer_ = null;
			
			removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			level_manager_.Destroy();
			level_manager_ = null;
			
			death_timer_.stop();
			death_timer_.removeEventListener(TimerEvent.TIMER, GameOver);
			death_timer_ = null;		
			
			player_ = null;
			
			removeChild(aim_);
			aim_ = null;
			
			var entity : GameEntity;
			while (entities_.length > 0) {
				entity = entities_.pop();
				entity.Destroy();
				entity = null;
			}
			
			score_ = null;
			player_energy_ = null;
			player_shields_ = null;
			
			alive_clock_.Destroy();
			
		}
		
		private function MoveBackground(e : TimerEvent) : void
		{
			var x_dir : Number = 0;
			var y_dir : Number = 0;
			if(Math.random() > 0.5) {
				x_dir = -1;
			}
			if(Math.random() < 0.5) {
				x_dir = 1;
			}			
			if (Math.random() > 0.5) {
				y_dir = -1;
			}
			if (Math.random() < 0.5) {
				y_dir = 1;
			}
			stars_bg_.x += x_dir;
			stars_bg_.y += y_dir;
		}
		
		private function BringHudToFront() : void
		{
			
			addChild(score_);
			addChild(player_energy_);
			addChild(player_shields_);
			addChild(aim_);
		}
		
		public function PlayerDeath() : void
		{			
			death_timer_.start();				
		}
		
		public function GameOver(e : TimerEvent)
		{
			SpaceGame.SetFinalScore(score_.current_value_);
			SpaceGame.SetFinalTime(alive_clock_.GetTime());
			death_timer_.stop();			
			dispatchEvent( new PlayerEvent ( PlayerEvent.DEAD ) );
		}
		
		public function GameLoop(e : TimerEvent) {	
			level_manager_.SetPlayerPosition(player_.x, player_.y);			
			for each(var entity : GameEntity in entities_) {
				entity.Input();
				entity.Logic();				
				entity.Render();	
				CheckCollision(entity);
			}
			player_energy_.SetValue(player_.GetEnergy());
			player_shields_.SetValue(player_.GetShields());
			level_manager_.Logic();	
			BringHudToFront();
			shield_hit_anim_.x = player_.x;
			shield_hit_anim_.y = player_.y;
			CleanUpFrame();		
		}
		
		
		private function CheckCollision(entity : GameEntity) : void
		{
			var type1 : Class = Object(entity).constructor;
			var type2 : Class;
			for each(var e : GameEntity in entities_) {
				type2 = Object(e).constructor;
				if ( entity.hitTestObject( e ) ) {
					if (type1 == PlayerShip) {						
						if (type2 == Asteroid) {
							e.SetAlive(false);
							player_.TakeDamage(e.GetDamage());							
							if (player_.GetShields() <= 0) {
									player_.SetAlive(false);
									alive_clock_.Stop();
							}else {
								shield_hit_anim_.gotoAndPlay(2);	
								shield_hit_sound_effect_.play();
							}
						}
						
						if (type2 == Mineral) {							
							var mineral : Mineral = e as Mineral;
							var bonus = mineral.GetEnergyBonus();
							if (mineral.GetType() == 1) {
								player_.AddEnergy(bonus);
							}else {
								player_.AddShields(bonus);
							}
							
							e.SetAlive(false);
						}
						
						if (type2 == PlasmaAmmo) {
							var plasma_bullet : PlasmaAmmo = e as PlasmaAmmo;							
							if (plasma_bullet.GetId() != 0) {								
								player_.TakeDamage(e.GetDamage());								
								if (player_.GetShields() <= 0) {
									player_.SetAlive(false);
								}else {
									shield_hit_anim_.gotoAndPlay(2);
									shield_hit_sound_effect_.play();
								}	
								e.SetAlive(false);
							}							
						}
					}
					if (type1 == PlasmaAmmo) {
						if (type2 == Asteroid) {
							score_.AddToValue( e.GetPoints() );
							e.SetAlive(false);
							entity.SetAlive(false);
						}
						if (type2 == EnemyShip) {
							var bullet : PlasmaAmmo = entity as PlasmaAmmo;
							var enemy_ship : EnemyShip = e as EnemyShip;
							if (bullet.GetId() != enemy_ship.GetId()) {
								e.SetAlive(false);
								bullet.SetAlive(false);
								entity.SetAlive(false);
							}							
						}					
					}
					if (type1 == EnemyShip) {
						if (type2 == Asteroid) {
							e.SetAlive(false);
							entity.SetAlive(false);
						}
					}
				}
				
			}
		}
		
		private function OnMouseMove(e : MouseEvent) {
			aim_.x = mouseX;
			aim_.y = mouseY;
		}
		
		private function CheckOffScreen(entity : GameEntity ) : Boolean {			
			if((entity.x + (entity.width/2)) < -100
			   || (entity.x - (entity.width/2)) > (SCREEN_WIDTH_ + 100)
			   || (entity.y + (entity.height/2)) < -100
			   || (entity.y - (entity.height / 2)) > (SCREEN_HEIGHT_ + 100)) {				  
				return true;
			}else {				
				return false;
			}
		}
		
		private function CleanUpFrame() : void {
			var entity_type : Class;
			for(var i : int = 0; i < entities_.length; i++){		
				if (CheckOffScreen(entities_[i])) {					
					entities_[i].SetAlive(false);				
				}
				if (!entities_[i].IsAlive()) {				
					entity_type = Object(entities_[i]).constructor;	
					if (entity_type == PlayerShip)
					{
						player_.visible = false;
						PlayerDeath();	
					}					
					/*if(entity_type == Asteroid){
						asteroids_count_--;
					}
					if(entity_type == EnemyShip){
						enemy_ships_count_--;
					}*/
					entities_[i].Destroy();					
					entities_[i] = null;
					entities_.splice(i, 1);	
					i--;					
				}
			}					
		}
		
		

	}
	
}
