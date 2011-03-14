package Weapons 
{
	import common.TList.TList;
	import common.TRegistry;
	import flash.display.MovieClip;
	import common.TTimerEvent;
	import flash.geom.Rectangle;
	import common.TTimer;
	/**
	 * ...
	 * @author Taymir
	 */
	public class DeathRayWeapon extends BaseWeapon
	{
		//@TODO надо как-то изменить нижнюю часть луча: очень "плоско" выглядит, возможно сделать каую-то дополнительную вспышку?
		protected var ray: CommonGameObject;
		protected var firingTimer: TTimer;
		
		protected var damage: Number = 2;
		
		public function DeathRayWeapon(shooterObj:ControllableObject, fireDelayPeriod:int = 60000, firingPeriod:int = 30000) 
		{
			firingTimer = new TTimer(firingPeriod);
			firingTimer.addEventListener(TTimerEvent.TIMER_COMPLETE, onRayComplete, false, 0, true);
			
			super(shooterObj, fireDelayPeriod);
		}
		
		override protected function launch(x: int, y: int): void
		{
			if (ray == null)
			{
				ray = new CommonGameObject(new death_ray());
				firingTimer.start();
				
				this.updateRayPosition();
				
				getGlobalEnterFrame().Add(update);
				
				
				super.launch(x, y);
			}
		}
		
		private function getGlobalEnterFrame() : GlobalEnterFrame
		{
			return TRegistry.instance.getValue("globalEnterFrame");
		}
		
		private function updateRayPosition()
		{
			ray.x = shooterObj.x;
			ray.y = shooterObj.y;
			
			ray.height = TRegistry.instance.getValue("groundPosition") - shooterObj.y;
		}
		
		protected function update() : void
		{
			// Луч следует за кораблем
			this.updateRayPosition();
			
			// Если пересечение существует:
			// * Для луча: уменьшить высоту до высоты препятсивя / игрока
			// * Для игрока: получить повреждения
			
			// Проверка на попадание
			TRegistry.instance.getValue("player").Walk(collision_detection_callback);
			TRegistry.instance.getValue("obstacles").Walk(collision_detection_callback);
			
			// Луч создает искры
			var sparkles: ParticleSparkles = new ParticleSparkles(ray.x, ray.y + ray.height); //@BUG при большой скорости движения корабля, искры запаздывают
		}
		
		protected function collision_detection_callback(obj: Object): int
		{
			var targetObj: MovieClip = obj as MovieClip;
			
			if (this.ray.hitTestObject(targetObj))
			{
				var y: Number = this.find_top_collision_point(targetObj, ray);
				
				this.ray.height = y - shooterObj.y;
				
				if (targetObj is UserControlledObject)
					hitTarget(targetObj as UserControlledObject,  ray.x, y);
				
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
		private function find_top_collision_point(targetObj: MovieClip, rayObj: MovieClip, accuracy: Number = 1.0) : Number
		{
			var rayRect: Rectangle = rayObj.getRect(TRegistry.instance.getValue("stage"));
			var targetRect: Rectangle = targetObj.getRect(TRegistry.instance.getValue("stage"));
			
			for (var y: Number = targetRect.top; y < targetRect.bottom; y += accuracy)
			{
				if (true == targetObj.hitTestPoint(rayRect.x + rayRect.width / 2, y, true))
					return y;
			}
			
			
			return rayRect.bottom;
		}
		
		protected function hitTarget(targetObj: ControllableObject, x: int, y: int)
		{
			if(Math.random() < 0.4)//@HARDFIX Слишком много взрывов...
				this.Explode(x, y);
			targetObj.hit(damage);
		}
		
		protected function Explode(x: int, y: int) : void
		{
			new Explosion(x, y);
		}
		protected function onRayComplete(e: TTimerEvent) : void		
		{
			this.stopFire();
		}
		
		public override function stopFire() : void
		{
			if (ray != null)
			{
				ray.parent.removeChild(ray);
				
				getGlobalEnterFrame().Remove(update);
				
				ray = null;
			}
		}
		
		public override function dispose() : void
		{
			// Прекращаем огонь перед удалением оружия
			this.stopFire();
			
			super.dispose();
		}
	}

}