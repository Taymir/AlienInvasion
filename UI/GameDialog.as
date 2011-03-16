package UI
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import common.TRegistry;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class GameDialog
	{
		public static const CLOSE_DIALOG = 0;
		
		public function GameDialog() 
		{
			
		}
		
		public function MessageBox(str:String, color:uint, alpha:Number, padding:Number, width:Number, buttons:uint)
		{
			// Создаём текстовое поле
			var text:TextField = makeTextField(str, padding, padding, width);
					
			switch(buttons)
			{
				case CLOSE_DIALOG:
					// Создаём кнопку
					var button:SimpleButton = new SimpleButton();
					button = makeButton("Закрыть", 0xFFFFFF, 0xFF0000, 1, padding, text.y + text.height + padding, onCloseDialog);
					break;
			}
			
			// Создаём окно и добавляем туда текстовое поле и кнопку
			var windowWidth = text.width + padding * 2;
			var windowHeight = text.height + padding * 3 + button.height;
			var windowX = TRegistry.instance.getValue("stage").stageWidth / 2 - windowWidth / 2;
			var windowY = TRegistry.instance.getValue("stage").stageHeight / 2 - (windowHeight) / 2;
			var window:MovieClip = makeWindow(windowX, windowY, windowWidth, windowHeight, 0xFF0000, 0.5);
			window.addChild(text);
			window.addChild(button);
			
			TRegistry.instance.getValue("stage").addChild(window);
		}		
		
		public function onCloseDialog(e:Event)
		{
			TRegistry.instance.getValue("stage").removeChild(e.currentTarget.parent);
			e.currentTarget.removeEventListener(MouseEvent.CLICK, onCloseDialog);
		}
		
		// Создание кнопки
		private function makeButton(title:String, colorText:uint, colorBackground:uint, alpha:Number, x:Number, y:Number, funcEvent:Function) : SimpleButton
		{
			// Создаём текстовое поле для надписи на кнопке
			var textField:TextField = new TextField();
			textField.text = title;
			textField.textColor = colorText;
			textField.autoSize = TextFieldAutoSize.LEFT;
			
			// Создаём тело кнопки (фигуру "прямоугольник")
			var shapeBody:Shape = new Shape();
			shapeBody.graphics.beginFill(colorBackground, alpha);
			shapeBody.graphics.drawRect(0, 0, textField.width, textField.height);
			shapeBody.graphics.endFill();
			
			// Создаём мувиклип, что бы объединить текстовое поле и тело			
			var movieClip:MovieClip = new MovieClip;
			movieClip.addChild(shapeBody);
			movieClip.addChild(textField);
					
			// Создаём кнопку и добавляем туда ранее созданый мувиклип
			var button:SimpleButton = new SimpleButton();
			button.upState = movieClip;
			button.overState = movieClip;
			button.downState = movieClip;
			button.hitTestState = movieClip;
			button.y = y;
			button.x = x;
			button.addEventListener(MouseEvent.CLICK, funcEvent);
			
			return button;
		}
		
		// Создание окна
		private function makeWindow(x:Number, y:Number, width:uint, height:uint, colorBackground:uint, alpha:Number) : MovieClip
		{
			// Создаём прямоугольник (как бы тело окна)
			var shapeBody:Shape = new Shape();
			shapeBody.graphics.beginFill(colorBackground, alpha);
			shapeBody.graphics.drawRect(0, 0, width, height);
			shapeBody.graphics.endFill();
			
			// Создаём контейнер и суём туда тело окна
			var window:MovieClip = new MovieClip();
			window.addChild(shapeBody);
			window.x = x;
			window.y = y;
			
			return window;
		}
		
		// Создание текстового поля
		private function makeTextField(text:String, x:Number, y:Number, width:uint) : TextField
		{
			var textField:TextField = new TextField();
			textField.htmlText = text;
			textField.wordWrap = true;
			textField.multiline = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.x = x;
			textField.y = y;
			textField.width = width;
			
			return textField;
		}
	}

}