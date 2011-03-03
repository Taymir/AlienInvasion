package  
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
		
		private const WEAPONS_OFFSET: int = 156;
		private const PROTECTIONS_OFFSET: int = 360;
		private const EQUIPMENTS_OFFSET: int = 566;
		
		private var uiPanel: MovieClip;
		
		private const Y_OFFSET: int = 20;
		
		private var weaponIcons: TList = new TList();
		private var protectionIcons: TList = new TList();
		private var equipmentIcons: TList = new TList();
		
		private var icons: Dictionary;
		
		//@TODO: добавить управление с клавиатуры
		public function UserInterfaceManager(uiPanel: MovieClip) 
		{
			//массив иконок должен содержать:
			//1) список иконок данного типа
			//2) графические отступы
			//3) цвета подсветки//@TODO!!!!!!!!!!!!!!!
			
			this.uiPanel = uiPanel;
			
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
		
		public function addWeaponIcon(icon:MovieClip, position: int, action: Function)
		{
			weaponIcons.Add(icon);
			var icon:MovieClip = this.addIcon(icon, this.WEAPONS_OFFSET, position, action);
			icon.addEventListener(MouseEvent.MOUSE_DOWN, weaponSelect);
		}
		
		public function addProtectionIcon(icon:MovieClip, position: int, action: Function)
		{
			protectionIcons.Add(icon);
			this.addIcon(icon, this.PROTECTIONS_OFFSET, position, action);
			icon.addEventListener(MouseEvent.MOUSE_DOWN, protectionSelect);
		}
		
		public function addEquipmentIcon(icon:MovieClip, position: int, action: Function)
		{
			equipmentIcons.Add(icon);
			this.addIcon(icon, this.EQUIPMENTS_OFFSET, position, action);
			icon.addEventListener(MouseEvent.MOUSE_DOWN, equipmentSelect);
		}
		
		public function clearIcons()
		{
			weaponIcons.Walk(hide_callback);
			weaponIcons.Clear();
			
			protectionIcons.Walk(hide_callback);
			protectionIcons.Clear();
			
			equipmentIcons.Walk(hide_callback);
			equipmentIcons.Clear();
		}
		
		private function clearWeaponsGlow()
		{
			weaponIcons.Walk(clear_glow_callbcak);
		}
		
		private function clearProtectionGlow()
		{
			protectionIcons.Walk(clear_glow_callbcak);
		}
		
		private function clearEquipmentnGlow()
		{
			equipmentIcons.Walk(clear_glow_callbcak);
		}
		
		private function hide_callback(obj: Object)
		{
			(obj as MovieClip).parent.removeChild(obj as MovieClip);
		}
		
		private function clear_glow_callbcak(obj: Object)
		{
			var filters: Array = new Array();
			(obj as MovieClip).filters = filters;
		}
		
		private function addIcon(icon: MovieClip, offset: int, position: int, action: Function) : MovieClip
		{
			if (action == null)//@DEBUG
			{
				// Изменяем цвет неактивной иконки
				var colTransf:ColorTransform = icon.transform.colorTransform;
				colTransf.blueMultiplier = 0.8;
				colTransf.redMultiplier = 1.5;
				colTransf.greenMultiplier = 0.8;
				icon.transform.colorTransform = colTransf;
			} else {
				// Привязка событий для mouseclick
				icon.buttonMode = true;
				icon.action = action;
				icon.addEventListener(MouseEvent.MOUSE_DOWN, iconClick);
			}
			
			// Позиционирование иконки
			uiPanel.addChild(icon);
			icon.x = offset + 5 + (5 + 20) * position;
			icon.y = Y_OFFSET + 5; //@TMP: пока иконок мало, они помещаются в одной строке
			
			return icon;
		}
		
		private function iconClick(evt: MouseEvent) : void
		{
			var icon: MovieClip = (evt.target as MovieClip);
			(icon.action as Function).call();
		}
		
		private function weaponSelect(evt: MouseEvent) : void
		{
			clearWeaponsGlow();
			iconLightUp(evt.target as MovieClip, 0xDD3333);
		}
		
		private function protectionSelect(evt: MouseEvent) : void
		{
			clearProtectionGlow();
			iconLightUp(evt.target as MovieClip, 0x3333DD);
		}
		
		private function equipmentSelect(evt: MouseEvent) : void
		{
			clearEquipmentnGlow();
			iconLightUp(evt.target as MovieClip, 0x33DD33);
		}
		
		private function iconLightUp(icon: MovieClip, color: uint) : void
		{
			// анимировать текущую иконку
			var filter = new GlowFilter(color);
			var filters: Array = icon.filters;
			filters.push(filter);
			icon.filters = filters;
		}
	}

}