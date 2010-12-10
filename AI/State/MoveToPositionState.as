package AI.State 
{
	import common.MathExtra;
	import flash.geom.Point;
	import FSM.State;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public final class MoveToPositionState extends State
	{
		public var minDistance:Number = 10;
		
		private var self: ControllableObject;
		private var position: Point;
		
		public function MoveToPositionState(self: ControllableObject, position: Point) 
		{
			this.self = self;
			this.position = position;
			name = "Перемещение к позиции";
		}
		
		protected override function action() : void
		{
			// Если до position > minDistance пикселей
			if (Math.abs(self.x - position.x) > minDistance)
			{
				if(self.x > position.x)
					self.decXShift();
				else if(self.x < position.x)
					self.incXShift();
			} else {
				self.slowdownXShift();
			}
			
			if (Math.abs(self.y - position.y) > minDistance)
			{
				if (self.y > position.y)
					self.decYShift();
				else if(self.y < position.y)
					self.incYShift();
			} else {
				self.slowdownYShift();
			}
		}
		
	}

}