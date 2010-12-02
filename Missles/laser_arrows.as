package Missles 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public final class laser_arrows extends BaseMissle
	{
		
		public function laser_arrows(x:Number, y:Number, direction:int) 
		{
			super(x, y, direction);
			
			this.speed = 30;
			this.damage = 3;
		}
		
	}

}