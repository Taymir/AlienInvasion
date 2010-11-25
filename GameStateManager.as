package  
{
	import common.TList.TList;
	import common.TRegistry;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class GameStateManager
	{
		private var isPause:Boolean = false;
		
		public function GameStateManager() 
		{
			
		}
		
		public function startGame() 
		{
			// Создаём танк
			var player:TList = new TList();
			TRegistry.instance.setValue("player", player);
			var tank: Tank = new Tank();
			player.Add(tank);
			tank.x = TRegistry.instance.getValue("stage").stageWidth / 2;
			tank.y = TRegistry.instance.getValue("groundPosition") - 20; //@TMP: Надо поправить координаты муви-клипов
			
			// Создаём НЛОшки
			var enemies:TList = new TList();
			TRegistry.instance.setValue("enemies", enemies);
			
			var ufo;
			if (TRegistry.instance.getValue("debug_ufo_test"))
				ufo = new TesterUFO();
			else
				ufo = new UFO();
			
			enemies.Add(ufo);
			ufo.x = 100;
			ufo.y = 100;
			
			TRegistry.instance.getValue("stage").addEventListener(Event.ENTER_FRAME, TRegistry.instance.getValue("globalEnterFrame").Update);
		}
		
		public function pauseGame()
		{
			if (isPause == true)
			{
				TRegistry.instance.getValue("stage").addEventListener(Event.ENTER_FRAME, TRegistry.instance.getValue("globalEnterFrame").Update);
				isPause = false;
			}
			else
			{
				TRegistry.instance.getValue("stage").removeEventListener(Event.ENTER_FRAME, TRegistry.instance.getValue("globalEnterFrame").Update);
				isPause = true;		
			}
		}
	}

}