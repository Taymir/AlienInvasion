package {
	import common.TList.TList;
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.filters.DisplacementMapFilterMode;
	import flash.ui.*;
	import common.TRegistry;
	import tests.*

	public class AlienInvasion extends MovieClip {
		
		public function AlienInvasion() {		
			this.initGame();
			
			//this.runTests(); //@DEBUG
		}
		
		public function runTests() : void
		{
			var test: TestTList = new TestTList();
			test.run();
		}
		
		public function initGame() : void
		{
			// Настройки
			TRegistry.instance.setValue("config_play_sounds", false);
			TRegistry.instance.setValue("config_play_music", false);
			TRegistry.instance.setValue("debug_no_enemies", false);
			TRegistry.instance.setValue("debug_god_mode", true);
			TRegistry.instance.setValue("debug_show_fps", true);
			
			// Инициализация globalEnterFrame
			var globalEnterFrame:GlobalEnterFrame = new GlobalEnterFrame();
			TRegistry.instance.setValue("globalEnterFrame", globalEnterFrame);	
			TRegistry.instance.setValue("stage", stage);
			
			// Инициализаци UI
			var userInterfaceManager: UserInterfaceManager = new UserInterfaceManager(uiPanel);
			TRegistry.instance.setValue("UI", userInterfaceManager);
			
			// Инициализация музыки
			var music : MusicManager = new MusicManager();
			TRegistry.instance.setValue("music_manager", music);
			music.loadTrack("track1", "music/track1.mp3", true);
			music.loadTrack("track2", "music/track2.mp3");
			music.loadTrack("track3", "music/track3.mp3");
			music.loadTrack("track4", "music/track4.mp3");
			music.loadTrack("track5", "music/track5.mp3");
			music.loadTrack("track_lobby", "music/track_lobby.mp3");
			
			// Инициализация звуков
			var sounds: SoundManager = new SoundManager();
			TRegistry.instance.setValue("sound_manager", sounds);
			sounds.addSound("shoot", new shootSnd);
			sounds.addSound("hit", new hitSnd);
			
			// Инициализация GameStateManager		
			var gameStateManager:GameStateManager = new GameStateManager(this);
			TRegistry.instance.setValue("gameStateManager", gameStateManager);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
			gameStateManager.startGame();
		}
		
		private function keyHandler(e:KeyboardEvent)
		{
			if (e.keyCode == 80) // P
				TRegistry.instance.getValue("gameStateManager").pauseGame();
			else if (e.keyCode == 82) // R
				TRegistry.instance.getValue("gameStateManager").restartGame();
		}
	}
}