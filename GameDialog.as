package  
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
		private var msgBox:MovieClip;
		private var btn:SimpleButton;
		
		public function GameDialog() 
		{
			
		}
		
		public function MessageBox(str:String, color:uint, alpha:Number, padding:Number, width:Number, button:Number)
		{
			// Создаём текстовое поле
			var textField:TextField = new TextField();
			textField.htmlText = str;
			textField.wordWrap = true;
			textField.multiline = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.x = padding;
			textField.y = padding;
			textField.width = width;
			
			// Создаём кнопку
			btn = new SimpleButton();
			
			switch(button)
			{
				case 0:
					break;
				case 1:
					var textBtn:TextField = new TextField();
					textBtn.text = "Закрыть";
					textBtn.autoSize = TextFieldAutoSize.LEFT;
				
					var shapeBtn:Shape = new Shape();
					shapeBtn.graphics.beginFill(0xffffff, alpha);
					shapeBtn.graphics.drawRect(0, 0, textBtn.width, textBtn.height);
					shapeBtn.graphics.endFill();
					
					var movieBtn:MovieClip = new MovieClip;
					movieBtn.addChild(shapeBtn);
					movieBtn.addChild(textBtn);
					
					btn.upState = movieBtn;
					btn.overState = movieBtn;
					btn.downState = movieBtn;
					btn.y = textField.height + padding;
					btn.x = padding;
					btn.hitTestState = shapeBtn;
					btn.addEventListener(MouseEvent.CLICK, onCloseDialog);
					break;
			}
			
			// Создаём окно
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color, alpha);
			shape.graphics.drawRect(0, 0, textField.width + padding * 2, textField.height + padding * 2 + btn.height);
			shape.graphics.endFill();
			
			// Создаём мувиклип и добавляем туда ранее созданные поле и окно
			msgBox = new MovieClip();
			msgBox.addChild(shape);
			msgBox.addChild(textField);
			msgBox.x = TRegistry.instance.getValue("stage").stageWidth / 2 - msgBox.width / 2;
			msgBox.y = TRegistry.instance.getValue("stage").stageHeight / 2 - msgBox.height / 2;
			msgBox.addChild(btn);
			
			TRegistry.instance.getValue("stage").addChild(msgBox);
		}		
		
		public function onCloseDialog(e:Event)
		{
			TRegistry.instance.getValue("stage").removeChild(msgBox);
			btn.removeEventListener(MouseEvent.CLICK, onCloseDialog);
		}
	}

}