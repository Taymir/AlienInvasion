package AI 
{
	import common.TRegistry;
	import Enemies.small_ship;
	import GameObjects.*;
	import FSM.FSM;
	import AI.State.*;
	import AI.Transition.*;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class small_shipAI extends BaseAI
	{
		private var self: small_ship;
		
		public function small_shipAI(self : small_ship, target : GameObject) 
		{
			// init small ship
			this.self = self;
			self.direction = small_ship.DIRECTION_RIGHT;
			self.y = 150;//@TMP
			
			// init AI
			var attackState: AttackState = new AttackState(self);
			var descentState: ChangeHeightState = new ChangeHeightState(self, ChangeHeightState.DIRECTION_DOWN, 300); descentState.name = "Снижение";//@TMP Жестко забитые значения...
			var climbState: ChangeHeightState = new ChangeHeightState(self, ChangeHeightState.DIRECTION_UP, 170); climbState.name = "Повышение";//@TMP Жестко забитые значения...
			
			var canSeeTransition : InSightTransition = new InSightTransition(self, target, 300);
			var canShootTransition : ReachedTransition = new ReachedTransition(self, target, 70);
			var canNotSeeTransition : InSightTransition = new InSightTransition(self, target, 300);
			var canNotShootTransition : ReachedTransition = new ReachedTransition(self, target, 70);
			
			climbState.transitions = new Array(canSeeTransition);
			canSeeTransition.nextTrueState = descentState;
			descentState.transitions = new Array(canShootTransition, canNotSeeTransition);
			canNotSeeTransition.nextFalseState = climbState;
			canShootTransition.nextTrueState = attackState;
			attackState.transitions = new Array(canNotShootTransition);
			canNotShootTransition.nextFalseState = climbState;
			
			fsm = new FSM.FSM(climbState);
		}
		
		public override function update()
		{
			super.update();
			self.followDirection();
		}
		
	}

}