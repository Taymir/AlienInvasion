package Weapons 
{
	import AI.Transition.MissleDangerTransition;
	import Missles.BaseMissle;
	import Missles.laser_missle;
	import common.TTimerEvent;
	import common.TRegistry;
	import UI.UserInterfaceManager;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TankLaserWeapon extends BaseWeapon 
	{
		
		public function TankLaserWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 300) 
		{
			super(shooterObj, fireDelayPeriod);
			
			fireTimer.addEventListener(TTimerEvent.TIMER_PROGRESS, onDelayProgress, false, 0, true);
		}
		
		override protected function launch(x: int, y: int): void
		{
			new laser_missle(x, y, BaseMissle.UP);
			
			// Это сделанно для возможности некоторыми нлошками "засечь" стрельбу игрока... 
			//возможно, существует более элегантное решение для этого...
			MissleDangerTransition.reportMissleLunch(x, y); 
			
			super.launch(x, y);
		}
		
		protected function onDelayProgress(e: TTimerEvent) : void
		{
			// Inform UIManager about delay progress
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).updateProgress("laser", e.progress);
		}
		
	}

}