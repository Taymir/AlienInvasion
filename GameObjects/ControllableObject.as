package  GameObjects
{
	import common.Debug;
	import common.Vector2D;
	import TmpEffects.TemporaryEffect;
	import flash.media.Sound;
	import common.TRegistry;
	import Weapons.BaseWeapon;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class ControllableObject extends GameObject
	{
		public var speed:Number = 1.5;
		public var velocity: Vector2D = new Vector2D;
		public var friction:Number = 0.93;
		public var maxspeed:Number = 15;
		public var maxHitPoints: int = 100;
		
		public var hitPoints: int = maxHitPoints;
		public var primaryWeapon: BaseWeapon;
		
		protected function updatePositionWithVelocity() : void
		{
			x += velocity.x;
			y += velocity.y;
		}
		
		protected function limitVelocity() : void
		{
			if (velocity.x > maxspeed)
				velocity.x = maxspeed;
			else if (velocity.x < -maxspeed)
				velocity.x = -maxspeed;
			
			if (velocity.y > maxspeed)
				velocity.y = maxspeed;
			else if (velocity.y < -maxspeed)
				velocity.y = -maxspeed;
		}
		
		protected function checkAndPlaceWithinScreenBounds() : void
		{
			if (x + halfWidth() > scene.bounds.width)
			{
				x = scene.bounds.width - halfWidth();
				reflectXVelocity();
			}
			else if (x - halfWidth() < 0)
			{
				x = halfWidth();
				reflectXVelocity();
			}
			
			if (y + halfHeight() > scene.bounds.height)
			{
				y = scene.bounds.height - halfHeight();
				reflectYVelocity();
			}
			else if (y - halfHeight() < 0)
			{
				y = halfHeight();
				reflectYVelocity();
			}
		}
		
		protected function reflectXVelocity()
		{
			velocity.x = -velocity.x;
		}
		
		protected function reflectYVelocity()
		{
			velocity.y = -velocity.y;
		}
		
		private function halfWidth() : Number
		{
			return width / 2;
		}
		
		private function halfHeight() : Number
		{
			return height / 2;
		}
		
		protected function isStill() : Boolean
		{
			return (velocity.x == 0 && velocity.y == 0);
		}
		
		protected function correctLowVelocity() : void
		{
			if (velocity.x < .1 && velocity.x > -.1)
				velocity.x = 0;
			if (velocity.y < .1 && velocity.y > -.1)
				velocity.y = 0;
		}
		
		public function slowdownXShift(multiplier: Number = 1.0) : void
		{
			velocity.x *= friction / multiplier;
		}
		
		public function slowdownYShift(multiplier: Number = 1.0) : void
		{
			velocity.y *= friction / multiplier;
		}
		
		public function decXShift() : Number
		{
			return velocity.x -= speed;
		}
		
		public function incXShift() : Number
		{
			return velocity.x += speed;
		}
		
		public function decYShift() : Number
		{
			return velocity.y -= speed;
		}
		
		public function incYShift() : Number
		{
			return velocity.y += speed;
		}
		
		public function fire() : void
		{
			Debug.assert(primaryWeapon != null, "Орудие не определенно");
			
			primaryWeapon.fire();
		}
		
		public function stopFire() : void
		{
			Debug.assert(primaryWeapon != null, "Орудие не определенно");
			
			primaryWeapon.stopFire();
		}
		
		public function hit(hits: int) : void
		{
			this.doDamage(hits);
			this.playSound("hit");
						
			if (this.isDead())
			{
				// Уничтожаем объект
				this.kill();
			}
		}
		
		protected function doDamage(hits: int) : void
		{
			this.hitPoints -= hits;
		}
		
		public function isDead() : Boolean
		{
			return (this.hitPoints <= 0);
		}
		
		// Убийство игрового объекта (с анимацией, проверкой конца игры и прочим) 
		public function kill() : void
		{
			this.dispose();
		}
		
		override public function dispose():void 
		{
			if(this.primaryWeapon != null)
				this.primaryWeapon.dispose();
			super.dispose();
		}
		
		// Воспроизведение звуков
		protected function playSound(soundName : String) : void
		{
			(TRegistry.instance.getValue("sound_manager") as SoundManager).play(soundName);
		}
		
		public function applyEffect(effect: TemporaryEffect)
		{
			effect.beginEffect(this);
			//@TOTHINK: Надо ли вести список всех примененных к объекту эффектов?
		}
	}

}