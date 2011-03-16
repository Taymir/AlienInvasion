package AI.Transition 
{
	import GameObjects.*;
	import Enemies.large_ship;
	/**
	 * ...
	 * @author Taymir
	 * Нарушает принцип LSP
	 */
	public class ReachedAndReadyTransition extends ReachedTransition
	{
		private var ship: large_ship;
		
		public function ReachedAndReadyTransition(self:large_ship, target:GameObject, reachDistance:int = 20) 
		{
			super(self, target, reachDistance);
			ship = self;
		}
		
		protected override function isTriggered() : Boolean
		{
			if (super.isTriggered() && ship.isSecondaryReady())
				return true;
			else
				return false;
		}	
	}

}