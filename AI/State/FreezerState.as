package AI.State
{
	import Enemies.large_ship;
	import FSM.OneTickState;
	import FSM.State;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class FreezerState extends OneTickState
	{
		private var self : large_ship;
		
		public function FreezerState(self : large_ship) 
		{
			this.self = self;
			name = "Заморозка";
		}
		
		protected override function action () : void
		{
			self.fireSecondary();
		}		
	}

}