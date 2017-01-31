package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Drew Calupe
	 */
	public class CatchTheEgg extends MovieClip{

		private var eggBasket:EggBasket;
		private var controller:Controllers;
		private var eggToCatch:EggToCatch;
		public var eggToCatchArr:Array;
		private var eggToCatchSpawnTimer:Timer;
		
		public function CatchTheEgg() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function catchInit(levelData:Object):void {
			initControllers();
			eggToCatchArr = new Array();
			eggToCatchSpawnTimer = new Timer(2000, 1);
			eggToCatchSpawnTimer.addEventListener(TimerEvent.TIMER, spawnEggToCatch);
		}
		
		public function initControllers():void {
			eggBasket = new EggBasket();
			controller = new Controllers();
			
			addChild(eggBasket);
			addChild(controller);
		}
		
		private function spawnEggToCatch(e:TimerEvent):void {
			eggToCatch = new EggToCatch();
			addChild(eggToCatch);
			eggToCatchArr.push(eggToCatch);
		}
		
		private function enterFrame(e:Event):void {
			
			if (eggToCatchArr.length < 3) {
				eggToCatchSpawnTimer.start();
			}
			
			eggDrop();
			moveBasket();
		}
		
		private function moveBasket() {
			switch(controller.moveTo()) {
				case 'left':
					if (!eggBasket.hitTestObject(controller.left)) {
						eggBasket.x-=3;
					}
				break;
				
				case 'right':
					if (!eggBasket.hitTestObject(controller.right)) {
						eggBasket.x += 3;
					}
				break;
				default:
			}
		}

		private function eggDrop() {
			if (eggToCatchArr.length) {
				for (var i = 0; i < eggToCatchArr.length; i++) {
					eggToCatchArr[i].eggDrop();
					
					if (eggToCatchArr[i].y > stage.stageHeight) {
						eggToCatchArr[i].eggBreak();
						eggToCatchArr.splice(i, 1);
					}
					else if (eggBasket.hitTestObject(eggToCatchArr[i]) ) {
						eggToCatchArr[i].eggCatch();
						eggToCatchArr.splice(i, 1);
					}
				}	
			}
		}
	}
}