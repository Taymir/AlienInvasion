package Enemies 
{
	import Enemies.BaseEnemy;
	import Missles.BaseMissle;
	import Missles.laser_arrows;
	
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
		
		public override function fire():void
		{
			//@TODO вынести в отдельный переопределяемый метод тело if-а
			if (canFire)
			{
				new laser_arrows(x, y, BaseMissle.DOWN);
				fireDelay();
				super.fire();
			}
		}
	}

}