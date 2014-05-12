package  
{
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class Clock 
	{
		var timer_ : Timer;
		var seconds_ : Number;
		var minutes_ : Number;
		var hours_ : Number;
		public function Clock() 
		{
			Reset();
			timer_ = new Timer(1000);			
			timer_.addEventListener(TimerEvent.TIMER, OnTimeout);
		}
		
		public function Destroy()
		{
			timer_.removeEventListener(TimerEvent.TIMER, OnTimeout);
			timer_ = null;
		}
	
		public function Start() : void
		{
			timer_.start();
		}
		
		public function Stop() : void 
		{
			timer_.stop();
		}
		
		public function Reset() : void 
		{
			seconds_ = 0;
			minutes_ = 0;
			hours_ = 0;
		}
		
		private function OnTimeout(e : TimerEvent) : void{
			if (++seconds_ >= 60) {
				seconds_ = 0;				
				if (++minutes_ >= 60) {
					minutes_ = 0;
					hours_++;
				}
			}
		}
		
		public function GetSeconds() : Number 
		{
			return seconds_;
		}
		
		public function GetMinutes() : Number 
		{
			return minutes_;
		}
		
		public function GetHours() : Number 
		{
			return hours_;
		}
		
	}

}