package TmpObstacles 
{
	import Missles.BaseMissle;
	/**
	 * ...
	 * @author Taymir
	 */
	public class reflector extends BaseTmpObstacle 
	{
		public function reflector(shooterObj: ControllableObject)
		{
			super(shooterObj);
		}
		
		public override function handleMissle(missle: BaseMissle)
		{
			// Смена направления движения ракеты
			missle.switchDirection();
		}
	}

}