package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Drew Calupe
	 */
	public class Game extends MovieClip{
		
		private var modals:MovieClip;
		private var homeScreen:MovieClip;
		
		private var memoryEgg:MemoryEgg;
		private var catchTheEgg:CatchTheEgg;
		private var eggQuake:EggQuake;
		
		private var isGamePause:Boolean;
		private var currentGame:String;
		private var currentLevelData:Object;
		
		public function Game() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Native Device Back Button Event
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_UP, handleBackButton, false, 0, true);
			
			modals = MovieClip(this.parent).modals;
			homeScreen = MovieClip(this.parent).homeScreen;
		}
		
		public function startGame(game:String, levelData:Object) {
			homeScreen.hide();
			currentGame = game;
			currentLevelData = levelData;
			
			switch (game) {
				case 'memoryEgg':
					memoryEgg = new MemoryEgg();
					addChild(memoryEgg);
					memoryEgg.cardInit(currentLevelData);
				break;
				
				case 'catchTheEgg':
					catchTheEgg = new CatchTheEgg();
					catchTheEgg.catchInit(currentLevelData);
					addChild(catchTheEgg);
				break;
				
				case 'eggQuake':
					eggQuake = new EggQuake();
				break;
				default:
			}
		}
		
		public function handleBackButton (e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.BACK) {
				
				if (numChildren > 0 ) {
					if (!isGamePause) {
						modals.showPauseModal();
					}
				}
				
				e.preventDefault();
				e.stopImmediatePropagation();
			}
		}
		
		public function pause():void {
			switch (currentGame) {
				case 'memoryEgg':
					memoryEgg.pause();
				break;
				
				case 'catchTheEgg':
					catchTheEgg.catchInit(currentLevelData);
				break;
				
				case 'eggQuake':
					
				break;
				default:
			}
		}
		
		public function resume():void {
			switch (currentGame) {
				case 'memoryEgg':
					memoryEgg.resume();
				break;
				
				case 'catchTheEgg':
					catchTheEgg.catchInit(currentLevelData);
				break;
				
				case 'eggQuake':
					
				break;
				default:
			}
		}
		
		public function timesUp():void {
			modals.showTimesUpModal();
		}
		
		public function restart():void {
			removeChildAt(0);
			startGame(currentGame, currentLevelData);
		}
		
		public function backToHomeScreen():void {
			homeScreen.show();
			removeChildAt(0);
		}
		
	}
}