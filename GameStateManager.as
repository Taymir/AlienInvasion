package  
{
	import common.Debug;
	import common.TList.TList;
	import Enemies.guard_ship;
	import Enemies.large_ship;
	import Enemies.small_ship;
	import Enemies.transport_ship;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import common.TRegistry;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class GameStateManager
	{
		private var isPause:Boolean = false;
		private var documentObj: MovieClip;
		private var BackBMP: BitmapData;// Изображение фона //@REFACTOR впоследствии уйдет на нижний уровень абстракции, что-то типа LevelLoader
		
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
			this.initAllLists();
			this.initLevel();
			var player = this.initPlayer();
			this.initEnemies();
			this.initUI(player);
			(TRegistry.instance.getValue("music_manager") as MusicManager).play("track1");
			
			this.startGameLoop();
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
		
		private function initLevel()
		{
			// Положение земли
			TRegistry.instance.setValue("groundPosition", 451);
			
			/* инициализация сцены */
			var scene:MovieClip = new Scene();
			scene.name = 'scene';
			
			BackBMP = rasterize(new Background());
			
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
			
			TRegistry.instance.setValue("scene", scene);
			
			/* инициализация препятствий */
			var left_rocks = new CommonGameObject(new rocks(), "obstacles");
			var right_rocks = new CommonGameObject(new rocks(), "obstacles");
			
			left_rocks.y = TRegistry.instance.getValue("groundPosition") + 3;
			left_rocks.x = scene.bounds.x + left_rocks.width / 2;
			
			right_rocks.y = TRegistry.instance.getValue("groundPosition") + 3;
			right_rocks.x = scene.bounds.width + scene.bounds.x - right_rocks.width / 2;
		}
		
		private function initPlayer() : Tank
		{
			// Создаём танк
			var tank: Tank = new Tank();
			tank.x = TRegistry.instance.getValue("stage").stageWidth / 2;
			tank.y = TRegistry.instance.getValue("groundPosition") - tank.height;
			
			return tank;
		}
		
		private function initEnemies()
		{
			// Создаём НЛОшки
			
			if(!TRegistry.instance.getValue("debug_no_enemies")) {
				var ufo;
				const maxEnemies: int = 5;//@TMP
				for(var i:int = 0; i < maxEnemies; i++)
				{
					ufo = new small_ship();
					ufo.x = 0 + 100 * i;
					ufo.y = 170;
				}
				
				ufo = new large_ship();//@TMP
				ufo.x = 800;
				ufo.y = 150;
				
				
				var transp: transport_ship = new transport_ship();
				transp.x = 800;
				transp.y = 50;
				
				var guard1 = new guard_ship(transp, guard_ship.RIGHT_POSITION);
				guard1.x = 850;
				guard1.y = 100;
				
				var guard2 = new guard_ship(transp, guard_ship.LEFT_POSITION);
				guard2.x = 750;
				guard2.y = 100;
				
				transp.attach_guards(guard1, guard2);
			}
		}
		
		private function initUI(player: Tank)
		{
			// Добавление UI-ярлыков
			var UI:UserInterfaceManager = TRegistry.instance.getValue("UI");
			UI.addWeaponIcon(new base_weapon_icon(), 0, player.activateBaseWeapon);
			UI.addWeaponIcon(new laser_icon(), 1, player.activateLaser);
			UI.addWeaponIcon(new self_guided_missles_icon(), 2, null);
			UI.addWeaponIcon(new bombs_icon(), 3, null);
			UI.addWeaponIcon(new reflector_icon(), 4, player.activateReflector);
			
			UI.addProtectionIcon(new metal_shield_icon(), 0, null);
			UI.addProtectionIcon(new energy_shield_icon(), 1, null);
			UI.addProtectionIcon(new fire_accelerator_icon(), 2, player.activateFireAccelerator);
			UI.addProtectionIcon(new speed_accelerator_icon(), 3, player.activateSpeedAccelerator);
			UI.addProtectionIcon(new invisability_icon(), 4, null);
		}
		
		private function startGameLoop()
		{
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
		
		private function endGame()
		{
			BackBMP.dispose();
			BackBMP = null;
			// Удаление всех инициализированных объектов
			/* Очистка массивов */
			clearList("player");
			clearList("enemies");
			clearList("obstacles");
			clearList("tmp_obstacles");
			
			/* Очищаем интерфейс */
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).clearIcons();
			
			/* Отвязка всех событий */
			(TRegistry.instance.getValue("stage") as Stage).removeEventListener(Event.ENTER_FRAME, TRegistry.instance.getValue("globalEnterFrame").Update);
			(TRegistry.instance.getValue("globalEnterFrame") as GlobalEnterFrame).RemoveAll();
			
			/* Удаление сцены */
			var scene = documentObj.getChildByName("scene");
			documentObj.removeChild(scene);
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