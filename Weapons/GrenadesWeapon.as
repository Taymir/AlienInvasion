package Weapons 
{
	import GameObjects.ControllableObject;
	import Missles.BaseMissle;
	import Missles.grenades;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class GrenadesWeapon extends BaseWeapon
	{
		
		public function GrenadesWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 400) 
		{
			super(shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int): void
		{
			new grenades(x, y, BaseMissle.DOWN);
			
			super.launch(x, y);
		}
	}

}