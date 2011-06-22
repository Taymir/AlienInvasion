package {
	import com.flashdynamix.utils.SWFProfiler;
	import common.TList.TList;
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.filters.DisplacementMapFilterMode;
	import flash.system.System;
	import flash.ui.*;
	import common.TRegistry;
	import tests.*
	import UI.UserInterfaceManager;

	public class AlienInvasion extends MovieClip {
		
		public function AlienInvasion() {		
			this.initGame();
			
			//this.runTests(); //@DEBUG
		}
		
		public function runTests() : void
		{
			//var test: TestTList = new TestTList();
			//var test: testListArrayVector = new testListArrayVector();
			//var test: testTTimer = new testTTimer(this);
			var test: testColorTransform = new testColorTransform(this);
			
			test.run();
		}
		
		public function initGame() : void
		{
			// Настройки
			TRegistry.instance.setValue("config_play_sounds", true);
			TRegistry.instance.setValue("config_play_music", true);
			TRegistry.instance.setValue("debug_no_enemies", false);
			TRegistry.instance.setValue("debug_god_mode", false);
			TRegistry.instance.setValue("debug_show_fps", true);
			TRegistry.instance.setValue("debug_profiler", true);
			TRegistry.instance.setValue("debug_no_menu", false);
			
			// Инициализация сцены
			TRegistry.instance.setValue("stage", stage);
			
			if(TRegistry.instance.getValue("debug_profiler"))
				SWFProfiler.init(TRegistry.instance.getValue("stage"), this);
			
			// Инициализация GameStateManager		
			var gameStateManager:GameStateManager = new GameStateManager(this);
			TRegistry.instance.setValue("gameStateManager", gameStateManager);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
			
			if (TRegistry.instance.getValue("debug_no_menu"))
				gameStateManager.startGame();
			else
				gameStateManager.startMenu();
		}
		
		private function keyHandler(e:KeyboardEvent)
		{
			switch(e.keyCode)
			{
				/// GAME STATE MANAGER
				case 27: //ESC
					TRegistry.instance.getValue("gameStateManager").showMenu();
					break;
				//case 80: //P
				//	TRegistry.instance.getValue("gameStateManager").pauseGame();
				//	break;
				//case 82: //R
				//	TRegistry.instance.getValue("gameStateManager").restartGame();
				//	break;
				
				/// SOUND & MUSIC MANAGERS
				//case 77: //M
				//	TRegistry.instance.getValue("music_manager").mute();
				//	break;
				//case 83: //S
				//	TRegistry.instance.getValue("sound_manager").mute();
				//	break;
				
				/// USER INTERFACE MANAGER
				//case 48: //0
				case 49://1
				case 50://2
				case 51://3
				case 52://4
				case 53://5
				case 54://6
				case 55://7
				case 56://8
				case 57://9
					TRegistry.instance.getValue("UI").keyHandler(e.keyCode, e.shiftKey);
					break;
			}
		}
	}
}