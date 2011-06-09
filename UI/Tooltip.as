package UI 
{
	import flash.display.Sprite;
    import flash.text.TextField;  
    import flash.text.TextFormat;  
    import flash.text.TextFormatAlign;  
    import flash.filters.BitmapFilter;  
    import flash.filters.DropShadowFilter;  
    import fl.transitions.Tween;  
    import fl.transitions.easing.Strong;  
	/**
	 * ...
	 * Taken from tutorial: 
	 * http://active.tutsplus.com/tutorials/effects/create-a-customizable-tooltip-in-actionscript-3-0/
	 **/
	public class Tooltip extends Sprite 
	{
		const txtColor:uint = 0xFFFFFF;
		const color:uint = 0x9F270F;
		const cornerRadius:int = 3;
		const w:int = 120, h:int = 20;
		
		var tween:Tween; //A tween object to animate the tooltip at start  
		  
		var tooltip:Sprite = new Sprite(); //The Sprite containing the tooltip graphics  
		var bmpFilter:BitmapFilter; //This will handle the drop shadow filter  
		  
		var textfield:TextField = new TextField(); //The textfield inside the tooltip  
		var textformat:TextFormat = new TextFormat(); //The format for the textfield  
		var font:Arial = new Arial(); // An embedded font
		
		public function Tooltip(txt:String):void  
		{  
			textfield.selectable = false; //You cannot select the text in the tooltip  
			  
			textformat.align = TextFormatAlign.CENTER; //Center alignment  
			textformat.font = font.fontName; //Use the embedded font  
			textformat.size = 10; //Size of the font  
			  
			textformat.color = txtColor; //Color of the text, taken from the parameters  
			  
			textfield = new TextField(); //A new TextField object  
			textfield.embedFonts = true; //Specify the embedding of fonts  
			textfield.width = w;  
			textfield.height = h;  
			textfield.defaultTextFormat = textformat; //Apply the format  
			textfield.text = txt; //The content of the TextField, taken from the parameters  
			
			tooltip = new Sprite();  
			
			tooltip.graphics.beginFill(color, 1.0);  
			tooltip.graphics.drawRoundRect(0, 0, w, h, cornerRadius, cornerRadius);  
			
			// arrow
			tooltip.graphics.moveTo(tooltip.width / 2 - 6, tooltip.height);  
			tooltip.graphics.lineTo(tooltip.width / 2, tooltip.height + 4.5);  
			tooltip.graphics.lineTo(tooltip.width / 2 + 6, tooltip.height - 4.5);  
			  
			tooltip.graphics.endFill(); // This line will finish the drawing no matter if the arrow is used or not.  
			
			// фильтр-тень
			bmpFilter = new DropShadowFilter(1, 90, 0x000000, 1, 2, 2, 1, 15);// (1, 90, color, 1, 2, 2, 1, 15);  
			tooltip.filters = [bmpFilter];
			
			tooltip.addChild(textfield); //Adds the TextField to the Tooltip Sprite 
			addChild(tooltip); //Adds the Tooltip to Stage  
			
			// анимация
			tween = new Tween(tooltip,"alpha",Strong.easeOut,0,tooltip.alpha,0.5,true);  
		}
	}

}