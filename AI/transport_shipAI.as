package AI 
{
	import AI.State.InactivityState;
	import AI.State.MoveAndAtackState;
	import AI.Transition.TimeoutTransition;
	import Enemies.transport_ship;
	import FSM.FSM;
	/**
	 * ...
	 * @author Taymir
	 */
	public class transport_shipAI 
	{
		private var fsm: FSM.FSM;
		
		public function transport_shipAI(self: transport_ship, target: GameObject) 
		{
			// init ship
			var self = self;
			self.direction = transport_ship.DIRECTION_LEFT;
			
			// init AI
			var inactiveState: InactivityState = new InactivityState();
			var moveAndAttackState: MoveAndAtackState = new MoveAndAtackState(self);
			
			var timeoutTransition: TimeoutTransition = new TimeoutTransition(100, 200);
			
			inactiveState.transitions = new Array(timeoutTransition);
			timeoutTransition.nextTrueState = moveAndAttackState;
			
			fsm = new FSM.FSM(inactiveState);
		}
		
		public function update() : void
		{
			fsm.update();
		}
		
	}

}