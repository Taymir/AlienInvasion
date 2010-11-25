package {
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
			TRegistry.instance.setValue("groundPosition", 415);
			
			/* инициализация сцены */
			var scene:MovieClip = new Scene();
			this.addChild(scene);
			this.swapChildren(scene, uiPanel);
			
			/* инициализация препятствий */
			var left_rocks = new rocks();
			var right_rocks = new rocks();
			
			scene.addChild(left_rocks);
			scene.addChild(right_rocks);
			
			left_rocks.y = TRegistry.instance.getValue("groundPosition") + left_rocks.height / 2;
			left_rocks.x = scene.bounds.x + left_rocks.width / 2;
			
			right_rocks.y = TRegistry.instance.getValue("groundPosition") + right_rocks.height / 2;
			right_rocks.x = scene.bounds.width + scene.bounds.x - right_rocks.width / 2;
			
			var obstacles:TList = new TList();
			obstacles.Add(left_rocks);
			obstacles.Add(right_rocks);
			TRegistry.instance.setValue("obstacles", obstacles);
			
			
			TRegistry.instance.setValue("userHp", uiPanel.userHp);
			TRegistry.instance.setValue("scene", scene);

			
			TRegistry.instance.setValue("debug_cannon_test", false);
			TRegistry.instance.setValue("debug_ufo_test", false);
			
			TRegistry.instance.setValue("config_play_sounds", false);
			TRegistry.instance.setValue("config_play_music", false);
			
			var player:TList = new TList();
			TRegistry.instance.setValue("player", player);
			var tank: Tank = new Tank();
			player.Add(tank);
			tank.x = 400;
			tank.y = TRegistry.instance.getValue("groundPosition") - 20; //@TMP: Надо поправить координаты муви-клипов
			
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
	}
}