package AI 
{
	import common.TRegistry;
	import Enemies.scout_ship;
	import GameObjects.*;
	import FSM.FSM;
	import AI.State.*;
	import AI.Transition.*;
	/**
	 * ...
	 * @author Akkarin
	 */
	public class scout_shipAI extends BaseAI
	{
		private var self: scout_ship;
		
		public function scout_shipAI(self : scout_ship, target : GameObject) 
		{
			// init scout ship
			this.self = self;
			self.direction = scout_ship.DIRECTION_RIGHT;
			self.y = 150;//@TMP
			
			// init AI
			//@TODO добавить следующую логику - если корабль заметил танк и поистечении некоторого времени, если не был уничтожен, то должен вызвать военный корабль и улететь.
			var descentState: ChangeHeightState = new ChangeHeightState(self, ChangeHeightState.DIRECTION_DOWN, 300); descentState.name = "Снижение";//@TMP Жестко забитые значения...
			var climbState: ChangeHeightState = new ChangeHeightState(self, ChangeHeightState.DIRECTION_UP, 170); climbState.name = "Повышение";//@TMP Жестко забитые значения...
			
			var canSeeTransition : ReachedTransition = new ReachedTransition(self, target, 300);
			var canNotSeeTransition : ReachedTransition = new ReachedTransition(self, target, 300);
			
			climbState.transitions = new Array(canSeeTransition);
			canSeeTransition.nextTrueState = descentState;
			descentState.transitions = new Array(canNotSeeTransition);
			canNotSeeTransition.nextFalseState = climbState;
			
			fsm = new FSM.FSM(climbState);
		}
		
		public override function update()
		{
			super.update();
			self.followDirection();
		}
		
	}

}