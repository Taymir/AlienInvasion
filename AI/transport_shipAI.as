package AI 
{
	import AI.State.InactivityState;
	import AI.State.MoveAndAtackState;
	import AI.Transition.GuardsKilledTransition;
	import AI.Transition.TimeoutTransition;
	import Enemies.transport_ship;
	import FSM.FSM;
	/**
	 * ...
	 * @author Taymir
	 */
	public class transport_shipAI extends BaseAI
	{
		private var self: transport_ship;
		private var target: GameObject;
		
		public function transport_shipAI(self: transport_ship, target: GameObject) 
		{
			// init ship
			this.self = self;
			this.self.direction = transport_ship.DIRECTION_NONE;
			this.target = target;
			
			// Данные:
			// 1) Ссылки на охрану
			
			// init AI
			var inactiveState: InactivityState = new InactivityState();
			
			fsm = new FSM.FSM(inactiveState);
		}
		
		public function attach_guards(guard_one: ControllableObject, guard_two: ControllableObject)
		{
			var inactive2State: InactivityState = new InactivityState();
			var moveAndAttackState: MoveAndAtackState = new MoveAndAtackState(this.self, this.target);
			
			var timeoutTransition: TimeoutTransition = new TimeoutTransition(500, 1000);
			var guardKilledTransition: GuardsKilledTransition = new GuardsKilledTransition(guard_one, guard_two);
			
			fsm.getCurrentState().transitions = new Array(guardKilledTransition);
			guardKilledTransition.nextTrueState = inactive2State;
			inactive2State.transitions = new Array(timeoutTransition);
			timeoutTransition.nextTrueState = moveAndAttackState;
		}
		
	}

}