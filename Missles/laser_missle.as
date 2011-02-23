package Missles
{
	import common.TList.TList;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import common.TRegistry;
	import Missles.BaseMissle;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public final class laser_missle extends BaseMissle
	{
		public function laser_missle(x: Number, y: Number, direction: int)
		{
			super(x, y, direction);
		}
	}

}