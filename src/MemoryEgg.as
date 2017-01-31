package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import Database;
	/**
	 * ...
	 * @author Drew Calupe
	 */
	
	public class MemoryEgg extends MovieClip {
		private var card:MemoryEggCards;
		private var cards:Array;
		private var randomCard:int;
		private var firstPick:MemoryEggCards;
		private var secondPick:MemoryEggCards;
		private var countDown:CountDown;
		private var cardsContainer:MovieClip;
		private var timeRemaining:Object;
		private var game:Game;
		
		public function MemoryEgg() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			cardsContainer = new MovieClip();
			countDown = new CountDown();
		}
		
		public function cardInit(levelData:Object) {
			var cardsRowCount:int = levelData.row_count;
			var cardsColCount:int = levelData.column_count;
			var card_pairs:Array = levelData.card_pairs.split(',');
			var card_size:Number = levelData.card_size;
			var pair_score:int = levelData.pair_score;
			
			level_txt.text = levelData.level;
			countDown.TARGET_SECONDS = levelData.seconds;
			countDown.START();
			countDown.addEventListener(Event.CHANGE, countDownUpdate);
            countDown.addEventListener(Event.COMPLETE, countDownComplete)
			
			cards = card_pairs;
			
			for (var i = 0; i < cardsRowCount; i++) {
				for (var x = 0; x < cardsColCount; x++) {
					randomCard = Math.floor(Math.random() * cards.length);
					card = new MemoryEggCards();
					cardSize(card_size);
					card.stop();
					card.frame = cards[randomCard];
					card.isFlip = false;
					cards.splice(randomCard, 1);
					card.x = (card.width * x);
					card.y += (i > 0 ? card.height * i : 0);
					card.addEventListener(TouchEvent.TOUCH_BEGIN, touchCard);
					cardsContainer.addChild(card);
				}
			}
			cardsContainer.x = (stage.stageWidth / 2) - (cardsContainer.width / 2);
			cardsContainer.y = ((stage.stageHeight / 2) - (cardsContainer.height / 2)) + (card.height / 4);
			addChild(cardsContainer);
		}
		
		private function countDownUpdate(evt:Event):void{
           timeRemaining = countDown.timeRemaining;
           countDown_txt.text =  String(timeRemaining.minutes) + ":" + ( timeRemaining.seconds > 9 ? String(timeRemaining.seconds) : '0' + String(timeRemaining.seconds) );
        }
 
        private function countDownComplete(evt:Event):void {
			MovieClip(this.parent).timesUp();
        }
		
		public function cardSize(size:Number) {
			card.scaleX = size;
			card.scaleY = size;
		}
		
		public function touchCard(e:TouchEvent):void {
			var selectedCard = e.currentTarget as MemoryEggCards;
			
			if (firstPick == null) {
				firstPick = selectedCard;
				firstPick.gotoAndStop(selectedCard.frame);
			}
			else if(firstPick != selectedCard && secondPick == null) {
				secondPick = selectedCard;
				secondPick.gotoAndStop(selectedCard.frame);
				
				if (firstPick.frame == secondPick.frame) {
					TweenMax.delayedCall(0.5, removeCards);
				}
				else {
					TweenMax.delayedCall(0.5, resetCards);
				}
			}
		}
		
		public function resetCards():void {
			firstPick.gotoAndStop(1);
			secondPick.gotoAndStop(1);
			
			firstPick = null;
			secondPick = null;
		}
		
		public function removeCards():void {
			cardsContainer.removeChild(firstPick);
			cardsContainer.removeChild(secondPick);
			
			firstPick = null;
			secondPick = null;
			
			checkComplete();
		}
		
		private function checkComplete():void {
			countDown.STOP();
			if (cardsContainer.numChildren == 0) {
				trace("Complete!");
			}
		}
		
		public function pause():void {
			countDown.STOP();
		}
		
		public function resume():void {
			countDown.START();
		}
	}
}