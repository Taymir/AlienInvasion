package Weapons 
{
	import Missles.BaseMissle;
	import Missles.energy_stream;
	/**
	 * ...
	 * @author Taymir
	 */
	public class EnergyStreamWeapon extends BaseWeapon
	{
		
		public function EnergyStreamWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 6000) 
		{
			super(shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int): void
		{
			new energy_stream(x, y, BaseMissle.DOWN);
			
			super.launch(x, y);
		}
	}

}