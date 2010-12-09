package AI.Transition 
{
	import AI.State.ICompletableState;
	import FSM.Transition;
	/**
	 * ...
	 * @author Taymir
	 */
	public class completeTransition extends Transition
	{
		private var currentState: ICompletableState;
		
		public function completeTransition(currentState: ICompletableState)
		{
			this.currentState = currentState;
		}
		
		protected override function isTriggered() : Boolean
		{
			return this.currentState.isComplete();
		}
	}

}