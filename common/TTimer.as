package common 
{
	import common.TRegistry;
	import common.TList.TList;
	import flash.events.EventDispatcher;
	/**
	 * @author Taymir
	 */
	
	// При инициализации таймера, присоединиться к глобалентерфрейму
	// при старте таймера, засечь сколько кадров надо до конца таймера
	// онтик: инкрементить кадры, раз в Nкадров вызывать onProgress
	// при достижении последнего кадра, вызвать onComplete
	// 
	// Если игра на паузе, кадры не инкрементятся
	public class TTimer extends EventDispatcher
	{		
		private const framerate: Number = 0.024; // 0.024 frames per millisecond!
		
		private var finalFrame: uint;
		private var currentFrame: uint;
		private var runningFlag: Boolean;
		private var delayMs: Number;
		private var progressFrames: uint;
		
		
		public function TTimer(delay: Number, progress_delay: uint = 100)
		{
			this.delay = delay;
			this.progressFrames = ms2frames(progress_delay);
			
			runningFlag = false;
		}
		
		public function start():void
		{
			currentFrame = 0;
			runningFlag = true;
			
			this.addToGlobalEnterFrame(tick);
		}
		
		public function stop():void
		{
			runningFlag = false;
			
			removeFromGlobalEnterFrame(tick);
		}
		
		public function get delay() : Number
		{
			return this.delayMs;
		}
		
		public function set delay(value: Number): void
		{
			this.delayMs = value;
			finalFrame = ms2frames(delay);
		}
		
		public function get running(): Boolean
		{
			return runningFlag;
		}
		
		private function tick(): void
		{
			currentFrame++;
			
			if ((currentFrame % progressFrames) == 0)
				this.dispatchEvent(new TTimerEvent(TTimerEvent.TIMER_PROGRESS, false, false, currentFrame / finalFrame) );
			
			if (currentFrame >= finalFrame)
			{
				this.dispatchEvent(new TTimerEvent(TTimerEvent.TIMER_COMPLETE));
				this.stop();
			}
				
		}
		
		private function ms2frames(milliseconds: Number) : uint
		{
			return Math.ceil(milliseconds * this.framerate);
		}
		
		
		protected function addToGlobalEnterFrame(f: Function)
		{
			Debug.assert( TRegistry.instance.getValue("globalEnterFrame") != null, "В реестре TRegistry не установлена ссылка на глобальный обновлятор" );
			
			(TRegistry.instance.getValue("globalEnterFrame") as GlobalEnterFrame).Add(f);
		}
		
		protected function removeFromGlobalEnterFrame(f: Function)
		{
			Debug.assert( TRegistry.instance.getValue("globalEnterFrame") != null, "В реестре TRegistry не установлена ссылка на глобальный обновлятор" );
			
			(TRegistry.instance.getValue("globalEnterFrame") as GlobalEnterFrame).Remove(f);
		}
		
	}

}