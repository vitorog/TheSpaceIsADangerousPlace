package  
{	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.ui.Mouse;
	
	import base.GameScene;
	import NavigationEvent;	
	public class MainMenu extends GameScene
	{		
		public var backgroundMusic : BackgroundMusic;
		public var bgmSoundChannel : SoundChannel;
		
		public function MainMenu() 
		{
			Mouse.show();			
			startGameButton.addEventListener( MouseEvent.CLICK, OnStartClicked );
			creditsButton.addEventListener( MouseEvent.CLICK, OnCreditsClicked );
			backgroundMusic = new BackgroundMusic();
			bgmSoundChannel = backgroundMusic.play();
		}
		
		public function OnStartClicked( e : MouseEvent ) : void {
			dispatchEvent( new NavigationEvent ( NavigationEvent.START_GAME ) );
			
		}
		
		public function OnCreditsClicked( e : MouseEvent ) : void {
			dispatchEvent( new NavigationEvent ( NavigationEvent.CREDITS ) );
		}		
	}
}