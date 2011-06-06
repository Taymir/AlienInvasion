package AI.State
{
	import FSM.State;	
	import common.TTimer;
	import common.TTimerEvent;
	import Enemies.large_ship;
	import Enemies.transport_ship;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class LaunchLargeShipsState extends State
	{
		private var self:  transport_ship;
		private var timer: TTimer; // Таймер для запуска короблей
		private var countLaunchShips:int = 0; // Колличество запущеных кораблей
		public var MAX_LAUNCH_SHIPS:int; // Максимальное количесво короблей, которые будут запущены
		
		public function LaunchLargeShipsState(self : transport_ship, max_ships = 3 ) 
		{
			name = "Запуск больших военных кораблей";
		
			this.self = self;
			this.MAX_LAUNCH_SHIPS = max_ships;
			
			// Создаём таймер и по нему запускаем корабли
			timer = new TTimer(2000);
			timer.addEventListener(TTimerEvent.TIMER_COMPLETE, LaunchTime);
			timer.start();//@BUG: не совсем правильно, т.к. запуск должен происходить в момент перехода в состояние...
		}
		
		// Запуск большого военного коробля
		private function LaunchLargeShip(typeShipAI: int) : void
		{
			var ufo = new large_ship(typeShipAI)
			ufo.x = self.x;
			ufo.y = self.y;
			//@TODO: Добавить анимацию выгрузки из материнского корабля
		}
		
		private function LaunchTime(e: TTimerEvent)
		{
			if (countLaunchShips < MAX_LAUNCH_SHIPS)
			{		
				LaunchLargeShip(++countLaunchShips);
				timer.start();
			}
		}
		
	}

}