package  
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author 
	 */
	public class Missle extends GameObject
	{
		private var speed:Number = 7.5;
		private var direction:int = 0;
		public static const UP:int = 0;
		public static const DOWN:int = 1;
		
		private var explosion:Explosion = new Explosion();
		
		public function Missle(x:Number, y:Number, direction:int) 
		{
			this.x = x;
			this.y = y;
			this.direction = direction;
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			
			stageRef.addChild(this);
		}
		
		private function loop(e: Event) : void
		{
			if (direction == DOWN && y < stageRef.stageHeight)
			{
				y += speed;
			} 
			else if (direction == UP && y > 0)
			{
				y -= speed;
			}
			else 
			{						
				explosion.x = x;
				explosion.y = y;
				
				stageRef.addChild(explosion);
				
				explosion.addFrameScript(explosion.totalFrames - 1, stopExplosion);
				
				removeEventListener(Event.ENTER_FRAME, loop, false);
			}
		}
		
		private function stopExplosion() : void
		{
			explosion.stop();
			
			stageRef.removeChild(explosion);							
			stageRef.removeChild(this);
		}
		
	}

}