package  
{
	import common.TRegistry;
	import common.TList.TList;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import Missles.BaseMissle;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public final class TesterUFO extends UserControlledObject
	{
		protected override function keyHandler() : void
		{
			// Обработка нажатий
			if (key.isDown(65))
				decXShift();
			else if (key.isDown(68))
				incXShift();
			else
				slowdownXShift();
				
			if (key.isDown(Keyboard.PAGE_DOWN))
				fire();
			
			// Корректировка малых значений vx и vy
			correctLowVelocity();
			
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
		
		public override function fire () : void
		{
			if (canFire)
			{
				new Missle(x, y, BaseMissle.DOWN);
				fireDelay();
			}
		}
		
		protected override function destroy() : void
		{
			//Удаляем НЛО из реестра игровых объектов
			(TRegistry.instance.getValue("enemies") as TList).Remove(this);
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
		}
		
	}

}