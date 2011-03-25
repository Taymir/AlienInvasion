package Weapons 
{
	import GameObjects.ControllableObject;
	import flash.display.MovieClip;
	import common.TTimer;
	import common.TTimerEvent;
	import TmpObstacles.reflector;
	import common.TRegistry;
	import UI.UserInterfaceManager;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TankReflectorWeapon extends BaseTankWeapon 
	{
		const icon_name: String = "reflector";
		private var shield: reflector;
		private var firingTimer: TTimer;
		
		public function TankReflectorWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 3000, firingPeriod:int = 2000)
		{
			firingTimer = new TTimer(firingPeriod);
			firingTimer.addEventListener(TTimerEvent.TIMER_COMPLETE, onFireComplete, false, 0, true);
			firingTimer.addEventListener(TTimerEvent.TIMER_PROGRESS, onFireProgress, false, 0, true);
			
			super(icon_name, shooterObj, fireDelayPeriod);
			
			this.DELAY_ON_STOP_FIRE = true;
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
				firingTimer.stop();
				
				shield.dispose();
				
				shield = null;
				
				super.stopFire();
			}
		}
		
		protected function onFireComplete(e: TTimerEvent) : void
		{
			this.stopFire();
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).updateProgress(this.UIIconName, 0.0);
		}
		
		protected function onFireProgress(e: TTimerEvent) : void
		{
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).updateProgress(this.UIIconName, 1.0 - e.progress);
		}
	}
}