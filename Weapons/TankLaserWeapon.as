package Weapons 
{
	import AI.Transition.MissleDangerTransition;
	import Missles.BaseMissle;
	import Missles.laser_missle;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TankLaserWeapon extends BaseWeapon 
	{
		
		public function TankLaserWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 300) 
		{
			super(shooterObj, fireDelayPeriod);
			
		}
		
		override protected function launch(x: int, y: int): void
		{
			new laser_missle(x, y, BaseMissle.UP);
			
			// Это сделанно для возможности некоторыми нлошками "засечь" стрельбу игрока... 
			//возможно, существует более элегантное решение для этого...
			MissleDangerTransition.reportMissleLunch(x, y); 
			
			super.launch(x, y);
		}
		
	}

}