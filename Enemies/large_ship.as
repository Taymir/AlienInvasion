package Enemies 
{
	import AI.large_shipAI;
	import common.TRegistry;
	import Missles.BaseMissle;
	import Missles.energy_stream;
	import Missles.grenades;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class large_ship extends BaseEnemy
	{
		private var ai:large_shipAI;
		
		public function large_ship() 
		{
			this.fireDelayPeriod = 400;
			this.speed = 3.5;
			this.friction = 0.7;
			this.maxspeed = 15;
			this.maxHitPoints = 30;
			this.hitPoints = this.maxHitPoints;
			
			//@BUG: После того, как танк убит, НЛО все ещё "помнит о его существовании"
			var tank:Tank = TRegistry.instance.getValue("player").Get(0);
			ai = new large_shipAI(this, tank);
		}
		
		public override function fire():void
		{
			//@REFACTOR вынести в отдельный переопределяемый метод тело if-а
			if (canFire)
			{
				//new grenades(x, y, BaseMissle.DOWN);
				new energy_stream(x, y, BaseMissle.DOWN);
				fireDelay();
				this.playSound("shoot");//@HARDFIX: не работали звуки стрельбы
			}
		}
		
		protected override function update() : void
		{
			ai.update();
			super.update();
		}
		
	}

}