package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.desktop.NativeApplication;
	/**
	 * ...
	 * @author Drew Calupe
	 */
	public class Modals extends MovieClip{
		
		private var game:Game;
		private var homeScreen:HomeScreen;
		private var quitModal:QuitModal;
		private var pauseModal:PauseModal;
		private var timesUpModal:TimesUpModal;
		
		
		public function Modals() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			hide();
			
			game =  MovieClip(this.parent).game;
			homeScreen = MovieClip(this.parent).homeScreen;
		}
		
		public function showGameLevels(game):void {
			switch (game) {
				case 'matchCards':
					
				break;
				
				case 'eggCatch':
					
				break;
				
				case 'eggQuake':
					
				break;
				default:
			}
		}
		
		public function showTimesUpModal():void {
			timesUpModal = new TimesUpModal();
			timesUpModal.x = (stage.stageWidth / 2) - (timesUpModal.width / 2);
			timesUpModal.y = (stage.stageHeight / 2) - (timesUpModal.height / 2);
			addChild(timesUpModal);
			show();
			
			timesUpModal.restart.addEventListener(TouchEvent.TOUCH_BEGIN, function(e:TouchEvent):void { 
				removeTimesUpModal();
				game.restart();
			});
			
			timesUpModal.mainMenu.addEventListener(TouchEvent.TOUCH_BEGIN, function(e:TouchEvent):void { 
				removeTimesUpModal();
				game.backToHomeScreen();
			});
		}
		
		public function showPauseModal():void {
			pauseModal = new PauseModal();
			pauseModal.x = (stage.stageWidth / 2) - (pauseModal.width / 2);
			pauseModal.y = (stage.stageHeight / 2) - (pauseModal.height / 2);
			addChild(pauseModal);
			show();
			
			game.pause();
			
			pauseModal.resume.addEventListener(TouchEvent.TOUCH_BEGIN, function(e:TouchEvent):void {
				removePauseModal();
				game.resume();
			});
			
			pauseModal.restart.addEventListener(TouchEvent.TOUCH_BEGIN, function(e:TouchEvent):void { 
				removePauseModal();
				game.restart();
			});
			
			pauseModal.mainMenu.addEventListener(TouchEvent.TOUCH_BEGIN, function(e:TouchEvent):void { 
				removePauseModal();
				game.backToHomeScreen();
			});
		}
		
		public function showQuitModal():void {
			quitModal = new QuitModal();
			quitModal.x = (stage.stageWidth / 2) - (quitModal.width / 2);
			quitModal.y = (stage.stageHeight / 2) - (quitModal.height / 2);
			addChild(quitModal);
			show();
			
			quitModal.cancel.addEventListener(TouchEvent.TOUCH_BEGIN, function(e:TouchEvent):void { 
				removeQuitModal();
			});
			
			quitModal.okay.addEventListener(TouchEvent.TOUCH_BEGIN, function(e:TouchEvent):void { 
				NativeApplication.nativeApplication.exit();
			});
		}
		
		public function removeQuitModal():void {
			hide();
			removeChild(quitModal);
		}
		
		public function removePauseModal():void {
			hide();
			removeChild(pauseModal);
		}
		
		public function removeTimesUpModal(): void {
			hide();
			removeChild(timesUpModal);
		}
		
		public function hide() {
			visible = false;
		}
		
		public function show() {
			visible = true;
		}
	}
}