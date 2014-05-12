package
{
	
	import flash.events.Event;	
	public class NavigationEvent extends Event
	{
		public static const RESTART : String = "restart";
		public static const START_GAME : String = "start";
		public static const CREDITS : String = "credits";
		public static const BACK_TO_MENU : String = "back_to_menu";
		public static const BACK_TO_MENU_GAME_OVER : String = "back_to_menu_game_over";
		public function NavigationEvent( type : String ) 
		{
			super ( type );
		}
		
	}
}