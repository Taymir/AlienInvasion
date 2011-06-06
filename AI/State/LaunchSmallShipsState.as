package AI.State
{
	import AI.large_shipAI;
	import Enemies.small_ship;
	import FSM.OneTickState;
	import FSM.State;	
	import common.TTimer;
	import common.TTimerEvent;
	import Enemies.large_ship;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class LaunchSmallShipsState extends OneTickState
	{
		private var self: large_ship;
		private var timer: TTimer; // Таймер для запуска короблей
		private var countLaunchShips:int = 0; // Колличество запущеных кораблей
		private var launchShips:int = 0; // Сколько выпускать за раз
		private const MAX_LAUNCH_SHIPS:int = 1; // Максимальное количесво короблей, которые будут запущены
		
		public function LaunchSmallShipsState(self : large_ship) 
		{
			name = "Запуск маленьких военных кораблей";
		
			this.self = self;
			
			// Создаём таймер и по нему запускаем корабли
			timer = new TTimer(1000);
			timer.addEventListener(TTimerEvent.TIMER_COMPLETE, LaunchTime);
			timer.start();
		}
		
		// Запуск большого военного коробля
		private function LaunchSmallShip() : void
		{
			var ufo = new small_ship();
			ufo.x = self.x;
			ufo.y = self.y;
		}
		
		private function LaunchTime(e: TTimerEvent)
		{
			if (countLaunchShips < MAX_LAUNCH_SHIPS)
			{				
				LaunchSmallShip();
				countLaunchShips++;
				
				timer.start();
			}
		}
		
	}

}