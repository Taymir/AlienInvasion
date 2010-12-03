package AI 
{
	import FSM.State;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class PursueState extends State
	{
		private var self : ControllableObject;
		private var target : GameObject;
		private const reachDistance : int = 20;
		
		public function PursueState(self : ControllableObject, target : GameObject) 
		{
			this.self = self;
			this.target = target;
			name = "Преследование";
		}
		
		protected override function action () : void
		{
			if (Math.abs(self.x - target.x) > reachDistance)
			{
				// Танк находится справа
				if (self.x < target.x)
				{
					self.incXShift();
				} else {
					self.decXShift();
				}
			}
		}
	}

}