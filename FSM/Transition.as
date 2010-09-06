package FSM 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class Transition
	{
		public var name: String = "Переход";
		
		public var nextTrueState: FSM.State = null;
		public var nextFalseState: FSM.State = null;
		
		protected function isTriggered() : Boolean
		{
			//@EMPTY
		}
		
		public function initialize():void
		{
			//@EMPTY
		}
		
		public function check() : FSM.State
		{
			if (isTriggered())
				return nextTrueState;
			
			return nextFalseState;
		}
		
	}

}