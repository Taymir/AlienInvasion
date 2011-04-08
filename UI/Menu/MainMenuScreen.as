package UI.Menu 
{
		import common.TRegistry;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class MainMenuScreen extends MenuScreen 
	{
		public function MainMenuScreen(menu:Menu) 
		{
			super(menu);
			
			this.setHeadline("ALIEN INVASION [WT]");
			
			this.addMenuItem("ИГРАТЬ", 0, playCallback);
			this.addMenuItem("УПРАВЛЕНИЕ", 1, controlsCallback);
			this.addMenuItem("НАСТРОЙКИ", 2, settingsCallback);
			this.addMenuItem("СОЗДАТЕЛИ", 3, creditsCallbcak);
		}
		
		private function playCallback()
		{
			menu.hide();
			TRegistry.instance.getValue("gameStateManager").startGame();
		}
		
		private function creditsCallbcak()
		{
			menu.switchToScreen("credits");
		}
		
		private function settingsCallback()
		{
			menu.switchToScreen("settings");
		}
		
		private function controlsCallback()
		{
			menu.switchToScreen("controls");
		}
	}

}