package UI.Menu
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import common.TRegistry;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Taymir
	 */
	public class Menu extends MovieClip
	{
		var menuScreens: Dictionary;
		var currentScreen: MenuScreen;
		var prevScreenName: String = "";
		
		public function Menu(documentObj: MovieClip) 
		{
			documentObj.addChild(this);
			var background: Bitmap = new Bitmap(new menu_background());
			this.addChild(background);
			
			menuScreens = new Dictionary();
			
			addMenuScreen("main", new MainMenuScreen(this));
			addMenuScreen("controls", new ControlsMenuScreen(this));
			addMenuScreen("settings", new SettingsMenuScreen(this));
			addMenuScreen("credits", new CreditsMenuScreen(this));
			addMenuScreen("pause", new PauseMenuScreen(this));
			
			this.loadSoundsAndMusic();
			
			this.visible = false;
		}
		
		private function addMenuScreen(screenName: String, menuScreen: MenuScreen)
		{
			this.menuScreens[screenName] = menuScreen;
			this.menuScreens[screenName].name = screenName;
		}
		
		private function loadSoundsAndMusic()
		{
			var music:MusicManager = TRegistry.instance.getValue("music_manager");
			music.loadTrack("track_lobby");
			
			var sounds: SoundManager = TRegistry.instance.getValue("sound_manager");
			sounds.addSound("rolloverMenuSnd");
			sounds.addSound("clickMenuSnd");
		}
		
		public function playMenuMusic()
		{
			(TRegistry.instance.getValue("music_manager") as MusicManager).play("track_lobby");
		}
		
		public function switchToScreen(screenName: String)
		{
			if (currentScreen)
			{
				prevScreenName = currentScreen.name;
				currentScreen.visible = false;
			}
			
			menuScreens[screenName].visible = true;
			currentScreen = menuScreens[screenName];
		}
		
		public function switchToPrevScreen()
		{
			switchToScreen(prevScreenName);
		}
		
		public function show(screenName: String = "main")
		{
			this.visible = true;
			switchToScreen(screenName);
		}
		
		public function hide()
		{
			this.visible = false;
		}
	}

}