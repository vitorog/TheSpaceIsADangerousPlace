package  
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	public class TimerHUD extends MovieClip
	{
		private var clock_ : Clock;
		private var update_timer_ : Timer;
		public function TimerHUD() 
		{
			clock_ = new Clock();		
			update_timer_ = new Timer(1000);
			update_timer_.addEventListener(TimerEvent.TIMER, UpdateDisplay);		
			update_timer_.start();
		}		
		
		public function Destroy() : void
		{			
			clock_.Destroy();
			clock_ = null;
			update_timer_.removeEventListener(TimerEvent.TIMER, UpdateDisplay);
			update_timer_ = null;			
		}
		
		public function UpdateDisplay(e : TimerEvent) : void {	
			var time : String;
			var seconds : Number = clock_.GetSeconds();
			var minutes : Number = clock_.GetMinutes();
			var minutes_str : String;
			var seconds_str : String;
			if (minutes <= 9) {
				minutes_str = "0" + String(minutes);
			}else {
				minutes_str = String(minutes);
			}
			if (seconds <= 9) {
				seconds_str = "0" + String(seconds);
			}else {
				seconds_str = String(seconds);
			}			
			clock.text = minutes_str + ":" + seconds_str;			
		}
		
		public function Stop() 
		{
			clock_.Stop();
		}
		
		public function Start() 
		{
			clock_.Start();		
		}
		
		public function GetTime() : String 
		{
			return clock.text;
		}
	}

}