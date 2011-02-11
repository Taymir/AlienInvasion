package FSM 
{
	/**
	 * Finite State Machine class
	 * @author Taymir
	 */
	public class FSM
	{
		public static var debug_mode: Boolean;
		private var currentState: State;
		
		public function FSM(initialState: State) 
		{
			this.changeState(initialState);
		}
		
		public function update() : void
		{
			var newState : State = currentState.update();
			
			if (newState != null)
				changeState(newState);
		}
		
		public function getCurrentState() : FSM.State
		{
			return currentState;
		}
		
		private  function changeState(newState: State) : void
		{
			if(debug_mode)
				trace(newState.name);
			
			currentState = newState;
			newState.onEnterState();
		}
	}

}