package Enemies 
{
	import AI.BaseAI;
	import AI.SimpleAI;
	import common.TList.TList;
	import common.TRegistry;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	import GameObjects.ControllableObject;
	import Missles.BaseMissle;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class BaseEnemy extends ControllableObject
	{
		protected var ai : BaseAI;
		
		public function BaseEnemy() : void
		{
			// Добавляемся в список
			addToList("enemies");
			
			// Привязываемся к глобальному обновлятору
			addToGlobalEnterFrame(update);
		}
		
		public function get aiEnabled():Boolean
		{
			return ai.enabled;
		}
		
		public function set aiEnabled(value: Boolean): void
		{
			ai.enabled = value;
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