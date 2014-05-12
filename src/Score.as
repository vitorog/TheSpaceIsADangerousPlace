package  {
	import flash.text.TextField
	public class Score  extends Counter {
		
		public function Score() {			
			super();			
		}
		
		override public function UpdateDisplay() : void {
			super.UpdateDisplay();
			var curr_value : String = current_value_.toString();
			var num_zeroes : Number = 9 - curr_value.length;
			var text : String = "";
			for (var i = 0; i < num_zeroes; i++) {
				text += "0";
			}
			text +=  current_value_.toString();		
			score.text = text;
		}

	}
	
}
