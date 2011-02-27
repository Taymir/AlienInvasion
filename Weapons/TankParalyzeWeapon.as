package Weapons 
{
	import Missles.BaseMissle;
	import Missles.paralyze_bomb;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TankParalyzeWeapon extends BaseWeapon
	{
		
		public function TankParalyzeWeapon(shooterObj: ControllableObject, fireDelayPeriod:int = 6000) 
		{
			super(shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int): void
		{
			new paralyze_bomb(x, y, BaseMissle.UP);
			
			super.launch(x, y);
		}
		
	}

}