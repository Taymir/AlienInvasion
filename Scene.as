package  
{
	import common.MathExtra;
	import GameObjects.GameObject
	import common.TList.TList;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import common.TRegistry;
	import common.Debug;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class Scene extends MovieClip
	{
		private var stageRef:Stage;
		
		public function Scene() 
		{
			Debug.assert( TRegistry.instance.getValue("stage") != null, "В реестре TRegistry не установлено значение объекта сцены stage" );
			stageRef = TRegistry.instance.getValue("stage");
			
			// Привязываемся к глобальному обновлятору
			TRegistry.instance.getValue("globalEnterFrame").Add(trackTank);
		}
		
		// Камера следует за танком
		protected function trackTank()
		{
			var player:TList = TRegistry.instance.getValue("player");
			if (player.Count() > 0)
			{
				var tank : GameObject = player.Get(0) as GameObject;
				this.x = -1 * (tank.x - 400);
				this.y = 0; // Для стабилизации после тряски
			}
		}
		
		// Тряска экрана
		public function shake(maxOffset = 4) 
		{
			this.x += MathExtra.RandomInt( -maxOffset, +maxOffset);
			this.y += MathExtra.RandomInt( -maxOffset, +maxOffset);
		}
	}

}