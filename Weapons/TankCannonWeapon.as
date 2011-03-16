package Weapons 
{
	import AI.Transition.MissleDangerTransition;
	import Missles.BaseMissle;
	import Missles.tank_ball;
	import common.TTimerEvent;
	import common.TRegistry;
	import UI.UserInterfaceManager;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TankCannonWeapon extends BaseTankWeapon
	{
		const icon_name: String = "base_weapon";
		
		public function TankCannonWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 300) 
		{
			super(icon_name, shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int): void
		{
			new tank_ball(x, y, BaseMissle.UP);
			
			super.launch(x, y);
		}
	}

}