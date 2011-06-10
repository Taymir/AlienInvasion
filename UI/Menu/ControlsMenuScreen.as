package UI.Menu 
{
	import flash.display.MovieClip;
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
			
			var controls: MovieClip = new controlsScreen();
			controls.x = 70;
			controls.y = 140;
			this.addChild(controls);
			
			this.addMenuItem("НАЗАД", 4, backCallBack);
		}
		
		private function backCallBack()
		{
			menu.switchToPrevScreen();
		}
		
	}

}