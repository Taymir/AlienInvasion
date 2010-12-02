package Enemies 
{
	import Enemies.BaseEnemy;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public final class small_ship extends BaseEnemy
	{		
		public function small_ship()
		{
			this.fireDelayPeriod = 20;
			this.speed = 3.0;
			this.friction = 1.3;
			this.maxspeed = 20;
			this.maxHitPoints = 1;
			this.hitPoints = this.maxHitPoints;
		}
		
		
	}

}