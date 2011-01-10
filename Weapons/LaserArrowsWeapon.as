package Weapons 
{
	import Missles.BaseMissle;
	import Missles.laser_arrows;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class LaserArrowsWeapon extends BaseWeapon
	{
		
		public function LaserArrowsWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 300) 
		{
			super(shooterObj, fireDelayPeriod);
			
		}
		
		override protected function launch(x: int, y: int): void
		{
			new laser_arrows(x, y, BaseMissle.DOWN);
			
			super.launch(x, y);
		}
		
	}

}