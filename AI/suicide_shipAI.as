package AI 
{
	import AI.State.*;
	import AI.Transition.*;
	import Enemies.suicide_ship;
	import flash.geom.Point;
	import GameObjects.*;
	import FSM.FSM;
	/**
	 * ...
	 * @author Akkarin
	 */
	public class suicide_shipAI extends BaseAI
	{
		private var self: suicide_ship;
		
		public function suicide_shipAI(self : suicide_ship, target : GameObject)
		{
			// init suicide ship
			this.self = self;
			
			// init AI
			var moveRandomState = new MoveRandomState(self);				
			var ramAttackState = new RamAttackState(self, target);
			
			var canSeeTransition : ReachedTransition = new ReachedTransition(self, target, 130);
			
			moveRandomState.transitions = new Array(canSeeTransition);
			canSeeTransition.nextTrueState = ramAttackState;
			
			fsm = new FSM.FSM(moveRandomState);
		}
		
	}

}