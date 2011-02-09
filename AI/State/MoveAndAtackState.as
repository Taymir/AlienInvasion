package AI.State 
{
	import Enemies.transport_ship;
	import FSM.State;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class MoveAndAtackState extends AttackState 
	{
		private var self:  transport_ship;
		
		public function MoveAndAtackState(self : transport_ship) 
		{
			this.self = self;
			super(self);
			name = "Движение и атака";
		}
		
		protected override function action () : void
		{
			super.action();
			self.followDirection();
		}		
		
	}

}