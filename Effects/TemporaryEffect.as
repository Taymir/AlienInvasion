package Effects 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TemporaryEffect
	{
		protected var duration:int; // milliseconds
		protected var targetObject:ControllableObject;
		
		private var effectTimer:Timer;
		
		public function TemporaryEffect(duration) 
		{
			this.duration = duration;
			
			effectTimer = new Timer(duration, 1);
			effectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, effectComplete)
		}
		
		public function beginEffect(targetObject: ControllableObject) : void
		{
			this.targetObject = targetObject;
			
			effectTimer.start();
		}
		
		private function effectComplete(e: TimerEvent) : void
		{
			this.endEffect();
		}
		
		protected function endEffect() : void
		{
			//@EMPTY
		}
		
		
		
	}

}