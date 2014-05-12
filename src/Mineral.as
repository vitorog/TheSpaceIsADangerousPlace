package  
{
	
	import Math;
	
	
	import base.GameItem;
	public class Mineral extends GameItem
	{		
		private var max_energy_bonus : Number;
		private var energy_pickup_effect_ : EnergyPickupSound;
		private var type_ : Number; //If it gives energy or shield bonus
		public function Mineral(type : Number = 1 ) 
		{
			max_energy_bonus = 12;
			energy_bonus_ = Math.floor(Math.random() * max_energy_bonus);	
			energy_pickup_effect_ = new EnergyPickupSound();
			type_ = type;
			if (type_ == 2) {
				gotoAndPlay(40);
			}
			var scale_rate : Number = (2*energy_bonus_) / 12;
			scaleX = scale_rate;
			scaleY = scale_rate;
			scaleZ = scale_rate;			
		}		
		
		override public function Destroy() : void
		{			
			energy_pickup_effect_ = null;
			super.Destroy();
		}
		
		override public function GetEnergyBonus() : Number
		{
			energy_pickup_effect_.play();
			return super.GetEnergyBonus();
		}
		
		public function GetType() : Number 
		{
			return type_;
		}
	}

}