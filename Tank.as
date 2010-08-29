package 
{
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	
	public class Tank extends UserControlledObject
	{
		protected override function keyHandler(e:Event) : void
		{
			// Обработка нажатий
			if (key.isDown(65))
				decXShift();
			else if (key.isDown(68))
				incXShift();
			else
				slowdownXShift();
				
			if (key.isDown(Keyboard.PAGE_UP))
				fire();
				
			// Корректировка малых значений vx и vy
			correctLowShifts();
				
			// Обновление положения
			updatePositionFromShifts();
			
			// Ограничение скорости
			limitShifts();
			
			// Проверка на нахождение в пределах игрового экрана
			checkAndPlaceWithinScreenBounds();
		}
		
		protected override function fire() : void
		{
			if (canFire)
			{
				new Missle(x, y, Missle.UP);
				fireDelay();
			}
		}
	}
}