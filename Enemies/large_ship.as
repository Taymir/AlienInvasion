package Enemies 
{
	import GameObjects.*;
	import AI.large_shipAI;
	import common.Debug;
	import common.TRegistry;
	import Weapons.BaseWeapon;
	import Weapons.DeathRayWeapon;
	import Weapons.FreezerWeapon;
	import Weapons.GrenadesWeapon;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class large_ship extends BaseEnemy
	{
		private var secondaryWeapon: BaseWeapon;
		
		public function large_ship(typeShipAI:int) 
		{
			this.speed = 3.5;
			this.friction = 0.7;
			this.maxspeed = 15;
			this.maxHitPoints = 30;
			this.hitPoints = this.maxHitPoints;
			
			primaryWeapon = new GrenadesWeapon(this);
			secondaryWeapon = new FreezerWeapon(this);
			
			//@BUG: После того, как танк убит, НЛО все ещё "помнит о его существовании"
			var tank:Tank = TRegistry.instance.getValue("player").Get(0);
			ai = new large_shipAI(this, tank, typeShipAI);
		}
		
		public function fireSecondary()
		{
			Debug.assert(secondaryWeapon != null, "Орудие не определенно");
			
			secondaryWeapon.fire();
		}
		
		public function isSecondaryReady() : Boolean
		{
			return this.secondaryWeapon.isReady();
		}
	}

}