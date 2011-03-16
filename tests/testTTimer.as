package tests 
{
	import com.flashdynamix.utils.SWFProfiler;
	import common.TRegistry;
	import common.TTimer;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import common.TTimerEvent;
	import UI.UserInterfaceManager;
	/**
	 * ...
	 * @author Taymir
	 */
	public class testTTimer 
	{
		
		public function testTTimer(ai: AlienInvasion) 
		{
			var globalEnterFrame:GlobalEnterFrame = new GlobalEnterFrame();
			TRegistry.instance.setValue("globalEnterFrame", globalEnterFrame);	
			TRegistry.instance.setValue("stage", ai.stage);
			TRegistry.instance.getValue("stage").addEventListener(Event.ENTER_FRAME, TRegistry.instance.getValue("globalEnterFrame").Update);
			
			TRegistry.instance.setValue("debug_show_fps", true);
			TRegistry.instance.setValue("debug_profiler", true);
			
			var userInterfaceManager: UserInterfaceManager = new UserInterfaceManager(ai.uiPanel);
			TRegistry.instance.setValue("UI", userInterfaceManager);
			if(TRegistry.instance.getValue("debug_profiler"))
				SWFProfiler.init(TRegistry.instance.getValue("stage"), ai);
		}
		
		private function test1()
		{
			// Проверяем работу таймера
			trace("TEST 1 - initiated.");
			var timer: TTimer = new TTimer(1000);
			timer.addEventListener(TTimerEvent.TIMER_COMPLETE, test_complete);
			timer.addEventListener(TTimerEvent.TIMER_PROGRESS, test_progress);
			timer.start();
		}
		
		private function test_complete(e: TTimerEvent)
		{
			trace("COMPLETE", e.progress);
		}
		
		private function test_progress(e: TTimerEvent)
		{
			trace("PROGRESS", e.progress);
		}
		
		private function test2()
		{
			count_timers = 0;
			max_timers = 20 * 1000;
			
			// Проверяем работу большого количества таймеров одновременно
			for (var i = 0; i < max_timers; i++)
			{
				var timer: TTimer = new TTimer(60*1000);
				timer.addEventListener(TTimerEvent.TIMER_COMPLETE, test2_complete);
				//timer.addEventListener(TTimerEvent.TIMER_PROGRESS, test_progress);
				timer.start();
			}
		}
		
		private var count_timers: int;
		private var max_timers: int;
		
		private function test2_complete(e: TTimerEvent)
		{
			count_timers++;
			
			if(count_timers == max_timers)
				trace("Все таймеры завершили работу");
		}
		
		public function run() : void
		{
			test1();
			test2();
		}
		
	}

}