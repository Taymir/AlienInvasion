package UI.Menu 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import common.TRegistry;
	/**
	 * ...
	 * @author Taymir
	 */
	public class MenuScreen extends MovieClip
	{
		private var menuOffset: Point = new Point(20, 300);
		private var itemOffset: int = 40;
		
		protected var menu: Menu;
		
		public function MenuScreen(menu: Menu) 
		{
			this.menu = menu;
			this.menu.addChild(this);
			this.visible = false;
		}
		
		protected function setHeadline(text: String)
		{
			this.showHeadline(text, this.parent.width / 2);
		}
		
		protected function addMenuItem(itemText: String, itemPos: int, action: Function = null)
		{
			var label: MovieClip = new MovieClip();
			label.addChild(this.createLabel(itemText, new Point(menuOffset.x, itemOffset * itemPos + menuOffset.y), TextFieldAutoSize.LEFT, 30, 3, 0.85));
			label.action = action;
			
			label.addEventListener(MouseEvent.CLICK, onItemClick);
			label.addEventListener(MouseEvent.MOUSE_OVER, onItemOver);
			label.addEventListener(MouseEvent.MOUSE_OUT, onItemOut);
			
			this.addChild(label);
			return label;
		}
		
		private function onItemClick(e: MouseEvent)
		{
			var mc = e.currentTarget;
			
			if (mc.action)
			{
				(TRegistry.instance.getValue("sound_manager") as SoundManager).play("clickMenuSnd");
				(mc.action as Function).call();
			}
		}
		
		private function onItemOver(e: MouseEvent)
		{
			var label = e.currentTarget;
			
			(TRegistry.instance.getValue("sound_manager") as SoundManager).play("rolloverMenuSnd");
			label.alpha = 1;
		}
		
		private function onItemOut(e: MouseEvent)
		{
			var label = e.currentTarget;
			
			label.alpha = 0.85;
		}
		
		private function showHeadline(text: String, position: int)
		{
			var label = this.createLabel(text, new Point(position, 20), TextFieldAutoSize.CENTER, 40, 4);
			this.addChild(label);
			
			return label;
		}
		
		private function createLabel(text: String, position:Point, autosize:String, size:int, letterSpacing:int, alpha: Number = 1.0)
		{
			var label: TextField = new TextField();
			label.x = position.x;
			label.y = position.y;
			label.autoSize = autosize;
			label.embedFonts = true;
			
			var format: TextFormat = new TextFormat();
			format.font = "Impact";
			format.bold = true;
			format.color = 0xFFFFFF;
			format.size = size;
			format.letterSpacing = letterSpacing;
			
			label.alpha = alpha;
			label.selectable = false;
			label.defaultTextFormat = format;
			
			var filters: Array = label.filters;
			filters.push(new BlurFilter(2, 2, 1));
			label.filters = filters;
			
			label.text = text;
			
			return label;
		}
		
	}

}