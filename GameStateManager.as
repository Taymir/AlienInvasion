package  
{
	import AI.suicide_shipAI;
	import common.Debug;
	import common.TList.TList;
	import Enemies.guard_ship;
	import Enemies.large_ship;
	import Enemies.scout_ship;
	import Enemies.small_ship;
	import Enemies.suicide_ship;
	import Enemies.transport_ship;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import common.TRegistry;
	import flash.display.Stage;
	import flash.events.Event;
	import GameObjects.*;
	import Levels.Level;
	import UI.*;
	import UI.Menu.Menu;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class GameStateManager
	{
		private var isPause:Boolean = false;
		private var documentObj: MovieClip;
		private var menu:Menu;
		private var level: Level;
		
		public function GameStateManager(document: MovieClip)
		{
			this.documentObj = document;
		}
		
		public function startGame() 
		{
			this.initCore();
			this.initAllLists();
			
			level = new Level();
			level.loadContent();
			level.initialize(documentObj);
			
			this.startGameLoop();
		}
		
		public function startMenu()
		{
			this.initMusic();
			this.initSounds();
			menu = new Menu(documentObj);
			menu.show();
			menu.playMenuMusic();
		}
		
		public function showMenu()
		{
			if (!TRegistry.instance.getValue("scene"))
				return;//@HACK чтобы ескейп не работал в меню
			if (isPause)
				return hideMenu();//@HACK: повторный ескейп прячет меню, реализовано криво пока
			TRegistry.instance.getValue("UI").visible = false;
			TRegistry.instance.getValue("scene").visible = false;
			
			pauseGame();
			menu.show("pause");
		}
		
		public function hideMenu()
		{
			TRegistry.instance.getValue("UI").visible = true;
			TRegistry.instance.getValue("scene").visible = true;
			
			pauseGame();
			menu.hide();
		}
		
		private function initCore()
		{
			// Инициализация globalEnterFrame
			var globalEnterFrame:GlobalEnterFrame = new GlobalEnterFrame();
			TRegistry.instance.setValue("globalEnterFrame", globalEnterFrame);
			
			// Инициализаци UI
			var userInterfaceManager: UserInterfaceManager = new UserInterfaceManager(documentObj);
			TRegistry.instance.setValue("UI", userInterfaceManager);
		}
		
		private function initMusic()
		{
			var music : MusicManager = new MusicManager();
			TRegistry.instance.setValue("music_manager", music);
		}
		
		private function initSounds()
		{
			var sounds: SoundManager = new SoundManager();
			TRegistry.instance.setValue("sound_manager", sounds);
		}
		
		private function initAllLists()
		{
			initList("player");
			initList("enemies");
			initList("obstacles");
			initList("tmp_obstacles");
		}
		
		private function initList(listname: String)
		{
			// Создать список
			var list: TList = new TList();
			TRegistry.instance.setValue(listname, list);
		}
		
		private function startGameLoop()
		{
			level.start();
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
			level.unloadContent();
			// Удаление всех инициализированных объектов
			/* Очистка массивов */
			clearList("player");
			clearList("enemies");
			clearList("obstacles");
			clearList("tmp_obstacles");
			
			/* Очищаем интерфейс */
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).dispose();
			
			/* Отвязка всех событий */
			(TRegistry.instance.getValue("stage") as Stage).removeEventListener(Event.ENTER_FRAME, TRegistry.instance.getValue("globalEnterFrame").Update);
			(TRegistry.instance.getValue("globalEnterFrame") as GlobalEnterFrame).RemoveAll();
		}
		
		private function clearList(listname:String)
		{
			var list: TList = (TRegistry.instance.getValue(listname) as TList);
			list.Walk(destroyer_callback);
			
			Debug.assert(list.Count() == 0, "Список не очищен полностью");
		}
		
		private function destroyer_callback(obj: Object)
		{
			Debug.assert(obj is GameObject, "В один из списков попал Movieclip - не GameObject");
			
			(obj as GameObject).dispose();
		}
		
		public function restartGame()
		{
			this.endGame();
			this.startGame();
		}
		
		public function checkEndGame()
		{
			if (TRegistry.instance.getValue("player").Count() == 0)
			{
				// Игрок погиб, конец игры
				// Показываем месадж бокс и ставим на паузу
				showEndGameDialog("Конец игры, смерть всем человекам!");
				
				this.pauseGame();
			} else if (TRegistry.instance.getValue("enemies").Count() == 0) {
				// Враги Повержены, конец игры
				// Показываем месадж бокс и ставим на паузу
				showEndGameDialog("Инопланетные захватчики повержены! УРА! УРА! УРА!");
				
				this.pauseGame();
			}
		}
		
		private function showEndGameDialog(message: String) : void
		{
			var dialog: GameDialog = new GameDialog();
			dialog.MessageBox("<p align=\"center\"><b><font size=\"14\" color=\"#ffffff\">" + message + "</font></b><p>", 0xFF0000, 0.5, 20, 350, GameDialog.CLOSE_DIALOG);
		}
	}

}