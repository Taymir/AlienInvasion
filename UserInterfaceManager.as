package  
{
	import common.TRegistry;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Taymir
	 */
	public class UserInterfaceManager 
	{
		//Данные:
		// * ссылка на userHP
		// * ссылка на fps
		// * массивы иконок:
		//   * Орудия
		//   * Средства защиты
		
		private var uiPanel: MovieClip;
		
		public function UserInterfaceManager(uiPanel: MovieClip) 
		{
			this.uiPanel = uiPanel;
			
			if (TRegistry.instance.getValue("debug_show_fps") == true)
				showFps(true);
			else
				showFps(false);
		}
		
		public function setHitPoints(hp: int)
		{
			this.uiPanel.userHp.text = hp.toString();
		}
		
		public function setFps(fps: Number)
		{
			this.uiPanel.fps.text = fps.toString();
		}
		
		public function showFps(show: Boolean = true)
		{
			this.uiPanel.fps.visible = show;
		}
		
	}

}