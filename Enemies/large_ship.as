package Enemies 
{
	import AI.large_shipAI;
	import common.Debug;
	import common.TRegistry;
	import Missles.BaseMissle;
	import Missles.energy_stream;
	import Missles.grenades;
	import Weapons.BaseWeapon;
	import Weapons.EnergyStreamWeapon;
	import Weapons.GrenadesWeapon;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class large_ship extends BaseEnemy
	{
		private var ai:large_shipAI;
		private var secondaryWeapon: BaseWeapon;
		
		public function large_ship() 
		{
			this.speed = 3.5;
			this.friction = 0.7;
			this.maxspeed = 15;
			this.maxHitPoints = 30;
			this.hitPoints = this.maxHitPoints;
			
			primaryWeapon = new GrenadesWeapon(this);
			secondaryWeapon = new EnergyStreamWeapon(this);
			
			//@BUG: После того, как танк убит, НЛО все ещё "помнит о его существовании"
			var tank:Tank = TRegistry.instance.getValue("player").Get(0);
			ai = new large_shipAI(this, tank);
		}
		
		public function fireSecondary()
		{
			Debug.assert(secondaryWeapon != null, "Орудие не определенно");
			
			secondaryWeapon.fire();
		}
		
		protected override function update() : void
		{
			ai.update();
			super.update();
		}
		
		public function isSecondaryReady() : Boolean
		{
			return this.secondaryWeapon.isReady();
		}
	}

}