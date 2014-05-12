package  
{
	import base.GameScene;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	public class CreditsScreen extends GameScene
	{
		
		public function CreditsScreen() 
		{
			Mouse.show();			
			backToMenuButton.addEventListener( MouseEvent.CLICK, OnClickBack);
		}
		
		public function OnClickBack(e :  MouseEvent ) : void
		{
			dispatchEvent( new NavigationEvent ( NavigationEvent.BACK_TO_MENU ) );
		}
		
	}

}