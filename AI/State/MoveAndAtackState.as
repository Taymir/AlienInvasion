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
		private var target: GameObject;
		
		public function MoveAndAtackState(self : transport_ship, target : GameObject) 
		{
			this.self = self;
			this.target = target;
			super(self);
			name = "Движение и атака";
		}
		
		override public function onEnterState():void 
		{
			this.self.direction = (target.x >= self.x? transport_ship.DIRECTION_RIGHT : transport_ship.DIRECTION_LEFT);
			
			super.onEnterState();
		}
		
		protected override function action () : void
		{
			super.action();
			self.followDirection();
		}		
		
	}

}