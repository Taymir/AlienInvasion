package Enemies 
{
	import AI.transport_shipAI;
	import common.TRegistry;
	import Weapons.DeathRayWeapon;
	/**
	 * ...
	 * @author Taymir
	 */
	public class transport_ship extends BaseEnemy
	{
		public static const DIRECTION_NONE:int = 0;
		public static const DIRECTION_RIGHT:int = +1;
		public static const DIRECTION_LEFT:int = -1;
		
		public var direction:int = DIRECTION_NONE;
		
		private var ai: transport_shipAI;
		
		public function transport_ship() 
		{
			this.speed = 1;
			this.friction = 0.7;
			this.maxspeed = 5;
			this.maxHitPoints = 200;
			this.hitPoints = this.maxHitPoints;
			
			primaryWeapon = new DeathRayWeapon(this);
			
			var tank: Tank = TRegistry.instance.getValue("player").Get(0);
			ai = new transport_shipAI(this, tank);
		}
		
		public function attach_guards(guard_one: ControllableObject, guard_two: ControllableObject)
		{
			ai.attach_guards(guard_one, guard_two);
		}
		
		override protected function update() : void
		{
			ai.update();
			super.update();
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