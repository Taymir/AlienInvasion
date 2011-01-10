package AI 
{
	import AI.State.AttackState;
	import AI.State.EvasiveManeuver;
	import AI.State.FreezerState;
	import AI.State.MoveToPositionState;
	import AI.State.NewPositionState;
	import AI.State.ShortPursueState;
	import AI.Transition.completeTransition;
	import AI.Transition.MissleDangerTransition;
	import AI.Transition.ReachedAndReadyTransition;
	import AI.Transition.ReachedTransition;
	import AI.Transition.TimeoutTransition;
	import Enemies.large_ship;
	import flash.geom.Point;
	import FSM.FSM;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class large_shipAI
	{
		private var fsm : FSM.FSM;
		public var tactical_position: Point;
		
		public function large_shipAI(self : large_ship, target : GameObject) 
		{
			tactical_position = new Point(self.x, self.y);
			var newPositionState: NewPositionState = new NewPositionState(self, tactical_position);
			var moveToPositionState: MoveToPositionState = new MoveToPositionState(self, tactical_position);
			var shortPursueState: ShortPursueState = new ShortPursueState(self, target, tactical_position);
			var atackState: AttackState = new AttackState(self);
			var freezerState: FreezerState = new FreezerState(self);
			var evasiveManeuver: EvasiveManeuver = new EvasiveManeuver(self, tactical_position);
			
			var timeoutTransition: TimeoutTransition = new TimeoutTransition(10*1000, 15*1000);
			var canSeeTransition: ReachedTransition = new ReachedTransition(self, target, shortPursueState.pursueDistance);
			var canShootTransition: ReachedTransition = new ReachedTransition(self, target, 100);
			var canNotShootTransition: ReachedTransition = new ReachedTransition(self, target, 100);
			var canNotSeeTransition: ReachedTransition = new ReachedTransition(self, target, shortPursueState.pursueDistance);
			var missleDangerTransition: MissleDangerTransition = new MissleDangerTransition(self);
			var canFreezeTransition: ReachedAndReadyTransition = new ReachedAndReadyTransition(self, target, 20);
			var maneuverCompleteTransition: completeTransition = new completeTransition(evasiveManeuver);
			
			newPositionState.nextState = moveToPositionState;
			moveToPositionState.transitions = new Array(timeoutTransition, canSeeTransition);
			timeoutTransition.nextTrueState = newPositionState;
			canSeeTransition.nextTrueState = shortPursueState;
			shortPursueState.transitions = new Array(canNotSeeTransition, canShootTransition);
			canNotSeeTransition.nextFalseState = moveToPositionState;
			canShootTransition.nextTrueState = atackState;
			atackState.transitions = new Array(canNotShootTransition, missleDangerTransition, canFreezeTransition);
			canNotShootTransition.nextFalseState = moveToPositionState;
			missleDangerTransition.nextTrueState = evasiveManeuver;
			canFreezeTransition.nextTrueState = freezerState;
			freezerState.nextState = atackState;
			evasiveManeuver.transitions = new Array(maneuverCompleteTransition);
			maneuverCompleteTransition.nextTrueState = atackState;
			
			fsm = new FSM.FSM(newPositionState);
		}
		
		public function update() : void
		{
			fsm.update();
		}
	}

}