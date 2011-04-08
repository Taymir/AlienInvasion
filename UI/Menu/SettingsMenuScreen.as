package UI.Menu 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class SettingsMenuScreen extends MenuScreen 
	{
		
		public function SettingsMenuScreen(menu:Menu) 
		{
			super(menu);
			
			this.setHeadline("НАСТРОЙКИ");
			
			this.addMenuItem("TODO", 0);
			
			
			
			
			this.addMenuItem("НАЗАД", 4, backCallBack);
		}
		
		private function backCallBack()
		{
			menu.switchToScreen("main");
		}
		
	}

}