package AI.State 
{
	import common.MathExtra;
	import Enemies.suicide_ship;
	import flash.geom.Point;
	import FSM.State;
	import common.TRegistry;

	/**
	 * ...
	 * @author Akkarin
	 */
	public final class MoveRandomState extends State
	{
		private var self: suicide_ship;
		private var random_point: Point;
		
		public function MoveRandomState(self: suicide_ship) 
		{
			this.self = self;
			random_point = new Point(MathExtra.RandomInt(0, 600), MathExtra.RandomInt(0, 300));
			name = "Рандомное перемещение";
		}
		
		protected override function action() : void
		{
			// Получение новых координат для движения
			if (MathExtra.RandomInt(0, 15) == 10)
			{
				random_point = new Point(MathExtra.RandomInt(0, 600), MathExtra.RandomInt(0, 300));
				trace("X: " + random_point.x + "; Y: " + random_point.y);
			}
			
			if(self.x > random_point.x)
				self.decXShift();
			else if(self.x < random_point.x)
				self.incXShift();
			
			if (self.y > random_point.y)
				self.decYShift();
			else if(self.y < random_point.y)
				self.incYShift();
		}		
	}

}