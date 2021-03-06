package AI 
{
	import GameObjects.*;
	import FSM.FSM;
	import AI.State.*;
	import AI.Transition.*;
	/**
	 * ...
	 * @author Akkarin
	 */
	public class SimpleAI extends BaseAI
	{		
		public function SimpleAI(self : ControllableObject, target : GameObject) 
		{
			var avoidState : AvoidState = new AvoidState(self, target);
			var pursueState : PursueState = new PursueState(self, target);
			var attackState : AttackState = new AttackState(self);
			var avoidTimeoutTransition : TimeoutTransition = new TimeoutTransition(3000, 7000);
			var attackTimeoutTransition : TimeoutTransition = new TimeoutTransition(2000, 3000);
			var reachedTransition : ReachedTransition = new ReachedTransition(self, target);
			var lostTransition : ReachedTransition = new ReachedTransition(self, target);
			
			avoidState.transitions = new Array(avoidTimeoutTransition);
			avoidTimeoutTransition.nextTrueState = pursueState;
			pursueState.transitions = new Array(reachedTransition);
			reachedTransition.nextTrueState = attackState;
			attackState.transitions = new Array(lostTransition, attackTimeoutTransition);
			lostTransition.nextFalseState = pursueState; // false state
			attackTimeoutTransition.nextTrueState = avoidState;
			
			fsm = new FSM.FSM(avoidState);
		}
	}

}