package AI 
{
	import FSM.Transition;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class ReachedTransition extends Transition
	{
		private var self : GameObject;
		private var target : GameObject;
		public var reachDistance : int;
		
		public function ReachedTransition(self : GameObject, target : GameObject, reachDistance:int = 20) 
		{
			this.self = self;
			this.target = target;
			this.reachDistance = reachDistance;
		}
		
		protected override function isTriggered() : Boolean
		{
			if (Math.abs(self.x - target.x) <= reachDistance)
				return true;
			else
				return false;
		}		
	}

}