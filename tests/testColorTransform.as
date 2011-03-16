package tests 
{
	import common.TRegistry;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Taymir
	 */
	public class testColorTransform 
	{
		public function testColorTransform(ai: AlienInvasion) 
		{
			TRegistry.instance.setValue("stage", ai.stage);
		}
		
		private function test1() : void
		{
			const colorTransformationNumber: int = 100 * 000;
			trace("Test 1: " + colorTransformationNumber + " color transformations");
			
			var square: Shape = makeShape();
			
			var startTime: Number = getTime();
			
			for (var i: int = 0; i < colorTransformationNumber; ++i)
			{
				var newColor: ColorTransform = square.transform.colorTransform;
				newColor.color = uint(Math.random() * uint.MAX_VALUE);
				square.transform.colorTransform = newColor;
			}
			
			var time: Number = (getTime() - startTime);
			
			trace("Transformation took", time, "ms");// 100k @ 237ms @ Core i5
		}
		
		private function getTime():Number
		{
			return (new Date()).getTime();
		}
		
		private function makeShape(): Shape
		{
			var shape: Shape = new Shape();
			shape.graphics.beginFill(0xFF0000);
			shape.graphics.drawRect(0, 0, 100, 100);
			shape.graphics.endFill();
			
			(TRegistry.instance.getValue("stage") as Stage).addChild(shape);
			return shape;
		}
		
		public function run() : void
		{
			test1();
		}
		
	}

}