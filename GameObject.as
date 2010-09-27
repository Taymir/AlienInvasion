package  
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import common.TRegistry;
	import common.Debug;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class GameObject extends MovieClip
	{
		protected const autoShow : Boolean = true;
		protected var scene : MovieClip;
		
		public function GameObject() 
		{
			Debug.assert( TRegistry.instance.getValue("scene") != null, "В реестре TRegistry не установлено значение объекта сцены scene" );
			
			this.scene = TRegistry.instance.getValue("scene");
			
			if (autoShow)
				show();
		}
		
		protected function show() : void
		{
			scene.addChild(this);
		}
		
		protected function hide() : void
		{
			scene.removeChild(this);
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