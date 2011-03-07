package common 
{
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class TTimerEvent extends TimerEvent 
	{
		public static const TIMER_PROGRESS: String = "timerProgress";
		public static const TIMER_COMPLETE: String = "timerComplete";
		
		private var _progress: Number;
						
		public function TTimerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, progress: Number = 1.0) 
		{
			super(type, bubbles, cancelable);
			this._progress = progress;
		}
		
		public function get progress() : Number
		{
			return this._progress;
		}
		
		
	}

}