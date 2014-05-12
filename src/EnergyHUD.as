package  
{
	public class EnergyHUD extends Counter
	{
		
		public function EnergyHUD() 
		{
			super();
		}
		
		override public function UpdateDisplay() : void {
			super.UpdateDisplay();
			energy.text = current_value_.toFixed(2).toString() + "%";		
		}		
		
		
	}

}