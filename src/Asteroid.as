package  
{
	import base.GameEntity;
	import flash.media.SoundChannel;
	import math.Vec2;
	import LevelManager;
	import Mineral;
	import flash.events.Event;
	public class Asteroid extends GameEntity 
	{
		private var direction_ : Vec2;
		private var speed_ : Number;
		private var rotation_speed_ : Number;		
		private var size_scale_ : Number;
		private var sound_channel_ : SoundChannel;
		private var asteroid_hit_sound_ : AsteroidHitSound;
		public function Asteroid() 
		{
			direction_ = new Vec2();
			rotation_speed_ = 5;
			damage_ = 15 + (Math.random() * 2.5);
			points_ = 100;
			LevelManager.asteroids_count_++;
			size_scale_ = 0.8 + (Math.random() * 0.5);
			this.scaleX = size_scale_;
			this.scaleY = size_scale_;
			sound_channel_ = new SoundChannel();
			asteroid_hit_sound_ = new AsteroidHitSound();
			this.stop();
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
		}
		
		override public function Destroy() : void
		{	
			asteroid_hit_sound_.play();
			this.play();				
		}
		
		public function ClearAsteroid() : void 
		{
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);	
			var chance : Number = Math.floor(Math.random() * 100);	
			var mineral_type : Number = 1;
			if (chance >= 90) {
				//This sets the bonus to be a shield bonus
				mineral_type = 2;
			}
			var mineral : Mineral = new Mineral(mineral_type);			
			parent_scene_.AddEntity(mineral);
			mineral.x = this.x;
			mineral.y = this.y;
			
			LevelManager.asteroids_count_--;
			direction_ = null;
			this.parent.removeChild(this);
			parent_scene_ = null;
			
			sound_channel_ = null;
			asteroid_hit_sound_ = null;		
		}
		
		override public function Logic() : void
		{
				Move();
				Rotate();				
		}
		
		protected function Move() : void{
			x += direction_.x_ * speed_;
			y += direction_.y_ * speed_;		
		}
		
		public function SetDirection(dir_x : Number, dir_y : Number) : void
		{
			direction_.x_ = dir_x;
			direction_.y_ = dir_y;
		}
		
		public function SetSpeed(speed : Number ) : void 
		{
			speed_ = speed;
		}
		
		public function SetRotationSpeed(rotation_speed : Number) : void
		{
			rotation_speed_ = rotation_speed;
		}
		
		private function Rotate() : void	
		{
			rotation += rotation_speed_;
		}
		
		override public function OnEnterFrame(e : Event) : void
		{
			if (currentFrame == totalFrames) {
				this.stop();
				ClearAsteroid();
			}
		}
		
	}

}