package  
{
	import common.TList.TList;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import common.TRegistry;
	import common.Debug;
	import com.senocular.utils.KeyObject;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class Scene extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		
		public function Scene() 
		{
			Debug.assert( TRegistry.instance.getValue("stage") != null, "В реестре TRegistry не установлено значение объекта сцены stage" );
			stageRef = TRegistry.instance.getValue("stage");
			
			addEventListener(Event.ENTER_FRAME, trackTank, false, 0, true);
		}
		
		protected function trackTank(e: Event)
		{
			var player:TList = TRegistry.instance.getValue("player");
			if (player.Count() > 0)
			{
				var tank = player.Get(0) as Tank;
				this.x = -1 * (tank.x - 400);
			}
		}
	}

}