package  
{
	import common.TList.TList;
	import Enemies.guard_ship;
	import Enemies.large_ship;
	import Enemies.small_ship;
	import Enemies.transport_ship;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
		
		//@REFACTOR: вынести из главной
		private function rasterize(source: MovieClip): BitmapData
		{
			var buffer: BitmapData = new BitmapData(source.width, source.height, true);
			buffer.draw(source);
			return buffer;
		}
		
		public function startGame() 
		{
			// Положение земли
			TRegistry.instance.setValue("groundPosition", 451);
			
			/* инициализация сцены */
			var scene:MovieClip = new Scene();
			scene.name = 'scene';
			
			var BackBMP: BitmapData = rasterize(new Background());
			
			var left_back = new Bitmap(BackBMP);
			left_back.x = 0 - left_back.width + 30;
			left_back.y = 0;
			var right_back = new Bitmap(BackBMP);
			right_back.x = scene.bounds.width - 34;
			right_back.y = 0;
			var center_back = new Bitmap(BackBMP);
			center_back.x = 0;
			center_back.y = 0;
			scene.addChild(left_back);
			scene.addChild(right_back);
			scene.addChild(center_back);
			documentObj.addChild(scene);
			documentObj.swapChildren(scene, documentObj.uiPanel);
			
			/* инициализация препятствий */
			var left_rocks = new rocks();
			var right_rocks = new rocks();
			
			left_rocks.y = TRegistry.instance.getValue("groundPosition") + 3;
			left_rocks.x = scene.bounds.x + left_rocks.width / 2;
			
			right_rocks.y = TRegistry.instance.getValue("groundPosition") + 3;
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
			tank.y = TRegistry.instance.getValue("groundPosition") - tank.height;
			
			// Создаём НЛОшки
			var enemies:TList = new TList();
			TRegistry.instance.setValue("enemies", enemies);
			
			if(!TRegistry.instance.getValue("debug_no_enemies")) {
				var ufo;
				const maxEnemies: int = 0;//@TMP
				for(var i:int = 0; i < maxEnemies; i++)
				{
					ufo = new small_ship();
					ufo.x = 0 + 100 * i;
					ufo.y = 170;
					enemies.Add(ufo);
				}
				
				/*ufo = new large_ship(); //@TMP
				ufo.x = 800;
				ufo.y = 50;
				*/
				
				/*ufo = new transport_ship();
				ufo.x = 800;
				ufo.y = 50;*/
				
				ufo = new guard_ship();
				ufo.x = 850;
				ufo.y = 100;
				
				enemies.Add(ufo);
				
				ufo = new guard_ship();
				ufo.x = 750;
				ufo.y = 100;
				
				enemies.Add(ufo);
			}
			
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