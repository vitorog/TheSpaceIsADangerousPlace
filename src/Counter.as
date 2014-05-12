package  {
	import flash.display.MovieClip;
	public class Counter extends MovieClip {
		public var current_value_  : Number;	
		public function Counter() {		
			Reset();
		}
		
		public function Reset() : void {
			current_value_ = 0;
			UpdateDisplay();
		}
		
		public function AddToValue(num : Number) : void {
			current_value_ += num;			
			UpdateDisplay();
		}
		
		public function SubtractFromValue(num : Number) : void
		{
			current_value_ -= num;
			UpdateDisplay();
		}
		
		public function SetValue(num : Number) : void
		{
			current_value_ = num;
			UpdateDisplay();
		}
		
		public function UpdateDisplay() : void {
			
		}
		

	}
	
}
