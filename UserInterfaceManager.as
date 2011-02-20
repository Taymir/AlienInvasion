package  
{
	import common.TRegistry;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Taymir
	 */
	public class UserInterfaceManager 
	{
		//Данные:
		// * ссылка на userHP+
		// * ссылка на fps+
		// * массивы иконок:?
		//   * Орудия
		//   * Средства защиты
		
		private var uiPanel: MovieClip;
		
		private const WEAPONS_OFFSET: int = 156;
		private const PROTECTIONS_OFFSET: int = 360;
		private const EQUIPMENTS_OFFSET: int = 566;
		
		private const Y_OFFSET: int = 20;
		
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
		
		public function addWeaponIcon(icon:MovieClip, position: int, action: Function)
		{
			this.addIcon(icon, this.WEAPONS_OFFSET, position, action);
		}
		
		public function addProtectionIcon(icon:MovieClip, position: int, action: Function)
		{
			this.addIcon(icon, this.PROTECTIONS_OFFSET, position, action);
		}
		
		public function addEquipmentIcon(icon:MovieClip, position: int, action: Function)
		{
			this.addIcon(icon, this.EQUIPMENTS_OFFSET, position, action);
		}
		
		private function addIcon(icon: MovieClip, offset: int, position: int, action: Function)
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
				// Привязка событий для drag-n-drop
				icon.buttonMode = true;
				icon.addEventListener(MouseEvent.MOUSE_DOWN, startIconDrag);
				icon.action = action;
			}
			
			// Позиционирование иконки
			uiPanel.addChild(icon);
			icon.x = offset + 5 + (5 + 20) * position;
			icon.y = Y_OFFSET + 5; //@TMP: пока иконок мало, они помещаются в одной строке
		}
		
		private function startIconDrag(evt: MouseEvent) : void 
		{
			// Дублирование иконки
			var targetClass: Class = Object(evt.target).constructor;
			var duplicate: MovieClip = new targetClass();
			evt.target.parent.addChild(duplicate);
			duplicate.x = evt.target.x;
			duplicate.y = evt.target.y;
			duplicate.action = evt.target.action;
			
			// Установка доп. параметров дубликата
			duplicate.addEventListener(MouseEvent.MOUSE_UP, stopIconDrag);
			duplicate.alpha = 0.75;
			
			duplicate.startDrag();
		}
		
		private function stopIconDrag(evt: MouseEvent) : void
		{
			evt.target.stopDrag();
			evt.target.parent.removeChild(evt.target);

			if (evt.stageY < 0)//@HARDFIX: применяем действие, если иконка отпущена выше UIPanel
			{
				trace("applied");
				(evt.target.action as Function).call();
			}
		}
	}

}