package Enemies 
{
	import AI.suicide_shipAI;
	import Enemies.BaseEnemy;
	import common.TRegistry;
	import common.TList.TList;
	/**
	 * ...
	 * @author Akkarin
	 */
	public class suicide_ship extends BaseEnemy
	{
		public static const DIRECTION_NONE:int = 0;
		public static const DIRECTION_RIGHT:int = +1;
		public static const DIRECTION_LEFT:int = -1;
		
		public var direction:int = DIRECTION_NONE;
		public var damage: Number = 50;
		
		public function suicide_ship() 
		{
			this.speed = 5.0;
			this.friction = 0.8;
			this.maxspeed = 20;
			this.maxHitPoints = 1;
			this.hitPoints = this.maxHitPoints;
									
			//@BUG: После того, как танк убит, НЛО все ещё "помнит о его существовании"
			var tank:Tank = TRegistry.instance.getValue("player").Get(0);
			ai = new suicide_shipAI(this, tank);
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
		
		public function collision_detection_callback(obj: Object) : int
		{
			var targetObj: ControllableObject = obj as ControllableObject;
			
			if (this.hitTestObject(targetObj))
			{
				hitTarget(targetObj);
				this.kill();
				
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
		protected function hitTarget(targetObj: ControllableObject)
		{
			this.Explode();
			targetObj.hit(damage);
		}
		
		protected function Explode() : void
		{
			new Explosion(x, y);
		}
		
		protected override function update() : void
		{		
			if (this.y >= TRegistry.instance.getValue("groundPosition"))
			{
				
				this.Explode();
				this.kill();
			}
			
			TRegistry.instance.getValue("player").Walk(collision_detection_callback);
			
			super.update();
		}
	}

}