package UI.Menu 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class ControlsMenuScreen extends MenuScreen 
	{
		
		public function ControlsMenuScreen(menu:Menu) 
		{
			super(menu);
			
			this.setHeadline("УПРАВЛЕНИЕ");
			
			this.addMenuItem("TODO", 0);
			
			
			
			
			this.addMenuItem("НАЗАД", 4, backCallBack);
		}
		
		private function backCallBack()
		{
			menu.switchToScreen("main");
		}
		
	}

}