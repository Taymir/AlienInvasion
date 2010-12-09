package AI.State 
{
	import common.MathExtra;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Taymir
	 */
	public class ShortPursueState extends PursueState
	{
		public var pursueDistance : int = 100;
		private var position: Point;
		
		public function ShortPursueState(self:ControllableObject, target:GameObject, position: Point) 
		{
			super(self, target);
			name = "Короткое преследование";
			this.position = position;
			this.pursueDistance = pursueDistance;
		}
		
		protected override function action():void
		{
			// Если расстояние до тактической позиции < pursueDistance
			if (Math.abs(self.x - position.x) < pursueDistance)
				// Выполняем приближение к цели-танку
				super.action();
		}
		
	}

}