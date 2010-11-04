package {
	import common.TList.TList;
	import flash.display.MovieClip;
	import flash.events.*; 
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
			TRegistry.instance.setValue("groundPosition", 500);
			
			TRegistry.instance.setValue("debug_cannon_test", false);
			TRegistry.instance.setValue("debug_ufo_test", false);
			
			// Sounds 
			TRegistry.instance.setValue("config_play_sounds", true);
			TRegistry.instance.setValue("config_play_music", true);
			
			TRegistry.instance.setValue("shootSnd", new shootSnd());
			TRegistry.instance.setValue("hitSnd", new hitSnd());
			
			var player:TList = new TList();
			TRegistry.instance.setValue("player", player);
			var tank: Tank = new Tank();
			player.Add(tank);
			tank.x = stage.stageWidth / 2;
			tank.y = TRegistry.instance.getValue("groundPosition") - 100;
			
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
			/*ufo = new UFO()
			enemies.push(ufo);
			ufo.x = 200;
			ufo.y = 200;
			ufo = new UFO()
			enemies.push(ufo);
			ufo.x = 300;
			ufo.y = 300;*/
			
			// Настройка музыки
			var music : MusicManager = new MusicManager();
			TRegistry.instance.setValue("music_manager", music);
			music.addTrack("track1", new track1);
			music.addTrack("track2", new track2);
			music.addTrack("track3", new track3);
			music.addTrack("track4", new track4);
			music.addTrack("track5", new track5);
			
			music.addTrack("track_lobby", new track_lobby);
			
			music.play("track1");
			
			// Настройка звуков
			//@TODO
		}
	}
}