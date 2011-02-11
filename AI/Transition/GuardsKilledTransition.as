package AI.Transition 
{
	import FSM.Transition;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class GuardsKilledTransition extends Transition 
	{
		private var guard_one: ControllableObject;
		private var guard_two: ControllableObject;
		
		public function GuardsKilledTransition(guard_one: ControllableObject, guard_two: ControllableObject) 
		{
			this.guard_one = guard_one;
			this.guard_two = guard_two;
		}
		
		protected override function isTriggered() : Boolean
		{
			if (guard_one.isDead() && guard_two.isDead())
				return true;
			return false;
		}
		
	}

}