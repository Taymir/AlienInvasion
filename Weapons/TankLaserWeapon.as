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
	public class TankLaserWeapon extends BaseTankWeapon 
	{
		const icon_name = "laser";
		
		public function TankLaserWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 300) 
		{
			super(icon_name, shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int): void
		{
			new laser_missle(x, y, BaseMissle.UP);
			
			super.launch(x, y);
		}
	}

}