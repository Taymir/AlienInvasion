﻿package  
{
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public final class UFO extends UserControlledObject
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
				
			if (key.isDown(Keyboard.UP))
				decYShift();
			else if (key.isDown(Keyboard.DOWN))
				incYShift();
			else
				slowdownYShift();
				
			//@TODO: избавиться от корректировок
			// Корректировка малых значений vx и vy
			correctLowVelocity();
				
			if (key.isDown(Keyboard.SPACE))
				fire();
				
			// Обновление положения
			updatePositionWithVelocity();
			
			// Ограничение скорости
			limitVelocity();
			
			inertiaDeviation();
			
			// Проверка на нахождение в пределах игрового экрана
			checkAndPlaceWithinScreenBounds();
		}
		
		private function inertiaDeviation() : void
		{
			rotation = velocity.x;
		}
		
		protected override function fire () : void
		{
			if (canFire)
			{
				new Missle(x, y, Missle.DOWN);
				fireDelay();
			}
		}
	}

}