package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import Database;
	/**
	 * ...
	 * @author Drew Calupe
	 */
	public class GameLevels extends MovieClip{
		public var db:Database;
		private var selectedGame:String;
		private var selectLevelTitle:SelectLevelTitle;
		private var level:Level;
		private var gameLevelData:Array;
		private var game:Game;
		
		public function GameLevels() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			game = MovieClip(this.parent).game;
		}
		
		public function getGameLevelsData(selectedGame:String):void {
			switch (selectedGame) 
			{
				case 'memoryEgg':
					gameLevelData = Database.getMemoryEggGameData();
				break;
				
				case 'catchTheEgg':
					
				break;
				
				case 'eggQuake':
					
				break;
				default:
			}
			this.selectedGame = selectedGame;
			showLevels();
		}
		
		public function showLevels():void {
			var levelsRowCount:int = (gameLevelData.length / 5)
			var levelsColCount:int = (gameLevelData.length / 2);
			var c:int = 0;
			
			for (var i = 0; i < levelsRowCount; i++) {
				var cc:int = 0;
				while (cc < levelsColCount) {
					level = new Level(gameLevelData[c]);
					level.x = (level.width * cc);
					level.x += (cc > 0 ? (10 * cc) : 0);
					level.y += (i > 0 ? (level.height + 10) * i : 0);
					if (!level.is_lock) {
						level.addEventListener(TouchEvent.TOUCH_BEGIN, startGame);
					}
					addChild(level);
					
					cc++;
					c++;
				}
			}
			
			x = (stage.stageWidth / 2) - (width / 2);
			y = (stage.stageHeight / 2) - (height / 2);
			
		}
		
		private function startGame(e:TouchEvent):void {
			var levelDetails = MovieClip(e.currentTarget).levelDetails;
			game.startGame(selectedGame, levelDetails);
		}
	}
}