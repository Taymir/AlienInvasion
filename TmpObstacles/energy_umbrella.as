package TmpObstacles 
{
	import GameObjects.ControllableObject;
	import Missles.BaseMissle;
	/**
	 * ...
	 * @author Taymir
	 */
	public class energy_umbrella extends BaseTmpObstacle 
	{
		
		public function energy_umbrella(shooterObj:ControllableObject) 
		{
			super(shooterObj);	
		}
		
		public override function handleMissle(missle: BaseMissle)
		{
			// уничтожение ракеты
			//if(missle.damage < 10)// Так по ТЗ, но смотрится непонятно
			missle.dispose();
		}
		
	}

}