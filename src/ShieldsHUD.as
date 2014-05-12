package  
{
	public class ShieldsHUD extends Counter
	{
		
		public function ShieldsHUD() 
		{
			super();
		}
		
		override public function UpdateDisplay() : void {
			super.UpdateDisplay();
			shields.text = current_value_.toFixed(2).toString() + "%";	
			
		}
		
	}

}