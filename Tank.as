package 
{
	import AI.Transition.MissleDangerTransition;
	import common.TList.TList;
	import common.TRegistry;
	import Effects.EnergyUmbrellaEffect;
	import Effects.FireAcceleratorEffect;
	import Effects.SpeedAcceleratorEffect;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	import Weapons.TankCannonWeapon;
	import Weapons.TankLaserWeapon;
	import Weapons.TankReflectorWeapon;
	
	public final class Tank extends UserControlledObject
	{
		public function Tank(): void
		{
			this.activateBaseWeapon();
		}
		
		protected override function keyHandler() : void
		{
			// Проверка на столкновения с препятствиями
			collisionDetection();
			// Обработка нажатий
			if (key.isDown(Keyboard.LEFT))
				decXShift();
			else if (key.isDown(Keyboard.RIGHT))
				incXShift();
			else
				slowdownXShift();
				
			if (key.isDown(Keyboard.UP))
				fire();
			else
				stopFire();
				
			// Корректировка малых значений vx и vy
			correctLowVelocity();
				
			// Обновление положения
			updatePositionWithVelocity();
			
			// Ограничение скорости
			limitVelocity();
			
			// Проверка на нахождение в пределах игрового экрана
			checkAndPlaceWithinScreenBounds();
			
			
		}
		
		private function collisionDetection() : void
		{
			/*
			 * Если среди списка препятствий имеется hitTest=true
			 * то reflectXVelocity (прозводим отталкивание от препятствия)
			 */
			TRegistry.instance.getValue("obstacles").Walk(collision_test_with);
		}
		
		private function collision_test_with(obj: Object) : int
		{
			var obstacle:MovieClip = obj as MovieClip;
			
			if (this.hitTestObject(obstacle))
			{
				this.reflectXVelocity();
				throw_me_out_of_obstacle(obstacle);
				
				 //@TOTHINK: а надо ли останавливать поиск после первого столкновения?
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
		//BUGFIX: чтобы танк не застревал в камне, насильно выбрасываем его из него
		private function throw_me_out_of_obstacle(obstacle: MovieClip) : void
		{
			var bounds:Rectangle = obstacle.getBounds(this.scene);
			if (this.x > obstacle.x)
			{
				this.x = bounds.right + this.width / 2;
			} else {
				this.x = bounds.left - this.width / 2;
			}
			
		}
		
		override protected function doDamage(hits: int) : void
		{
			if(!TRegistry.instance.getValue("debug_god_mode"))
				super.doDamage(hits);
			
			//@EXPERIMENT Торможение танка при попадании
			slowdownXShift(2);
		}
		
		//* USER CONTROLLED ACTION *//
		//@BUG наверное, не надо создавать заново экземпляр класса при каждой смене орудия
		public function activateLaser() : void
		{
			this.primaryWeapon = new TankLaserWeapon(this);
		}
		
		public function activateBaseWeapon() : void
		{
			this.primaryWeapon = new TankCannonWeapon(this);
		}
		
		public function activateReflector() : void
		{
			this.primaryWeapon = new TankReflectorWeapon(this);
		}
		
		public function activateFireAccelerator() : void
		{
			this.applyEffect(new FireAcceleratorEffect());
		}
		
		public function activateSpeedAccelerator() : void
		{
			this.applyEffect(new SpeedAcceleratorEffect());
		}
		
		public function activateEneryUmbrella() : void
		{
			this.applyEffect(new EnergyUmbrellaEffect());
		}
	}
}