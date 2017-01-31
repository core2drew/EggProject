package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	/**
	 * ...
	 * @author Drew Calupe
	 */
	public class Controllers extends MovieClip{
		
		private var direction:String;
		
		public function Controllers() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			left.addEventListener(TouchEvent.TOUCH_BEGIN, moveLeft);
			right.addEventListener(TouchEvent.TOUCH_BEGIN, moveRight);
			
			left.addEventListener(TouchEvent.TOUCH_END, stopMove);
			right.addEventListener(TouchEvent.TOUCH_END, stopMove);
		}
		
		private function moveLeft(e:TouchEvent):void {
			direction = 'left';
		}
		
		private function moveRight(e:TouchEvent):void {
			direction = 'right';
		}
		
		private function stopMove(e:TouchEvent):void {
			direction = '';
		}
		
		public function moveTo():String {
			return direction;
		}
	}
}