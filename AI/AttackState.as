package AI 
{
	import FSM.State;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class AttackState extends State
	{
		private var self : ControllableObject;
		
		public function AttackState(self : ControllableObject) 
		{
			this.self = self;
			name = "Атака";
		}
		
		protected override function action () : void
		{
			self.fire();
		}		
	}

}