package Enemies 
{
	import AI.SimpleAI;
	import common.TList.TList;
	import common.TRegistry;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	import ControllableObject;
	import Missles.BaseMissle;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class BaseEnemy extends ControllableObject
	{
		private var ai : SimpleAI;
		
		public function BaseEnemy() : void
		{
			// Привязываемся к глобальному обновлятору
			TRegistry.instance.getValue("globalEnterFrame").Add(update);
			
			//@BUG: После того, как танк убит, НЛО все ещё "помнит о его существовании"
			//@REFACTOR: Как-то упростить эти длинные конструкции
			var tank:Tank = (TRegistry.instance.getValue("player") as TList).Iterator().CurrentItem() as Tank;
			ai = new SimpleAI(this, tank);
		}
		
		protected function update() : void
		{	
			ai.update();
			slowdownXShift();
			slowdownYShift();
			
			// Корректировка малых значений vx и vy
			correctLowVelocity();
			
			// Обновление положения
			updatePositionWithVelocity();
			
			// Ограничение скорости
			limitVelocity();
			
			//inertiaDeviation();
			
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
				new Missle(x, y, BaseMissle.DOWN);
				fireDelay();
				super.fire();
			}
		}
		
		protected override function destroy() : void
		{
			//Удаляем НЛО из реестра игровых объектов
			(TRegistry.instance.getValue("enemies") as TList).Remove(this);
			
			//Отвязываем все события
			//this.removeEventListener(TRegistry.instance.getValue("globalEnterFrame").Add, update);
			TRegistry.instance.getValue("globalEnterFrame").Remove(update);
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
		}
		
	}

}