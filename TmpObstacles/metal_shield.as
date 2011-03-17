package TmpObstacles 
{
	import GameObjects.ControllableObject;
	import Missles.BaseMissle;
	/**
	 * ...
	 * @author Taymir
	 */
	public class metal_shield extends BaseTmpObstacle 
	{		
		public function metal_shield(shooterObj:ControllableObject) 
		{
			super(shooterObj);
		}
		
		public override function get CAN_STAND_AGAINST_DEATH_RAY():Boolean
		{
			return true;
		}
		
		public override function handleMissle(missle: BaseMissle)
		{
			// уничтожение ракеты
			missle.Explode();
			missle.dispose();
			
			// Анимация попадания по щиту
			this.gotoAndPlay("hit");
		}
		
		protected override function update()
		{
			//@EMPTY: щит должен стоять на месте, а не перемещаться за танком
		}
		
	}

}