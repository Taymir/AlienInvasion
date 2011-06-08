package AI 
{
	import AI.State.InactivityState;
	import AI.State.LaunchShipState;
	import AI.State.MoveAndAtackState;
	import AI.Transition.GuardsKilledTransition;
	import AI.Transition.TimeoutTransition;
	import common.MathExtra;
	import Enemies.large_ship;
	import Enemies.transport_ship;
	import GameObjects.*;
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
			var launchLargeShipsState: LaunchShipState = new LaunchShipState(self, launchingLargeShip);
			
			fsm = new FSM.FSM(launchLargeShipsState);
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
		
		private function launchingLargeShip() : large_ship
		{
			return new large_ship(MathExtra.RandomInt(1, 3));
		}
		
	}

}