package Weapons 
{
	import common.TRegistry;
	import common.TTimerEvent;
	import common.TTimer;
	/**
	 * ...
	 * @author Taymir
	 */
	public class BaseWeapon
	{
		protected var fireDelayPeriod: int;
		protected var canFire: Boolean = true;
		protected var shooterObj: ControllableObject;
		protected var fireTimer: TTimer;
		
		public function BaseWeapon(shooterObj:ControllableObject, fireDelayPeriod: int = 300) 
		{
			this.fireDelayPeriod = fireDelayPeriod;
			
			fireTimer = new TTimer(fireDelayPeriod);
			fireTimer.addEventListener(TTimerEvent.TIMER_COMPLETE, fireTimerHandler, false, 0, true);
			
			this.shooterObj = shooterObj;
		}
		
		public function changeFireDelayPeriod(fireDelayPeriodMultiplicator: Number = 1.0)
		{
			fireTimer.delay *= fireDelayPeriodMultiplicator;
		}
		
		private function fireTimerHandler(e:TTimerEvent) : void
		{
			canFire = true;
		}
		
		protected function fireDelay() : void
		{
			canFire = false;
			fireTimer.start();
		}
		
		public function fire() : void
		{
			if (canFire)
			{
				this.launch(shooterObj.x, shooterObj.y);
				fireDelay();
			}
		}
		
		/*public function getDelayStatus() : Number
		{
			//@TODO
		}*/
		
		public function stopFire() : void
		{
			//@EMPTY
		}
		
		public function isReady() : Boolean
		{
			return canFire;
		}
		
		protected function launch(x: int, y: int) : void
		{
			//@EMPTY
			this.playSound("shoot");
		}
		
		// Воспроизведение звуков
		protected function playSound(soundName : String) : void
		{
			(TRegistry.instance.getValue("sound_manager") as SoundManager).play(soundName);
		}
		
		public function dispose() : void
		{
			//@EMPTY
		}
		
	}

}