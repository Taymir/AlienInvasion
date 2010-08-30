package  
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import common.TRegistry;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class GameObject extends MovieClip
	{
		protected var stageRef:Stage;
		
		public function GameObject() 
		{
			this.stageRef = TRegistry.instance.getValue("stage");
		}
		
		// Возвращает угол между граф. объектами
		private function getAngleBetweenObjs(obj1:DisplayObject, obj2:DisplayObject) : Number
		{
			return Math.atan2(obj2.x - obj1.x, obj2.y - obj1.y);
		}
		
		// Возвращает расстояние между граф. объектами
		private function getDistanceBetweenObjs(obj1:DisplayObject, obj2:DisplayObject) : Number
		{
			return Math.sqrt(Math.pow(obj2.x - obj1.x, 2) + Math.pow(obj2.y - obj1.y, 2));
		}
	}

}