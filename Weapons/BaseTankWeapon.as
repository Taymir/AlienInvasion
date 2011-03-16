package Weapons 
{
	import AI.Transition.MissleDangerTransition;
	import common.TTimerEvent;
	import common.TRegistry;
	import UI.UserInterfaceManager;
	/**
	 * ...
	 * @author Taymir
	 */
	public class BaseTankWeapon extends BaseWeapon 
	{
		protected var UIIconName: String;
		
		public function BaseTankWeapon(UIiconName: String, shooterObj:ControllableObject, fireDelayPeriod:int = 300) 
		{
			this.UIIconName = UIiconName;
			
			super(shooterObj, fireDelayPeriod);
			fireTimer.addEventListener(TTimerEvent.TIMER_PROGRESS, onDelayProgress, false, 0, true);
		}
		
		override protected function launch(x: int, y: int): void
		{
			// Это сделанно для возможности некоторыми нлошками "засечь" стрельбу игрока... 
			//возможно, существует более элегантное решение для этого...
			MissleDangerTransition.reportMissleLunch(x, y); 
			
			super.launch(x, y);
		}
		
		protected function onDelayProgress(e: TTimerEvent) : void
		{
			// Inform UIManager about delay progress
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).updateProgress(this.UIIconName, e.progress);
		}
		
		public function activateWeapon() : void
		{
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).activateIcon(this.UIIconName);
		}
		
		public function deactivateWeapon() : void
		{
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).deactivateIcon(this.UIIconName);
		}
	}

}