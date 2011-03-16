package UI 
{
	import common.Debug;
	import common.TRegistry;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class UIIcon extends MovieClip 
	{
		private const _x_padding: int = 5;
		private const _x_width: int = 20;
		
		private const _y_padding: int = 5;
		private const _y_height: int = 20;
		
		protected var _x_offset: int;
		protected var _y_offset: int = 20;
		
		protected var _light_up_color: uint = 0xDDDDDD;
		
		protected var _action: Function;
		
		private var _progress_bar: Shape;
		private var _position: int = 0;
		
		public function UIIcon(name: String, position: int, action: Function)
		{
			this.name = name;
			this.position = position;
			super();
			
			var ClassReference: Class = getDefinitionByName(name + "_icon") as Class;
			var instance: Object = new ClassReference();
			addChild(DisplayObject(instance));
			
			if (action == null)//@DEBUG
			{
				// Изменяем цвет неактивной иконки
				var colTransf:ColorTransform = this.transform.colorTransform;
				colTransf.blueMultiplier = 0.8;
				colTransf.redMultiplier = 1.5;
				colTransf.greenMultiplier = 0.8;
				this.transform.colorTransform = colTransf;
			} else {
				// Привязка событий для mouseclick
				this.buttonMode = true;
				this._action = action;
				this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			}
		}
		
		public function addToUI(uiPanel: MovieClip) : void
		{
			uiPanel.addChild(this);
			createProgressBar(uiPanel);
		}
		
		private function createProgressBar(uiPanel: MovieClip) : void
		{
			_progress_bar = new Shape();
			_progress_bar.graphics.beginFill(0x00DD00);
			_progress_bar.graphics.drawRect(0, 0, _x_width, 3);
			_progress_bar.graphics.endFill();
			
			_progress_bar.x = this.x;
			_progress_bar.y = this.y + _y_height + 1;
			
			uiPanel.addChild(_progress_bar);
			
		}
		
		public function set position(value: int)
		{
			this._position = value;
			this.x = _x_offset + _x_padding + (_x_padding + _x_width) * value;
			this.y = _y_offset + _y_padding; //@TMP: пока иконок мало, они помещаются в одной строке
		}
		
		public function get position() : int
		{
			return this._position;
		}
		
		private function onMouseClick(e: MouseEvent) : void
		{
			this.press();
		}
		
		public function press() : void
		{
			this._action.call();
		}
		
		public function activate() : Boolean
		{
			// Добавляем свечение
			var filter = new GlowFilter(this._light_up_color);
			var filters : Array = this.filters;
			filters.push(filter);
			this.filters = filters;
			
			return true;//@TMP
		}
		
		public function deactivate() : void
		{
			// Убираем свечение
			var filters: Array = new Array();
			this.filters = filters;
		}
		
		public function updateProgress(percentage: Number) : void
		{
			this._progress_bar.width = percentage * _x_width;
			
			var newColor: ColorTransform = this._progress_bar.transform.colorTransform;
			
			var r: uint = (1.0 - percentage) * 2 * 0xFF;  	r = (r > 0xFF ? 0xFF : r);
			var g: uint = percentage * 2 * 0xFF; 			g = (g > 0xFF ? 0xFF : g);
			var b:uint = 0x00;
			
			newColor.color = r << 16 | g << 8 | b;
			
			this._progress_bar.transform.colorTransform = newColor;
		}
	}

}