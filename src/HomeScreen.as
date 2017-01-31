package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.Font;
	
	/**
	 * ...
	 * @author Drew Calupe
	 */
	public class HomeScreen extends MovieClip {
		private var modals:MovieClip;
		private var gameStages:GameStages;
		private var headerTitle:HeaderTitle;
		
		public function HomeScreen() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			hide();
			modals = MovieClip(this.parent).modals;
			this.exitGame.addEventListener(TouchEvent.TOUCH_BEGIN, showExitModal);
			
			gameStages = new GameStages();
			headerTitle = new HeaderTitle();
			addChild(gameStages);
			addChild(headerTitle);
			
			changeHeaderTitle("Select Stage");
		}
		
		private function showExitModal(e:TouchEvent):void {
			
			if (gameStages.isLevelsShowing) {
				gameStages.removeLevels();
				gameStages.showSelectStage();
				gameStages.isLevelsShowing = false;
				changeHeaderTitle("Select Stage");
				return;
			}
			
			modals.showQuitModal();
		}
		
		public function changeHeaderTitle (title:String):void {
			headerTitle.gotoAndStop(title);
		}

		public function hide():void {
			visible = false;
		}
		
		public function show():void {
			visible = true;
		}
	}
}