package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class EggBasket extends MovieClip {
		
		public function EggBasket() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			x = (stage.stageWidth / 2) - (width / 2);
			y = 475;
		}
	}
}
