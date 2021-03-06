package AI.State 
{
	import GameObjects.*;
	import common.MathExtra;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Taymir
	 */
	public class ShortPursueState extends PursueState
	{
		public var pursueDistance : int = 200;
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