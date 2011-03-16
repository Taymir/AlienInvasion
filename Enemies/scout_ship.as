package Enemies 
{
	import GameObjects.*;
	import AI.scout_shipAI;
	import Enemies.BaseEnemy;
	import common.TRegistry;
	/**
	 * ...
	 * @author Akkarin
	 */
	public class scout_ship extends BaseEnemy 
	{
		public static const DIRECTION_NONE:int = 0;
		public static const DIRECTION_RIGHT:int = +1;
		public static const DIRECTION_LEFT:int = -1;
		
		public var direction:int = DIRECTION_NONE;
		
		public function scout_ship() 
		{
			this.speed = 5.0;
			this.friction = 0.8;
			this.maxspeed = 20;
			this.maxHitPoints = 1;
			this.hitPoints = this.maxHitPoints;
									
			//@BUG: После того, как танк убит, НЛО все ещё "помнит о его существовании"
			var tank:Tank = TRegistry.instance.getValue("player").Get(0);
			ai = new scout_shipAI(this, tank);
		}
		
		protected override function reflectXVelocity()
		{
			this.direction *= -1;
			super.reflectXVelocity();
		}
		
		public function followDirection() : void
		{
			// Увеличиваем скорость движения в заданном направлении
			this.velocity.x += this.speed * this.direction;
		}
	}

}