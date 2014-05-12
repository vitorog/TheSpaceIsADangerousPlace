package  
{	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Math;	
	
	import base.GameScene;
	import base.GameEntity;
	import math.Vec2;
	import Asteroid;
	import EnemyShip;

	
	public class LevelManager extends GameEntity
	{		
		public static var player_pos_ : Vec2;
		
		public static var asteroids_count_ : Number;
		private var asteroids_rate_ : Number;
		private var max_asteroids_ : Number;
		
		public static var enemy_ships_count_ : Number;
		private var enemy_ships_rate_ : Number;
		private var max_enemy_ships_ : Number;
		
		private var level_timer_ : Timer;
		private var generate_timer_ : Timer;
		private var current_level_ : Number;
		public function LevelManager(parent_scene : GameScene) 
		{
			super( parent_scene );
			player_pos_ = new Vec2();			
			asteroids_count_ = 0;
			enemy_ships_count_ = 0;
			
			current_level_ = 1;
			level_timer_ = new Timer(10000);
			level_timer_.addEventListener(TimerEvent.TIMER, OnLevelFinish );
			level_timer_.start();	
			SetLevelChallenge();
			
			generate_timer_ = new Timer(100);
			generate_timer_.addEventListener(TimerEvent.TIMER, GenerateChallenge );
			generate_timer_.start();
		}		
		
		public override function Destroy() : void 
		{
			level_timer_.stop();
			level_timer_.removeEventListener(TimerEvent.TIMER, OnLevelFinish);
			level_timer_ = null;
			
			generate_timer_.stop();
			generate_timer_.removeEventListener(TimerEvent.TIMER, GenerateChallenge );
			generate_timer_ = null;
			
			player_pos_ = null;
			super.Destroy();
		}
		
		public function GenerateChallenge( e : TimerEvent ) {
			if (asteroids_count_ < max_asteroids_) {
				if ((Math.random() * 100) <= asteroids_rate_) {
						GenerateAsteroids();
				}				
			}
			if (enemy_ships_count_ < max_enemy_ships_) {
				if ((Math.random() * 100) <= enemy_ships_rate_) {
					GenerateEnemyShip();
				}
			}
		}
		
		private function OnLevelFinish( e : TimerEvent )
		{
			current_level_++;
			max_asteroids_++;
			SetLevelChallenge();
		}
		
		private function SetLevelChallenge() : void 
		{
			switch(current_level_) {
				case 1:					
					asteroids_rate_ = 40;
					max_asteroids_ = 2;					
					enemy_ships_rate_ = 0;
					max_enemy_ships_ = 0;
				break;
				case 2:
					max_asteroids_ = 2;
					asteroids_rate_ = 45;
					
					enemy_ships_rate_ = 0;
					max_enemy_ships_ = 0;
				break;
				case 3:
					max_asteroids_ = 3;
					asteroids_rate_ = 50;
					
					enemy_ships_rate_ = 0;
					max_enemy_ships_ = 0;
				break;
				case 4:
					max_asteroids_ = 3;
					asteroids_rate_ = 55;
					
					enemy_ships_rate_ = 0;
					max_enemy_ships_ = 0;
				break;
				case 5:
					max_asteroids_ = 4;
					asteroids_rate_ = 55;
					
					enemy_ships_rate_ = 5;
					max_enemy_ships_ = 1;
				break;
				case 6:
					max_asteroids_ = 4;
					asteroids_rate_ = 60;
					
					enemy_ships_rate_ = 6;
					max_enemy_ships_ = 2;
				break;
				case 7:
					max_asteroids_ = 5;
					asteroids_rate_ = 60;
					
					enemy_ships_rate_ = 10;
					max_enemy_ships_ = 2;
				break;
				case 8:
					max_asteroids_ = 6;
					asteroids_rate_ = 65;
					
					enemy_ships_rate_ = 12;
					max_enemy_ships_ = 3;
				break;
				case 9:
					max_asteroids_ = 7;
					asteroids_rate_ = 65;
					
					enemy_ships_rate_ = 16;
					max_enemy_ships_ = 4;
				break;
				case 10:
					max_asteroids_ = 8;
					asteroids_rate_ = 70;
					
					enemy_ships_rate_ = 20;
					max_enemy_ships_ = 5;
				break;
				default:
					max_asteroids_++;
					asteroids_rate_ += 5;
					
					enemy_ships_rate_ += 5;
					max_enemy_ships_++;
				break;
			}
			
		}
		
		public function SetPlayerPosition(x_pos : Number, y_pos : Number)
		{
			player_pos_.x_ = x_pos;
			player_pos_.y_ = y_pos;
		}
		
		
		private function GenerateAsteroids() : void {
			var corner : Number;
			corner = Math.floor((Math.random() * 4));
			var asteroid_position : Vec2 = new Vec2();
			switch(corner){				
				case 0:	 //TOP	
				asteroid_position.x_ = Math.floor(Math.random() * parent_scene_.GetWidth() );
				asteroid_position.y_ = -50;				
				break;				
				case 1: //BOTTOM
				asteroid_position.x_ = Math.floor(Math.random() * parent_scene_.GetWidth() );
				asteroid_position.y_ = parent_scene_.GetHeight() + 50;	
				break;				
				case 2: //LEFT
				asteroid_position.x_ = -50;
				asteroid_position.y_ = Math.floor(Math.random() * parent_scene_.GetHeight());
				break;
				case 3: //RIGHT
				asteroid_position.x_ = parent_scene_.GetWidth() + 50;
				asteroid_position.y_ = Math.floor(Math.random() * parent_scene_.GetHeight());
				break;
			}	
			var asteroid : Asteroid = new Asteroid();
			asteroid.SetParentScene(parent_scene_);
			asteroid.x = asteroid_position.x_;
			asteroid.y = asteroid_position.y_;
			var asteroid_direction : Vec2 = new Vec2();
			asteroid_direction.x_ = player_pos_.x_ - asteroid_position.x_;
			asteroid_direction.y_ = player_pos_.y_ - asteroid_position.y_;
			asteroid_direction.Normalize();
			asteroid.SetDirection(asteroid_direction.x_, asteroid_direction.y_);			
			var speed : Number = Math.random() * 10;
			asteroid.SetSpeed(speed);
			var rotation_speed : Number = Math.ceil(Math.random() * 20);
			asteroid.SetRotationSpeed(rotation_speed);
			parent_scene_.AddEntity(asteroid);			
		}
		
		private function GenerateEnemyShip() : void {			
			var corner : Number;
			corner = Math.floor((Math.random() * 4));
			var enemy_pos : Vec2 = new Vec2();
			switch(corner){				
				case 0:	 //TOP	
				enemy_pos.x_ = Math.floor(Math.random() * parent_scene_.GetWidth() );
				enemy_pos.y_ = -50;				
				break;				
				case 1: //BOTTOM
				enemy_pos.x_ = Math.floor(Math.random() * parent_scene_.GetWidth());
				enemy_pos.y_ = parent_scene_.GetHeight() + 50;	
				break;				
				case 2: //LEFT
				enemy_pos.x_ = -50;
				enemy_pos.y_ = Math.floor(Math.random() * parent_scene_.GetHeight());
				break;
				case 3: //RIGHT
				enemy_pos.x_ = parent_scene_.GetWidth() + 50;
				enemy_pos.y_ = Math.floor(Math.random() * parent_scene_.GetHeight());
				break;
			}	
						
			var enemy_ship : EnemyShip = new EnemyShip(parent_scene_);	
			parent_scene_.AddEntity(enemy_ship);
			
			enemy_ship.x = enemy_pos.x_;
			enemy_ship.y = enemy_pos.y_;			
			var dir_x : Number = player_pos_.x_ - enemy_pos.x_;
			var dir_y : Number = player_pos_.y_ - enemy_pos.y_;
			enemy_ship.SetDirection(dir_x, dir_y);
			enemy_ship.StartShooting();
			enemy_pos = null;			
		}
	}

}