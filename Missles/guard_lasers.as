package Missles 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class guard_lasers extends BaseMissle 
	{
		
		public function guard_lasers(x:Number, y:Number, direction:int) 
		{
			super(x, y, direction);
			
			this.speed = 30;
			this.damage = 6;
		}
		
		public override function switchDirection() : void
		{
			this.rotation = 180;
			super.switchDirection();
		}
		
	}

}