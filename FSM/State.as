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
			for each(var transition: Transition in transitions)
				transition.initialize();
			
			action();
		}
		
		protected function action () : void
		{
			//@EMPTY
		}
		
		public function update() : State
		{
			var newState : State = checkAllTransitions();
			
			if (newState == null)
				this.action();
			
			return newState;
		}
		
		private function checkAllTransitions() : State
		{
			for each(var transition:Transition in transitions)
			{
				var newState:State = transition.check();
				
				if (newState != null)
					return newState;
			}
			return null;
		}
		
	}

}