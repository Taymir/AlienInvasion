package Weapons 
{
	import GameObjects.ControllableObject;
	import Missles.BaseMissle;
	import Missles.guard_lasers;
	/**
	 * ...
	 * @author Taymir
	 */
	public class GuardLasersWeapon extends BaseWeapon 
	{
		
		public function GuardLasersWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 300) 
		{
			super(shooterObj, fireDelayPeriod);
			
		}
		
		override protected function launch(x: int, y: int): void
		{
			new guard_lasers(x, y, BaseMissle.DOWN);
			
			super.launch(x, y);
		}
	}

}