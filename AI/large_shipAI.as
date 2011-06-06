package AI 
{
	import AI.State.AttackState;
	import AI.State.EvasiveManeuver;
	import AI.State.FreezerState;
	import AI.State.MoveToPositionState;
	import AI.State.NewPositionState;
	import AI.State.ShortPursueState;
	import AI.State.LaunchSmallShipsState;
	import AI.Transition.completeTransition;
	import AI.Transition.MissleDangerTransition;
	import AI.Transition.ReachedAndReadyTransition;
	import AI.Transition.ReachedTransition;
	import AI.Transition.TimeoutTransition;
	import Enemies.large_ship;
	import flash.geom.Point;
	import GameObjects.*;
	import FSM.FSM;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class large_shipAI extends BaseAI
	{
		public static const LARGE_SHIP_PRODUCES_SMALL_SHIPS:int = 1;
		public static const LARGE_SHIP_PRODUCES_SUICIDE_SHIPS:int = 2;
		public static const LARGE_SHIP_SHOOTING_FREEZE:int = 3;
		
		public var tactical_position: Point;
		
		public function large_shipAI(self : large_ship, target : GameObject, typeShipAI: int) 
		{
			tactical_position = new Point(self.x, self.y);
			var newPositionState: NewPositionState = new NewPositionState(self, tactical_position);
			var moveToPositionState: MoveToPositionState = new MoveToPositionState(self, tactical_position);
			var shortPursueState: ShortPursueState = new ShortPursueState(self, target, tactical_position);
			var atackState: AttackState = new AttackState(self);
			var evasiveManeuver: EvasiveManeuver = new EvasiveManeuver(self, tactical_position);
			
			var timeoutTransition: TimeoutTransition = new TimeoutTransition(10*1000, 15*1000);
			var canSeeTransition: ReachedTransition = new ReachedTransition(self, target, shortPursueState.pursueDistance);
			var canShootTransition: ReachedTransition = new ReachedTransition(self, target, 100);
			var canNotShootTransition: ReachedTransition = new ReachedTransition(self, target, 100);
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
			
			canNotShootTransition.nextFalseState = moveToPositionState;
			missleDangerTransition.nextTrueState = evasiveManeuver;
			
			if (typeShipAI == LARGE_SHIP_PRODUCES_SMALL_SHIPS)
			{
				var launchSmallShipsState: LaunchSmallShipsState = new LaunchSmallShipsState(self);
				
				var canLaunchShipTransition: ReachedTransition = new ReachedTransition(self, target, 20);
				
				atackState.transitions = new Array(canNotShootTransition, missleDangerTransition, canLaunchShipTransition);
				canLaunchShipTransition.nextTrueState = launchSmallShipsState;
				launchSmallShipsState.nextState = atackState;
			} else if (typeShipAI == LARGE_SHIP_SHOOTING_FREEZE) {
				var freezerState: FreezerState = new FreezerState(self);
				
				var canFreezeTransition: ReachedAndReadyTransition = new ReachedAndReadyTransition(self, target, 20);
				
				atackState.transitions = new Array(canNotShootTransition, missleDangerTransition, canFreezeTransition);
				canFreezeTransition.nextTrueState = freezerState;
				freezerState.nextState = atackState;
			} else {
				//@TODO: LARGE_SHIP_SHOOTING_FREEZE
				atackState.transitions = new Array(canNotShootTransition, missleDangerTransition);
			}
			
			evasiveManeuver.transitions = new Array(maneuverCompleteTransition);
			maneuverCompleteTransition.nextTrueState = atackState;
			
			fsm = new FSM.FSM(newPositionState);
		}
	}

}