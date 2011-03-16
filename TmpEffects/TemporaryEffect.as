package TmpEffects 
{
	import GameObjects.*;
	import common.TTimerEvent;
	import common.TTimer;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TemporaryEffect
	{
		protected var duration:int; // milliseconds
		protected var targetObject:ControllableObject;
		
		private var effectTimer:TTimer;
		
		public function TemporaryEffect(duration) 
		{
			this.duration = duration;
			
			effectTimer = new TTimer(duration);
		}
		
		public function beginEffect(targetObject: ControllableObject) : void
		{
			//@BUGFIX: т.к. не можем использовать weakReference (сборщик мусора удаляет эффекты из памяти), то
			// приходится отвязывать событие после окончания эффекта. Впрочем, сам эффект в любом случае 
			// используется лишь один раз
			effectTimer.addEventListener(TTimerEvent.TIMER_COMPLETE, effectComplete);
			this.targetObject = targetObject;
			
			effectTimer.start();
		}
		
		private function effectComplete(e: TTimerEvent) : void
		{
			effectTimer.removeEventListener(TTimerEvent.TIMER_COMPLETE, effectComplete);
			this.endEffect();
			this.targetObject = null;
		}
		
		protected function endEffect() : void
		{
			//@EMPTY
		}
		
		
		
	}

}