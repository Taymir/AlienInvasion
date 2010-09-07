package AI 
{
	import FSM.Transition;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class TimeoutTransition extends Transition
	{
		private var minTimeDelay : int;
		private var maxTimeDelay : int;
		private var endTime: Date;
		
		public function TimeoutTransition(minTimeDelay : int, maxTimeDelay : int) : void
		{
			this.minTimeDelay = minTimeDelay;
			this.maxTimeDelay = maxTimeDelay;
		}
		
		public override function initialize():void
		{
			var timeDelay : int;
			timeDelay = Math.floor((maxTimeDelay - minTimeDelay) * Math.random() + minTimeDelay);
			endTime = new Date();
			endTime.milliseconds += timeDelay;
		}
		
		protected override function isTriggered() : Boolean
		{
			if (new Date() >= endTime)
				return true;
			else
				return false;
		}
	}

}