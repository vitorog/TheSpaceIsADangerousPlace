package  {
	
	import base.Game;	
	import flash.display.Stage;
	
	public class SpaceGame extends Game {		
		private var play_screen_ : PlayScreen;
		private var main_menu_screen_ : MainMenu;
		private var credits_screen_ : CreditsScreen;
		private var game_over_screen_ : GameOverScreen;
		private static var final_score_ : Number;
		private static var final_time_ : String;
		public static var global_stage : Stage;
		public function SpaceGame() {			
			global_stage = this.stage;			
			SetupMainMenu();
		}
		
		private function SetupMainMenu() : void {
			play_screen_ = null;
			credits_screen_ = null;
			game_over_screen_ = null;
			
			main_menu_screen_ = new MainMenu();
			main_menu_screen_.addEventListener( NavigationEvent.START_GAME, OnStartGame );
			main_menu_screen_.addEventListener( NavigationEvent.CREDITS, OnCreditsClicked );			
			addChild(main_menu_screen_);
		}				
		
		private function OnStartGame ( e : NavigationEvent ) : void {
			
			removeChild(main_menu_screen_);			
			main_menu_screen_.removeEventListener( NavigationEvent.START_GAME, OnStartGame );
			main_menu_screen_.removeEventListener( NavigationEvent.CREDITS, OnCreditsClicked );			
			main_menu_screen_ = null;
			
			play_screen_ = new PlayScreen();
			play_screen_.addEventListener( PlayerEvent.DEAD, OnPlayerDeath );
			addChild(play_screen_);
			stage.focus = stage;
		}
		
		private function OnCreditsClicked( e : NavigationEvent ) : void 
		{
			removeChild(main_menu_screen_);			
			main_menu_screen_.removeEventListener( NavigationEvent.START_GAME, OnStartGame );
			main_menu_screen_.removeEventListener( NavigationEvent.CREDITS, OnCreditsClicked );			
			main_menu_screen_ = null;
			
			credits_screen_ = new CreditsScreen();
			credits_screen_.addEventListener( NavigationEvent.BACK_TO_MENU, OnBackToMenu );
			addChild(credits_screen_);
		}
		
		private function OnBackToMenu( e : NavigationEvent ) : void 
		{
			removeChild(credits_screen_);
			credits_screen_.removeEventListener( NavigationEvent.BACK_TO_MENU, OnBackToMenu );
			credits_screen_ = null;
			SetupMainMenu();
		}
		
		private function OnBackToMenuGameOver( e : NavigationEvent ) : void
		{
			removeChild(game_over_screen_);
			game_over_screen_.removeEventListener( NavigationEvent.BACK_TO_MENU_GAME_OVER, OnBackToMenuGameOver );
			game_over_screen_ = null;
			SetupMainMenu();
		}
		
		private function OnPlayerDeath( e : PlayerEvent ) : void 
		{
			play_screen_.Destroy();
			removeChild(play_screen_);
			play_screen_ = null;
			
			game_over_screen_ = new GameOverScreen();
			addChild(game_over_screen_);
			game_over_screen_.addEventListener( NavigationEvent.RESTART, OnRestartGame );
			game_over_screen_.addEventListener( NavigationEvent.BACK_TO_MENU_GAME_OVER, OnBackToMenuGameOver );
		}
		
		private function OnRestartGame( e : NavigationEvent ) : void
		{
			game_over_screen_.Destroy();
			removeChild(game_over_screen_);
			game_over_screen_ = null;
			
			
			play_screen_ = new PlayScreen();
			play_screen_.addEventListener( PlayerEvent.DEAD, OnPlayerDeath );
			addChild(play_screen_);
			stage.focus = stage;
		}
		
		public static function SetFinalScore(score : Number ) : void 
		{
			final_score_ = score;
		}
		
		public static function GetFinalScore() : Number 
		{
			return final_score_;
		}	
		
		public static function SetFinalTime(time : String ) : void 
		{
			final_time_ = time;
		}
		
		public static function GetFinalTime() : String 
		{
			return final_time_;
		}
	}
}
