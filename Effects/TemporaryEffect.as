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
		}
		
		public function beginEffect(targetObject: ControllableObject) : void
		{
			//@BUGFIX: т.к. не можем использовать weakReference (сборщик мусора удаляет эффекты из памяти), то
			// приходится отвязывать событие после окончания эффекта. Впрочем, сам эффект в любом случае 
			// используется лишь один раз
			effectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, effectComplete);
			this.targetObject = targetObject;
			
			effectTimer.start();
		}
		
		private function effectComplete(e: TimerEvent) : void
		{
			effectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, effectComplete);
			this.endEffect();
			this.targetObject = null;
		}
		
		protected function endEffect() : void
		{
			//@EMPTY
		}
		
		
		
	}

}