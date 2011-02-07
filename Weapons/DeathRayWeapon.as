package Weapons 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class DeathRayWeapon extends BaseWeapon
	{
		
		public function DeathRayWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 6000) 
		{
			super(shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int): void
		{
			//@TODO: добавить луч
			// создать луч высотой от корабля до поверхности земли
			// поддерживать его существование (применять ParticleSparkles
			// до момента timout
			
			super.launch();
		}
	}

}