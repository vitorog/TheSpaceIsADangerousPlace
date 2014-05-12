package  {	
	import base.GameEntity;
	import flash.automation.KeyboardAutomationAction;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;	
	import flash.utils.Timer;
	
	import weapons.WeaponEvent;
	import base.GameScene;
	import weapons.PlasmaCannon;
	import Ship;
	
	public class PlayerShip extends Ship {
		private var directions_ : Vector.<Boolean>;
		private var acceleration_ : Number;
				
		private var is_shooting_ : Boolean;		
		private var energy_ : Number;
		private var shields_ : Number;
		private var move_req_energy_ : Number;
		private var energy_timer_ : Timer;
		private var shields_timer_ : Timer;		
		public function PlayerShip(parent_scene : GameScene) {	
			SetParentScene(parent_scene);			
			
			directions_ = new Vector.<Boolean>();
			directions_.push(false); //FORWARD
			directions_.push(false); //BACKWARD
			directions_.push(false); //LEFT
			directions_.push(false); //RIGHT
			
			acceleration_ = 5;
			energy_ = 100.00;
			shields_ = 100.00;
			move_req_energy_ = 0.05;
			
			
			SpaceGame.global_stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			SpaceGame.global_stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);	
			
			parent_scene_.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			parent_scene_.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			parent_scene_.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove );
			
			this.stop();
			
			ship_weapon_ = new PlasmaCannon(parent_scene);		
			ship_weapon_.addEventListener( WeaponEvent.WEAPON_FIRED, OnWeaponFired );
			ship_weapon_.SetId(0);					
		}		
		
		
		override public function Destroy() : void {
			ExplodingAnimation();
			
			SpaceGame.global_stage.removeEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			SpaceGame.global_stage.removeEventListener(KeyboardEvent.KEY_UP, OnKeyUp);	
			
			parent_scene_.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			parent_scene_.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			parent_scene_.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove );
			
			ship_weapon_.Destroy();
			ship_weapon_ = null;
			
			directions_.slice(0, directions_.length);
			directions_ = null;
			super.Destroy();
		}		
	
		
		private function OnKeyDown(e : KeyboardEvent) : void {			
			if(e.keyCode == Keyboard.W ){
				directions_[0] = true;
			}
			if(e.keyCode == Keyboard.S ){
				directions_[1] = true;
			}
			if(e.keyCode == Keyboard.A ){
				directions_[2] = true;
			}
			if(e.keyCode == Keyboard.D ){
				directions_[3] = true;
			}		
		}
		
		private function OnKeyUp(e : KeyboardEvent) : void {
			if(e.keyCode == Keyboard.W ){
				directions_[0] = false;
			}
			if(e.keyCode == Keyboard.S ){
				directions_[1] = false;
			}
			if(e.keyCode == Keyboard.A ){
				directions_[2] = false;
			}
			if(e.keyCode == Keyboard.D ){
				directions_[3] = false;
			}				
		}	
		
		private function OnMouseDown(e : MouseEvent) : void {		
			var weapon_energy_req = ship_weapon_.GetEnergyReq();
			if (energy_ >=  weapon_energy_req) {
				ship_weapon_.StartShooting();
			}
			
		}
		
		private function OnMouseUp(e : MouseEvent) : void {
			ship_weapon_.StopShooting();
		}
		
		private function OnMouseMove(e : MouseEvent) : void {			
			var x_target = parent_scene_.mouseX - x;
			var y_target = parent_scene_.mouseY - y;
			ship_weapon_.SetTarget(x_target, y_target);
		}
		
		override public function Input() : void {
			speed_.x_ = 0;
			speed_.y_ = 0;
			is_moving_ = false;		
			if (directions_[0]) {
				speed_.AddXY(0, -acceleration_);
				is_moving_ = true;
			}
			if (directions_[1]) {
				speed_.AddXY(0, acceleration_);
				is_moving_ = true;
			}
			if (directions_[2]) {
				speed_.AddXY( -acceleration_, 0);
				is_moving_ = true;
			}
			if (directions_[3]) {
				speed_.AddXY(acceleration_, 0);
				is_moving_ = true;
			}			
		}
		
		override public function Logic() : void {	
			if(ship_weapon_ != null){
				ship_weapon_.SetPosition(this.x, this.y);
			}
			if (energy_ >= move_req_energy_) {					
				acceleration_ = 5;
			}else {
				acceleration_ = 0.5;
			}
			Move();
			if (is_moving_) {
				LoseEnergy(move_req_energy_);						
			}
		}		
		
		override public function Render() : void 
		{			
			if (is_moving_) {				
				UpdateDirection();
				if (HasEnergy()) {
					play();	
				}else {
					gotoAndStop(9);
				}							
			}else {
				if (HasEnergy()) {
					gotoAndStop(0);
				}else {					
					gotoAndStop(9);
				}			
			}			
		}
		
		private function OnWeaponFired( e : WeaponEvent ) : void 
		{			
			var weapon_energy_req = ship_weapon_.GetEnergyReq();
			LoseEnergy(weapon_energy_req);
			if (energy_ < weapon_energy_req) {
				ship_weapon_.StopShooting();
			}
		}
		
		public function SetEnergy(num : Number) : void
		{
			energy_ = num;
		}
		
		public function SetShields(num : Number) : void
		{
			shields_ = num;
		}
		
		public function GetEnergy() : Number 
		{
			return energy_;
		}
		
		public function AddEnergy(num : Number ) : void 
		{
			energy_ += num;
			if (energy_ > 100) {
				energy_ = 100;
			}
		}
		
		public function GetShields() : Number 
		{
			return shields_;
		}
		
		public function AddShields(num : Number) : void 
		{
			shields_ += num;
			if (shields_ > 100) {
				shields_ += num;
			}
		}
		
		override public function TakeDamage(num : Number) : void
		{
			shields_ -= num;
			if (shields_ < 0) {
				shields_ = 0;
			}
		}
		
		public function HasEnergy() : Boolean 
		{
			return energy_ > 0.1;
		}
		
		public function LoseEnergy(num : Number) : void
		{
			energy_  -= num;
			if (energy_ < 0) {
				energy_ = 0;
			}
		}
		
	}
	
}
