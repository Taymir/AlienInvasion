package AI.Transition
{
	import Enemies.small_ship;
	import FSM.Transition;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public final class InSightTransition extends Transition
	{
		private var self : small_ship;
		private var target : GameObject;
		public var reachDistance : int;
		
		public function InSightTransition(self: small_ship, target: GameObject, reachDistance:int = 20) 
		{
			this.self = self;
			this.target = target;
			this.reachDistance = reachDistance;
		}
		
		protected override function isTriggered() : Boolean
		{
			if (inMyDirection() && inReachDistance())
				return true;
			else
				return false;
		}
		
		private function inMyDirection() : Boolean
		{
			// Если нло правее танка
			if (self.x >= target.x && self.direction == small_ship.DIRECTION_LEFT)
				return true;
			// Если нло левее танка
			if (self.x <= target.x  && self.direction == small_ship.DIRECTION_RIGHT)
				return true;
				
			return false;
		}
		
		private function inReachDistance() : Boolean
		{
			return Math.abs(self.x - target.x) <= reachDistance;
		}
	}

}