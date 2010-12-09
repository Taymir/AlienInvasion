package FSM 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class OneTickState extends FSM.State
	{
		public var nextState: FSM.State;
		
		public override function onEnterState() : void
		{
			action();
		}
		
		public override function update() : FSM.State
		{
			return nextState;
		}
		
	}

}