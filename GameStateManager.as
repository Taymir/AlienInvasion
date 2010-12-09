package  
{
	import common.TList.TList;
	import Enemies.large_ship;
	import Enemies.small_ship;
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
			/*if (TRegistry.instance.getValue("debug_ufo_test"))
				ufo = new TesterUFO();
			else
				ufo = new UFO();
			
			enemies.Add(ufo);
			ufo.x = 100;
			ufo.y = 100;*/

            
            /*var maxEnemies: int = 5;
            for(var i:int = 0; i < maxEnemies; i++)
            {
                ufo = new small_ship();
                ufo.x = 0 + 100 * i;
                ufo.y = 150;
                enemies.Add(ufo);
            }*/
			
			ufo = new large_ship();
			ufo.x = 800;
			ufo.y = 50;
			enemies.Add(ufo);

			
			
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
		
		public function checkEndGame()
		{
			if (TRegistry.instance.getValue("player").Count() == 0)
			{
				// Игрок погиб, конец игры
				// Показываем месадж бокс и ставим на паузу
				TRegistry.instance.getValue("gameDialog").MessageBox("<p align=\"center\"><b><font size=\"14\" color=\"#ffffff\">Конец игры, смерть всем человекам!</font></b><p>", 0xFF0000, 0.5, 20, 350, GameDialog.CLOSE_DIALOG);
				this.pauseGame();
			} else if (TRegistry.instance.getValue("enemies").Count() == 0) {
				// Враги Повержены, конец игры
				// Показываем месадж бокс и ставим на паузу
				TRegistry.instance.getValue("gameDialog").MessageBox("<p align=\"center\"><b><font size=\"14\" color=\"#ffffff\">Инопланетные захватчики повержены! УРА! УРА! УРА!</font></b><p>", 0xFF0000, 0.5, 20, 350, GameDialog.CLOSE_DIALOG);
				this.pauseGame();
			}
		}
	}

}