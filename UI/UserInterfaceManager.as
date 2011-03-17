package UI
{
	import common.TList.TList;
	import common.TRegistry;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Taymir
	 */
	public class UserInterfaceManager 
	{
		private var uiPanel: MovieClip;
		
		private var icons: Dictionary;
		
		//@TODO: добавить управление с клавиатуры
		public function UserInterfaceManager(uiPanel: MovieClip) 
		{
			//массив иконок должен содержать:
			//1) список иконок данного типа
			//2) графические отступы
			//3) цвета подсветки//@TODO!!!!!!!!!!!!!!!
			
			this.uiPanel = uiPanel;
			this.clearIcons();
			
			if (TRegistry.instance.getValue("debug_show_fps") == true)
				showFps(true);
			else
				showFps(false);
		}
		
		public function setHitPoints(hp: int)
		{
			if (TRegistry.instance.getValue("debug_god_mode") == true)
				this.uiPanel.userHp.text = "∞";
			else
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
		
		public function clearIcons()
		{
			icons = new Dictionary();
		}
		
		public function addIcon(icon: UIIcon) : void
		{
			icons[icon.name] = icon;
			icons[icon.identificator] = icon;
			
			icon.addToUI(this.uiPanel);
		}
		
		public function updateProgress(iconName, progress: Number) : void
		{
			if(icons[iconName] != null)
				(icons[iconName] as UIIcon).updateProgress(progress);
		}
		
		public function activateIcon(iconName) : void
		{
			if(icons[iconName] != null)
				(icons[iconName] as UIIcon).activate();
		}
		
		public function deactivateIcon(iconName) : void
		{
			if(icons[iconName] != null)
				(icons[iconName] as UIIcon).deactivate();
		}
		
		public function pressIcon(iconName) : void
		{
			if(icons[iconName] != null)
				(icons[iconName] as UIIcon).press();
		}
		
		public function keyHandler(keyCode: int, shift: Boolean) : void
		{
			const firstDigitCode: int = 49;
			var num: int = keyCode - firstDigitCode;

			if (shift)
				this.pressIcon("protection" + num.toString());
			else
				this.pressIcon("weapon" + num.toString());
		}
	}

}