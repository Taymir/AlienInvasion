package AI.State 
{
	import GameObjects.ControllableObject;
	import Enemies.guard_ship;
	import flash.geom.Point;
	import FSM.OneTickState;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class GuardPositionState extends OneTickState 
	{
		private var position: Point;
		private var transport: ControllableObject;
		private var left_or_right: int;
		
		public function GuardPositionState(position: Point, transport: ControllableObject, left_or_right: int) 
		{
			this.position = position;
			this.left_or_right = left_or_right;
			this.transport = transport;
			
			name = "Выбор поцизиции охраны";
		}
		
		protected override function action() : void
		{
			if (left_or_right == guard_ship.LEFT_POSITION)
			{
				// Тактическая позиция - левее транспортника
				position.x = transport.x - 50;
			} else {
				// Тактическая позиция - правее транспортника
				position.x = transport.x + 50;
			}
			// Тактическая позиция - ниже транспортника
			position.y = transport.y + 50;
		}
		
	}

}