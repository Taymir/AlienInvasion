package AI 
{
	import AI.State.AttackState;
	import AI.State.EvasiveManeuver;
	import AI.State.MoveToPositionState;
	import AI.State.NewPositionState;
	import AI.State.ShortPursueState;
	import AI.Transition.completeTransition;
	import AI.Transition.MissleDangerTransition;
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
		
		public function large_shipAI(self : ControllableObject, target : GameObject) 
		{
			// МНОГО БАГОВ: тряска нло, преследование не доходит до конца
			//@TODO гранаты
			//@TODO энергопоток
			tactical_position = new Point(self.x, self.y);
			var newPositionState: NewPositionState = new NewPositionState(self, tactical_position);
			var moveToPositionState: MoveToPositionState = new MoveToPositionState(self, tactical_position);
			var shortPursueState: ShortPursueState = new ShortPursueState(self, target, tactical_position);
			var atackState: AttackState = new AttackState(self);
			var evasiveManeuver: EvasiveManeuver = new EvasiveManeuver(self, tactical_position);
			
			var timeoutTransition: TimeoutTransition = new TimeoutTransition(500*1000, 600*1000);
			var canSeeTransition: ReachedTransition = new ReachedTransition(self, target, shortPursueState.pursueDistance);
			var canShootTransition: ReachedTransition = new ReachedTransition(self, target, 50);
			var canNotShootTransition: ReachedTransition = new ReachedTransition(self, target, 50);
			var canNotSeeTransition: ReachedTransition = new ReachedTransition(self, target, shortPursueState.pursueDistance);
			var missleDangerTransition: MissleDangerTransition = new MissleDangerTransition(self);
			var maneuverCompleteTransition: completeTransition = new completeTransition(evasiveManeuver);
			
			newPositionState.nextState = moveToPositionState;
			moveToPositionState.transitions = new Array(timeoutTransition, canSeeTransition);
			timeoutTransition.nextTrueState = newPositionState;
			canSeeTransition.nextTrueState = shortPursueState;
			shortPursueState.transitions = new Array(canNotSeeTransition, canShootTransition);
			canNotSeeTransition.nextFalseState = moveToPositionState;
			canShootTransition.nextTrueState = atackState;
			atackState.transitions = new Array(canNotShootTransition, missleDangerTransition);
			canNotShootTransition.nextFalseState = moveToPositionState;
			missleDangerTransition.nextTrueState = evasiveManeuver;
			evasiveManeuver.transitions = new Array(maneuverCompleteTransition);
			maneuverCompleteTransition.nextTrueState = atackState;
			
			FSM.FSM.debug_mode = true;
			fsm = new FSM.FSM(newPositionState);
		}
		
		public function update() : void
		{
			fsm.update();
		}
	}

}