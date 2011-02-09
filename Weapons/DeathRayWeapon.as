package Weapons 
{
	import common.TRegistry;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Taymir
	 */
	public class DeathRayWeapon extends BaseWeapon
	{
		protected var ray: MovieClip;
		protected var firingTimer: Timer;
		
		public function DeathRayWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 60000, firingPeriod:int = 30000) 
		{
			firingTimer = new Timer(firingPeriod, 1);
			firingTimer.addEventListener(TimerEvent.TIMER_COMPLETE, stopFire);
			
			super(shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int): void
		{
			if (ray == null)
			{
				ray = new death_ray();
				firingTimer.start();
				
				ray.x = shooterObj.x;
				ray.y = shooterObj.y;
				
				//@TMP working with scene
				ray.height = TRegistry.instance.getValue("groundPosition") - shooterObj.y;
				var scene : MovieClip = TRegistry.instance.getValue("scene");
				scene.addChild(ray);
				
				//@TMP working with enter frame
				TRegistry.instance.getValue("globalEnterFrame").Add(update);
				
				
				super.launch(x, y);
			}
		}
		
		protected function update() : void
		{
			// Луч следует за кораблем
			ray.x = shooterObj.x;
			ray.y = shooterObj.y;
			
			// Луч создает искры
			var sparkles: ParticleSparkles = new ParticleSparkles(ray.x, ray.y + ray.height, 300, 300, 1, 100); //@BUG при большой скорости движения корабля, искры запаздывают
			
			//@BUG //@TODO Если транспортник будет менять высоту, то надо обновлять высоту луча здесь.
		}
		
		protected function stopFire(e: TimerEvent) : void
		{
			if (ray != null)
			{
				ray.parent.removeChild(ray);
				
				//@TMP working with enter frame
				TRegistry.instance.getValue("globalEnterFrame").Remove(update);
				
				ray = null;
			}
		}
	}

}