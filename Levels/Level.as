package Levels 
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
	import UI.*;
	import UI.Menu.Menu;
	/**
	 * ...
	 * @author Taymir
	 */
	public class Level 
	{
		private var BackBMP: BitmapData;// Изображение фона
		private var player: Tank;
		
		public function Level() 
		{
			
		}
		
		public function loadContent()
		{
			// load music used on level
			var music: MusicManager = TRegistry.instance.getValue("music_manager");
			music.loadTrack("track1");
			
			// load sounds used on level
			var sounds: SoundManager = TRegistry.instance.getValue("sound_manager");
			sounds.addSound("shoot", new shootSnd);
			sounds.addSound("hit", new hitSnd);
			
			// load back image
			BackBMP = rasterize(new Background());
		}
		
		public function unloadContent()
		{
			BackBMP.dispose();
			BackBMP = null;
			
			//SOUNDS SHOULD BE REMOVED
			//MUSIC SHOULD BE REMOVED
			
			//  Удаление сцены
			var scene : MovieClip = TRegistry.instance.getValue("scene");
			scene.parent.removeChild(scene);
		}
		
		public function initialize(documentObj: MovieClip)
		{
			this.initLevel(documentObj);
			player = this.initPlayer();
			this.initEnemies();
			this.initUI(player);
		}
		
		public function start()
		{
			(TRegistry.instance.getValue("music_manager") as MusicManager).play("track1");
			this.player.activateBaseWeapon();
		}
		
		private function rasterize(source: MovieClip): BitmapData
		{
			var buffer: BitmapData = new BitmapData(source.width, source.height, true);
			buffer.draw(source);
			return buffer;
		}
		
		private function initLevel(documentObj: MovieClip)
		{
			// Положение земли
			TRegistry.instance.setValue("groundPosition", 451);
			
			/* инициализация сцены */
			var scene:MovieClip = new Scene();
			scene.name = 'scene';
			
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
			documentObj.swapChildren(scene, documentObj.getChildByName("uiPanel"));
			
			TRegistry.instance.setValue("scene", scene);
			
			/* инициализация препятствий */
			var left_rocks = new CommonGameObject(new rocks(), "obstacles");
			var right_rocks = new CommonGameObject(new rocks(), "obstacles");
			
			left_rocks.y = TRegistry.instance.getValue("groundPosition") + 3;
			left_rocks.x = scene.bounds.x + left_rocks.width / 2;
			
			right_rocks.y = TRegistry.instance.getValue("groundPosition") + 3;
			right_rocks.x = scene.bounds.width + scene.bounds.x - right_rocks.width / 2;
		}
		
		private function initEnemies()
		{
			// Создаём НЛОшки
			if(!TRegistry.instance.getValue("debug_no_enemies")) {
				var ufo;
				const maxEnemies: int = 5;
				for(var i:int = 0; i < maxEnemies; i++)
				{
					ufo = new small_ship();
					ufo.x = 0 + 100 * i;
					ufo.y = 170;
				}
				
				ufo = new large_ship();
				ufo.x = 800;
				ufo.y = 150;
				
				var scout: scout_ship = new scout_ship();
				scout.x = 600;
				scout.y = 250;		
				
				var suicide: suicide_ship = new suicide_ship();
				suicide.x = -600;
				suicide.y = -250;
				
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
		
		private function initPlayer() : Tank
		{
			// Создаём танк
			var tank: Tank = new Tank();
			tank.x = TRegistry.instance.getValue("stage").stageWidth / 2;
			tank.y = TRegistry.instance.getValue("groundPosition") - tank.height;
			
			return tank;
		}
		
		private function initUI(player: Tank)
		{
			// Добавление UI-ярлыков
			var ui:UserInterfaceManager = TRegistry.instance.getValue("UI");
			
			ui.addIcon(new WeaponIcon("base_weapon", 0, player.activateBaseWeapon));
			ui.addIcon(new WeaponIcon("laser", 1, player.activateLaser));
			ui.addIcon(new WeaponIcon("self_guided_missles", 2, player.activateRocketWeapon));
			ui.addIcon(new WeaponIcon("bombs", 3, player.activateParalyzeBombs));
			ui.addIcon(new WeaponIcon("reflector", 4, player.activateReflector));
			
			ui.addIcon(new ProtectionIcon("metal_shield", 0, player.activateMetalShield));
			ui.addIcon(new ProtectionIcon("energy_umbrella", 1, player.activateEnergyUmbrella));
			ui.addIcon(new ProtectionIcon("fire_accelerator", 2, player.activateFireAccelerator));
			ui.addIcon(new ProtectionIcon("speed_accelerator", 3, player.activateSpeedAccelerator));
			//ui.addIcon(new ProtectionIcon("invisability", 4, null)); // Не будет доступно
			
		}
	}

}