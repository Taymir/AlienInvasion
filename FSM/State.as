package FSM 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class State
	{
		public var name: String = "Состояние";
		public var transitions: Array;
		
		public function onEnterState() : void
		{
			// Перебор transition-ов
			for each(var transition: FSM.Transition in transitions)
				transition.initialize();
			
			action();
		}
		
		protected function action () : void
		{
			//@EMPTY
		}
		
		public function update() : void
		{
			newState : FSM.State = checkAllTransitions();
			
			if (newState = null)
				this.action();
			
			return newState;
		}
		
		private function checkAllTransitions() : FSM.State
		{
			for each(var transition:FSM.Transition in transitions)
			{
				var newState:FSM.State = transition.check();
				
				if (newState != null)
					return newState;
			}
			return null;
		}
		
	}

}