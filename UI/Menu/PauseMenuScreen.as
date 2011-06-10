package UI.Menu 
{
	import common.TRegistry;
	/**
	 * ...
	 * @author Taymir
	 */
	public class PauseMenuScreen extends MenuScreen 
	{
		
		public function PauseMenuScreen(menu:Menu) 
		{
			super(menu);
			
			this.setHeadline("ПАУЗА");
			
			this.addMenuItem("ПРОДОЛЖИТЬ", 0, continueCallback);
			this.addMenuItem("УПРАВЛЕНИЕ", 1, controlsCallback);
			this.addMenuItem("НАСТРОЙКИ", 2, settingsCallback);
			this.addMenuItem("ЗАНОВО", 3, restartCallback);
			this.addMenuItem("ЗАКОНЧИТЬ ИГРУ", 4, stopCallback);
		}
		
		private function continueCallback()
		{
			TRegistry.instance.getValue("gameStateManager").hideMenu();
		}
		
		private function restartCallback()
		{
			TRegistry.instance.getValue("gameStateManager").hideMenu();
			TRegistry.instance.getValue("gameStateManager").restartGame();
		}
		
		private function settingsCallback()
		{
			menu.switchToScreen("settings");
		}
		
		private function controlsCallback()
		{
			menu.switchToScreen("controls");
		}
		
		private function stopCallback()
		{
			TRegistry.instance.getValue("gameStateManager").endGame();
			menu.switchToScreen("main");
			menu.playMenuMusic();
		}
	}

}