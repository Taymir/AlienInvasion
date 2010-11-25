package 
{
	import common.TList.TList;
	import common.TRegistry;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	
	public final class Tank extends UserControlledObject
	{
		protected override function keyHandler(e:Event) : void
		{
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
			
			// Проверка на столкновения с препятствиями
			collisionDetection();
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
				 //@TOTHINK: а надо ли останавливать поиск после первого столкновения?
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
		public override function fire() : void
		{
			//@TODO вынести в отдельный переопределяемый метод тело if-а
			if (canFire)
			{
				new Missle(x, y, Missle.UP);
				fireDelay();
				super.fire();
			}
		}
		
		protected override function destroy() : void
		{
			//Удаляем ссылку на танк
			(TRegistry.instance.getValue("player") as TList).Remove(this);
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
		}
	}
}