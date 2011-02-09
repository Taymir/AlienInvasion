package Enemies 
{
	import AI.guard_shipAI;
	import common.TRegistry;
	import Weapons.BaseWeapon;
	import Weapons.GuardLasersWeapon;
	/**
	 * ...
	 * @author Taymir
	 */
	public class guard_ship extends BaseEnemy
	{
		private var ai: guard_shipAI;
		
		public function guard_ship() 
		{
			this.speed = 4;
			this.friction = 0.7;
			this.maxspeed = 13;
			this.maxHitPoints = 40;
			this.hitPoints = this.maxHitPoints;
			
			primaryWeapon = new GuardLasersWeapon(this);
			
			var tank: Tank = TRegistry.instance.getValue("player").Get(0);
			ai = new guard_shipAI(this, tank);
		}
		
		override protected function update() : void
		{
			ai.update();
			super.update();
		}
	}

}