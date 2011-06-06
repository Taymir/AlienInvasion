package AI.State 
{
	import common.MathExtra;
	import common.TTimer;
	import common.TTimerEvent;
	import Enemies.BaseEnemy;
	import FSM.State;
	/**
	 * ...
	 * @author Taymir
	 */
	public class LaunchShipState extends State
	{
		public var maxShips: int = 3;
		public var minDelay: int = 1000;
		public var maxDelay: int = 2000;
		
		
		private var self: BaseEnemy;
		private var timer: TTimer;
		private var launchedShips: int = 0;
		private var canLaunch: Boolean = false;
		private var launchShipFunc: Function;
		
		
		public function LaunchShipState(self: BaseEnemy, launchShipFunc: Function) 
		{
			name = "Запуск кораблей";
			
			this.self = self;
			this.launchShipFunc = launchShipFunc;
			initDelayTimer();
		}
		
		public override function onEnterState() : void
		{
			initDelayTimer();
			
			super.onEnterState();
		}
		
		private function initDelayTimer()
		{
			if (!(timer && timer.running))
			{
				timer = new TTimer(MathExtra.RandomInt(minDelay, maxDelay));
				timer.addEventListener(TTimerEvent.TIMER_COMPLETE, allowLaunching);
				timer.start();
			}
		}
		
		private function allowLaunching(e: TTimerEvent)
		{
			canLaunch = true;
		}
		
		protected override function action() : void
		{
			if (canLaunch)
			{
				if (launchedShips < maxShips)
				{
					var ship: BaseEnemy = this.launchShipFunc.call();
					ship.x = self.x;
					ship.y = self.y;
					
					canLaunch = false;
					launchedShips++;
					initDelayTimer();
				}
			}
		}
		
	}

}