package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.display.StageScaleMode;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	/**
	 * ...
	 * @author Drew Calupe
	 */
	public class Main extends MovieClip {

		public var db:Database;
		public var modals:Modals;
		public var game:Game;
		public var homeScreen:HomeScreen;
		public var startScreen:StartScreen;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			db = new Database();
			modals = new Modals();
			game = new Game();
			homeScreen = new HomeScreen();
			startScreen = new StartScreen();
			
			addChild(startScreen);
			addChild(homeScreen);
			addChild(game);
			addChild(modals);
		}
	}
}