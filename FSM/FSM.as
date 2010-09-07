package FSM 
{
	/**
	 * Finite State Machine class
	 * @author Taymir
	 */
	public class FSM
	{
		private var currentState: State;
		
		public function FSM(initialState: State) 
		{
			this.currentState = initialState;
		}
		
		public function update() : void
		{
			var newState : State = currentState.update();
			
			if (newState != null)
				changeState(newState);
		}
		
		private  function changeState(newState: State) : void
		{
			//trace(newState.name);
			currentState = newState;
			newState.onEnterState();
		}
		
	}

}