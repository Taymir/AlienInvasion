package Enemies 
{
	import GameObjects.*;
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
		public static const LEFT_POSITION: int = -1;
		public static const RIGHT_POSITION: int = +1;
		
		public function guard_ship(transport: transport_ship, left_or_right: int = LEFT_POSITION) 
		{
			this.speed = 4;
			this.friction = 0.7;
			this.maxspeed = 13;
			this.maxHitPoints = 25;
			this.hitPoints = this.maxHitPoints;
			
			primaryWeapon = new GuardLasersWeapon(this);
			
			var tank: Tank = TRegistry.instance.getValue("player").Get(0);
			ai = new guard_shipAI(this, tank, transport, left_or_right);
		}
	}

}