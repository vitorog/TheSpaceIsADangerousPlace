package weapons 
{
	import base.GameEntity;
	import base.GameWeapon;
	import base.GameScene;
	import flash.media.SoundChannel;
	import PlasmaAmmo;
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class PlasmaCannon extends GameWeapon
	{
		private var shoot_sound_channel_ : SoundChannel;
		private var shoot_sound_effect_ : PlasmaCannonSoundEffect;
		private var color_ : Number;
		public function PlasmaCannon(parent_scene : GameScene, rate_of_fire : Number = 200, color : Number = 1 ) 
		{
			super( parent_scene );
			shoot_sound_channel_ = new SoundChannel();
			shoot_sound_effect_ = new PlasmaCannonSoundEffect();
			
			rate_of_fire_ = rate_of_fire;
			color_ = color;
			SetupWeapon();
		}
		
		override protected function SetupWeapon() : void
		{			
			energy_requirement_ = 3.1;
			damage_ = 10;
			target_x_ = 0;
			target_y_ = 0;
			shoot_timer_ = new Timer( rate_of_fire_ );
			shoot_timer_.addEventListener( TimerEvent.TIMER, OnShootTimer );
		}
		
		override protected function Shoot() : void 
		{			
			shoot_sound_effect_.play();
			dispatchEvent( new WeaponEvent( WeaponEvent.WEAPON_FIRED ) );
			var plasma_bullet : PlasmaAmmo = new PlasmaAmmo(target_x_, target_y_, 15, color_);			
			plasma_bullet.SetId(id_);
			plasma_bullet.x = x_pos_;
			plasma_bullet.y = y_pos_;
			parent_scene_.AddEntity(plasma_bullet);			
		}
	}

}