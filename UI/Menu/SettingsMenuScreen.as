package UI.Menu 
{
	import flash.display.MovieClip;
	import common.TRegistry;
	/**
	 * ...
	 * @author Taymir
	 */
	public class SettingsMenuScreen extends MenuScreen 
	{
		private var musicLabel: MovieClip;
		private var soundLabel: MovieClip;
		
		const MUSIC_ON_TEXT: String = "МУЗЫКА - ВЫКЛ.";
		const MUSIC_OFF_TEXT: String = "МУЗЫКА - ВКЛ.";
		const SOUND_ON_TEXT: String = "ЗВУКИ - ВЫКЛ.";
		const SOUND_OFF_TEXT: String = "ЗВУКИ - ВКЛ.";
		
		public function SettingsMenuScreen(menu:Menu) 
		{
			super(menu);
			
			this.setHeadline("НАСТРОЙКИ");
			
			musicLabel = this.addMenuItem(MUSIC_ON_TEXT, 0, musicCallbcak);
			soundLabel = this.addMenuItem(SOUND_ON_TEXT, 1, soundCallbcak);
			
			
			
			this.addMenuItem("НАЗАД", 4, backCallBack);
		}
		
		private function backCallBack()
		{
			menu.switchToScreen("main");
		}
		
		private function musicCallbcak()
		{
			if (musicLabel.getText() == MUSIC_ON_TEXT)
			{
				musicLabel.setText(MUSIC_OFF_TEXT);
			} else {
				musicLabel.setText(MUSIC_ON_TEXT);
			}
			
			TRegistry.instance.getValue("music_manager").mute();
		}
		
		private function soundCallbcak()
		{
			if (soundLabel.getText() == SOUND_ON_TEXT)
			{
				soundLabel.setText(SOUND_OFF_TEXT);
			} else {
				soundLabel.setText(SOUND_ON_TEXT);
			}
			
			TRegistry.instance.getValue("sound_manager").mute();
		}
		
	}

}