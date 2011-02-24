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
		//private var ai : SimpleAI;//@REFACTOR: вынести в UFO
		
		public function BaseEnemy() : void
		{
			// Добавляемся в список
			addToList("enemies");
			
			// Привязываемся к глобальному обновлятору
			addToGlobalEnterFrame(update);
			
			//@BUG: После того, как танк убит, НЛО все ещё "помнит о его существовании"
			//@REFACTOR: Как-то упростить эти длинные конструкции
			/*var tank:Tank = (TRegistry.instance.getValue("player") as TList).Get(0) as Tank;
			ai = new SimpleAI(this, tank);*///@REFACTOR: вынести в UFO
		}
		
		protected function update() : void
		{	
			//ai.update();//@REFACTOR: вынести в UFO
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
		
		private function inertiaDeviation() : void//@REFACTOR: вынести в UFO
		{
			rotation = velocity.x;
		}
		
		public override function dispose() : void
		{
			//Удаляем НЛО из реестра игровых объектов
			removeFromList("enemies");
			
			//Отвязываем все события
			removeFromGlobalEnterFrame(update);
			
			//Уничтожение продолжается в родительском методе
			super.dispose();
		}
		
		public override function kill() : void
		{
			//@TODO анимация смерти
			
			super.kill();
			
			// Проверка конца игры
			TRegistry.instance.getValue("gameStateManager").checkEndGame();
		}
		
	}

}