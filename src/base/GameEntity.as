package base {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import base.GameScene;
	import math.Vec2;
	public class GameEntity extends MovieClip {		
		protected var parent_scene_ : GameScene;
		private var is_alive_ : Boolean;
		
		protected var damage_;
		protected var points_;
		protected var resistance_;
		
		public function GameEntity(parent_scene : GameScene = null) 
		{
			parent_scene_ = parent_scene;
			is_alive_ = true;			
		}		
		
		public function Destroy() : void {			
			parent_scene_ = null;
		}
		
		public function Input() : void{			
		}
		
		public function Logic() : void{			
		}
		
		public function Render() : void{			
		}
		
		public function SetParentScene(scene : GameScene) : void{
			parent_scene_  = scene;
		}
		
		public function SetAlive(alive : Boolean) : void {
			is_alive_ = alive;
		}
		
		public function IsAlive() : Boolean {
			return is_alive_;
		}
		
		public function GetDamage() : Number 
		{
			return damage_;
		}
		
		public function GetPoints() : Number
		{
			return points_;
		}
		
		public function GetResistanec() : Number 
		{
			return resistance_;
		}
		
		public function TakeDamage(damage : Number) : void 
		{
			resistance_ -= damage;
		}
		
		public function OnEnterFrame(e : Event) : void
		{
			//DO NOTHING
		}
		
		
		
	}
	
}
