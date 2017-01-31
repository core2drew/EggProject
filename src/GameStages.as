package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	/**
	 * ...
	 * @author Drew Calupe
	 */
	public class GameStages extends MovieClip {
		public var gameLevels:GameLevels;
		public var isLevelsShowing:Boolean;
		public var game:Game;	
		public var homeScreen:HomeScreen;
		
		public function GameStages() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			homeScreen = MovieClip(this.parent) as HomeScreen;
			game = MovieClip(this.parent.parent).game;
			
			this.memoryEgg.addEventListener(TouchEvent.TOUCH_BEGIN, function(e:TouchEvent):void {
				showSelectedStageLevels('memoryEgg');
			});
			
			this.catchTheEgg.addEventListener(TouchEvent.TOUCH_BEGIN, function(e:TouchEvent):void { 
				showSelectedStageLevels('catchTheEgg');
			});
			
			this.eggQuake.addEventListener(TouchEvent.TOUCH_BEGIN, function (e:TouchEvent):void {
				showSelectedStageLevels('eggQuake');
			});
		}
		
		public function showSelectedStageLevels(selectedStage:String):void {
			homeScreen.changeHeaderTitle("Select Level");
			hideSelectStage();
			gameLevels = new GameLevels();
			addChild(gameLevels);
			gameLevels.getGameLevelsData(selectedStage);
		}
		
		public function hideSelectStage():void {
			isLevelsShowing = true;
			this.memoryEgg.visible = false;
			this.catchTheEgg.visible = false;
			this.eggQuake.visible = false;
		}
		
		public function showSelectStage():void {
			this.memoryEgg.visible = true;
			this.catchTheEgg.visible = true;
			this.eggQuake.visible = true;
		}
		
		public function removeLevels():void {
			removeChild(gameLevels);
		}
		
		public function hide():void {
			visible = false;
		}
		
		public function show():void {
			visible = true;
		}
	}
}