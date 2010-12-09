package AI.State
{
	import FSM.State;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class PursueState extends State
	{
		protected var self : ControllableObject;
		protected var target : GameObject;
		
		public function PursueState(self : ControllableObject, target : GameObject) 
		{
			this.self = self;
			this.target = target;
			name = "Преследование";
		}
		
		protected override function action () : void
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