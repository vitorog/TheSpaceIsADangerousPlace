package base 
{
	import flash.display.MovieClip;
	import flash.media.SoundChannel;
	public class GameItem extends GameEntity
	{		
		protected var energy_bonus_ : Number;
		protected var shield_bonus_ : Number;
		private var sound_effect_channel_ : SoundChannel;		
		public function GameItem() 
		{
			sound_effect_channel_ = new SoundChannel();			
		}		
		
		override public function Destroy() : void 
		{
			this.parent.removeChild(this);		
			sound_effect_channel_ = null;
		}
		
		public function GetShieldBonus() :  Number
		{
			return shield_bonus_;
		}
		
		public function GetEnergyBonus() : Number
		{
			return energy_bonus_;
		}
	}
}