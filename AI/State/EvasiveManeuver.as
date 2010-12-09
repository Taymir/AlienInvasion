package AI.State 
{
	import flash.geom.Point;
	import FSM.State;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class EvasiveManeuver extends State implements ICompletableState
	{
		private var self: ControllableObject;
		private var tactical_position: Point;
		private var safe_positionX: int;
		private const reachDistance:int = 20; // Не требует регулировки, нужно только чтобы не пролететь позицию отсутпления
		private var maneuver_complete: Boolean = false;
		
		public function EvasiveManeuver(self: ControllableObject, tactical_position: Point)
		{
			this.self = self;
			this.tactical_position = tactical_position;
			this.name = "Маневр уклонения";
		}
		
		public override function onEnterState() : void
		{
			this.maneuver_complete = false;
			this.safe_positionX = findSafePositionX(self, tactical_position);
			
			super.onEnterState();
		}
		
		private function findSafePositionX(self: ControllableObject, tactitcal_position: Point) : int
		{
			// Цель: оступить на расстояние собственной ширины в сторону тактической позиции
			if (self.x > tactitcal_position.x)
				return self.x - self.width;
			else
				return self.x + self.width;
		}
		
		protected override function action() : void
		{
			//  Если не долетели до безопасной позиции
			if (Math.abs(self.x - safe_positionX) > reachDistance)
			{
				if (self.x > safe_positionX)
				{
					self.decXShift();
				} else {
					self.incXShift();
				}
			} else {
				this.maneuver_complete = true;
			}
		}
		
		public function isComplete() : Boolean
		{
			return this.maneuver_complete;
		}
		
	}

}