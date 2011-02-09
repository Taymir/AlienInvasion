package AI 
{
	import AI.State.AttackState;
	import AI.State.InactivityState;
	import AI.Transition.TimeoutTransition;
	import Enemies.guard_ship;
	import FSM.FSM;
	/**
	 * ...
	 * @author Taymir
	 */
	public class guard_shipAI 
	{
		private var fsm: FSM;
		public function guard_shipAI(self: guard_ship, target: GameObject) 
		{
			// init AI
			//@TMP Просто для проверки оружия, надо поправить
			var inactiveState: InactivityState = new InactivityState();
			var atackState: AttackState = new AttackState(self);
			
			var timeoutTransition: TimeoutTransition = new TimeoutTransition(100, 200);
			
			inactiveState.transitions = new Array(timeoutTransition);
			timeoutTransition.nextTrueState = atackState;
			
			fsm = new FSM.FSM(inactiveState);
		}
		
		public function update() : void
		{
			fsm.update();
		}
	}

}