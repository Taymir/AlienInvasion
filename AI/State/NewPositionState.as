package AI.State
{
	import common.MathExtra;
	import flash.geom.Point;
	import FSM.OneTickState;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public final class NewPositionState extends OneTickState
	{
		public var minY: int = 40;
		public var maxY: int = 150;
		public var minX: int = 240;
		public var maxX: int = 1240;
		
		private var self: ControllableObject;
		private var position: Point;
		
		public function NewPositionState(self: ControllableObject, position: Point) 
		{
			this.self = self;
			this.position = position;
			name = "Выбор тактической позиции";
		}
		
		protected override function action() : void
		{
			position.x = MathExtra.RandomInt(minX, maxX);
			position.y = MathExtra.RandomInt(minY, maxY);
		}
		
	}

}