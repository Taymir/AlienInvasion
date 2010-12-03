package AI 
{
	import common.TRegistry;
	import Enemies.small_ship;
	import FSM.FSM;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class small_shipAI
	{
		
		private var fsm : FSM.FSM;
		
		public function small_shipAI(self : small_ship, target : GameObject) 
		{
			// init small ship
			//@TODO: randomize direction
			self.direction = small_ship.DIRECTION_RIGHT;
			self.y = 150;//@TMP
			
			// init AI
			var atackState: AttackState = new AttackState(self);
			var descentState: ChangeHeightState = new ChangeHeightState(self, ChangeHeightState.DIRECTION_DOWN, 270); descentState.name = "Снижение";//@TMP Жестко забитые значения...
			var climbState: ChangeHeightState = new ChangeHeightState(self, ChangeHeightState.DIRECTION_UP, 150); climbState.name = "Повышение";//@TMP Жестко забитые значения...
			
			var canSeeTransition : InSightTransition = new InSightTransition(self, target, 300);
			var canShootTransition : ReachedTransition = new ReachedTransition(self, target, 70);
			var canNotSeeTransition : InSightTransition = new InSightTransition(self, target, 300);
			var canNotShootTransition : ReachedTransition = new ReachedTransition(self, target, 70);
			
			
			climbState.transitions = new Array(canSeeTransition);
			canSeeTransition.nextTrueState = descentState;
			descentState.transitions = new Array(canShootTransition, canNotSeeTransition);
			canNotSeeTransition.nextFalseState = climbState;
			canShootTransition.nextTrueState = atackState;
			atackState.transitions = new Array(canNotShootTransition);
			canNotShootTransition.nextFalseState = climbState;
			
			FSM.FSM.debug_mode = false;
			fsm = new FSM.FSM(climbState);
		}
		
		public function update() : void
		{
			fsm.update();
		}
		
	}

}