package math {	
	import math.Utils;
	
	public class Vec2 {
		public var x_ : Number;
		public var y_ : Number;
		public function Vec2(x : Number = 0, y : Number = 0) {
			x_ = x;
			y_ = y;
		}
		
		public function Normalize() : void {
			var mag : Number = Magnitude();
			x_ /= mag;
			y_ /= mag;
		}
		
		public function Magnitude() : Number {
			var mag : Number;
			mag = Math.sqrt((x_*x_) + (y_*y_));
			return mag;
		}
		
		public function AddXY(x : Number, y : Number) : void {
			x_ += x;
			y_ += y;
		}
		
		public function AngleBetweenVector(v : Vec2) : Number {
			var dot : Number = Dot(v);			
			this.Normalize();			
			v.Normalize();			
			var angle : Number = Math.acos(dot);			
			return Utils.RadiansToDegrees(angle);
		}
		
		public function Dot(v : Vec2) : Number { 
			var result : Number;
			result = (x_ * v.x_) + (y_ * v.y_);
			return result;
		}	
		

	}
	
}
