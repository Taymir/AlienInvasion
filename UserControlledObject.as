package  
{
	import com.senocular.utils.KeyObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author Taymir
	 */
	public class UserControlledObject extends GameObject
	{
		protected var key:KeyObject;
		
		protected var speed:Number = 1.5;
		protected var vx:Number = 0;
		protected var vy:Number = 0;
		protected var friction:Number = 0.93;
		protected var maxspeed:Number = 15;
		
		public function UserControlledObject() 
		{
			key = new KeyObject(stageRef);
			
			addEventListener(Event.ENTER_FRAME, keyHandler, false, 0, true);
		}
		
		protected function keyHandler(e: Event) : void
		{
			//@EMPTY: переопределяется в наследниках
		}
		
		protected function updatePositionFromShifts() : void
		{
			x += vx;
			y += vy;
		}
		
		protected function limitShifts() : void
		{
			if (vx > maxspeed)
				vx = maxspeed;
			else if (vx < -maxspeed)
				vx = -maxspeed;
			
			if (vy > maxspeed)
				vy = maxspeed;
			else if (vy < -maxspeed)
				vy = -maxspeed;
		}
		
		protected function checkAndPlaceWithinScreenBounds() : void
		{
			if (x > stageRef.stageWidth)
			{
				x = stageRef.stageWidth;
				vx = -vx;
			}
			else if (x < 0)
			{
				x = 0;
				vx = -vx;
			}
 
			if (y > stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				vy = -vy;
			}
			else if (y < 0)
			{
				y = 0;
				vy = -vy;
			}
		}
		
		protected function isStill() : Boolean
		{
			return (vx == 0 && vy == 0);
		}
		
		//@TODO: избавиться от корректировок
		protected function correctLowShifts() : void
		{
			if (vx < .5 && vx > -.5)
				vx = 0;
			if (vy < .5 && vy > -.5)
				vy = 0;
		}
		
		protected function slowdownXShift() : void
		{
			vx *= friction;
		}
		
		protected function slowdownYShift() : void
		{
			vy *= friction;
		}
		
		protected function decXShift() : Number
		{
			return vx -= speed;
		}
		
		protected function incXShift() : Number
		{
			return vx += speed;
		}
		
		protected function decYShift() : Number
		{
			return vy -= speed;
		}
		
		protected function incYShift() : Number
		{
			return vy += speed;
		}
	}

}