package 
{
	import common.TRegistry;
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
		}
		
		public override function fire() : void
		{
			if (canFire)
			{
				new Missle(x, y, Missle.UP);
				fireDelay();
			}
		}
		
		protected override function destroy() : void
		{
			//Удаляем танк из реестра игровых объектов
			TRegistry.instance.setValue("Tank", null);
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
		}
	}
}