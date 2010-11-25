package 
{
	import common.TList.TList;
	import common.TRegistry;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	
	public final class Tank extends UserControlledObject
	{
		protected override function keyHandler() : void
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
			
			//Показываем месадж бокс и ставим на паузу
			TRegistry.instance.getValue("gameDialog").MessageBox("<p align=\"center\"><b><font size=\"14\" color=\"#ffffff\">Много ма нлоно отаке ма, и твоя танка пиздеца ма!!!</font></b><p>", 0xFF0000, 0.5, 20, 350, 1);
			TRegistry.instance.getValue("gameStateManager").pauseGame();
		}
	}
}