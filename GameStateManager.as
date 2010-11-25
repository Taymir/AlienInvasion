package  
{
	import common.TList.TList;
	import flash.display.MovieClip;
	import common.TRegistry;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class GameStateManager
	{
		private var isPause:Boolean = false;
		private var documentObj: MovieClip;
		
		public function GameStateManager(document: MovieClip)
		{
			this.documentObj = document;
		}
		
		public function startGame() 
		{
			// Положение земли
			TRegistry.instance.setValue("groundPosition", 415);
			
			/* инициализация сцены */
			var scene:MovieClip = new Scene();
			scene.name = 'scene';
			documentObj.addChild(scene);
			documentObj.swapChildren(scene, documentObj.uiPanel);
			
			/* инициализация препятствий */
			var left_rocks = new rocks();
			var right_rocks = new rocks();
			
			left_rocks.y = TRegistry.instance.getValue("groundPosition") + left_rocks.height / 2;
			left_rocks.x = scene.bounds.x + left_rocks.width / 2;
			
			right_rocks.y = TRegistry.instance.getValue("groundPosition") + right_rocks.height / 2;
			right_rocks.x = scene.bounds.width + scene.bounds.x - right_rocks.width / 2;
			
			scene.addChild(left_rocks);
			scene.addChild(right_rocks);
			
			var obstacles:TList = new TList();
			obstacles.Add(left_rocks);
			obstacles.Add(right_rocks);
			TRegistry.instance.setValue("obstacles", obstacles);
			
			TRegistry.instance.setValue("scene", scene);
			
			// Создаём танк
			var player:TList = new TList();
			TRegistry.instance.setValue("player", player);
			var tank: Tank = new Tank();
			player.Add(tank);
			tank.x = TRegistry.instance.getValue("stage").stageWidth / 2;
			//@TMP: Надо поправить координаты муви-клипов
			tank.y = TRegistry.instance.getValue("groundPosition") - 20;
			
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
		
		private function endGame()
		{
			
			// Удаление всех инициализированных
			/* Удаление сцены */
			var scene = documentObj.getChildByName("scene");
			documentObj.removeChild(scene);
			
			/* Очистка массивов */
			TRegistry.instance.getValue("obstacles").Clear();
			TRegistry.instance.getValue("player").Clear();
			TRegistry.instance.getValue("enemies").Clear();
			
			/* Отвязка всех событий */
			TRegistry.instance.getValue("globalEnterFrame");
			
			//@TODO Возможны утечки памяти! (Мог забыть что-то отвязать)
		}
		
		public function restartGame()
		{
			//@TODO: Не работает: Танк не удаляется, Нло не удаляется... Где остаются ссылки на них?
			/*this.endGame();
			this.startGame();*/
		}
	}

}