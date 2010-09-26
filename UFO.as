package  
{
	import AI.SimpleAI;
	import common.TRegistry;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public final class UFO extends ControllableObject
	{		
		private var ai : SimpleAI;
		
		public function UFO() : void
		{
			addEventListener(Event.ENTER_FRAME, update);
			ai = new SimpleAI(this, TRegistry.instance.getValue("Tank"));
		}
		
		protected function update(e : Event) : void
		{
			ai.update();
			slowdownXShift();
			slowdownYShift();
			
			//@TODO: избавиться от корректировок
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
				new Missle(x, y, Missle.DOWN);
				fireDelay();
			}
		}
		
		protected override function destroy() : void
		{
			//Удаляем НЛО из реестра игровых объектов
			//(TRegistry.instance.getValue("Enemies") as Array).splice//@TODO: Удаление врага из реестра
			
			//Отвязываем все события
			this.removeEventListener(Event.ENTER_FRAME, update);
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
		}
	}

}