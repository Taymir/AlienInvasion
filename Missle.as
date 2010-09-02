package  
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import common.TRegistry;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public final class Missle extends GameObject
	{
		public static const UP:int = 0;
		public static const DOWN:int = 1;
		
		private var speed:Number = 17;
		private var direction:int = 0;
		
		private var explosion:Explosion;
		
		public function Missle(x:Number, y:Number, direction:int) 
		{
			this.x = x;
			this.y = y;
			this.direction = direction;
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
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
			removeEventListener(Event.ENTER_FRAME, loop, false);
			
			this.explosion = new Explosion();
			explosion.x = x;
			explosion.y = y;
				
			explosion.addFrameScript(explosion.totalFrames - 1, stopExplosion);
			stageRef.addChild(explosion);
				
			this.hide();
		}
		
		private function stopExplosion() : void
		{
			explosion.stop();
			
			stageRef.removeChild(explosion);
		}
		
	}

}