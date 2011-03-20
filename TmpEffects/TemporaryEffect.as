package TmpEffects 
{
	import flash.events.Event;
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
		protected var restoration:int; //milliseconds
		protected var targetObject:ControllableObject;
		
		private var effectTimer:TTimer;
		private var restoreTimer:TTimer;
		private var _progressAction: Function;
		private var _completeAction: Function;
		private var _progressRestoreAction: Function;
		private var _restoreCompleteAction: Function;
		
		public function TemporaryEffect(duration: int, restoration: int = 0 ) 
		{
			if (restoration == 0)
				restoration = duration;
			this.duration = duration;
			this.restoration = restoration;
			
			effectTimer = new TTimer(duration);
			restoreTimer = new TTimer(restoration);
		}
		
		public function set progressAction(value: Function)
		{
			this._progressAction = value;
		}
		
		public function set completeAction(value: Function)
		{
			this._completeAction = value;
		}
		
		public function set progressRestoreAction(value: Function)
		{
			this._progressRestoreAction = value;
		}
		
		public function set restoreCompleteAction(value: Function)
		{
			this._restoreCompleteAction = value;
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
			
			restoreTimer.addEventListener(TTimerEvent.TIMER_COMPLETE, restoreComplete);
			if (_progressRestoreAction != null)
				restoreTimer.addEventListener(TTimerEvent.TIMER_PROGRESS, _progressRestoreAction);
			restoreTimer.start();
		}
		
		private function restoreComplete(e: TTimerEvent) : void
		{
			restoreTimer.removeEventListener(TTimerEvent.TIMER_COMPLETE, restoreComplete);
			
			if (_progressRestoreAction != null)
				restoreTimer.removeEventListener(TTimerEvent.TIMER_PROGRESS, _progressRestoreAction);
			if (_restoreCompleteAction != null)
				_restoreCompleteAction.call(null, e);
				
			this.targetObject = null;
		}
		
		protected function endEffect() : void
		{
			//@EMPTY
		}
		
		
		
	}

}