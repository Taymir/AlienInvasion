﻿package {
	import common.TList.TList;
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.filters.DisplacementMapFilterMode;
	import flash.ui.*;
	import common.TRegistry;
	import tests.*;

	public class AlienInvasion extends MovieClip {
		
		public function AlienInvasion() {		
			this.initGame();
			
			//@DEBUG
			/*
			var test: TestTList = new TestTList();
			test.run();
			*/
		}
		
		public function initGame() : void
		{
			TRegistry.instance.setValue("stage", stage);
			TRegistry.instance.setValue("userHp", uiPanel.userHp);
			TRegistry.instance.setValue("scene", scene);
			TRegistry.instance.setValue("groundPosition", 410);
			
			TRegistry.instance.setValue("debug_cannon_test", false);
			TRegistry.instance.setValue("debug_ufo_test", false);
			
			TRegistry.instance.setValue("config_play_sounds", true);
			TRegistry.instance.setValue("config_play_music", true);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, Pause);			
			var globalEnterFrame:GlobalEnterFrame = new GlobalEnterFrame();
			TRegistry.instance.setValue("globalEnterFrame", globalEnterFrame);			
			
			var gameStateManager:GameStateManager = new GameStateManager();
			TRegistry.instance.setValue("gameStateManager", gameStateManager);
			gameStateManager.startGame();			
						
			// Testing message box
			var gd:GameDialog = new GameDialog();
			TRegistry.instance.setValue("gameDialog", gd);			
			//gd.MessageBox("<p align=\"center\"><b><font size=\"20\" color=\"#ffffff\">Самый охуенный Месаджбокс!!!</font></b><p>", 0xFF0000, 0.5, 20, 350, 1);
			
			// Настройка музыки
			var music : MusicManager = new MusicManager();
			TRegistry.instance.setValue("music_manager", music);
			music.loadTrack("track1", "music/track1.mp3", true);
			music.loadTrack("track2", "music/track2.mp3");
			music.loadTrack("track3", "music/track3.mp3");
			music.loadTrack("track4", "music/track4.mp3");
			music.loadTrack("track5", "music/track5.mp3");
			music.loadTrack("track_lobby", "music/track_lobby.mp3");
			
			// Настройка звуков
			var sounds: SoundManager = new SoundManager();
			TRegistry.instance.setValue("sound_manager", sounds);
			sounds.addSound("shoot", new shootSnd);
			sounds.addSound("hit", new hitSnd);
		}
		
		private function Pause(e:KeyboardEvent)
		{
			if (e.keyCode == 80)
				TRegistry.instance.getValue("gameStateManager").pauseGame();
		}
	}
}