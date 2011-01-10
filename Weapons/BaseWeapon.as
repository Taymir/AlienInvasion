package Weapons 
{
	import common.TRegistry;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Taymir
	 */
	public class BaseWeapon
	{
		protected var fireDelayPeriod: int;
		protected var canFire: Boolean = true;
		protected var shooterObj: ControllableObject;
		private var fireTimer: Timer;
		
		public function BaseWeapon(shooterObj:ControllableObject, fireDelayPeriod: int = 300) 
		{
			this.fireDelayPeriod = fireDelayPeriod;
			
			fireTimer = new Timer(fireDelayPeriod, 1);
			fireTimer.addEventListener(TimerEvent.TIMER_COMPLETE, fireTimerHandler);
			
			this.shooterObj = shooterObj;
		}
		
		private function fireTimerHandler(e:TimerEvent) : void
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
		
	}

}