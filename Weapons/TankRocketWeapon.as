package Weapons 
{
	import GameObjects.ControllableObject;
	import AI.Transition.MissleDangerTransition;
	import Missles.BaseMissle;
	import Missles.rocket_missle;
	import common.TTimerEvent;
	import common.TRegistry;
	import UI.UserInterfaceManager;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TankRocketWeapon extends BaseTankWeapon 
	{
		const icon_name = "self_guided_missles";
		
		public function TankRocketWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 1200) 
		{
			super(icon_name, shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int) : void
		{
			new rocket_missle(x, y, BaseMissle.UP);
			
			super.launch(x, y);
		}
	
		
	}

}