package Missles 
{
	/**
	 * ...
	 * @author Taymir
	 */
	//@TODO: Добавить повреждение не только  при прямом попадании
	public final class grenades extends BaseMissle
	{
		
		public function grenades(x:Number, y:Number, direction:int) 
		{
			super(x, y, direction);
			
			this.speed = 10;
			this.damage = 3;
		}
		
	}

}