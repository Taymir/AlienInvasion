package Weapons 
{
	import AI.Transition.MissleDangerTransition;
	import Missles.BaseMissle;
	import Missles.paralyze_bomb;
	import common.TTimerEvent;
	import common.TRegistry;
	import UI.UserInterfaceManager;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TankParalyzeWeapon extends BaseWeapon
	{
		
		public function TankParalyzeWeapon(shooterObj: ControllableObject, fireDelayPeriod:int = 6000) 
		{
			super(shooterObj, fireDelayPeriod);
			
			fireTimer.addEventListener(TTimerEvent.TIMER_PROGRESS, onDelayProgress, false, 0, true);
		}
		
		override protected function launch(x: int, y: int): void
		{
			new paralyze_bomb(x, y, BaseMissle.UP);
			
			// Это сделанно для возможности некоторыми нлошками "засечь" стрельбу игрока... 
			//возможно, существует более элегантное решение для этого...
			MissleDangerTransition.reportMissleLunch(x, y); 
			
			super.launch(x, y);
		}
		
		protected function onDelayProgress(e: TTimerEvent) : void
		{
			// Inform UIManager about delay progress
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).updateProgress("bombs", e.progress);
		}
		
	}

}