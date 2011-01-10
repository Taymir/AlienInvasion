package  
{
	import common.Debug;
	import common.Vector2D;
	import Effects.TemporaryEffect;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
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
		protected var primaryWeapon: BaseWeapon;
		
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
		
		public function slowdownXShift() : void
		{
			velocity.x *= friction;
		}
		
		public function slowdownYShift() : void
		{
			velocity.y *= friction;
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
		
		public function hit(hits: int) : void
		{
			this.doDamage(hits);
			this.playSound("hit");
						
			if (this.isDead())
			{
				//@TODO анимация смерти
				
				// Уничтожаем объект
				this.destroy();
			}
		}
		
		protected function doDamage(hits: int) : void
		{
			this.hitPoints -= hits;
		}
		
		private function isDead() : Boolean
		{
			return (this.hitPoints <= 0);
		}
		
		protected function destroy() : void
		{
			// переопределить у наследников, чтобы отвязать события
			
			//@TOTHINK: надо ли уничтожать оружие: т.е. отвязывать у него все события и ссылки на
			// shooterObj? Если я правильно понимаю, то сейчас controllableObject всегда остается
			// в памяти из-за ссылок на него из чужого и своего AI, из BaseWeapon (при том, что ссылки
			// эти кольцевые... 
			
			// Прячем со сцены
			hide();//@TODO: перенести на уровень ниже??
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