package  
{	
	import base.GameEntity;
	import base.GameScene;	
	import math.Vec2;
	public class PlasmaAmmo extends GameEntity
	{
		private var dir_ : Vec2;
		private var speed_ : Number;
		private var id_ : Number;	
		public function PlasmaAmmo(dir_x : Number, dir_y : Number, speed : Number, color : Number = 1 ) 
		{			
			dir_ = new Vec2(dir_x, dir_y);			
			speed_ = speed;
			damage_ = 19;
			gotoAndStop(color); //Each frame will have a color
		}
		
		override public function Logic() : void
		{			
			Move();
		}
		
		override public function Destroy() : void {			
			this.parent.removeChild(this);
		}
		
		private function Move() : void 
		{			
			dir_.Normalize();
			x += dir_.x_ * speed_;
			y += dir_.y_ * speed_;	
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