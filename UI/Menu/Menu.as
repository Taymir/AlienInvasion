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
		
		public function Menu(documentObj: MovieClip) 
		{
			documentObj.addChild(this);
			var background: Bitmap = new Bitmap(new menu_background());
			this.addChild(background);
			
			menuScreens = new Dictionary();
			menuScreens["main"] = new MainMenuScreen(this);
			menuScreens["controls"] = new ControlsMenuScreen(this);
			menuScreens["settings"] = new SettingsMenuScreen(this);
			menuScreens["credits"] = new CreditsMenuScreen(this);
			menuScreens["pause"] = new PauseMenuScreen(this);
			(TRegistry.instance.getValue("music_manager") as MusicManager).play("track_lobby"); //@BUGFIX: чтобы музыка менялась только в начальном меню, но не во время игры
			
			this.visible = false;
		}
		
		public function switchToScreen(screenName: String)
		{
			if (currentScreen)
				currentScreen.visible = false;
			
			menuScreens[screenName].visible = true;
			currentScreen = menuScreens[screenName];
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