package Weapons 
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import TmpObstacles.reflector;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TankReflectorWeapon extends BaseWeapon 
	{
		private var shield: reflector;
		private var firingTimer: Timer;
		
		//@TODO: изменить поведение fireDelayPeriod так, чтобы отчет начался только после конца действия щита
		public function TankReflectorWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 3000, firingPeriod:int = 2000)
		{
			firingTimer = new Timer(firingPeriod, 1);
			firingTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onFireComplete, false, 0, true);
			
			super(shooterObj, fireDelayPeriod);
			
		}
		
		override protected function launch(x: int, y: int): void
		{
			if (shield == null)
			{
				shield = new reflector(this.shooterObj);
				firingTimer.start();
			}
		}
		
		public override function stopFire() : void
		{
			if (shield != null)
			{				
				shield.destroy();
				
				shield = null;
			}
		}
		
		protected function onFireComplete(e: TimerEvent) : void
		{
			this.stopFire();
		}
	}
}