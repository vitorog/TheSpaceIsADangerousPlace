package  
{
	import base.GameScene;
	import Ship;
	import weapons.PlasmaCannon;
	
	public class EnemyShip extends Ship
	{	
		public function EnemyShip(parent_scene : GameScene) 
		{
			SetParentScene(parent_scene);
			LevelManager.enemy_ships_count_++;
			is_moving_ = true;
			speed_factor_ = 5;
			ship_weapon_ = new PlasmaCannon(parent_scene_, 800, 2);			
			ship_weapon_.SetId(LevelManager.enemy_ships_count_);			
		}	
		
		public function SetDirection(dir_x : Number, dir_y : Number) 
		{			
			speed_.x_ = dir_x;
			speed_.y_ = dir_y;
			speed_.Normalize();		
		}
		
		override public function Destroy() : void
		{
			if (x > 0 && x < 800) {
				if (y > 0 && y < 600) {
					ExplodingAnimation();
				}
			}
			
			
			this.parent.removeChild(this);
			parent_scene_ = null;
			LevelManager.enemy_ships_count_--;
			ship_weapon_.Destroy();
			ship_weapon_ = null;
			super.Destroy();
		}	
		
		override public function Logic() : void {			
			var x_target = LevelManager.player_pos_.x_;
			var y_target = LevelManager.player_pos_.y_;			
			ship_weapon_.SetTarget(x_target - this.x, y_target - this.y);
			super.Logic();
		}
		
		public function GetId() : Number 
		{
			return ship_weapon_.GetId();
		}			
		
		public function StartShooting() : void
		{
			ship_weapon_.SetPosition(this.x, this.y);
			ship_weapon_.SetTarget(LevelManager.player_pos_.x_, LevelManager.player_pos_.y_);
			ship_weapon_.StartShooting();	
		}
		
	}
}