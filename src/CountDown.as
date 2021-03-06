package  {
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.display.Sprite;
    import flash.events.EventDispatcher;
 
    public class CountDown extends EventDispatcher{
 
        private var secondsRemaining:int;
        private var _timeRemaining:Object = {}
        private var countdownTimer:Timer;
		private var days:int;
        private var hours:int;
        private var minutes:int;
        private var seconds:int;
		
        /*
            @ Author: Andrew Keith
            @ Website: www.andrewkeith.com
            @ Ver: 1.0 - 12.5.2013
            @ License: Do whatever you want with it, commercial or free, its for the world to use <img draggable="false" class="emoji" alt="🙂" src="https://s.w.org/images/core/emoji/2.2.1/svg/1f642.svg">
 
        //INFO//
 
        This countdown does all the math to calculate how many days/hours/minutes/seconds are left in a specific countdown.
            * You can countdown to a specified date in time or for a specific amount of seconds
            * Create a new instance of countdown
            * Set the target seconds or target date
            * Add a listener for Event.CHANGE (each second update) and Event.COMPLETE (when timer is up)
            * On each update, get the object "timeRemaining" from the clock. This will return an object with the days, hours, minutes, seconds left
            * Use this info however you want <img draggable="false" class="emoji" alt="🙂" src="https://s.w.org/images/core/emoji/2.2.1/svg/1f642.svg">
 
        EXAMPLE:
 
        private function init(evt:Event):void
        {
            cdc = new CountDown();
                //cdc.TARGET_SECONDS = 120; //Use this if you want to countdown to a specific # of seconds
            cdc.TARGET_DATE = new Date(2013, 11, 7);
            cdc.START();
            cdc.addEventListener(Event.CHANGE, onUpdate);
            cdc.addEventListener(Event.COMPLETE, onComplete)
        }
 
        private function onUpdate(evt:Event):void
        {
            var timeRemaining:Object = cdc.timeRemaining;
            trace("hours:", timeRemaining.hours, "minutes:", timeRemaining.minutes, "seconds:", timeRemaining.seconds);
        }
 
        private function onComplete(evt:Event):void
        {
            trace ("Times up!");
        }
 
        */
 
        public function CountDown() {
            countdownTimer = new Timer(1000);
            countdownTimer.addEventListener(TimerEvent.TIMER, onCountdown);
        }
 
        public function set TARGET_SECONDS(seconds:int):void
        {
            secondsRemaining = seconds;
        }
 
        public function set TARGET_DATE(target:Date):void
        {
            var currentDate:Date = new Date();
            var currentSeconds = currentDate.valueOf();
 
            var targetSeconds = target.valueOf();
 
            var difference:int = (targetSeconds - currentSeconds) / 1000;
            secondsRemaining = difference;
        }
		
        public function START():void
        {
            countdownTimer.start();
        }
 
        public function STOP():void
        {
            countdownTimer.stop();
        }
 
        private function onCountdown(evt:TimerEvent):void
        {
            secondsRemaining--;
			
			days = Math.floor(secondsRemaining/(3600*24));
            hours = Math.floor((secondsRemaining / 3600)%24);
            minutes = Math.floor((secondsRemaining / 60) % 60);
            seconds = secondsRemaining % 60;
 
            timeRemaining.days = days;
            timeRemaining.hours = hours;
            timeRemaining.minutes = minutes;
            timeRemaining.seconds = seconds;
 
            if(secondsRemaining < 0)
            {
                dispatchEvent(new Event(Event.COMPLETE, true));
                countdownTimer.stop();
                countdownTimer.removeEventListener(TimerEvent.TIMER, onCountdown);
            }
            else
            {
                dispatchEvent(new Event(Event.CHANGE, true));
            }
        }
 
        public function get timeRemaining():Object
        {
            return _timeRemaining;
        }
 
    }
 
}