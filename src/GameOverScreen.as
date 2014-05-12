package  
{	
	import base.GameScene;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	public class GameOverScreen extends GameScene
	{
		private var score_ : Score;
		private var time_score_ : TimeScore;
		public function GameOverScreen() 
		{			
			Mouse.show();			
			restartButton.addEventListener( MouseEvent.CLICK, OnClickRestart);
			backToMenuGameOverButton.addEventListener( MouseEvent.CLICK, OnClickBackToMenu);
			score_ = new Score();
			var score_label : TextField = score_.getChildByName("ScoreLabel") as TextField;
			score_label.text = "Your score: ";
			score_label.x -= 30;
			score_label.textColor = 0xFFFFFF;
			var score_value : TextField = score_.getChildByName("score") as TextField;
			score_value.x += 45;
			score_.AddToValue( SpaceGame.GetFinalScore() );
			addChild(score_);								
			score_.x = width / 2 - 130;
			score_.y = height / 4 + 130;
			
			
			time_score_ = new TimeScore();
			var time_score_label : TextField = time_score_.getChildByName("time_score") as TextField;
			time_score_label.text = SpaceGame.GetFinalTime();
			addChild(time_score_);
			time_score_.x = width / 2 - 130;
			time_score_.y = height / 4 + 130 + score_.height;		
		}
		
		public function OnClickRestart(mouse_event : MouseEvent) : void 
		{
			dispatchEvent( new NavigationEvent ( NavigationEvent.RESTART ) );
		}	
		
		public function OnClickBackToMenu(mouse_event : MouseEvent) : void
		{
			dispatchEvent( new NavigationEvent ( NavigationEvent.BACK_TO_MENU_GAME_OVER ) );
		}
		
		override public function Destroy() : void 
		{
				score_ = null;
		}
	}
}