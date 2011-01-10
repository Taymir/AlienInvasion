package Enemies 
{
	import AI.large_shipAI;
	import common.TRegistry;
	import Missles.BaseMissle;
	import Missles.energy_stream;
	import Missles.grenades;
	import Weapons.EnergyStreamWeapon;
	import Weapons.GrenadesWeapon;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class large_ship extends BaseEnemy
	{
		private var ai:large_shipAI;
		
		public function large_ship() 
		{
			this.speed = 3.5;
			this.friction = 0.7;
			this.maxspeed = 15;
			this.maxHitPoints = 30;
			this.hitPoints = this.maxHitPoints;
			
			//primaryWeapon = new GrenadesWeapon();//@TMP
			primaryWeapon = new EnergyStreamWeapon(this);
			
			//@BUG: После того, как танк убит, НЛО все ещё "помнит о его существовании"
			var tank:Tank = TRegistry.instance.getValue("player").Get(0);
			ai = new large_shipAI(this, tank);
		}
		
		protected override function update() : void
		{
			ai.update();
			super.update();
		}
		
	}

}