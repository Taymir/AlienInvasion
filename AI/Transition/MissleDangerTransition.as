package AI.Transition 
{
	import GameObjects.*;
	import flash.geom.Point;
	import FSM.Transition;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class MissleDangerTransition extends Transition
	{
		private static var lastMisslePositionX: Number = NaN;
		
		public static function reportMissleLunch(x: Number, y: Number)
		{
			lastMisslePositionX = x;
		}
		
		private var self:GameObject;
		
		public function MissleDangerTransition(self: GameObject) 
		{
			this.self = self;
		}
		
		protected override function isTriggered() : Boolean
		{
			if (isNaN(lastMisslePositionX)) return false;
			
			if (Math.abs(self.x - lastMisslePositionX) <= self.width / 2)
			{
				lastMisslePositionX = NaN;
				return true;
			}
				
			return false;
		}	
		
	}

}