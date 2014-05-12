package math 
{
	public class Utils 
	{
		
		public function Utils() 
		{
			
		}
		
		public static function DegreesToRadians(degrees : Number) : Number {
			var radians : Number = ((degrees * Math.PI) /  180);
			return radians;
		}
		
		public static function RadiansToDegrees(radians : Number) : Number {
			var degrees : Number =  ((radians * 180) / Math.PI);
			return degrees;
		}
		
	}

}