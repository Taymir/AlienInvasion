package GameObjects
{
	import AI.Transition.MissleDangerTransition;
	import common.TList.TList;
	import common.TRegistry;
	import TmpEffects.EnergyUmbrellaEffect;
	import TmpEffects.FireAcceleratorEffect;
	import TmpEffects.MetalShieldEffect;
	import TmpEffects.SpeedAcceleratorEffect;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import Weapons.BaseTankWeapon;
	import Weapons.TankCannonWeapon;
	import Weapons.TankLaserWeapon;
	import Weapons.TankParalyzeWeapon;
	import Weapons.TankReflectorWeapon;
	import Weapons.TankRocketWeapon;
	
	public final class Tank extends UserControlledObject
	{
		private var weapons: Dictionary;
		
		public function Tank(): void
		{
			initWeapons();
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
		
		override public function dispose():void 
		{
			super.dispose();
			this.weapons = null;
		}
		
		//* USER CONTROLLED ACTION *//
		private function initWeapons() : void
		{
			weapons = new Dictionary();
			
			weapons["base_weapon"] = new TankCannonWeapon(this);
			weapons["laser"] = new TankLaserWeapon(this);
			weapons["self_guided_missles"] = new TankRocketWeapon(this);
			weapons["bombs"] = new TankParalyzeWeapon(this);
			weapons["reflector"] = new TankReflectorWeapon(this);
		}
		
		public function activateLaser() : void
		{
			activateWeapon(weapons["laser"]);
		}
		
		public function activateBaseWeapon() : void
		{
			activateWeapon(weapons["base_weapon"]);
		}
		
		public function activateReflector() : void
		{
			activateWeapon(weapons["reflector"])
		}
		
		public function activateParalyzeBombs() : void
		{
			activateWeapon(weapons["bombs"]);
		}
		
		public function activateRocketWeapon() : void
		{
			activateWeapon(weapons["self_guided_missles"]);
		}
		
		private function activateWeapon(weapon : BaseTankWeapon) : void
		{
			if (this.primaryWeapon != null)
				(this.primaryWeapon as BaseTankWeapon).deactivateWeapon();
			
			this.primaryWeapon = weapon;
			weapon.activateWeapon();
		}
		
		public function activateFireAccelerator() : void
		{
			this.applyEffect(new FireAcceleratorEffect());
		}
		
		public function activateSpeedAccelerator() : void
		{
			this.applyEffect(new SpeedAcceleratorEffect());
		}
		
		public function activateEnergyUmbrella() : void
		{
			this.applyEffect(new EnergyUmbrellaEffect());
		}
		
		public function activateMetalShield() : void
		{
			this.applyEffect(new MetalShieldEffect());
		}
	}
}