package AI.State 
{
	import Enemies.suicide_ship;
	import flash.geom.Point;
	import FSM.State;
	import common.TRegistry;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RamAttackState extends State 
	{
		private var self: suicide_ship;
		private var target: GameObject;
		private var target_point: Point;
		
		public function RamAttackState(self: suicide_ship, target : GameObject) 
		{
			this.self = self;
			this.target = target;
			this.target_point = new Point(0, 0);
			name = "Атака тараном";
		}
		
		protected override function action() : void
		{
			if(self.x > target_point.x)
				self.decXShift();
			else if(self.x < target_point.x)
				self.incXShift();
			
			if (self.y > target_point.y)
				self.decYShift();
			else if(self.y < target_point.y)
				self.incYShift();
		}
		
		public override function onEnterState() : void
		{
			target_point.x = target.x;
			target_point.y = TRegistry.instance.getValue("groundPosition");
			
			super.onEnterState();
		}
	}

}