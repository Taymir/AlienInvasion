package Missles 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class tank_ball extends BaseMissle 
	{
		
		public function tank_ball(x:Number, y:Number, direction:int) 
		{
			super(x, y, direction);
			
			speed = 13;
			damage = 7;
		}
		
	}

}