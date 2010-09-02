package  
{
	import common.Vector2D;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Taymir
	 */
	public class ControllableObject extends GameObject
	{
		protected var fireDelayPeriod : int = 300;
		protected var speed:Number = 1.5;
		protected var velocity: Vector2D = new Vector2D;
		protected var friction:Number = 0.93;
		protected var maxspeed:Number = 15;
		
		protected var canFire : Boolean = true;
		
		private var fireTimer : Timer;
		
		
		public function ControllableObject ()
		{
			fireTimer = new Timer(fireDelayPeriod, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler);
		}
		
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
			if (x + halfWidth() > stageRef.stageWidth)
			{
				x = stageRef.stageWidth - halfWidth();
				velocity.x = -velocity.x;
			}
			else if (x - halfWidth() < 0)
			{
				x = halfWidth();
				velocity.x = -velocity.x;
			}
			
			if (y + halfHeight() > stageRef.stageHeight)
			{
				y = stageRef.stageHeight - halfHeight();
				velocity.y = -velocity.y;
			}
			else if (y - halfHeight() < 0)
			{
				y = halfHeight();
				velocity.y = -velocity.y;
			}
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
		
		//@TODO: избавиться от корректировок
		protected function correctLowVelocity() : void
		{
			if (velocity.x < .1 && velocity.x > -.1)
				velocity.x = 0;
			if (velocity.y < .1 && velocity.y > -.1)
				velocity.y = 0;
		}
		
		protected function slowdownXShift() : void
		{
			velocity.x *= friction;
		}
		
		protected function slowdownYShift() : void
		{
			velocity.y *= friction;
		}
		
		protected function decXShift() : Number
		{
			return velocity.x -= speed;
		}
		
		protected function incXShift() : Number
		{
			return velocity.x += speed;
		}
		
		protected function decYShift() : Number
		{
			return velocity.y -= speed;
		}
		
		protected function incYShift() : Number
		{
			return velocity.y += speed;
		}
		
		protected function fire() : void
		{
			//@EMPTY: переопределяется в наследниках
		}
		
		protected function fireDelay() : void
		{
			canFire = false;
			fireTimer.start();
		}
		
		private function fireTimerHandler(e:TimerEvent) : void
		{
			canFire = true;
		}
	}

}