package AI.State
{
	import GameObjects.*;
	import FSM.State;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class AvoidState extends State
	{
		private var self : ControllableObject;
		private var target : GameObject;
		private const reachDistance : int = 100;
		
		public function AvoidState(self : ControllableObject, target : GameObject) 
		{
			this.self = self;
			this.target = target;
			name = "Избежание";
		}
		
		protected override function action () : void
		{
			if (Math.abs(self.x - target.x) <= reachDistance)
			{
				// Танк находится слева
				if (self.x > target.x)
					self.incXShift();
				else
					self.decXShift();
			}
		}
	}

}