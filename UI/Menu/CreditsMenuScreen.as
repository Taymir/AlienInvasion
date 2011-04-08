package UI.Menu 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class CreditsMenuScreen extends MenuScreen 
	{
		
		public function CreditsMenuScreen(menu:Menu) 
		{
			super(menu);
			
			this.setHeadline("СОЗДАТЕЛИ");
			
			this.addMenuItem("ИННА КОНДРАТЬЕВА", 0);
			this.addMenuItem("НАСКИН СТАНИСЛАВ", 1);
			this.addMenuItem("ТАБАНИ ТИМУР", 2);
			
			this.addMenuItem("НАЗАД", 4, backCallBack);
		}
		
		private function backCallBack()
		{
			menu.switchToScreen("main");
		}
		
	}

}