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
		private var _progressAction: Function;
		private var _completeAction: Function;
		
		public function TemporaryEffect(duration) 
		{
			this.duration = duration;
			
			effectTimer = new TTimer(duration);
		}
		
		public function set progressAction(value: Function)
		{
			this._progressAction = value;
		}
		
		public function set completeAction(value: Function)
		{
			this._completeAction = value;
		}
		
		public function beginEffect(targetObject: ControllableObject) : void
		{
			//@BUGFIX: т.к. не можем использовать weakReference (сборщик мусора удаляет эффекты из памяти), то
			// приходится отвязывать событие после окончания эффекта. Впрочем, сам эффект в любом случае 
			// используется лишь один раз
			effectTimer.addEventListener(TTimerEvent.TIMER_COMPLETE, effectComplete);
			if (_progressAction != null)
				effectTimer.addEventListener(TTimerEvent.TIMER_PROGRESS, _progressAction);
			this.targetObject = targetObject;
			
			effectTimer.start();
		}
		
		private function effectComplete(e: TTimerEvent) : void
		{
			effectTimer.removeEventListener(TTimerEvent.TIMER_COMPLETE, effectComplete);
			if (_progressAction != null)
				effectTimer.removeEventListener(TTimerEvent.TIMER_PROGRESS, _progressAction);
			if (_completeAction != null)
				_completeAction.call(null, e);
			this.endEffect();
			this.targetObject = null;
		}
		
		protected function endEffect() : void
		{
			//@EMPTY
		}
		
		
		
	}

}