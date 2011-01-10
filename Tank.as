package 
{
	import AI.Transition.MissleDangerTransition;
	import common.TList.TList;
	import common.TRegistry;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	import Weapons.TankCannonWeapon;
	
	public final class Tank extends UserControlledObject
	{
		public function Tank(): void
		{
			this.primaryWeapon = new TankCannonWeapon(this);
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
				
			if (key.isDown(Keyboard.SPACE))
				fire();
				
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
		
		protected override function destroy() : void
		{
			//Удаляем ссылку на танк
			(TRegistry.instance.getValue("player") as TList).Remove(this);
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
			
			// Проверка конца игры
			TRegistry.instance.getValue("gameStateManager").checkEndGame();
		}
		
		
		override protected function doDamage(hits: int) : void
		{
			if(!TRegistry.instance.getValue("debug_god_mode"))
				super.doDamage(hits);
		}
		
	}
}