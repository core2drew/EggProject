package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Level extends MovieClip {
		
		public var levelDetails:Object;
		public var level:int;
		public var is_lock:int;
		public var card_pairs:int;
		public var card_size:int;
		public var seconds:int;
		public var score:int;
		
		public function Level(levelDetails:Object) {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			this.levelDetails = levelDetails;
			is_lock = levelDetails.is_lock;
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			if (is_lock) {
				gotoAndStop(1);
			}else {
				gotoAndStop(2);
				level_txt.text = String(levelDetails.level);
			}
		}
	}
}
