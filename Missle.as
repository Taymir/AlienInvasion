package  
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import common.TRegistry;
	
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
			if (direction == DOWN && y < TRegistry.instance.getValue("groundPosition"))
			{
				if (this.hitTestObject(TRegistry.instance.getValue("Tank")))
				{
					this.Explode();
					//TRegistry.instance.getValue("Tank").hit();
					return;
				} 
				
				y += speed;
			} 
			else if (direction == UP && y > -70)
			{
				for each (var enemy in TRegistry.instance.getValue("Enemies"))
				{
					if (this.hitTestObject(enemy))
					{
						this.Explode();
						//enemy.hit();
						return;
					}
				}
				
				y -= speed;
			}
			else 
			{			
				this.Explode();
			}
		}
		
		private function Explode() : void
		{
			explosion.x = x;
			explosion.y = y;
				
			stageRef.addChild(explosion);
				
			explosion.addFrameScript(explosion.totalFrames - 1, stopExplosion);
				
			removeEventListener(Event.ENTER_FRAME, loop, false);
				
			stageRef.removeChild(this);
		}
		
		private function stopExplosion() : void
		{
			explosion.stop();
			
			stageRef.removeChild(explosion);							
		}
		
	}

}