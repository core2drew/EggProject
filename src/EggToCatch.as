package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Drew Calupe
	 */
	
	public class EggToCatch extends MovieClip {
		
		public function EggToCatch() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			y = -54;
			x = Helper.randomRange(170, 590);
		}
		
		public function eggDrop() {
			y += 3;
		}
		
		public function eggCatch():void {
			this.parent.removeChild(this);
		}
		
		public function eggBreak():void {
			this.parent.removeChild(this);
		}
	}
}
