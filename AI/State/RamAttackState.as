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
		
		public function RamAttackState(self: suicide_ship, target : GameObject) 
		{
			this.self = self;
			this.target = target;
			name = "Атака тараном";
		}
		
		protected override function action() : void
		{
			if(self.x > target.x)
				self.decXShift();
			else if(self.x < target.x)
				self.incXShift();
			
			if (self.y > target.y)
				self.decYShift();
			else if(self.y < target.y)
				self.incYShift();
				
			TRegistry.instance.getValue("player").Walk(self.collision_detection_callback);
		}
	}

}