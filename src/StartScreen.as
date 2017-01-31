package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	public class StartScreen extends MovieClip {
		
		public function StartScreen() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event = null):void {
			this.playGame.addEventListener(TouchEvent.TOUCH_BEGIN, goToHomeScreen);
		}
		
		private function goToHomeScreen(e:TouchEvent):void {
			this.playGame.removeEventListener(TouchEvent.TOUCH_BEGIN, goToHomeScreen);
			MovieClip(this.parent).homeScreen.show();
			this.parent.removeChild(this);
		}
		
		public function hide():void {
			visible = false;
		}
		
		public function show():void {
			visible = true;
		}
	}
}
