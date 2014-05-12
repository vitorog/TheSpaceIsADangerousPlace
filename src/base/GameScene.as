package base {
	import flash.display.MovieClip;
	import base.GameEntity;
	public class GameScene extends MovieClip{
		protected var entities_ : Vector.<GameEntity>;	
		protected var width_ : Number;
		protected var height_ : Number;
		public function GameScene() {
			entities_ = new Vector.<GameEntity>();
		}
		
		public function AddEntity(entity : GameEntity) 
		{
			entities_.push(entity);
			addChild(entity);
		}
		
		public function Destroy() : void
		{			
		}
		
		public function SetSize(width : Number, height : Number) : void
		{
			width_ = width;
			height_ = height;
		}
		
		public function GetWidth() : Number
		{
			return width_;
		}
		
		public function GetHeight() : Number
		{
			return height_;
		}

	}
	
}
