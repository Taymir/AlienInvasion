package Enemies 
{
	import Weapons.BaseWeapon;
	/**
	 * ...
	 * @author Taymir
	 */
	public class transport_ship extends BaseEnemy
	{
		
		public function transport_ship() 
		{
			this.speed = 2;
			this.friction = 0.7;
			this.maxspeed = 7;
			this.maxHitPoints = 200;
			this.hitPoints = this.maxHitPoints;
			
			primaryWeapon = new BaseWeapon(this);//@TMP
		}
		
		override protected function update() : void
		{
			//@TODO: update AI
			super.update();
		}
	}

}