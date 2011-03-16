package Weapons 
{
	import GameObjects.ControllableObject;
	import Missles.BaseMissle;
	import Missles.freezer;
	/**
	 * ...
	 * @author Taymir
	 */
	public class FreezerWeapon extends BaseWeapon
	{
		
		public function FreezerWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 6000) 
		{
			super(shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int): void
		{
			new freezer(x, y, BaseMissle.DOWN);
			
			super.launch(x, y);
		}
	}

}