package weapons 
{
	import flash.events.Event;	
	public class WeaponEvent extends Event
	{
		public static var WEAPON_FIRED = "weapon_fired";
		public function WeaponEvent( type : String ) 
		{
			super( type );
		}
		
	}

}