package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class HeaderTitle extends MovieClip {
		
		public function HeaderTitle() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stop();
			x = 205;
			y = 24;
		}
	}
}
