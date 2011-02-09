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
				// Работаем напрямую с мувиклипом. Возможно вынести работу с графикой на отдельный уровень 
				// абстракции: класс RAY
				// Но пока в этом не вижу необходимости
				ray = new death_ray();
				firingTimer.start();
				
				this.updateRayPosition();
				
				getScene().addChild(ray);
				
				getGlobalEnterFrame().Add(update);
				
				
				super.launch(x, y);
			}
		}
		
		private function getScene() : MovieClip
		{
			return  TRegistry.instance.getValue("scene")
		}
		
		private function getGlobalEnterFrame() : GlobalEnterFrame
		{
			return TRegistry.instance.getValue("globalEnterFrame");
		}
		
		private function updateRayPosition()
		{
			ray.x = shooterObj.x;
			ray.y = shooterObj.y;
			
			//@TODO проверка на пересечение с игроком / препятствиями
			// Если пересечение существует:
			// * Для луча: уменьшить высоту до высоты препятсивя / игрока
			// * Для игрока: получить повреждения
			ray.height = TRegistry.instance.getValue("groundPosition") - shooterObj.y
		}
		
		protected function update() : void
		{
			// Луч следует за кораблем
			this.updateRayPosition();
			
			// Луч создает искры
			var sparkles: ParticleSparkles = new ParticleSparkles(ray.x, ray.y + ray.height); //@BUG при большой скорости движения корабля, искры запаздывают
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