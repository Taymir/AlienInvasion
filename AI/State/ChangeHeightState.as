package AI.State
{
	import GameObjects.ControllableObject;
	import common.Debug;
	import FSM.State;
	/**
	 * ...
	 * @author Taymir
	 */
	public class ChangeHeightState extends State
	{
		public static const DIRECTION_UP: int = -1;
		public static const DIRECTION_DOWN: int = +1;
		
		private var self : ControllableObject;
		private var direction: int;
		private var border: Number;
		
		public function ChangeHeightState(self: ControllableObject, direction: int, border: Number) 
		{
			name = "Изменение высоты";

			this.self = self;
			this.direction = direction;
			this.border = border;
			
		}
		
		protected override function action() : void
		{
			if (direction == DIRECTION_UP && self.y > border)
			{
				self.decYShift();
			} else if (direction == DIRECTION_DOWN && self.y < border) {
				self.incYShift();
			}
			//Если за пределами границы - ничего не делаем
		}
		
	}

}