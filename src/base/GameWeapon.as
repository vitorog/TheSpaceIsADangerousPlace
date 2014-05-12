package base 
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import base.GameScene;
	import weapons.WeaponEvent;
	import flash.events.Event;	
	public class GameWeapon extends MovieClip
	{
		protected var rate_of_fire_ : Number;
		protected var damage_ : Number;		
		protected var parent_scene_ : GameScene;
		protected var shoot_timer_ : Timer;
		protected var target_x_ : Number;
		protected var target_y_ : Number;
		protected var x_pos_ : Number;
		protected var y_pos_ : Number;		
		private var shooting_check_ : Boolean;
		protected var energy_requirement_ : Number;
		protected var id_ : Number;
		public function GameWeapon(parent_scene : GameScene)
		{			
			shoot_timer_ = null;
			parent_scene_ = parent_scene;			
			energy_requirement_ = 0;
			id_ = -1;
		}
		
		protected function SetupWeapon() : void
		{			
			rate_of_fire_ = 0;			
			damage_ = 0;
			x_pos_ = 0;
			y_pos_ = 0;
			
		}
		
		public function StartShooting() : void 
		{			
			Shoot();			
			shoot_timer_.start();		
		}
		
		public function StopShooting() :  void 
		{			
			shoot_timer_.stop();					
		}
		
		protected function OnShootTimer( e : TimerEvent ) : void 
		{			
			Shoot();		
		}
		
		protected function Shoot() : void
		{
			
		}
		
		public function SetTarget( target_x : Number, target_y : Number )
		{
			target_x_ = target_x;
			target_y_ = target_y;
		}
		
		public function SetPosition(x_pos : Number, y_pos : Number)
		{
			x_pos_ = x_pos;
			y_pos_ = y_pos;
		}
		
		public function Destroy() : void
		{
			shoot_timer_.stop();
			shoot_timer_.removeEventListener( TimerEvent.TIMER, OnShootTimer );
			shoot_timer_ = null;
			parent_scene_ = null;
		}
		
		public function GetEnergyReq() : Number 
		{
			return energy_requirement_;
		}
		
		public function SetId(id : Number) : void
		{
			id_ = id;
		}
		
		public function GetId() : Number
		{
			return id_;
		}
		
	}

}