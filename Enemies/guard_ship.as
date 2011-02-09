package Enemies 
{
	import Weapons.BaseWeapon;
	import Weapons.GuardLasersWeapon;
	/**
	 * ...
	 * @author Taymir
	 */
	public class guard_ship extends BaseEnemy
	{
		
		public function guard_ship() 
		{
			this.speed = 4;
			this.friction = 0.7;
			this.maxspeed = 13;
			this.maxHitPoints = 40;
			this.hitPoints = this.maxHitPoints;
			
			primaryWeapon = new GuardLasersWeapon(this);
		}
		
		override protected function update() : void
		{
			//@TODO: update AI
			super.update();
		}
	}

}