package  
{
	import AI.SimpleAI;
	import common.TList.TList;
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
			//@BUG: После того, как танк убит, НЛО все ещё "помнит о его существовании"
			//@REFACTOR: Как-то упростить эти длинные конструкции
			var tank:Tank = (TRegistry.instance.getValue("player") as TList).Iterator().CurrentItem() as Tank;
			ai = new SimpleAI(this, tank);
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
			//@TODO вынести в отдельный переопределяемый метод тело if-а
			if (canFire)
			{
				new Missle(x, y, Missle.DOWN);
				fireDelay();
				super.fire();
			}
		}
		
		protected override function destroy() : void
		{
			//Удаляем НЛО из реестра игровых объектов
			(TRegistry.instance.getValue("enemies") as TList).Remove(this);
			
			//Отвязываем все события
			this.removeEventListener(Event.ENTER_FRAME, update);
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
		}
	}

}