package  {	
	import base.GameScene;
	import base.GameWeapon;
	import flash.media.SoundChannel;
	import math.Vec2;
	import base.GameEntity;	
	public class Ship extends GameEntity {
		protected var speed_ : Vec2;
		protected var speed_factor_ : Number;
		//protected var speed_ : Number;
		protected var ship_weapon_ : GameWeapon;
		protected var is_moving_ : Boolean;
		
		private var explosion_sound_channel_ : SoundChannel;
		private var explosion_sound_effect_ : ExplosionSoundEffect;
		public function Ship(parent_scene : GameScene = null) {
			speed_ = new Vec2();
			speed_factor_ = 1;
			ship_weapon_ = null;
			is_moving_ = false;		
			
			explosion_sound_channel_ = new SoundChannel();
			explosion_sound_effect_ = new ExplosionSoundEffect();
		}
		
		override public function Logic() : void {	
			if(ship_weapon_ != null){
				ship_weapon_.SetPosition(this.x, this.y);
			}
			Move();
		}
		
		override public function Destroy() : void{
			speed_ = null;
			super.Destroy();
		}
		
		protected function Move() : void{
			x += speed_.x_ * speed_factor_;
			y += speed_.y_ * speed_factor_;		
		}
		
		protected function UpdateDirection() : void {
			var speed : Vec2 = speed_;
			var forward_dir : Vec2 = new Vec2(0, -1);
			speed.Normalize();
			var angle : Number = speed.AngleBetweenVector(forward_dir);
			if(speed.x_ < 0 ){
				angle = -angle;
			}									
			rotation = angle;	
			forward_dir = null;
		}
		
		override public function Render() : void 
		{
			if (is_moving_) {				
				UpdateDirection();
				play();				
			}else {
				gotoAndStop(0);
			}
		}
		
		protected function ExplodingAnimation() : void 
		{
			explosion_sound_effect_.play();
			var ship_exploding_ : ShipExploding = new ShipExploding();
			ship_exploding_.x = this.x;
			ship_exploding_.y = this.y;
			this.parent.addChild(ship_exploding_);
			ship_exploding_.play();
		}

	}
	
}
