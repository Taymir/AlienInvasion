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
		private const reachDistance : int = 20;
		
		public function ReachedTransition(self : GameObject, target : GameObject) 
		{
			this.self = self;
			this.target = target;
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